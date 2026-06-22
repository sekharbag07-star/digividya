import 'package:flutter/material.dart';

import 'package:digividya/features/live_classes/screens/add_live_class_screen.dart';
import 'package:digividya/features/live_classes/screens/live_class_list_screen.dart';

class TeacherLiveClassScreen extends StatelessWidget {
  const TeacherLiveClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Classes")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddLiveClassScreen()),
          );
        },
      ),
      body: const LiveClassListScreen(),
    );
  }
}
