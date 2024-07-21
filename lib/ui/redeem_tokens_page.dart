import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'view_transaction_page.dart';

class RedeemTokensPage extends StatefulWidget {
  final int recyclableCount;

  const RedeemTokensPage({super.key, required this.recyclableCount});

  @override
  _RedeemTokensPageState createState() => _RedeemTokensPageState();
}

class _RedeemTokensPageState extends State<RedeemTokensPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _recyclableCountController =
      TextEditingController();
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _recyclableCountController.text = widget.recyclableCount.toString();
  }

  Future<void> _postTransaction() async {
    var headers = {'Content-Type': 'application/json'};

    var assetData = jsonEncode({
      "data": {
        "time": DateTime.now().millisecondsSinceEpoch,
        "name": _nameController.text,
        "recycled_items": widget.recyclableCount
      }
    }).replaceAll('"', r'\"');

    var request = http.Request(
        'POST', Uri.parse('https://cloud.resilientdb.com/graphql'));

    request.body =
        '''{"query":"mutation { postTransaction(data: {operation: \\"CREATE\\", amount: ${widget.recyclableCount}, signerPublicKey: \\"9uU9au1qZwrCs1eKZcyPfxmgmas4SB8iRviizyEbeTuv\\", signerPrivateKey: \\"B67g7fASxQyiXz2iRpPtr3rPms5EsdxQkP5ZxYQZtEG6\\", recipientPublicKey: \\"ECJksQuF9UWi3DPCYvQqJPjF6BqSbXrnDiXUjdiVvkyH\\", asset: \\"\\"\\"$assetData\\"\\"\\" }) { id }}","variables":{}}''';

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseData = jsonDecode(await response.stream.bytesToString());
        if (responseData['data'] != null &&
            responseData['data']['postTransaction'] != null) {
          final transactionId = responseData['data']['postTransaction']['id'];
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  ViewTransactionPage(transactionId: transactionId),
            ),
          );
        } else {
          setState(() {
            errorMessage =
                'Error: ${responseData['errors'] ?? 'Unknown error'}';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Error posting transaction: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Network error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redeem Tokens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _recyclableCountController,
              decoration: const InputDecoration(labelText: 'Recyclable Items'),
              readOnly: true,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _postTransaction,
              child: const Text('Post Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
