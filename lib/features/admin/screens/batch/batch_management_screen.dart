import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BatchManagementScreen extends StatefulWidget {
  const BatchManagementScreen({super.key});

  @override
  State<BatchManagementScreen> createState() => _BatchManagementScreenState();
}

class _BatchManagementScreenState extends State<BatchManagementScreen> {
  final nameController = TextEditingController();
  final subjectController = TextEditingController();
  final teacherController = TextEditingController();

  Future<void> addBatch() async {
    await FirebaseFirestore.instance.collection('batches').add({
      'name': nameController.text.trim(),
      'subject': subjectController.text.trim(),
      'teacher': teacherController.text.trim(),
      'active': true,
      'createdAt': Timestamp.now(),
    });

    nameController.clear();
    subjectController.clear();
    teacherController.clear();
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

            TextField(
              controller: subjectController,
              decoration: const InputDecoration(labelText: "Subject"),
            ),

            TextField(
              controller: teacherController,
              decoration: const InputDecoration(labelText: "Teacher"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: addBatch, child: const Text("Add Batch")),

            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('batches')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final batches = snapshot.data!.docs;

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
