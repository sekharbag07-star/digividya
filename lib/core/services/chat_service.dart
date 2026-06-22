import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required String chatId,
    required String chatType,
    required String senderId,
    required String receiverId,
    required String senderRole,
    required String message,

    String? parentUid,
    String? teacherUid,
    String? supportUid,
  }) async {
    await _firestore.collection('chats').doc(chatId).set({
      'chatType': chatType,

      'parentUid': parentUid,
      'teacherUid': teacherUid,
      'supportUid': supportUid,

      'participants': [senderId, receiverId],

      'lastMessage': message,
      'lastMessageTime': Timestamp.now(),
      'createdAt': Timestamp.now(),
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
          'messageType': 'text',

          'isRead': false,
          'createdAt': Timestamp.now(),
        });
  }

  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots();
  }

  Future<void> markAsRead(String chatId) async {
    final docs = await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('isRead', isEqualTo: false)
        .get();

    final batch = _firestore.batch();

    for (final doc in docs.docs) {
      batch.update(doc.reference, {'isRead': true});
    }

    await batch.commit();
  }

  Stream<QuerySnapshot> getUserChats(String userId) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots();
  }
}
