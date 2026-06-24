import 'package:flutter/material.dart';

class AiWelcomeScreen extends StatelessWidget {
  const AiWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/digividya_logo.png',
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.school, size: 80);
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Welcome to DigiVidya AI',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'Homework Help\n'
              'Exam Preparation\n'
              'Attendance Queries\n'
              'Fee Queries\n'
              'Notice Summary\n'
              'Parent Guidance\n'
              'Teacher Assistant',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
