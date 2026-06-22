import 'package:flutter/material.dart';

class ParentMeetingRequestScreen extends StatelessWidget {
  const ParentMeetingRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meeting Request')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Meeting Purpose',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text('Request Meeting')),
          ],
        ),
      ),
    );
  }
}
