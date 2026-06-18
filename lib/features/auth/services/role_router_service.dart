import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../admin/screens/admin_dashboard.dart';
import '../../teacher/screens/teacher_dashboard.dart';
import '../../parent/screens/parent_dashboard.dart';
import '../../student/screens/student_dashboard.dart';

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
        return const AdminDashboard();

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

  static Widget? _studentRouter(Map<String, dynamic> data) {
    final admissionStatus = data['admissionStatus'] ?? 'pending';

    final paymentStatus = data['paymentStatus'] ?? 'pending';

    final subscriptionActive = data['subscriptionActive'] ?? false;

    if (admissionStatus != 'approved') {
      return null;
    }

    if (paymentStatus != 'approved') {
      return null;
    }

    if (!subscriptionActive) {
      return null;
    }

    return const StudentDashboard();
  }
}
