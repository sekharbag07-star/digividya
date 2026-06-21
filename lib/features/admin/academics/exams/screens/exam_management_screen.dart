import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExamManagementScreen extends StatefulWidget {
  const ExamManagementScreen({super.key});

  @override
  State<ExamManagementScreen> createState() => _ExamManagementScreenState();
}

class _ExamManagementScreenState extends State<ExamManagementScreen> {
  final nameController = TextEditingController();
  final totalMarksController = TextEditingController();

  bool isLoading = false;

  Future<void> addExam() async {
    if (nameController.text.isEmpty || totalMarksController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all fields")));
      return;
    }

    setState(() {
      isLoading = true;
    });

    await FirebaseFirestore.instance.collection('exams').add({
      'name': nameController.text.trim(),
      'totalMarks': int.parse(totalMarksController.text.trim()),
      'active': true,
      'createdAt': Timestamp.now(),
    });

    nameController.clear();
    totalMarksController.clear();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Exam Added Successfully")));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    totalMarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exam Management")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Exam Name"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: totalMarksController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Total Marks"),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : addExam,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Add Exam"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('exams')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final exams = snapshot.data!.docs;

                  if (exams.isEmpty) {
                    return const Center(child: Text("No Exams Added"));
                  }

                  return ListView.builder(
                    itemCount: exams.length,
                    itemBuilder: (context, index) {
                      final exam = exams[index];

                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.quiz)),
                          title: Text(exam['name']),
                          subtitle: Text("Total Marks: ${exam['totalMarks']}"),
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







