import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentApprovalScreen extends StatelessWidget {
  const PaymentApprovalScreen({super.key});

  Future<void> approvePayment(
    String paymentId,
    String studentId,
    String utr,
  ) async {
    await FirebaseFirestore.instance
        .collection('payments')
        .doc(paymentId)
        .update({'status': 'approved'});

    await FirebaseFirestore.instance.collection('users').doc(studentId).update({
      'paymentStatus': 'paid',
      'subscriptionActive': true,
      'transactionId': utr,
    });
  }

  Future<void> rejectPayment(String paymentId) async {
    await FirebaseFirestore.instance
        .collection('payments')
        .doc(paymentId)
        .update({'status': 'rejected'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Approvals')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('payments')
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final payments = snapshot.data!.docs;

          if (payments.isEmpty) {
            return const Center(child: Text("No Pending Payments"));
          }

          return ListView.builder(
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final data = payments[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['studentName'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(data['email'] ?? ''),

                      Text("₹${data['amount']}"),

                      Text("UTR: ${data['utrNumber']}"),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                await approvePayment(
                                  payments[index].id,
                                  data['studentId'],
                                  data['utrNumber'],
                                );

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Payment Approved"),
                                    ),
                                  );
                                }
                              },
                              child: const Text("Approve"),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                await rejectPayment(payments[index].id);

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Payment Rejected"),
                                    ),
                                  );
                                }
                              },
                              child: const Text("Reject"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
