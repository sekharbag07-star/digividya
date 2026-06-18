import 'package:firebase_auth/firebase_auth.dart';

class OtpService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendOtp({
    required String phoneNumber,
    required Function(String) onCodeSent,
    required Function(FirebaseAuthException) onFailed,
    required Function(PhoneAuthCredential) onAutoVerify,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      verificationCompleted: onAutoVerify,

      verificationFailed: onFailed,

      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },

      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  PhoneAuthCredential createCredential({
    required String verificationId,
    required String otp,
  }) {
    return PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
  }
}
