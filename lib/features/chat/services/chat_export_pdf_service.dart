import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../models/ai_chat_message.dart';

class ChatExportPdfService {
  static Future<void> export(List<AiChatMessage> messages) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(level: 0, child: pw.Text('DigiVidya AI Chat Export')),

          ...messages.map(
            (msg) => pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 8),
              child: pw.Text('[${msg.role.toUpperCase()}]\n${msg.message}'),
            ),
          ),
        ],
      ),
    );

    final directory = await getTemporaryDirectory();

    final file = File('${directory.path}/digividya_ai_chat.pdf');

    await file.writeAsBytes(await pdf.save());

    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)], text: 'DigiVidya AI Chat Export'),
    );
  }
}
