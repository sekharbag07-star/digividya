import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth/screens/login_screen.dart';

import '../../../../core/services/dashboard_service.dart';

import 'teacher/teacher_management_screen.dart';
import 'student/student_management_screen.dart';
import 'batch/batch_management_screen.dart';
import 'assignment/student_batch_screen.dart';
import 'attendance/attendance_screen.dart';
import 'fees/fee_management_screen.dart';
import 'exams/exam_management_screen.dart';
import 'results/result_entry_screen.dart';
import 'payment_approval_screen.dart';

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
      appBar: AppBar(
  title: const Text("Admin Dashboard"),
  centerTitle: true,
  actions: [
    IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () async {
        await FirebaseAuth.instance.signOut();

        if (!mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
          (route) => false,
        );
      },
    ),
  ],
),
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
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF0B1033),
                      Color(0xFF132B5E),
                      Color(0xFF1E3A8A),
                    ],
                  ),
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

              Column(
                children: [
                  _statCard("Students", studentsCount.toString(), Icons.school),

                  const SizedBox(height: 10),

                  _statCard("Teachers", teachersCount.toString(), Icons.person),

                  const SizedBox(height: 10),

                  _statCard("Batches", batchesCount.toString(), Icons.groups),

                  const SizedBox(height: 10),

                  _statCard("Fees", feesCount.toString(), Icons.receipt_long),

                  const SizedBox(height: 10),

                  _statCard(
                    "Collection",
                    "₹${totalCollection.toStringAsFixed(0)}",
                    Icons.account_balance_wallet,
                  ),

                  const SizedBox(height: 10),

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
                  "Recent Activities",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 12),

              Column(
                children: [
                  _activityCapsule(Icons.person_add, "New Student Added"),

                  const SizedBox(height: 8),

                  _activityCapsule(Icons.currency_rupee, "Fee Received"),

                  const SizedBox(height: 8),

                  _activityCapsule(Icons.fact_check, "Attendance Updated"),
                ],
              ),

              const SizedBox(height: 25),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Analytics",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 12),

              Column(
                children: [
                  _statCard("Students", studentsCount.toString(), Icons.school),

                  const SizedBox(height: 8),

                  _statCard("Teachers", teachersCount.toString(), Icons.person),

                  const SizedBox(height: 8),

                  _statCard(
                    "Collection",
                    "₹${totalCollection.toStringAsFixed(0)}",
                    Icons.account_balance_wallet,
                  ),

                  const SizedBox(height: 8),

                  _statCard(
                    "Pending",
                    "₹${pendingAmount.toStringAsFixed(0)}",
                    Icons.warning,
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

              Column(
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

                  const SizedBox(height: 8),

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

                  const SizedBox(height: 8),

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

                  const SizedBox(height: 8),

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

                  const SizedBox(height: 8),

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

                  const SizedBox(height: 8),

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

                  const SizedBox(height: 8),

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

                  const SizedBox(height: 8),

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

                  const SizedBox(height: 8),

                  _dashboardCard(
                    context,
                    title: "Payment Approvals",
                    icon: Icons.payments,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PaymentApprovalScreen(),
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
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 4),
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
          Icon(icon, color: const Color(0xFFFFD700), size: 22),

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

          Text(
            value,
            style: const TextStyle(
              color: Color(0xFFFFD700),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityCapsule(IconData icon, String title) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(vertical: 4),
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
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
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
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(vertical: 4),
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
    );
  }
}
