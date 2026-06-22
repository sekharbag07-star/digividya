import 'package:flutter/material.dart';

class ParentNoticeScreen extends StatelessWidget {
  const ParentNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notices')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.campaign),
              title: Text('Holiday Notice'),
              subtitle: Text('Institute will remain closed tomorrow'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.campaign),
              title: Text('Exam Schedule'),
              subtitle: Text('Monthly test starts next week'),
            ),
          ),
        ],
      ),
    );
  }
}
