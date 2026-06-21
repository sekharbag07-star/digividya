import 'package:flutter/material.dart';

import '../models/analytics_model.dart';
import 'analytics_card.dart';

class AnalyticsGrid extends StatelessWidget {
  final AnalyticsModel analytics;

  const AnalyticsGrid({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        AnalyticsCard(
          title: 'Students',
          value: analytics.totalStudents.toString(),
          icon: Icons.school,
        ),

        AnalyticsCard(
          title: 'Teachers',
          value: analytics.totalTeachers.toString(),
          icon: Icons.person,
        ),

        AnalyticsCard(
          title: 'Subscribers',
          value: analytics.activeSubscribers.toString(),
          icon: Icons.workspace_premium,
        ),

        AnalyticsCard(
          title: 'Trial Users',
          value: analytics.trialUsers.toString(),
          icon: Icons.timer,
        ),

        AnalyticsCard(
          title: 'Pending Payments',
          value: analytics.pendingPayments.toString(),
          icon: Icons.pending_actions,
        ),

        AnalyticsCard(
          title: 'Revenue',
          value: '₹${analytics.totalRevenue.toStringAsFixed(0)}',
          icon: Icons.currency_rupee,
        ),
      ],
    );
  }
}
