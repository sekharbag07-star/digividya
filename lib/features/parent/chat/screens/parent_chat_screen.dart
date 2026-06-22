import 'package:flutter/material.dart';

class ParentChatScreen extends StatelessWidget {
  const ParentChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat With Institute')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('No Messages Yet', style: TextStyle(fontSize: 18)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type Message...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
