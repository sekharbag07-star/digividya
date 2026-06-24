import 'package:cloud_firestore/cloud_firestore.dart';

class AiChatMessage {
  final String id;
  final String role;
  final String message;
  final Timestamp createdAt;

  final String? parentMessageId;

  // Favorites Support
  final bool isFavorite;

  const AiChatMessage({
    required this.id,
    required this.role,
    required this.message,
    required this.createdAt,
    this.parentMessageId,
    this.isFavorite = false,
  });

  factory AiChatMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return AiChatMessage(
      id: doc.id,
      role: data['role'] ?? 'user',
      message: data['message'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      parentMessageId: data['parentMessageId'],
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'message': message,
      'createdAt': createdAt,
      'parentMessageId': parentMessageId,
      'isFavorite': isFavorite,
    };
  }

  AiChatMessage copyWith({
    String? id,
    String? role,
    String? message,
    Timestamp? createdAt,
    String? parentMessageId,
    bool? isFavorite,
  }) {
    return AiChatMessage(
      id: id ?? this.id,
      role: role ?? this.role,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      parentMessageId: parentMessageId ?? this.parentMessageId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
