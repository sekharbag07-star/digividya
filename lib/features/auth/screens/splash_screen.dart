import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../admin/screens/admin_dashboard.dart';
import '../../teacher/screens/teacher_dashboard.dart';
import '../../student/screens/student_dashboard.dart';
import '../../parent/screens/parent_dashboard.dart';
import '../../payment/screens/payment_screen.dart';
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
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
      return;
    }

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists) {
        await FirebaseAuth.instance.signOut();

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
        return;
      }

      // ===============================
      // Trial + Subscription Check
      // ===============================

      final data = userDoc.data()!;

      bool subscriptionActive = data['subscriptionActive'] ?? false;

      Timestamp? trialEndTimestamp = data['trialEndDate'];

      if (!subscriptionActive && trialEndTimestamp != null) {
        final trialEnd = trialEndTimestamp.toDate();

        if (DateTime.now().isAfter(trialEnd)) {
          if (!mounted) return;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const PaymentScreen()),
          );
          return;
        }
      }
      Timestamp? subscriptionEndTimestamp = data['subscriptionEndDate'];

      if (subscriptionActive && subscriptionEndTimestamp != null) {
        final subscriptionEnd = subscriptionEndTimestamp.toDate();

        if (DateTime.now().isAfter(subscriptionEnd)) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
                'subscriptionActive': false,
                'paymentStatus': 'expired',
              });

          if (!mounted) return;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const PaymentScreen()),
          );
          return;
        }
      }

      // ===============================
      // Role Based Navigation
      // ===============================

      final role = data['role'];

      Widget screen;

      switch (role) {
        case 'admin':
          screen = const AdminDashboard();
          break;

        case 'teacher':
          screen = const TeacherDashboard();
          break;

        case 'student':
          screen = const StudentDashboard();
          break;

        case 'parent':
          screen = const ParentDashboard();
          break;

        default:
          await FirebaseAuth.instance.signOut();

          if (!mounted) return;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
          return;
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => screen),
      );
    } catch (e) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
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
