import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../core/services/teacher_service.dart';
import '../../../../../../shared/widgets/delete_confirmation_dialog.dart';

class TeacherManagementScreen extends StatefulWidget {
  const TeacherManagementScreen({super.key});

  @override
  State<TeacherManagementScreen> createState() =>
      _TeacherManagementScreenState();
}

class _TeacherManagementScreenState extends State<TeacherManagementScreen> {
  final TeacherService _teacherService = TeacherService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final subjectController = TextEditingController();

  bool isLoading = false;

  Future<void> addTeacher() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        subjectController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all required fields")));
      return;
    }

    setState(() {
      isLoading = true;
    });

    await _teacherService.addTeacher(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      subject: subjectController.text.trim(),
    );

    nameController.clear();
    emailController.clear();
    phoneController.clear();
    subjectController.clear();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Teacher Added Successfully")));

    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteTeacher(String teacherId) async {
    final confirmed = await showDeleteConfirmationDialog(context, "Teacher");

    if (confirmed != true) return;

    await _teacherService.deleteTeacher(teacherId);

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Teacher Deleted")));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teacher Management")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Teacher Name"),
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
              controller: subjectController,
              decoration: const InputDecoration(labelText: "Subject"),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : addTeacher,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Add Teacher"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _teacherService.getTeachers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final teachers = snapshot.data!.docs;

                  if (teachers.isEmpty) {
                    return const Center(child: Text("No Teachers Added"));
                  }

                  return ListView.builder(
                    itemCount: teachers.length,
                    itemBuilder: (context, index) {
                      final teacher = teachers[index];

                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(teacher['name']),
                          subtitle: Text(
                            "${teacher['subject']} • ${teacher['email']}",
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteTeacher(teacher.id);
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
