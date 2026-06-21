import 'package:flutter/material.dart';
import 'package:digividya/core/services/dashboard_service.dart';

import 'package:digividya/features/admin/dashboard/widgets/lotus/lotus_dashboard.dart';
import 'package:digividya/features/admin/dashboard/widgets/dashboard_activities.dart';
import 'package:digividya/features/admin/dashboard/widgets/lotus/welcome_banner.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
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
    return RefreshIndicator(
      onRefresh: loadDashboardData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            WelcomeBanner(
              studentsCount: studentsCount,
              teachersCount: teachersCount,
              batchesCount: batchesCount,
              activeToday: 0,
              pendingFees: 0,
              newAdmissions: 0,
              newEnquiries: 0,
            ),

            const SizedBox(height: 20),

            LotusDashboard(
              studentsCount: studentsCount,
              teachersCount: teachersCount,
              batchesCount: batchesCount,
              feesCount: feesCount,
              totalCollection: totalCollection,
              pendingAmount: pendingAmount,
            ),

            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Activities",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            const DashboardActivities(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}







