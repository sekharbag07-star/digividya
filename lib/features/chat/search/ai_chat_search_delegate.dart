import 'package:flutter/material.dart';

import 'package:digividya/features/chat/models/ai_chat_message.dart';

class AiChatSearchDelegate extends SearchDelegate {
  final List<AiChatMessage> messages;

  AiChatSearchDelegate({required this.messages});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = messages.where((msg) {
      return msg.message.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return const Center(child: Text('No messages found'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final msg = results[index];

        return ListTile(
          leading: Icon(msg.role == 'user' ? Icons.person : Icons.smart_toy),
          title: Text(
            msg.message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(msg.role.toUpperCase()),
        );
      },
    );
  }
}
