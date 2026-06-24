import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import 'package:digividya/features/chat/models/ai_chat_message.dart';

class ChatExportPdfService {
  static Future<void> export(List<AiChatMessage> messages) async {
    final pdf = pw.Document();

    final exportDate = DateFormat('dd MMM yyyy hh:mm a').format(DateTime.now());

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'DigiVidya AI Chat Export',
              style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
            ),
          ),

          pw.Text('Generated: $exportDate'),

          pw.SizedBox(height: 15),

          ...messages.map(
            (msg) => pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 10),
              padding: const pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    msg.role.toUpperCase(),
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),

                  pw.SizedBox(height: 4),

                  pw.Text(msg.message),
                ],
              ),
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
