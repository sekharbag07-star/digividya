import 'dart:async';

import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/digividya_logo.png', height: 180),

            const SizedBox(height: 20),

            const Text(
              'DigiVidya',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Smart Coaching Management',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
