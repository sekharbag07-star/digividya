import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:digividya/features/auth/services/account_service.dart';
import 'package:digividya/features/auth/services/auth_service.dart';
import 'package:digividya/features/auth/screens/login_screen.dart';

class ParentRegisterScreen extends StatefulWidget {
  const ParentRegisterScreen({super.key});

  @override
  State<ParentRegisterScreen> createState() => _ParentRegisterScreenState();
}

class _ParentRegisterScreenState extends State<ParentRegisterScreen> {
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final AccountService _accountService = AccountService();
  final AuthService _authService = AuthService();

  bool isLoading = false;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  Future<void> linkParentToStudent({
    required String parentUid,
    required String parentEmail,
    required String parentPhone,
  }) async {
    final firestore = FirebaseFirestore.instance;

    final students = await firestore
        .collection('students')
        .where('parentEmail', isEqualTo: parentEmail)
        .limit(1)
        .get();

    if (students.docs.isNotEmpty) {
      await students.docs.first.reference.update({
        'parentUid': parentUid,
        'updatedAt': Timestamp.now(),
      });

      return;
    }

    final studentsByPhone = await firestore
        .collection('students')
        .where('parentPhone', isEqualTo: parentPhone)
        .limit(1)
        .get();

    if (studentsByPhone.docs.isNotEmpty) {
      await studentsByPhone.docs.first.reference.update({
        'parentUid': parentUid,
        'updatedAt': Timestamp.now(),
      });
    }
  }

  Future<void> registerParent() async {
    if (fullNameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    if (phoneController.text.trim().length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid 10 digit mobile number")),
      );
      return;
    }

    if (passwordController.text.trim().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password must be at least 6 characters")),
      );
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      final user = credential.user;

      if (user == null) {
        throw Exception("User creation failed");
      }

      await user.sendEmailVerification();

      await _accountService.createParentRecord(
        uid: user.uid,
        fullName: fullNameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        email: emailController.text.trim(),
      );

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'preferredLanguage': 'en',
      }, SetOptions(merge: true));

      await linkParentToStudent(
        parentUid: user.uid,
        parentEmail: emailController.text.trim(),
        parentPhone: phoneController.text.trim(),
      );

      await _authService.logout();

      if (!mounted) return;

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text("Registration Successful"),
          content: const Text(
            "Parent account created successfully.\n\nPlease verify your email before login.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Registration Failed")),
      );
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
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Parent Registration")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SizedBox(
            width: 450,
            child: Column(
              children: [
                const Icon(Icons.family_restroom, size: 90, color: Colors.blue),

                const SizedBox(height: 20),

                TextField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                    labelText: "Parent Full Name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Mobile Number",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : registerParent,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Register Parent"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
