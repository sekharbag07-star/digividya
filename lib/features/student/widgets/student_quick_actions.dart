import 'package:flutter/material.dart';

import '../attendance/screens/student_attendance_screen.dart';
import '../assignments/screens/student_assignment_screen.dart';
import '../results/screens/student_result_screen.dart';
import '../fees/screens/student_fee_screen.dart';
import '../profile/screens/student_profile_screen.dart';
import '../../live_classes/screens/live_class_list_screen.dart';

class StudentQuickActions extends StatelessWidget {
  const StudentQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.4,
      children: [
        _actionCard(
          context,
          "Attendance",
          Icons.fact_check,
          const StudentAttendanceScreen(),
        ),

        _actionCard(
          context,
          "Assignments",
          Icons.assignment,
          const StudentAssignmentScreen(),
        ),

        _actionCard(
          context,
          "Results",
          Icons.leaderboard,
          const StudentResultScreen(),
        ),

        _actionCard(
          context,
          "Fees",
          Icons.currency_rupee,
          const StudentFeeScreen(),
        ),

        _actionCard(
          context,
          "Profile",
          Icons.person,
          const StudentProfileScreen(),
        ),

        _actionCard(
          context,
          "Live Class",
          Icons.live_tv,
          const LiveClassListScreen(),
        ),
      ],
    );
  }

  Widget _actionCard(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => screen,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0B1033),
              Color(0xFF132B5E),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.amber,
              size: 32,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



