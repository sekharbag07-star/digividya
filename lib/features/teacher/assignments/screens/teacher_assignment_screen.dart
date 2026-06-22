import 'package:flutter/material.dart';

import 'package:digividya/core/services/assignment_service.dart';
import 'package:digividya/features/assignments/models/assignment_model.dart';
import 'package:digividya/features/assignments/screens/add_assignment_screen.dart';

class TeacherAssignmentScreen extends StatelessWidget {
  const TeacherAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = AssignmentService();

    return Scaffold(
      appBar: AppBar(title: const Text("Assignments"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddAssignmentScreen()),
          );
        },
      ),
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
            itemCount: assignments.length,
            itemBuilder: (context, index) {
              final assignment = assignments[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.assignment),
                  title: Text(assignment.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(assignment.description),
                      const SizedBox(height: 5),
                      Text("Due: ${assignment.dueDate}"),
                      Text("Batch: ${assignment.batchName}"),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await service.deleteAssignment(assignment.id);
                    },
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
