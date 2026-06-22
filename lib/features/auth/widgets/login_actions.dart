import 'package:flutter/material.dart';
import 'package:digividya/features/parent/auth/screens/parent_register_screen.dart';

class LoginActions extends StatelessWidget {
  final bool isLoading;

  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;
  final VoidCallback onRegister;

  const LoginActions({
    super.key,
    required this.isLoading,
    required this.onLogin,
    required this.onForgotPassword,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: onForgotPassword,
            child: const Text("Forgot Password?"),
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1565C0),
              foregroundColor: Colors.white,
            ),
            onPressed: isLoading ? null : onLogin,
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
                    "Login",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          ),
        ),

        const SizedBox(height: 10),

        TextButton(
          onPressed: onRegister,
          child: const Text("New Here? Create Account"),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ParentRegisterScreen()),
            );
          },
          child: const Text("Parent Registration"),
        ),
      ],
    );
  }
}
