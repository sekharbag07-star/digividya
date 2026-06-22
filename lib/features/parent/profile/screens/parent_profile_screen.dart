import 'package:flutter/material.dart';

class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Child Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            SizedBox(height: 20),
            ListTile(
              title: Text('Student Name'),
              subtitle: Text('Demo Student'),
            ),
            ListTile(title: Text('Class'), subtitle: Text('Class 10')),
            ListTile(title: Text('Roll Number'), subtitle: Text('101')),
          ],
        ),
      ),
    );
  }
}
