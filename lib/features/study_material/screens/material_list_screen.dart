import 'package:flutter/material.dart';

import '../../../core/services/study_material_service.dart';

class MaterialListScreen
    extends StatelessWidget {
  const MaterialListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final service =
        StudyMaterialService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Study Materials',
        ),
      ),
      body: StreamBuilder(
        stream: service.getMaterials(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final materials =
              snapshot.data!;

          if (materials.isEmpty) {
            return const Center(
              child: Text(
                'No Study Material Found',
              ),
            );
          }

          return ListView.builder(
            itemCount:
                materials.length,
            itemBuilder:
                (context, index) {
              final item =
                  materials[index];

              return Card(
                margin:
                    const EdgeInsets.all(
                  10,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.menu_book,
                  ),
                  title:
                      Text(item.title),
                  subtitle: Text(
                    '${item.subject} • ${item.batch}',
                  ),
                  trailing: Text(
                    item.type,
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



