import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewTransactionPage extends StatefulWidget {
  final String transactionId;

  const ViewTransactionPage({super.key, required this.transactionId});

  @override
  _ViewTransactionPageState createState() => _ViewTransactionPageState();
}

class _ViewTransactionPageState extends State<ViewTransactionPage> {
  Map<String, dynamic>? transactionDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTransactionDetails();
  }

  Future<void> _fetchTransactionDetails() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://cloud.resilientdb.com/graphql'));

    request.body =
        '''{"query":"query {getTransaction(id: \\"${widget.transactionId}\\") {\\n  id\\n  version\\n  amount\\n  metadata\\n  operation\\n  asset\\n  publicKey\\n  uri\\n  type\\n}}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseData = jsonDecode(await response.stream.bytesToString());
      setState(() {
        transactionDetails = responseData['data']['getTransaction'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : transactionDetails != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount: ${transactionDetails!['amount']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                      Text(
                        'Asset: ${transactionDetails!['asset']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Public Key: ${transactionDetails!['publicKey']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                )
              : const Center(
                  child: Text('Failed to fetch transaction details'),
                ),
    );
  }
}
