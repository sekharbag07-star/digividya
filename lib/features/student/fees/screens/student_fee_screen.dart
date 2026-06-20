import 'package:flutter/material.dart';

class StudentFeeScreen extends StatelessWidget {
  const StudentFeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fees"),
      ),
      body: const Center(
        child: Text(
          "Student Fee Screen",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}



