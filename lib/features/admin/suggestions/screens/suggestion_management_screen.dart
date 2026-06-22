import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:digividya/core/services/suggestion_service.dart';

class SuggestionManagementScreen extends StatelessWidget {
  const SuggestionManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suggestion Management')),
      body: StreamBuilder<QuerySnapshot>(
        stream: SuggestionService().getSuggestions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final suggestions = snapshot.data!.docs;

          if (suggestions.isEmpty) {
            return const Center(child: Text('No Suggestions Found'));
          }

          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final doc = suggestions[index];

              final data = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(data['parentName'] ?? ''),
                  subtitle: Text(data['suggestion'] ?? ''),
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
