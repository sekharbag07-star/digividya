class PraveshData {
  // =========================
  // STUDENT DETAILS
  // =========================

  String fullName;
  String phoneNumber;
  String email;
  String password;

  String dateOfBirth;
  String age;
  String gender;

  String studentClass;

  String studentPhoto;

  // =========================
  // PARENT DETAILS
  // =========================

  String fatherName;
  String fatherMobile;
  String fatherWhatsapp;
  String fatherEmail;

  String motherName;
  String motherMobile;
  String motherWhatsapp;
  String motherEmail;

  // =========================
  // ADDRESS
  // =========================

  String address;
  String city;
  String state;
  String pinCode;

  // =========================
  // SCHOOL DETAILS
  // =========================

  bool alreadyStudying;

  String currentSchool;
  String previousSchool;

  // =========================
  // DOCUMENTS
  // =========================

  String aadhaarFile;
  String birthCertificateFile;
  String admitCardFile;

  String parentAadhaarFile;
  String addressProofFile;

  // =========================
  // PLAN
  // =========================

  String selectedPlan;
  double planAmount;

  // =========================
  // TERMS & CONSENT
  // =========================

  String parentConsentName;
  bool termsAccepted;

  // =========================
  // PAYMENT
  // =========================

  String paymentStatus;

  // pending
  // submitted
  // approved
  // rejected
  // expired

  // =========================
  // ADMISSION
  // =========================

  String admissionStatus;

  // pending
  // approved
  // rejected

  // =========================
  // SUBSCRIPTION
  // =========================

  bool subscriptionActive;

  String subscriptionStartDate;
  String subscriptionEndDate;

  // =========================
  // TIMESTAMPS
  // =========================

  String createdAt;
  String updatedAt;

  // =========================
  // CONSTRUCTOR
  // =========================

  PraveshData({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,

    required this.dateOfBirth,
    required this.age,
    required this.gender,

    required this.studentClass,

    required this.studentPhoto,

    required this.fatherName,
    required this.fatherMobile,
    required this.fatherWhatsapp,
    required this.fatherEmail,

    required this.motherName,
    required this.motherMobile,
    required this.motherWhatsapp,
    required this.motherEmail,

    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,

    required this.alreadyStudying,
    required this.currentSchool,
    required this.previousSchool,

    required this.aadhaarFile,
    required this.birthCertificateFile,
    required this.admitCardFile,

    required this.parentAadhaarFile,
    required this.addressProofFile,

    required this.selectedPlan,
    required this.planAmount,

    required this.parentConsentName,
    required this.termsAccepted,

    required this.paymentStatus,
    required this.admissionStatus,

    required this.subscriptionActive,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,

    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      // Student
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,

      'dateOfBirth': dateOfBirth,
      'age': age,
      'gender': gender,

      'studentClass': studentClass,

      'studentPhoto': studentPhoto,

      // Parent
      'fatherName': fatherName,
      'fatherMobile': fatherMobile,
      'fatherWhatsapp': fatherWhatsapp,
      'fatherEmail': fatherEmail,

      'motherName': motherName,
      'motherMobile': motherMobile,
      'motherWhatsapp': motherWhatsapp,
      'motherEmail': motherEmail,

      // Address
      'address': address,
      'city': city,
      'state': state,
      'pinCode': pinCode,

      // School
      'alreadyStudying': alreadyStudying,
      'currentSchool': currentSchool,
      'previousSchool': previousSchool,

      // Documents
      'aadhaarFile': aadhaarFile,
      'birthCertificateFile': birthCertificateFile,
      'admitCardFile': admitCardFile,

      'parentAadhaarFile': parentAadhaarFile,
      'addressProofFile': addressProofFile,

      // Plan
      'selectedPlan': selectedPlan,
      'planAmount': planAmount,

      // Consent
      'parentConsentName': parentConsentName,
      'termsAccepted': termsAccepted,

      // Payment
      'paymentStatus': paymentStatus,

      // Admission
      'admissionStatus': admissionStatus,

      // Subscription
      'subscriptionActive': subscriptionActive,
      'subscriptionStartDate': subscriptionStartDate,
      'subscriptionEndDate': subscriptionEndDate,

      // Timestamps
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
