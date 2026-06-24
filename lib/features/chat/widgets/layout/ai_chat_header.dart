import 'package:flutter/material.dart';

import 'package:digividya/features/chat/helpers/language_helper.dart';
import 'package:digividya/features/chat/widgets/common/ai_language_selector.dart';

class AiChatHeader extends StatelessWidget implements PreferredSizeWidget {
  final String selectedLanguage;
  final String role;

  final Function(String) onLanguageChanged;

  final VoidCallback? onSearch;
  final VoidCallback? onClearChat;
  final VoidCallback? onExportPdf;
  final VoidCallback? onExportWord;

  const AiChatHeader({
    super.key,
    required this.selectedLanguage,
    required this.role,
    required this.onLanguageChanged,
    this.onSearch,
    this.onClearChat,
    this.onExportPdf,
    this.onExportWord,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.school, size: 28);
              },
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(child: Text('DigiVidya AI')),
        ],
      ),
      actions: [
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              role.toUpperCase(),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              LanguageHelper.getLanguageName(selectedLanguage),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),

        AiLanguageSelector(onSelected: onLanguageChanged),

        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search Chat',
          onPressed: onSearch,
        ),

        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            switch (value) {
              case 'pdf':
                onExportPdf?.call();
                break;

              case 'word':
                onExportWord?.call();
                break;

              case 'clear':
                onClearChat?.call();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'pdf',
              child: Row(
                children: [
                  Icon(Icons.picture_as_pdf),
                  SizedBox(width: 8),
                  Text('Export PDF'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'word',
              child: Row(
                children: [
                  Icon(Icons.description),
                  SizedBox(width: 8),
                  Text('Export Word'),
                ],
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'clear',
              child: Row(
                children: [
                  Icon(Icons.delete_outline),
                  SizedBox(width: 8),
                  Text('Clear Chat'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
