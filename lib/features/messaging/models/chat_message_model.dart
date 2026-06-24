class ChatMessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String senderRole;
  final String message;
  final DateTime createdAt;
  final bool isRead;

  ChatMessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.senderRole,
    required this.message,
    required this.createdAt,
    required this.isRead,
  });

  factory ChatMessageModel.fromMap(String id, Map<String, dynamic> data) {
    return ChatMessageModel(
      id: id,
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      senderRole: data['senderRole'] ?? '',
      message: data['message'] ?? '',
      createdAt: data['createdAt'] != null
          ? data['createdAt'].toDate()
          : DateTime.now(),
      isRead: data['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'senderRole': senderRole,
      'message': message,
      'createdAt': createdAt,
      'isRead': isRead,
    };
  }
}
