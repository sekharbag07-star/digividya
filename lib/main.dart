import 'package:flutter/material.dart';
import 'features/auth/screens/splash_screen.dart';

void main() {
  runApp(const CoachingERP());
}

class CoachingERP extends StatelessWidget {
  const CoachingERP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coaching ERP',
      home: const SplashScreen(),
    );
  }
}
