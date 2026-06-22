import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:digividya/core/services/leave_request_service.dart';

class LeaveRequestManagementScreen extends StatelessWidget {
  const LeaveRequestManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leave Requests')),
      body: StreamBuilder<QuerySnapshot>(
        stream: LeaveRequestService().getLeaveRequests(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final requests = snapshot.data!.docs;

          if (requests.isEmpty) {
            return const Center(child: Text('No Leave Requests'));
          }

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final doc = requests[index];

              final data = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(data['parentName'] ?? ''),
                  subtitle: Text(data['reason'] ?? ''),
                  trailing: Chip(label: Text(data['status'] ?? 'pending')),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
