import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WelcomeBanner extends StatelessWidget {
  final int studentsCount;
  final int teachersCount;
  final int batchesCount;

  final int activeToday;
  final int pendingFees;
  final int newAdmissions;
  final int newEnquiries;

  const WelcomeBanner({
    super.key,
    required this.studentsCount,
    required this.teachersCount,
    required this.batchesCount,
    required this.activeToday,
    required this.pendingFees,
    required this.newAdmissions,
    required this.newEnquiries,
  });

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) return "🌅 Good Morning";
    if (hour < 17) return "☀️ Good Afternoon";
    return "🌙 Good Evening";
  }

  String getFestivalMessage() {
    return "🎉 Have a productive day";
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final day = DateFormat('EEEE').format(now);

    final date = DateFormat('dd MMMM yyyy').format(now);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B1033), Color(0xFF132B5E), Color(0xFF1E3A8A)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFFFD700), width: 1.5),
        boxShadow: const [
          BoxShadow(color: Color(0x22FFD700), blurRadius: 20, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${getGreeting()}, Admin",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text("$day • $date", style: const TextStyle(color: Colors.white70)),

          const SizedBox(height: 8),

          Text(
            getFestivalMessage(),
            style: const TextStyle(
              color: Color(0xFFFFD700),
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _stat("👨‍🎓 Students", studentsCount),
              _stat("👨‍🏫 Teachers", teachersCount),
              _stat("🏫 Batches", batchesCount),
              _stat("🟢 Active", activeToday),
              _stat("🔴 Pending", pendingFees),
              _stat("🟡 New", newAdmissions),
              _stat("🔵 Enquiry", newEnquiries),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String title, int value) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
          const SizedBox(height: 4),
          Text(
            value.toString(),
            style: const TextStyle(
              color: Color(0xFFFFD700),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}







