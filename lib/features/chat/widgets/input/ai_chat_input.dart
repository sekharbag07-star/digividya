import 'package:flutter/material.dart';

class AiChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isLoading;

  const AiChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      'Homework Help',
      'Exam Preparation',
      'Study Plan',
      'Attendance Query',
      'Fee Details',
    ];

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 42,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemCount: suggestions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final text = suggestions[index];

                return ActionChip(
                  label: Text(text),
                  onPressed: () {
                    controller.text = text;
                    controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: controller.text.length),
                    );
                  },
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Ask DigiVidya AI...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => onSend(),
                  ),
                ),

                const SizedBox(width: 10),

                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: isLoading ? null : onSend,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
