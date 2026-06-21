class LiveClassModel {
  final String id;
  final String title;
  final String teacher;
  final String meetingLink;
  final String date;
  final String time;
  final bool isActive;

  LiveClassModel({
    required this.id,
    required this.title,
    required this.teacher,
    required this.meetingLink,
    required this.date,
    required this.time,
    required this.isActive,
  });

  factory LiveClassModel.fromMap(
    String id,
    Map<String, dynamic> data,
  ) {
    return LiveClassModel(
      id: id,
      title: data['title'] ?? '',
      teacher: data['teacher'] ?? '',
      meetingLink: data['meetingLink'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      isActive: data['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'teacher': teacher,
      'meetingLink': meetingLink,
      'date': date,
      'time': time,
      'isActive': isActive,
    };
  }
}







