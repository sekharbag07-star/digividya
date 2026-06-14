import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentBatchScreen extends StatefulWidget {
  const StudentBatchScreen({super.key});

  @override
  State<StudentBatchScreen> createState() => _StudentBatchScreenState();
}

class _StudentBatchScreenState extends State<StudentBatchScreen> {
  String? selectedStudentId;
  String? selectedBatchId;

  Future<void> assignBatch() async {
    if (selectedStudentId == null || selectedBatchId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Select Student and Batch")));
      return;
    }

    final studentDoc = await FirebaseFirestore.instance
        .collection('students')
        .doc(selectedStudentId)
        .get();

    final batchDoc = await FirebaseFirestore.instance
        .collection('batches')
        .doc(selectedBatchId)
        .get();

    await FirebaseFirestore.instance
        .collection('students')
        .doc(selectedStudentId)
        .update({'batchId': selectedBatchId, 'batchName': batchDoc['name']});

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${studentDoc['name']} assigned to ${batchDoc['name']}"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Batch Assignment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('students')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                return DropdownButtonFormField<String>(
                  initialValue: selectedStudentId,
                  decoration: const InputDecoration(
                    labelText: "Select Student",
                  ),
                  items: snapshot.data!.docs.map((student) {
                    return DropdownMenuItem<String>(
                      value: student.id,
                      child: Text(student['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStudentId = value;
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('batches')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                return DropdownButtonFormField<String>(
                  initialValue: selectedBatchId,
                  decoration: const InputDecoration(labelText: "Select Batch"),
                  items: snapshot.data!.docs.map((batch) {
                    return DropdownMenuItem<String>(
                      value: batch.id,
                      child: Text(batch['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBatchId = value;
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: assignBatch,
              child: const Text("Assign Batch"),
            ),
          ],
        ),
      ),
    );
  }
}
