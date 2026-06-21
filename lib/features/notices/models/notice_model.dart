class NoticeModel {
  final String id;
  final String title;
  final String description;
  final String type;
  final String targetRole;
  final String fileUrl;
  final DateTime createdAt;

  NoticeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.targetRole,
    required this.fileUrl,
    required this.createdAt,
  });

  factory NoticeModel.fromMap(
    String id,
    Map<String, dynamic> data,
  ) {
    return NoticeModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      type: data['type'] ?? 'text',
      targetRole: data['targetRole'] ?? 'all',
      fileUrl: data['fileUrl'] ?? '',
      createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'targetRole': targetRole,
      'fileUrl': fileUrl,
      'createdAt': createdAt,
    };
  }
}





