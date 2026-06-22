class AssignmentModel {
  final String id;
  final String title;
  final String description;
  final String dueDate;
  final String batchName;

  AssignmentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.batchName,
  });

  factory AssignmentModel.fromMap(String id, Map<String, dynamic> data) {
    return AssignmentModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      dueDate: data['dueDate'] ?? '',
      batchName: data['batchName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'batchName': batchName,
    };
  }
}
