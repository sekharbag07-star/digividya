import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:digividya/core/services/complaint_service.dart';

class ComplaintManagementScreen extends StatelessWidget {
  const ComplaintManagementScreen({super.key});

  Future<void> updateStatus(
    BuildContext context,
    String complaintId,
    String status,
  ) async {
    try {
      await ComplaintService().updateStatus(complaintId, status);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              status == 'resolved'
                  ? 'Complaint marked as resolved'
                  : 'Complaint rejected',
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'resolved':
        return Colors.green;

      case 'rejected':
        return Colors.red;

      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complaint Management')),
      body: StreamBuilder<QuerySnapshot>(
        stream: ComplaintService().getComplaints(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final complaints = snapshot.data?.docs ?? [];

          if (complaints.isEmpty) {
            return const Center(child: Text('No Complaints Found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final doc = complaints[index];

              final data = doc.data() as Map<String, dynamic>;

              final parentName =
                  data['parentName']?.toString() ?? 'Unknown Parent';

              final complaint = data['complaint']?.toString() ?? 'No Complaint';

              final status = data['status']?.toString() ?? 'pending';

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        parentName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(complaint, style: const TextStyle(fontSize: 15)),

                      const SizedBox(height: 12),

                      Chip(
                        backgroundColor: statusColor(
                          status,
                        ).withValues(alpha: 0.15),
                        label: Text(
                          status.toUpperCase(),
                          style: TextStyle(
                            color: statusColor(status),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      if (status == 'pending')
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.check),
                                label: const Text('Resolve'),
                                onPressed: () {
                                  updateStatus(context, doc.id, 'resolved');
                                },
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.close),
                                label: const Text('Reject'),
                                onPressed: () {
                                  updateStatus(context, doc.id, 'rejected');
                                },
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
