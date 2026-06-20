import 'package:flutter/material.dart';

import '../../users/student/screens/student_management_screen.dart';
import '../../users/teacher/screens/teacher_management_screen.dart';

import '../../academics/batches/screens/batch_management_screen.dart';
import '../../academics/student_batch/screens/student_batch_screen.dart';
import '../../academics/attendance/screens/attendance_screen.dart';
import '../../academics/exams/screens/exam_management_screen.dart';
import '../../academics/results/screens/result_entry_screen.dart';

import '../../finance/screens/fee_management_screen.dart';
import '../../finance/screens/payment_approval_screen.dart';

class DashboardActions extends StatelessWidget {
  const DashboardActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        dashboardCard(
          context,
          "Teachers",
          Icons.person,
          const TeacherManagementScreen(),
        ),

        dashboardCard(
          context,
          "Students",
          Icons.school,
          const StudentManagementScreen(),
        ),

        dashboardCard(
          context,
          "Batches",
          Icons.groups,
          const BatchManagementScreen(),
        ),

        dashboardCard(
          context,
          "Attendance",
          Icons.fact_check,
          const AttendanceScreen(),
        ),

        dashboardCard(
          context,
          "Student Batch",
          Icons.assignment_ind,
          const StudentBatchScreen(),
        ),

        dashboardCard(
          context,
          "Fees",
          Icons.currency_rupee,
          const FeeManagementScreen(),
        ),

        dashboardCard(
          context,
          "Exams",
          Icons.quiz,
          const ExamManagementScreen(),
        ),

        dashboardCard(
          context,
          "Results",
          Icons.leaderboard,
          const ResultEntryScreen(),
        ),

        dashboardCard(
          context,
          "Payment Approvals",
          Icons.payments,
          const PaymentApprovalScreen(),
        ),
      ],
    );
  }

  Widget dashboardCard(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        },
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0B1033), Color(0xFF132B5E)],
            ),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: const Color(0xFFFFD700), width: 1.5),
          ),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFFFFD700)),

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

              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFFFFD700),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
