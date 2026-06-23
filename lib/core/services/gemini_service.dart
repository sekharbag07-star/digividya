import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static String get apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  GenerativeModel get _model =>
      GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);

  Future<String> generateResponse({
    required String message,
    required String language,
  }) async {
    try {
      if (apiKey.isEmpty) {
        return 'Gemini API key not configured.';
      }

      final prompt =
          '''
You are DigiVidya AI Assistant.

Reply in this language: $language

Help students, parents and teachers.

User Message:
$message
''';

      final response = await _model.generateContent([Content.text(prompt)]);

      return response.text ?? 'No response generated';
    } catch (e) {
      return 'Error: $e';
    }
  }
}
