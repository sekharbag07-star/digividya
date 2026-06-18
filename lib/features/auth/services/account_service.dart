import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> createAccount({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> sendEmailVerification(User user) async {
    await user.sendEmailVerification();
  }

  Future<void> createStudentRecord({
    required String uid,
    required String fullName,
    required String phoneNumber,
    required String email,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'name': fullName,
      'phone': phoneNumber,
      'email': email,

      'role': 'student',

      // Admission Flow
      'profileCompleted': false,
      'admissionStatus': 'pending',

      // Payment
      'paymentStatus': 'pending',

      // Subscription
      'subscriptionActive': false,
      'subscriptionStartDate': '',
      'subscriptionEndDate': '',

      // Verification
      'phoneVerified': true,
      'emailVerified': false,

      // Audit
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    }, SetOptions(merge: true));
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
