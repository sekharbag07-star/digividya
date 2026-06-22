import 'package:flutter/material.dart';

class ParentComplaintScreen extends StatelessWidget {
  const ParentComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complaint')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Write Complaint',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text('Submit Complaint')),
          ],
        ),
      ),
    );
  }
}
