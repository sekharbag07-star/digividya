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
}
