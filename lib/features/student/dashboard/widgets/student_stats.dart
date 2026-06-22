import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentStats extends StatelessWidget {
  const StudentStats({super.key});

  Future<Map<String, String>> loadStats() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return {
        'attendance': '0%',
        'fees': '₹0',
        'result': '0%',
        'subscription': 'Inactive',
      };
    }

    double attendancePercent = 0;
    double pendingFees = 0;
    double latestResult = 0;

    // Attendance
    final attendanceDocs = await FirebaseFirestore.instance
        .collection('attendance')
        .where('studentUid', isEqualTo: uid)
        .get();

    int present = 0;
    int absent = 0;

    for (final doc in attendanceDocs.docs) {
      final status = (doc['status'] ?? '').toString().toLowerCase();

      if (status == 'present') {
        present++;
      } else {
        absent++;
      }
    }

    final totalAttendance = present + absent;

    if (totalAttendance > 0) {
      attendancePercent = (present / totalAttendance) * 100;
    }

    // Fees
    final feeDocs = await FirebaseFirestore.instance
        .collection('fees')
        .where('studentUid', isEqualTo: uid)
        .get();

    for (final doc in feeDocs.docs) {
      final data = doc.data();

      if (data['status'] != 'paid') {
        pendingFees += (data['amount'] ?? 0).toDouble();
      }
    }

    // Results
    final resultDocs = await FirebaseFirestore.instance
        .collection('results')
        .where('studentId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (resultDocs.docs.isNotEmpty) {
      latestResult = (resultDocs.docs.first['percentage'] ?? 0).toDouble();
    }

    // Subscription
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    final subscriptionActive = userDoc.data()?['subscriptionActive'] ?? false;

    return {
      'attendance': '${attendancePercent.toStringAsFixed(1)}%',
      'fees': '₹${pendingFees.toStringAsFixed(0)}',
      'result': '${latestResult.toStringAsFixed(1)}%',
      'subscription': subscriptionActive ? 'Active' : 'Inactive',
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: loadStats(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final stats = snapshot.data!;

        return Column(
          children: [
            _statCard(
              'Attendance',
              stats['attendance']!,
              Icons.fact_check,
              Colors.green,
            ),

            const SizedBox(height: 10),

            _statCard(
              'Pending Fees',
              stats['fees']!,
              Icons.currency_rupee,
              Colors.red,
            ),

            const SizedBox(height: 10),

            _statCard(
              'Latest Result',
              stats['result']!,
              Icons.emoji_events,
              Colors.blue,
            ),

            const SizedBox(height: 10),

            _statCard(
              'Subscription',
              stats['subscription']!,
              Icons.workspace_premium,
              Colors.amber,
            ),
          ],
        );
      },
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B1033), Color(0xFF132B5E)],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
