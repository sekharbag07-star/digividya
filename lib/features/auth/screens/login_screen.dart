import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';
import '../services/role_router_service.dart';

import '../widgets/login_logo.dart';
import '../widgets/login_form.dart';
import '../widgets/login_actions.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool isLoading = false;
  bool obscurePassword = true;

  Future<void> login() async {
    final messenger = ScaffoldMessenger.of(context);

    final navigator = Navigator.of(context);

    try {
      setState(() {
        isLoading = true;
      });

      final email = emailController.text.trim();

      final password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        messenger.showSnackBar(
          const SnackBar(content: Text("Please enter email and password")),
        );
        return;
      }

      UserCredential credential = await _authService.login(
        email: email,
        password: password,
      );

      User user = credential.user!;

      await user.reload();

      user = FirebaseAuth.instance.currentUser!;

      final verified = await _authService.isEmailVerified();

      if (!verified) {
        await FirebaseAuth.instance.signOut();

        if (!mounted) return;

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Email Not Verified"),
            content: const Text("Please verify your email before login."),
            actions: [
              TextButton(
                onPressed: () async {
                  await user.sendEmailVerification();

                  if (!mounted) return;

                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text("Verification email sent again"),
                    ),
                  );

                  Navigator.pop(context);
                },
                child: const Text("Resend Email"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );

        return;
      }

      final screen = await RoleRouterService.getHomeScreen(user.uid);

      if (!mounted) return;

      if (screen == null) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text(
              "Account pending approval, payment, or subscription activation.",
            ),
          ),
        );
        return;
      }

      navigator.pushReplacement(MaterialPageRoute(builder: (_) => screen));
    } catch (e) {
      if (!mounted) return;

      messenger.showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> resetPassword() async {
    final messenger = ScaffoldMessenger.of(context);

    if (emailController.text.trim().isEmpty) {
      messenger.showSnackBar(
        const SnackBar(content: Text("Enter your email first")),
      );
      return;
    }

    try {
      await _authService.sendResetPassword(email: emailController.text.trim());

      if (!mounted) return;

      messenger.showSnackBar(
        const SnackBar(content: Text("Password reset email sent")),
      );
    } catch (e) {
      if (!mounted) return;

      messenger.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("DigiVidya")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              children: [
                const SizedBox(height: 20),

                const LoginLogo(),

                const SizedBox(height: 30),

                LoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  obscurePassword: obscurePassword,
                  onTogglePassword: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  onPasswordSubmitted: (_) => login(),
                ),

                const SizedBox(height: 10),

                LoginActions(
                  isLoading: isLoading,
                  onLogin: login,
                  onForgotPassword: resetPassword,
                  onRegister: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
