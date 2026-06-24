import 'package:flutter/material.dart';

class AiLanguageSelector extends StatelessWidget {
  final Function(String) onSelected;

  const AiLanguageSelector({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: onSelected,
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'en', child: Text('English')),
        PopupMenuItem(value: 'hi', child: Text('हिन्दी')),
        PopupMenuItem(value: 'bn', child: Text('বাংলা')),
        PopupMenuItem(value: 'ta', child: Text('தமிழ்')),
        PopupMenuItem(value: 'te', child: Text('తెలుగు')),
      ],
    );
  }
}
