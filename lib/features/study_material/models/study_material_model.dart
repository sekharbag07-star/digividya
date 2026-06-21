class StudyMaterialModel {
  final String id;
  final String title;
  final String subject;
  final String batch;
  final String type;
  final String fileUrl;
  final DateTime createdAt;

  StudyMaterialModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.batch,
    required this.type,
    required this.fileUrl,
    required this.createdAt,
  });

  factory StudyMaterialModel.fromMap(
    String id,
    Map<String, dynamic> data,
  ) {
    return StudyMaterialModel(
      id: id,
      title: data['title'] ?? '',
      subject: data['subject'] ?? '',
      batch: data['batch'] ?? '',
      type: data['type'] ?? 'pdf',
      fileUrl: data['fileUrl'] ?? '',
      createdAt:
          data['createdAt']?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subject': subject,
      'batch': batch,
      'type': type,
      'fileUrl': fileUrl,
      'createdAt': createdAt,
    };
  }
}







