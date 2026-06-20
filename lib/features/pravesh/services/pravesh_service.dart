import 'package:cloud_firestore/cloud_firestore.dart';

class PraveshService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> savePravesh({
    required String uid,

    // Student
    required String fullName,
    required String dob,
    required String age,
    required String gender,
    required String studentClass,

    // Parent
    required String fatherName,
    required String fatherMobile,
    required String fatherWhatsapp,
    required String fatherEmail,

    required String motherName,
    required String motherMobile,
    required String motherWhatsapp,
    required String motherEmail,

    // Address
    required String address,
    required String city,
    required String state,
    required String pincode,

    // School
    required bool alreadyStudying,
    required String currentSchool,
    required String previousSchool,

    // Plan
    required String selectedPlan,
    required int planAmount,

    // Consent
    required String parentConsentName,
    required bool termsAccepted,

    // Documents
    String? studentPhotoUrl,
    String? birthCertificateUrl,
    String? aadhaarUrl,
    String? admitCardUrl,
    String? parentAadhaarUrl,
    String? addressProofUrl,
  }) async {
    final now = Timestamp.now();

    await _firestore.collection('users').doc(uid).set({
      // ======================
      // STUDENT
      // ======================
      'fullName': fullName,
      'dob': dob,
      'age': age,
      'gender': gender,
      'studentClass': studentClass,

      // ======================
      // PARENT
      // ======================
      'fatherName': fatherName,
      'fatherMobile': fatherMobile,
      'fatherWhatsapp': fatherWhatsapp,
      'fatherEmail': fatherEmail,

      'motherName': motherName,
      'motherMobile': motherMobile,
      'motherWhatsapp': motherWhatsapp,
      'motherEmail': motherEmail,

      // ======================
      // ADDRESS
      // ======================
      'address': address,
      'city': city,
      'state': state,
      'pinCode': pincode,

      // ======================
      // SCHOOL
      // ======================
      'alreadyStudying': alreadyStudying,
      'currentSchool': currentSchool,
      'previousSchool': previousSchool,

      // ======================
      // PLAN
      // ======================
      'selectedPlan': selectedPlan,
      'planAmount': planAmount,

      // ======================
      // CONSENT
      // ======================
      'parentConsentName': parentConsentName,

      'termsAccepted': termsAccepted,

      // ======================
      // DOCUMENTS
      // ======================
      'studentPhoto': studentPhotoUrl ?? '',

      'birthCertificateFile': birthCertificateUrl ?? '',

      'aadhaarFile': aadhaarUrl ?? '',

      'admitCardFile': admitCardUrl ?? '',

      'parentAadhaarFile': parentAadhaarUrl ?? '',

      'addressProofFile': addressProofUrl ?? '',

      // ======================
      // PAYMENT
      // ======================
      'paymentStatus': 'pending',

      // pending
      // submitted
      // approved
      // rejected

      // ======================
      // ADMISSION
      // ======================
      'admissionStatus': 'pending',

      // pending
      // approved
      // rejected

      // ======================
      // SUBSCRIPTION
      // ======================
      'subscriptionActive': false,

      'subscriptionStartDate': '',

      'subscriptionEndDate': '',

      // ======================
      // SYSTEM
      // ======================
      'profileCompleted': true,

      'createdAt': now,
      'updatedAt': now,
    }, SetOptions(merge: true));
  }
}



