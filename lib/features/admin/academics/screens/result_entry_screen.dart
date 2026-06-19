import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/ranking_service.dart';

class ResultEntryScreen extends StatefulWidget {
  const ResultEntryScreen({super.key});

  @override
  State<ResultEntryScreen> createState() => _ResultEntryScreenState();
}

class _ResultEntryScreenState extends State<ResultEntryScreen> {
  String? selectedStudentId;
  String? selectedStudentName;

  String? selectedBatchId;
  String? selectedBatchName;

  String? selectedExamId;
  String? selectedExamName;

  final RankingService _rankingService = RankingService();

  final mathController = TextEditingController();
  final scienceController = TextEditingController();
  final englishController = TextEditingController();

  bool isLoading = false;

  Future<void> saveResult() async {
    if (selectedStudentId == null ||
        selectedExamId == null ||
        mathController.text.trim().isEmpty ||
        scienceController.text.trim().isEmpty ||
        englishController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all fields")));
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final math = int.tryParse(mathController.text.trim()) ?? 0;
      final science = int.tryParse(scienceController.text.trim()) ?? 0;
      final english = int.tryParse(englishController.text.trim()) ?? 0;

      final total = math + science + english;

      final percentage = total / 3;

      final resultStatus = percentage >= 35 ? "Pass" : "Fail";

      final existingResult = await FirebaseFirestore.instance
          .collection('results')
          .where('studentId', isEqualTo: selectedStudentId)
          .where('examId', isEqualTo: selectedExamId)
          .limit(1)
          .get();

      if (existingResult.docs.isNotEmpty) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Result already entered for this student in this exam",
            ),
          ),
        );

        setState(() {
          isLoading = false;
        });

        return;
      }

      await FirebaseFirestore.instance.collection('results').add({
        'studentId': selectedStudentId,
        'studentName': selectedStudentName,

        'batchId': selectedBatchId,
        'batchName': selectedBatchName,

        'examId': selectedExamId,
        'examName': selectedExamName,

        'math': math,
        'science': science,
        'english': english,

        'total': total,
        'percentage': percentage,

        'status': resultStatus,

        'createdAt': Timestamp.now(),
      });

      await _rankingService.updateAllRanks();

      mathController.clear();
      scienceController.clear();
      englishController.clear();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Result Saved Successfully")),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    mathController.dispose();
    scienceController.dispose();
    englishController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Result Entry")),
      body: SingleChildScrollView(
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
                    final doc = snapshot.data!.docs.firstWhere(
                      (e) => e.id == value,
                    );

                    setState(() {
                      selectedStudentId = value;
                      selectedStudentName = doc['name'];

                      selectedBatchId = doc.data() is Map<String, dynamic>
                          ? (doc['batchId'] ?? '')
                          : '';

                      selectedBatchName = doc.data() is Map<String, dynamic>
                          ? (doc['batchName'] ?? doc['batch'] ?? '')
                          : '';
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 15),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('exams')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                return DropdownButtonFormField<String>(
                  initialValue: selectedExamId,
                  decoration: const InputDecoration(labelText: "Select Exam"),
                  items: snapshot.data!.docs.map((exam) {
                    return DropdownMenuItem<String>(
                      value: exam.id,
                      child: Text(exam['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    final doc = snapshot.data!.docs.firstWhere(
                      (e) => e.id == value,
                    );

                    setState(() {
                      selectedExamId = value;
                      selectedExamName = doc['name'];
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: mathController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Math Marks"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: scienceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Science Marks"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: englishController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "English Marks"),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : saveResult,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Save Result"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
