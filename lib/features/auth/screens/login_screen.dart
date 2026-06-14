import 'package:flutter/material.dart';

import '../../admin/screens/admin_dashboard.dart';
import '../../teacher/screens/teacher_dashboard.dart';
import '../../student/screens/student_dashboard.dart';
import '../../parent/screens/parent_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  void login() {
    final email = emailController.text.trim().toLowerCase();

    Widget screen;

    if (email == "admin@gmail.com") {
      screen = const AdminDashboard();
    } else if (email == "teacher@gmail.com") {
      screen = const TeacherDashboard();
    } else if (email == "student@gmail.com") {
      screen = const StudentDashboard();
    } else if (email == "parent@gmail.com") {
      screen = const ParentDashboard();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid User")));
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Coaching ERP")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
