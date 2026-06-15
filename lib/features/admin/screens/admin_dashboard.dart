import 'package:flutter/material.dart';

import '../../../../core/services/dashboard_service.dart';

import 'teacher/teacher_management_screen.dart';
import 'student/student_management_screen.dart';
import 'batch/batch_management_screen.dart';
import 'assignment/student_batch_screen.dart';
import 'attendance/attendance_screen.dart';
import 'fees/fee_management_screen.dart';
import 'exams/exam_management_screen.dart';
import 'results/result_entry_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final DashboardService _dashboardService = DashboardService();

  int studentsCount = 0;
  int teachersCount = 0;
  int batchesCount = 0;
  int feesCount = 0;
  double totalCollection = 0;
  double pendingAmount = 0;

  @override
  void initState() {
    super.initState();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    final students = await _dashboardService.getStudentsCount();
    final teachers = await _dashboardService.getTeachersCount();
    final batches = await _dashboardService.getBatchesCount();
    final fees = await _dashboardService.getFeesCount();

    final collection = await _dashboardService.getTotalCollection();
    final pending = await _dashboardService.getPendingAmount();

    if (!mounted) return;

    setState(() {
      studentsCount = students;
      teachersCount = teachers;
      batchesCount = batches;
      feesCount = fees;

      totalCollection = collection;
      pendingAmount = pending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard"), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: loadDashboardData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _statCard("Students", studentsCount.toString(), Icons.school),

                  _statCard("Teachers", teachersCount.toString(), Icons.person),

                  _statCard("Batches", batchesCount.toString(), Icons.groups),

                  _statCard("Fees", feesCount.toString(), Icons.receipt),

                  _statCard(
                    "Collection",
                    "₹${totalCollection.toStringAsFixed(0)}",
                    Icons.account_balance_wallet,
                  ),

                  _statCard(
                    "Pending",
                    "₹${pendingAmount.toStringAsFixed(0)}",
                    Icons.warning,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _dashboardCard(
                    context,
                    title: "Teachers",
                    icon: Icons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TeacherManagementScreen(),
                        ),
                      );
                    },
                  ),

                  _dashboardCard(
                    context,
                    title: "Students",
                    icon: Icons.school,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StudentManagementScreen(),
                        ),
                      );
                    },
                  ),

                  _dashboardCard(
                    context,
                    title: "Batches",
                    icon: Icons.groups,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BatchManagementScreen(),
                        ),
                      );
                    },
                  ),

                  _dashboardCard(
                    context,
                    title: "Student Batch",
                    icon: Icons.assignment_ind,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StudentBatchScreen(),
                        ),
                      );
                    },
                  ),

                  _dashboardCard(
                    context,
                    title: "Attendance",
                    icon: Icons.fact_check,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AttendanceScreen(),
                        ),
                      );
                    },
                  ),

                  _dashboardCard(
                    context,
                    title: "Fees",
                    icon: Icons.currency_rupee,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FeeManagementScreen(),
                        ),
                      );
                    },
                  ),

                  _dashboardCard(
                    context,
                    title: "Exams",
                    icon: Icons.quiz,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ExamManagementScreen(),
                        ),
                      );
                    },
                  ),

                  _dashboardCard(
                    context,
                    title: "Results",
                    icon: Icons.leaderboard,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ResultEntryScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(title, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _dashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
