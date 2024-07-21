import 'package:flutter/material.dart';
import 'package:live_object_detection_ssd_mobilenet/models/recognition.dart';
import 'package:live_object_detection_ssd_mobilenet/ui/redeem_tokens_page.dart';

class RecyclableItemsPage extends StatelessWidget {
  final List<Recognition> recognitions;

  const RecyclableItemsPage({super.key, required this.recognitions});

  @override
  Widget build(BuildContext context) {
    final recyclableItems = recognitions
        .where((rec) =>
            rec.classification.toLowerCase().contains('recyclable') ||
            rec.classification.toLowerCase().contains('yes'))
        .toList();
    final recyclableCount = recyclableItems.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recyclable Items'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Recyclable Items: $recyclableCount',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recyclableItems.length,
              itemBuilder: (context, index) {
                final item = recyclableItems[index];
                return ListTile(
                  title: Text(item.label),
                  subtitle: Text('Count: ${item.recyclableCount}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        RedeemTokensPage(recyclableCount: recyclableCount),
                  ),
                );
              },
              child: const Text('Redeem Tokens'),
            ),
          ),
        ],
      ),
    );
  }
}
