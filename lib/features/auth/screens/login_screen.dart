import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../admin/screens/admin_dashboard.dart';
import '../../teacher/screens/teacher_dashboard.dart';
import '../../student/screens/student_dashboard.dart';
import '../../parent/screens/parent_dashboard.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> login() async {
    try {
      setState(() {
        isLoading = true;
      });

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (!mounted) return;

      if (!userDoc.exists) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("User data not found")));
        return;
      }

      String role = userDoc['role'];

      Widget screen;

      switch (role) {
        case "admin":
          screen = const AdminDashboard();
          break;

        case "teacher":
          screen = const TeacherDashboard();
          break;

        case "student":
          screen = const StudentDashboard();
          break;

        case "parent":
          screen = const ParentDashboard();
          break;

        default:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Invalid role")));
          return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => screen),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Login failed")));
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("DigiVidya")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              children: [
                const SizedBox(height: 20),

                Image.asset('assets/logo/digividya_logo.png', height: 120),

                const SizedBox(height: 20),

                const Text(
                  'DigiVidya',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Smart Coaching Management',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),

                const SizedBox(height: 30),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1565C0),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: isLoading ? null : login,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 10),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: const Text("New User? Create Account"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
