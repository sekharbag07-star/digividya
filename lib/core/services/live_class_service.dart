import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/live_classes/models/live_class_model.dart';

class LiveClassService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> addLiveClass(
    LiveClassModel liveClass,
  ) async {
    await _firestore
        .collection('live_classes')
        .add(liveClass.toMap());
  }

  Stream<List<LiveClassModel>> getLiveClasses() {
    return _firestore
        .collection('live_classes')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return LiveClassModel.fromMap(
          doc.id,
          doc.data(),
        );
      }).toList();
    });
  }

  Future<void> deleteLiveClass(
    String classId,
  ) async {
    await _firestore
        .collection('live_classes')
        .doc(classId)
        .delete();
  }

  Future<void> updateClassStatus(
    String classId,
    bool isActive,
  ) async {
    await _firestore
        .collection('live_classes')
        .doc(classId)
        .update({
      'isActive': isActive,
    });
  }
}





