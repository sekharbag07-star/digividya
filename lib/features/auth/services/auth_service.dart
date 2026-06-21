import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> sendResetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<bool> isEmailVerified() async {
    User? user = _auth.currentUser;

    if (user == null) {
      return false;
    }

    await user.reload();

    user = _auth.currentUser;

    return user?.emailVerified ?? false;
  }

  Future<void> resendVerificationEmail() async {
    User? user = _auth.currentUser;

    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  User? get currentUser => _auth.currentUser;
}





