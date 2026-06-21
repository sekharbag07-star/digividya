import 'package:flutter/material.dart';

import '../models/analytics_model.dart';
import '../services/analytics_service.dart';
import '../widgets/analytics_grid.dart';

class AnalyticsDashboardScreen extends StatefulWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  State<AnalyticsDashboardScreen> createState() =>
      _AnalyticsDashboardScreenState();
}

class _AnalyticsDashboardScreenState extends State<AnalyticsDashboardScreen> {
  final AnalyticsService _analyticsService = AnalyticsService();

  late Future<AnalyticsModel> _analyticsFuture;

  @override
  void initState() {
    super.initState();
    _analyticsFuture = _analyticsService.getAnalytics();
  }

  Future<void> _refresh() async {
    setState(() {
      _analyticsFuture = _analyticsService.getAnalytics();
    });

    await _analyticsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics Dashboard')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<AnalyticsModel>(
          future: _analyticsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final analytics = snapshot.data ?? AnalyticsModel.empty();

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Business Overview',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  AnalyticsGrid(analytics: analytics),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
