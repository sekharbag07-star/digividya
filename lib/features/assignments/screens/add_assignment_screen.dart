import 'package:flutter/material.dart';

import 'package:digividya/core/services/assignment_service.dart';
import 'package:digividya/features/assignments/models/assignment_model.dart';

class AddAssignmentScreen extends StatefulWidget {
  const AddAssignmentScreen({super.key});

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  final batchController = TextEditingController();

  bool isLoading = false;

  final AssignmentService service = AssignmentService();

  Future<void> saveAssignment() async {
    if (titleController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final assignment = AssignmentModel(
      id: '',
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      dueDate: dueDateController.text.trim(),
      batchName: batchController.text.trim(),
    );

    await service.addAssignment(assignment);

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Assignment Added Successfully")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Assignment")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: dueDateController,
              decoration: const InputDecoration(
                labelText: "Due Date",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: batchController,
              decoration: const InputDecoration(
                labelText: "Batch Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : saveAssignment,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Create Assignment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
