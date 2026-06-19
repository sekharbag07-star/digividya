import 'package:flutter/material.dart';

class TeacherLiveClassScreen extends StatelessWidget {
  const TeacherLiveClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Classes"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.video_call),
      ),
      body: const Center(
        child: Text(
          "Teacher Live Classes",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}