import 'package:flutter/material.dart';

class StudentLiveClassCard extends StatelessWidget {
  final String title;
  final String teacher;
  final String time;
  final VoidCallback onJoin;

  const StudentLiveClassCard({
    super.key,
    required this.title,
    required this.teacher,
    required this.time,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B1033),
            Color(0xFF132B5E),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.live_tv,
                color: Colors.red,
              ),
              SizedBox(width: 8),
              Text(
                "LIVE CLASS",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Teacher: $teacher",
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),

          Text(
            "Time: $time",
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onJoin,
              child: const Text("Join Class"),
            ),
          ),
        ],
      ),
    );
  }
}







