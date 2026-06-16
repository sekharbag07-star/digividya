import 'package:flutter/material.dart';

class TeacherAssignmentScreen extends StatelessWidget {
  const TeacherAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignments"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.assignment),
              title: Text("Math Homework"),
              subtitle: Text("Submission Date: 20 June"),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.assignment),
              title: Text("Science Project"),
              subtitle: Text("Submission Date: 25 June"),
            ),
          ),
        ],
      ),
    );
  }
}