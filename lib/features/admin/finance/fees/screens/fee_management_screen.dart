import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeeManagementScreen extends StatefulWidget {
  const FeeManagementScreen({super.key});

  @override
  State<FeeManagementScreen> createState() => _FeeManagementScreenState();
}

class _FeeManagementScreenState extends State<FeeManagementScreen> {
  String? selectedStudentId;
  String? selectedStudentName;

  String status = "Paid";

  final amountController = TextEditingController();
  final monthController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveFee() async {
    if (selectedStudentId == null ||
        selectedStudentName == null ||
        amountController.text.isEmpty ||
        monthController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all fields")));
      return;
    }

    final amount = double.tryParse(amountController.text) ?? 0;

    await firestore.collection('fees').add({
      'studentId': selectedStudentId,
      'studentName': selectedStudentName,
      'amount': amount,
      'month': monthController.text.trim(),
      'status': status,
      'createdAt': Timestamp.now(),
    });

    final studentRef = firestore.collection('students').doc(selectedStudentId);

    if (status == 'Paid') {
      await studentRef.update({'totalPaid': FieldValue.increment(amount)});
    } else {
      await studentRef.update({'pendingFees': FieldValue.increment(amount)});
    }

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
              stream: firestore.collection('students').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                return DropdownButtonFormField<String>(
                  initialValue: selectedStudentId,
                  decoration: const InputDecoration(labelText: "Student"),
                  items: snapshot.data!.docs.map((student) {
                    final data = student.data() as Map<String, dynamic>;

                    return DropdownMenuItem<String>(
                      value: student.id,
                      child: Text(data['name'] ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    final doc = snapshot.data!.docs.firstWhere(
                      (e) => e.id == value,
                    );

                    setState(() {
                      selectedStudentId = value;
                      selectedStudentName = doc['name'];
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
                stream: firestore
                    .collection('fees')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final fees = snapshot.data!.docs;

                  if (fees.isEmpty) {
                    return const Center(child: Text("No Fee Records"));
                  }

                  return ListView.builder(
                    itemCount: fees.length,
                    itemBuilder: (context, index) {
                      final fee = fees[index].data() as Map<String, dynamic>;

                      return Card(
                        child: ListTile(
                          title: Text(fee['studentName'] ?? ''),
                          subtitle: Text('${fee['month']} • ₹${fee['amount']}'),
                          trailing: Text(fee['status'] ?? ''),
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





