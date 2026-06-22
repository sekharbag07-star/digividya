import 'package:flutter/material.dart';

class ParentSuggestionScreen extends StatelessWidget {
  const ParentSuggestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suggestion')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Write Suggestion',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text('Submit Suggestion')),
          ],
        ),
      ),
    );
  }
}
