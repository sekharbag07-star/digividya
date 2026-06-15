import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/student_service.dart';
import '../../../../shared/widgets/delete_confirmation_dialog.dart';

class StudentManagementScreen extends StatefulWidget {
  const StudentManagementScreen({super.key});

  @override
  State<StudentManagementScreen> createState() =>
      _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {
  final StudentService _studentService = StudentService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final batchController = TextEditingController();

  bool isLoading = false;

  Future<void> addStudent() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        batchController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all required fields")));
      return;
    }

    setState(() {
      isLoading = true;
    });

    await _studentService.addStudent(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      batch: batchController.text.trim(),
    );

    nameController.clear();
    emailController.clear();
    phoneController.clear();
    batchController.clear();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Student Added Successfully")));

    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteStudent(String studentId) async {
    final confirmed = await showDeleteConfirmationDialog(context, "Student");

    if (confirmed != true) return;

    await _studentService.deleteStudent(studentId);

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Student Deleted")));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    batchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Management")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Student Name"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: batchController,
              decoration: const InputDecoration(labelText: "Batch"),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : addStudent,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Add Student"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _studentService.getStudents(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final students = snapshot.data!.docs;

                  if (students.isEmpty) {
                    return const Center(child: Text("No Students Added"));
                  }

                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];

                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.school),
                          ),
                          title: Text(student['name']),
                          subtitle: Text(
                            "${student['batch']} • ${student['email']}",
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteStudent(student.id);
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
