import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String generateChatId({
    required String parentUid,
    required String teacherUid,
  }) {
    return '${parentUid}_$teacherUid';
  }

  Future<void> sendMessage({
    required String parentUid,
    required String teacherUid,
    required String senderId,
    required String receiverId,
    required String senderRole,
    required String message,
  }) async {
    final chatId = generateChatId(parentUid: parentUid, teacherUid: teacherUid);

    await _firestore.collection('chats').doc(chatId).set({
      'parentUid': parentUid,
      'teacherUid': teacherUid,
      'lastMessage': message,
      'lastMessageTime': Timestamp.now(),
    }, SetOptions(merge: true));

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
          'senderId': senderId,
          'receiverId': receiverId,
          'senderRole': senderRole,
          'message': message,
          'isRead': false,
          'createdAt': Timestamp.now(),
        });
  }

  Stream<QuerySnapshot> getMessages({
    required String parentUid,
    required String teacherUid,
  }) {
    final chatId = generateChatId(parentUid: parentUid, teacherUid: teacherUid);

    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots();
  }

  Future<void> markAsRead({
    required String parentUid,
    required String teacherUid,
  }) async {
    final chatId = generateChatId(parentUid: parentUid, teacherUid: teacherUid);

    final docs = await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('isRead', isEqualTo: false)
        .get();

    for (final doc in docs.docs) {
      await doc.reference.update({'isRead': true});
    }
  }
}
