import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/analytics_model.dart';

class AnalyticsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AnalyticsModel> getAnalytics() async {
    final usersSnapshot = await _firestore.collection('users').get();

    final paymentsSnapshot = await _firestore.collection('payments').get();

    int totalStudents = 0;
    int totalTeachers = 0;
    int activeSubscribers = 0;
    int trialUsers = 0;
    double totalRevenue = 0;

    for (final doc in usersSnapshot.docs) {
      final data = doc.data();

      final role = data['role'];
      final subscriptionActive = data['subscriptionActive'] ?? false;
      final trialActive = data['trialActive'] ?? false;

      if (role == 'student') totalStudents++;
      if (role == 'teacher') totalTeachers++;

      if (subscriptionActive) {
        activeSubscribers++;
      }

      if (trialActive) {
        trialUsers++;
      }
    }

    int pendingPayments = 0;

    for (final doc in paymentsSnapshot.docs) {
      final data = doc.data();

      if (data['status'] == 'pending') {
        pendingPayments++;
      }

      if (data['status'] == 'approved') {
        totalRevenue += (data['amount'] ?? 0).toDouble();
      }
    }

    return AnalyticsModel(
      totalStudents: totalStudents,
      totalTeachers: totalTeachers,
      activeSubscribers: activeSubscribers,
      trialUsers: trialUsers,
      pendingPayments: pendingPayments,
      totalRevenue: totalRevenue,
    );
  }
}
