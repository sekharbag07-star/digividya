import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:digividya/features/admin/home/screens/admin_home_screen.dart';
import 'package:digividya/features/teacher/dashboard/screens/teacher_dashboard.dart';
import 'package:digividya/features/parent/dashboard/screens/parent_dashboard.dart';

import 'package:digividya/features/student/dashboard/screens/student_dashboard.dart';
import 'package:digividya/features/student/approval/screens/approval_waiting_screen.dart';

import 'package:digividya/features/payment/screens/payment_screen.dart';
import 'package:digividya/features/pravesh/screens/pravesh_screen.dart';

class RoleRouterService {
  static Future<Widget?> getHomeScreen(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (!doc.exists) {
      return null;
    }

    final data = doc.data() as Map<String, dynamic>;

    final role = data['role']?.toString() ?? '';

    switch (role) {
      case 'admin':
        return const AdminHomeScreen();

      case 'teacher':
        return const TeacherDashboard();

      case 'parent':
        return const ParentDashboard();

      case 'student':
        return _studentRouter(data);

      default:
        return null;
    }
  }

  static Widget _studentRouter(Map<String, dynamic> data) {
    final profileCompleted = data['profileCompleted'] ?? false;

    final paymentStatus = data['paymentStatus'] ?? 'pending';

    final admissionStatus = data['admissionStatus'] ?? 'pending';

    final subscriptionActive = data['subscriptionActive'] ?? false;

    // STEP 1
    if (!profileCompleted) {
      return const PraveshScreen();
    }

    // STEP 2
    if (paymentStatus == 'pending') {
      return const PaymentScreen();
    }

    // STEP 3
    if (paymentStatus == 'paid' && admissionStatus == 'pending') {
      return const ApprovalWaitingScreen();
    }

    // STEP 4
    if (paymentStatus == 'approved' &&
        admissionStatus == 'approved' &&
        subscriptionActive) {
      return const StudentDashboard();
    }

    return const ApprovalWaitingScreen();
  }
}







