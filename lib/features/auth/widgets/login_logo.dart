import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}





