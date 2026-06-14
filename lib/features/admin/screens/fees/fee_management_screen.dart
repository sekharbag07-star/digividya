import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeeManagementScreen extends StatefulWidget {
  const FeeManagementScreen({super.key});

  @override
  State<FeeManagementScreen> createState() => _FeeManagementScreenState();
}

class _FeeManagementScreenState extends State<FeeManagementScreen> {
  String? selectedStudent;
  String status = "Paid";

  final amountController = TextEditingController();
  final monthController = TextEditingController();

  Future<void> saveFee() async {
    if (selectedStudent == null ||
        amountController.text.isEmpty ||
        monthController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all fields")));
      return;
    }

    await FirebaseFirestore.instance.collection('fees').add({
      'studentName': selectedStudent,
      'amount': double.parse(amountController.text),
      'month': monthController.text.trim(),
      'status': status,
      'createdAt': Timestamp.now(),
    });

    amountController.clear();
    monthController.clear();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Fee Saved")));
  }

  @override
  void dispose() {
    amountController.dispose();
    monthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fee Management")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('students')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                return DropdownButtonFormField<String>(
                  initialValue: selectedStudent,
                  decoration: const InputDecoration(labelText: "Student"),
                  items: snapshot.data!.docs.map((student) {
                    return DropdownMenuItem<String>(
                      value: student['name'],
                      child: Text(student['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStudent = value;
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount"),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: monthController,
              decoration: const InputDecoration(labelText: "Month (June 2026)"),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: status,
              decoration: const InputDecoration(labelText: "Status"),
              items: const [
                DropdownMenuItem(value: "Paid", child: Text("Paid")),
                DropdownMenuItem(value: "Pending", child: Text("Pending")),
              ],
              onChanged: (value) {
                setState(() {
                  status = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveFee,
                child: const Text("Save Fee"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('fees')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final fees = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: fees.length,
                    itemBuilder: (context, index) {
                      final fee = fees[index];

                      return Card(
                        child: ListTile(
                          title: Text(fee['studentName']),
                          subtitle: Text("${fee['month']} • ₹${fee['amount']}"),
                          trailing: Text(fee['status']),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
