class AnalyticsModel {
  final int totalStudents;
  final int totalTeachers;
  final int activeSubscribers;
  final int trialUsers;
  final int pendingPayments;
  final double totalRevenue;

  const AnalyticsModel({
    required this.totalStudents,
    required this.totalTeachers,
    required this.activeSubscribers,
    required this.trialUsers,
    required this.pendingPayments,
    required this.totalRevenue,
  });

  factory AnalyticsModel.empty() {
    return const AnalyticsModel(
      totalStudents: 0,
      totalTeachers: 0,
      activeSubscribers: 0,
      trialUsers: 0,
      pendingPayments: 0,
      totalRevenue: 0,
    );
  }
}
