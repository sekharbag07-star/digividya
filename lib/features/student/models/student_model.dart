class StudentModel {
  final String uid;
  final String name;
  final String email;
  final String phone;

  final String studentClass;

  final String fatherName;
  final String fatherMobile;

  final String motherName;
  final String motherMobile;

  final String address;

  final String paymentStatus;
  final String admissionStatus;

  final bool subscriptionActive;

  StudentModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.studentClass,
    required this.fatherName,
    required this.fatherMobile,
    required this.motherName,
    required this.motherMobile,
    required this.address,
    required this.paymentStatus,
    required this.admissionStatus,
    required this.subscriptionActive,
  });

  factory StudentModel.fromMap(String uid, Map<String, dynamic> data) {
    return StudentModel(
      uid: uid,
      name: data['fullName'] ?? data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phoneNumber'] ?? data['phone'] ?? '',

      studentClass: data['studentClass'] ?? '',

      fatherName: data['fatherName'] ?? '',
      fatherMobile: data['fatherMobile'] ?? '',

      motherName: data['motherName'] ?? '',
      motherMobile: data['motherMobile'] ?? '',

      address: data['address'] ?? '',

      paymentStatus: data['paymentStatus'] ?? 'pending',
      admissionStatus: data['admissionStatus'] ?? 'pending',

      subscriptionActive: data['subscriptionActive'] ?? false,
    );
  }
}
