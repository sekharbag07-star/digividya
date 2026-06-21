import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:digividya/features/auth/screens/login_screen.dart';

class ApprovalWaitingScreen extends StatelessWidget {
  const ApprovalWaitingScreen({super.key});

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Approval Pending"),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.hourglass_top, size: 100, color: Colors.orange),

              const SizedBox(height: 20),

              const Text(
                "Verification In Progress",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              const Text(
                "Your admission form and payment have been submitted successfully.\n\nPlease wait for admin approval.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => logout(context),
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text("Exit Application"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





