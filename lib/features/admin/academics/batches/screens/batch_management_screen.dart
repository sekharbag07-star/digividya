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

  String? selectedTeacherId;
  String? selectedTeacherName;

  bool isLoading = false;

  Future<void> addBatch() async {
    if (nameController.text.isEmpty ||
        subjectController.text.isEmpty ||
        selectedTeacherId == null ||
        selectedTeacherName == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all required fields")));
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await _batchService.addBatch(
        name: nameController.text.trim(),
        subject: subjectController.text.trim(),
        teacherId: selectedTeacherId!,
        teacherName: selectedTeacherName!,
      );

      nameController.clear();
      subjectController.clear();

      setState(() {
        selectedTeacherId = null;
        selectedTeacherName = null;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Batch Added Successfully")));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
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
    super.dispose();
  }

  Widget buildTeacherDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('teachers')
          .where('active', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final teachers = snapshot.data!.docs;

        return DropdownButtonFormField<String>(
          initialValue: selectedTeacherId,
          decoration: const InputDecoration(
            labelText: "Select Teacher",
            border: OutlineInputBorder(),
          ),
          items: teachers.map((teacher) {
            final data = teacher.data() as Map<String, dynamic>;

            return DropdownMenuItem<String>(
              value: teacher.id,
              child: Text(data['name'] ?? 'Teacher'),
            );
          }).toList(),
          onChanged: (value) {
            if (value == null) return;

            final teacher = teachers.firstWhere((doc) => doc.id == value);

            final data = teacher.data() as Map<String, dynamic>;

            setState(() {
              selectedTeacherId = teacher.id;
              selectedTeacherName = data['name'];
            });
          },
        );
      },
    );
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

            buildTeacherDropdown(),

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

                      final data = batch.data() as Map<String, dynamic>? ?? {};

                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.group)),
                          title: Text(data['name'] ?? ''),
                          subtitle: Text(
                            "${data['subject'] ?? ''} • ${data['teacherName'] ?? ''}",
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
