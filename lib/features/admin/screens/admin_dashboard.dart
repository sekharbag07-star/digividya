import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/screens/login_screen.dart';
import '../../../../core/services/dashboard_service.dart';

import '../widgets/admin_widgets.dart';

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

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
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
              const DashboardHeader(),

              const SizedBox(height: 20),

              DashboardStats(
                studentsCount: studentsCount,
                teachersCount: teachersCount,
                batchesCount: batchesCount,
                feesCount: feesCount,
                totalCollection: totalCollection,
                pendingAmount: pendingAmount,
              ),

              const SizedBox(height: 25),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recent Activities",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const DashboardActivities(),

              const SizedBox(height: 25),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const DashboardActions(),
            ],
          ),
        ),
      ),
    );
  }
}