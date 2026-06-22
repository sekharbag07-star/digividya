import 'package:flutter/material.dart';

class ParentResultScreen extends StatelessWidget {
  const ParentResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exam Results')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              title: Text('Mathematics'),
              subtitle: Text('85 / 100'),
            ),
          ),
          Card(
            child: ListTile(title: Text('Science'), subtitle: Text('90 / 100')),
          ),
          Card(
            child: ListTile(title: Text('English'), subtitle: Text('88 / 100')),
          ),
        ],
      ),
    );
  }
}
