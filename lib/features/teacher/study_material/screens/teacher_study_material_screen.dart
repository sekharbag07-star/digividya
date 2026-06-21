import 'package:flutter/material.dart';

class TeacherStudyMaterialScreen extends StatelessWidget {
  const TeacherStudyMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Material"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.upload_file),
      ),
      body: const Center(
        child: Text(
          "Teacher Study Material",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}





