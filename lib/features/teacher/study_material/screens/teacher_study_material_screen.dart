import 'package:flutter/material.dart';

import 'package:digividya/features/study_material/screens/add_material_screen.dart';
import 'package:digividya/features/study_material/screens/material_list_screen.dart';

class TeacherStudyMaterialScreen extends StatelessWidget {
  const TeacherStudyMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Study Material"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddMaterialScreen()),
          );
        },
      ),
      body: const MaterialListScreen(),
    );
  }
}
