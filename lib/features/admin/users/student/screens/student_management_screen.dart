import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../core/services/student_service.dart';
import '../../../../../../shared/widgets/delete_confirmation_dialog.dart';
import 'student_profile_screen.dart';

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

  final parentNameController = TextEditingController();
  final parentPhoneController = TextEditingController();
  final parentEmailController = TextEditingController();

  bool isLoading = false;

  Future<void> addStudent() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        parentNameController.text.isEmpty ||
        parentPhoneController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all required fields")));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await _studentService.addStudent(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        parentName: parentNameController.text.trim(),
        parentPhone: parentPhoneController.text.trim(),
        parentEmail: parentEmailController.text.trim(),
      );

      nameController.clear();
      emailController.clear();
      phoneController.clear();

      parentNameController.clear();
      parentPhoneController.clear();
      parentEmailController.clear();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Student Added Successfully")),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    if (!mounted) return;

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

    parentNameController.dispose();
    parentPhoneController.dispose();
    parentEmailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Student Management"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person_add), text: "Add Student"),
              Tab(icon: Icon(Icons.school), text: "Student List"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ADD STUDENT TAB
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Student Name",
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Student Email",
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Student Phone",
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Parent Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: parentNameController,
                    decoration: const InputDecoration(labelText: "Parent Name"),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: parentPhoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Parent Phone",
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: parentEmailController,
                    decoration: const InputDecoration(
                      labelText: "Parent Email",
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : addStudent,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text("Add Student"),
                    ),
                  ),
                ],
              ),
            ),

            // STUDENT LIST TAB
            Padding(
              padding: const EdgeInsets.all(16),
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

                      final data =
                          student.data() as Map<String, dynamic>? ?? {};

                      final name =
                          data['name']?.toString() ?? 'Unknown Student';

                      final parentName =
                          data['parentName']?.toString() ?? 'No Parent';

                      final batchName =
                          data['batchName']?.toString() ?? 'Not Assigned';

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    StudentProfileScreen(studentId: student.id),
                              ),
                            );
                          },
                          leading: const CircleAvatar(
                            child: Icon(Icons.school),
                          ),
                          title: Text(name),
                          subtitle: Text("$batchName • $parentName"),
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



