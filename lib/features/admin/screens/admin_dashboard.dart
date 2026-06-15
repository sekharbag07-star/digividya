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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Admin",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Manage your coaching institute efficiently",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

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

                  _statCard("Fees", feesCount.toString(), Icons.receipt_long),

                  _statCard(
                    "Collection",
                    "₹${totalCollection.toStringAsFixed(0)}",
                    Icons.account_balance_wallet,
                  ),

                  _statCard(
                    "Pending",
                    "₹${pendingAmount.toStringAsFixed(0)}",
                    Icons.warning_amber_rounded,
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Quick Actions",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 12),

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
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 24, child: Icon(icon, size: 24)),

            const SizedBox(height: 8),

            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
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
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 28, child: Icon(icon, size: 28)),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
