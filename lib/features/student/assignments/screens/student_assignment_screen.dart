import 'package:flutter/material.dart';

class StudentAssignmentScreen extends StatelessWidget {
  const StudentAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignments"),
      ),
      body: const Center(
        child: Text(
          "Student Assignment Screen",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}







