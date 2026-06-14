import 'package:flutter/material.dart';

class StudentBatchScreen extends StatelessWidget {
  const StudentBatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Batch Assignment")),
      body: const Center(
        child: Text(
          "Student Batch Screen",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
