import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/notices/models/notice_model.dart';

class NoticeService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> addNotice(NoticeModel notice) async {
    await _firestore
        .collection('notices')
        .add(notice.toMap());
  }

  Stream<List<NoticeModel>> getNotices({
    String role = 'all',
  }) {
    return _firestore
        .collection('notices')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.where((doc) {
        final data = doc.data();

        return data['targetRole'] == 'all' ||
            data['targetRole'] == role;
      }).map((doc) {
        return NoticeModel.fromMap(
          doc.id,
          doc.data(),
        );
      }).toList();
    });
  }

  Future<void> deleteNotice(String noticeId) async {
    await _firestore
        .collection('notices')
        .doc(noticeId)
        .delete();
  }
}





