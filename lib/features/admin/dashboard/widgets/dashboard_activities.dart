import 'package:flutter/material.dart';

class DashboardActivities extends StatelessWidget {
  const DashboardActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        activityCard(
          Icons.person_add,
          "New Student Added",
        ),

        const SizedBox(height: 8),

        activityCard(
          Icons.currency_rupee,
          "Fee Received",
        ),

        const SizedBox(height: 8),

        activityCard(
          Icons.fact_check,
          "Attendance Updated",
        ),
      ],
    );
  }

  Widget activityCard(
    IconData icon,
    String title,
  ) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B1033),
            Color(0xFF132B5E),
          ],
        ),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: const Color(0xFFFFD700),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFFFFD700),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}







