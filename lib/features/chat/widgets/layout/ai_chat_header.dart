import 'package:flutter/material.dart';

import 'package:digividya/features/chat/helpers/language_helper.dart';
import 'package:digividya/features/chat/widgets/common/ai_language_selector.dart';

class AiChatHeader extends StatelessWidget implements PreferredSizeWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageChanged;

  const AiChatHeader({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              'assets/logo/digividya_logo.png',
              height: 30,
              width: 30,
              errorBuilder: (_, _, _) => const Icon(Icons.school),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(child: Text('DigiVidya AI')),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Center(
            child: Text(
              LanguageHelper.getLanguageName(selectedLanguage),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
        AiLanguageSelector(onSelected: onLanguageChanged),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
