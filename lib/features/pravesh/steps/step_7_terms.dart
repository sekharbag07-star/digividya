import 'package:flutter/material.dart';

class Step7Terms extends StatelessWidget {
  final bool termsAccepted;
  final ValueChanged<bool?> onTermsChanged;

  final TextEditingController parentConsentController;

  const Step7Terms({
    super.key,
    required this.termsAccepted,
    required this.onTermsChanged,
    required this.parentConsentController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Declaration & Consent",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: parentConsentController,
                decoration: const InputDecoration(
                  labelText: "Parent / Guardian Full Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "I confirm that all information provided in this admission form is true and correct. I agree to coaching institute rules and policies.",
                ),
              ),

              const SizedBox(height: 20),

              CheckboxListTile(
                value: termsAccepted,
                onChanged: onTermsChanged,
                title: const Text("I accept all terms and conditions"),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
