import 'package:cloud_firestore/cloud_firestore.dart';

class ParentLinkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> linkStudentAndParent({
    required String studentUid,
    required String parentUid,
  }) async {
    await _firestore.collection('users').doc(studentUid).update({
      'parentUid': parentUid,
    });

    await _firestore.collection('users').doc(parentUid).update({
      'studentUid': studentUid,
    });
  }
}
