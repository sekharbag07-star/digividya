import 'package:flutter/material.dart';

class NiyamShartein extends StatefulWidget {
  final VoidCallback onAccepted;

  const NiyamShartein({super.key, required this.onAccepted});

  @override
  State<NiyamShartein> createState() => _NiyamSharteinState();
}

class _NiyamSharteinState extends State<NiyamShartein> {
  bool accepted = false;

  final parentNameController = TextEditingController();

  @override
  void dispose() {
    parentNameController.dispose();
    super.dispose();
  }

  void continueRegistration() {
    if (parentNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Parent / Guardian Name required")),
      );
      return;
    }

    if (!accepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept Terms & Conditions")),
      );
      return;
    }

    widget.onAccepted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Niyam Aur Shartein")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "DIGIVIDYA ADMISSION TERMS",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "1. Student aur Parent dwara di gayi sabhi jankari satya honi chahiye.",
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "2. Fake documents paye jane par admission turant cancel kiya ja sakta hai.",
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "3. Fees payment hone ke baad refund policy ke anusaar hi refund diya jayega.",
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "4. Student ko classes, tests aur assignments me niyamit roop se bhag lena hoga.",
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "5. DigiVidya cheating, abuse ya misconduct par account suspend kar sakta hai.",
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "6. Parent ko mobile number aur email active rakhna hoga.",
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "7. Attendance, Result, Homework aur Notices app ke madhyam se diye jayenge.",
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "8. DigiVidya bhavishya me fees, plans aur policies update kar sakta hai.",
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "9. Uploaded documents sirf admission verification aur academic purpose ke liye use honge.",
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "10. Registration submit karne par aap sabhi niyam aur shartein svikaar karte hain.",
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "11. Parent/Guardian admission ke liye digital consent dete hain.",
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Parent / Guardian Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: parentNameController,
                    decoration: const InputDecoration(
                      hintText: "Enter Parent Full Name",
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
                      border: Border.all(color: Colors.blue),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Registration continue karne se pehle Parent/Guardian consent dena anivarya hai.",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                CheckboxListTile(
                  value: accepted,
                  title: const Text(
                    "Main aur mere Parent/Guardian sabhi niyam aur shartein svikaar karte hain.",
                  ),
                  onChanged: (value) {
                    setState(() {
                      accepted = value ?? false;
                    });
                  },
                ),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: continueRegistration,
                    child: const Text("Continue Registration"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}







