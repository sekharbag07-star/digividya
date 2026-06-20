import 'package:flutter/material.dart';

class StudentStats extends StatelessWidget {
  const StudentStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _statCard(
          "Attendance",
          "92%",
          Icons.fact_check,
          Colors.green,
        ),

        const SizedBox(height: 10),

        _statCard(
          "Pending Fees",
          "₹500",
          Icons.currency_rupee,
          Colors.red,
        ),

        const SizedBox(height: 10),

        _statCard(
          "Assignments",
          "3",
          Icons.assignment,
          Colors.orange,
        ),

        const SizedBox(height: 10),

        _statCard(
          "Result",
          "A Grade",
          Icons.emoji_events,
          Colors.blue,
        ),
      ],
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B1033),
            Color(0xFF132B5E),
          ],
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
