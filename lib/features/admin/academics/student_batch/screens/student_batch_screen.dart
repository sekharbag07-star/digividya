import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentBatchScreen extends StatefulWidget {
  const StudentBatchScreen({super.key});

  @override
  State<StudentBatchScreen> createState() => _StudentBatchScreenState();
}

class _StudentBatchScreenState extends State<StudentBatchScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? selectedStudentId;
  String? selectedBatchId;

  bool isLoading = false;

  Future<void> assignBatch() async {
    if (selectedStudentId == null || selectedBatchId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Select Student and Batch")));
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final studentDoc = await firestore
          .collection('students')
          .doc(selectedStudentId)
          .get();

      final batchDoc = await firestore
          .collection('batches')
          .doc(selectedBatchId)
          .get();

      if (!studentDoc.exists || !batchDoc.exists) {
        throw Exception("Student or Batch not found");
      }

      final studentData = studentDoc.data() ?? {};
      final batchData = batchDoc.data() ?? {};

      final currentBatchId = studentData['batchId'];

      if (currentBatchId == selectedBatchId) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Student already assigned to this batch"),
          ),
        );

        setState(() {
          isLoading = false;
        });

        return;
      }

      await firestore.collection('students').doc(selectedStudentId).update({
        'batchId': selectedBatchId,
        'batchName': batchData['name'],

        // Teacher Mapping
        'assignedTeacherId': batchData['teacherId'] ?? '',
        'assignedTeacherName': batchData['teacherName'] ?? '',

        // Reset Rank
        'batchRank': 0,

        'updatedAt': Timestamp.now(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${studentData['name']} assigned to ${batchData['name']}",
          ),
        ),
      );

      setState(() {
        selectedStudentId = null;
        selectedBatchId = null;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget buildStudentDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('students').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final students = snapshot.data!.docs;

        return DropdownButtonFormField<String>(
          initialValue: selectedStudentId,
          decoration: const InputDecoration(
            labelText: "Select Student",
            border: OutlineInputBorder(),
          ),
          items: students.map((student) {
            final data = student.data() as Map<String, dynamic>? ?? {};

            return DropdownMenuItem<String>(
              value: student.id,
              child: Text(data['name'] ?? 'Unknown Student'),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedStudentId = value;
            });
          },
        );
      },
    );
  }

  Widget buildBatchDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('batches').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final batches = snapshot.data!.docs;

        return DropdownButtonFormField<String>(
          initialValue: selectedBatchId,
          decoration: const InputDecoration(
            labelText: "Select Batch",
            border: OutlineInputBorder(),
          ),
          items: batches.map((batch) {
            final data = batch.data() as Map<String, dynamic>? ?? {};

            return DropdownMenuItem<String>(
              value: batch.id,
              child: Text(
                "${data['name']} (${data['teacherName'] ?? 'No Teacher'})",
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedBatchId = value;
            });
          },
        );
      },
    );
  }

  Widget buildAssignmentList() {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('students').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final students = snapshot.data!.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;

          return (data['batchId'] ?? '').toString().isNotEmpty;
        }).toList();

        if (students.isEmpty) {
          return const Center(child: Text("No Batch Assignments Yet"));
        }

        return ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index].data() as Map<String, dynamic>;

            return Card(
              child: ListTile(
                isThreeLine: true,
                leading: const Icon(Icons.assignment_ind),
                title: Text(student['name'] ?? ''),
                subtitle: Text(
                  "${student['batchName'] ?? 'Not Assigned'}\n"
                  "Teacher: ${student['assignedTeacherName'] ?? 'Not Assigned'}",
                ),
              ),
            );
          },
        );
      },
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
            buildStudentDropdown(),

            const SizedBox(height: 20),

            buildBatchDropdown(),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : assignBatch,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Assign Batch"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(child: buildAssignmentList()),
          ],
        ),
      ),
    );
  }
}
