import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:digividya/features/chat/models/ai_chat_message.dart';

class ChatExportWordService {
  static Future<void> export(List<AiChatMessage> messages) async {
    final buffer = StringBuffer();

    final exportDate = DateFormat('dd MMM yyyy hh:mm a').format(DateTime.now());

    buffer.writeln('DIGIVIDYA AI CHAT EXPORT');
    buffer.writeln('');
    buffer.writeln('Generated: $exportDate');
    buffer.writeln('');
    buffer.writeln('================================================');
    buffer.writeln('');

    for (final msg in messages) {
      buffer.writeln('[${msg.role.toUpperCase()}]');

      buffer.writeln(msg.message);

      buffer.writeln('');

      buffer.writeln('------------------------------------------------');

      buffer.writeln('');
    }

    final directory = await getTemporaryDirectory();

    final file = File('${directory.path}/digividya_ai_chat.doc');

    await file.writeAsString(buffer.toString());

    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)], text: 'DigiVidya AI Chat Export'),
    );
  }
}
