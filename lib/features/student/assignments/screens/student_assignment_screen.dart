import 'package:flutter/material.dart';

import 'package:digividya/core/services/assignment_service.dart';
import 'package:digividya/features/assignments/models/assignment_model.dart';

class StudentAssignmentScreen extends StatelessWidget {
  const StudentAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = AssignmentService();

    return Scaffold(
      appBar: AppBar(title: const Text("Assignments")),
      body: StreamBuilder<List<AssignmentModel>>(
        stream: service.getAssignments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Assignments Available"));
          }

          final assignments = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: assignments.length,
            itemBuilder: (context, index) {
              final assignment = assignments[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.assignment),
                  title: Text(assignment.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(assignment.description),
                      const SizedBox(height: 6),
                      Text("Due Date: ${assignment.dueDate}"),
                      Text("Batch: ${assignment.batchName}"),
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
