import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // OTP credential validate karega
  Future<void> checkPhoneCredential(PhoneAuthCredential credential) async {
    final credentialUser = await _auth.signInWithCredential(credential);

    if (credentialUser.user == null) {
      throw FirebaseAuthException(
        code: 'phone-verification-failed',
        message: 'Phone verification failed.',
      );
    }

    // Phone verification ke baad session clean
    await _auth.signOut();
  }

  // Email account create
  Future<UserCredential> createAccount({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  // Email verification
  Future<void> sendEmailVerification(User user) async {
    await user.sendEmailVerification();
  }

  // Firestore Student Record
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

      // Profile
      'profileCompleted': false,

      // Admission
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

      // Status
      'active': true,

      // Audit
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    }, SetOptions(merge: true));
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
