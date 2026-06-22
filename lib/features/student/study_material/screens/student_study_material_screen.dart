import 'package:flutter/material.dart';

import 'package:digividya/core/services/study_material_service.dart';
import 'package:digividya/features/study_material/models/study_material_model.dart';

class StudentStudyMaterialScreen extends StatelessWidget {
  const StudentStudyMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = StudyMaterialService();

    return Scaffold(
      appBar: AppBar(title: const Text("Study Materials")),
      body: StreamBuilder<List<StudyMaterialModel>>(
        stream: service.getMaterials(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Study Materials Available"));
          }

          final materials = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: materials.length,
            itemBuilder: (context, index) {
              final material = materials[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: Text(material.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(material.subject),
                      Text("Batch: ${material.batch}"),
                      Text("Type: ${material.type}"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
