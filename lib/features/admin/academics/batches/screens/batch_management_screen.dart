import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:digividya/core/services/batch_service.dart';
import 'package:digividya/shared/widgets/delete_confirmation_dialog.dart';

class BatchManagementScreen extends StatefulWidget {
  const BatchManagementScreen({super.key});

  @override
  State<BatchManagementScreen> createState() => _BatchManagementScreenState();
}

class _BatchManagementScreenState extends State<BatchManagementScreen> {
  final BatchService _batchService = BatchService();

  final nameController = TextEditingController();
  final subjectController = TextEditingController();
  final teacherController = TextEditingController();

  bool isLoading = false;

  Future<void> addBatch() async {
    if (nameController.text.isEmpty ||
        subjectController.text.isEmpty ||
        teacherController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all required fields")));
      return;
    }

    setState(() {
      isLoading = true;
    });

    await _batchService.addBatch(
      name: nameController.text.trim(),
      subject: subjectController.text.trim(),
      teacher: teacherController.text.trim(),
    );

    nameController.clear();
    subjectController.clear();
    teacherController.clear();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Batch Added Successfully")));

    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteBatch(String batchId) async {
    final confirmed = await showDeleteConfirmationDialog(context, "Batch");

    if (confirmed != true) return;

    await _batchService.deleteBatch(batchId);

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Batch Deleted")));
  }

  @override
  void dispose() {
    nameController.dispose();
    subjectController.dispose();
    teacherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Batch Management")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Batch Name"),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: subjectController,
              decoration: const InputDecoration(labelText: "Subject"),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: teacherController,
              decoration: const InputDecoration(labelText: "Teacher"),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : addBatch,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Add Batch"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _batchService.getBatches(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final batches = snapshot.data!.docs;

                  if (batches.isEmpty) {
                    return const Center(child: Text("No Batches Added"));
                  }

                  return ListView.builder(
                    itemCount: batches.length,
                    itemBuilder: (context, index) {
                      final batch = batches[index];

                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.group)),
                          title: Text(batch['name']),
                          subtitle: Text(
                            "${batch['subject']} • ${batch['teacher']}",
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteBatch(batch.id);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}







