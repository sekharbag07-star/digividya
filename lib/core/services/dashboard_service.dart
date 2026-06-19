import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> getStudentsCount() async {
    return (await _firestore.collection('students').get()).docs.length;
  }

  Future<int> getTeachersCount() async {
    return (await _firestore.collection('teachers').get()).docs.length;
  }

  Future<int> getBatchesCount() async {
    return (await _firestore.collection('batches').get()).docs.length;
  }

  Future<int> getFeesCount() async {
    return (await _firestore.collection('fees').get()).docs.length;
  }

  Future<int> getPendingFeesCount() async {
    return (await _firestore
            .collection('fees')
            .where('status', isEqualTo: 'Pending')
            .get())
        .docs
        .length;
  }

  Future<int> getNewAdmissionsCount() async {
    final today = DateTime.now();

    final startOfDay = DateTime(today.year, today.month, today.day);

    return (await _firestore
            .collection('students')
            .where(
              'createdAt',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
            )
            .get())
        .docs
        .length;
  }

  Future<double> getTotalCollection() async {
    final snapshot = await _firestore
        .collection('fees')
        .where('status', isEqualTo: 'Paid')
        .get();

    double total = 0;

    for (var doc in snapshot.docs) {
      total += (doc['amount'] as num).toDouble();
    }

    return total;
  }

  Future<double> getPendingAmount() async {
    final snapshot = await _firestore
        .collection('fees')
        .where('status', isEqualTo: 'Pending')
        .get();

    double total = 0;

    for (var doc in snapshot.docs) {
      total += (doc['amount'] as num).toDouble();
    }

    return total;
  }
}
