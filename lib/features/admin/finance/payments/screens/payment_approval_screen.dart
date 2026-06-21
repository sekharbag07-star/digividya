import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:digividya/core/services/subscription_service.dart';

class PaymentApprovalScreen extends StatelessWidget {
  const PaymentApprovalScreen({super.key});

  Future<void> approvePayment(
    String paymentId,
    String studentId,
    String utr,
  ) async {
    final subscriptionService = SubscriptionService();

    // Mark payment approved
    await FirebaseFirestore.instance
        .collection('payments')
        .doc(paymentId)
        .update({
          'status': 'approved',
          'approvedAt': FieldValue.serverTimestamp(),
        });

    // Activate subscription using central service
    await subscriptionService.activateSubscription(
      userId: studentId,
      transactionId: utr,
      durationDays: 30,
      plan: 'monthly',
    );
  }

  Future<void> rejectPayment(String paymentId) async {
    await FirebaseFirestore.instance
        .collection('payments')
        .doc(paymentId)
        .update({
          'status': 'rejected',
          'rejectedAt': FieldValue.serverTimestamp(),
        });
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Pending Payments'));
          }

          final payments = snapshot.data!.docs;

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

                      Text('₹${data['amount'] ?? 0}'),

                      Text('Plan: ${data['plan'] ?? 'monthly'}'),

                      Text('UTR: ${data['utrNumber'] ?? ''}'),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  await approvePayment(
                                    payments[index].id,
                                    data['studentId'],
                                    data['utrNumber'],
                                  );

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Payment Approved'),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())),
                                    );
                                  }
                                }
                              },
                              child: const Text('Approve'),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  await rejectPayment(payments[index].id);

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Payment Rejected'),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())),
                                    );
                                  }
                                }
                              },
                              child: const Text('Reject'),
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

