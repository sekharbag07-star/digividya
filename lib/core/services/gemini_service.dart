import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String apiKey = 'YOUR_API_KEY';

  final GenerativeModel _model = GenerativeModel(
    model: 'gemini-2.5-flash',
    apiKey: apiKey,
  );

  Future<String> generateResponse({
    required String message,
    required String language,
  }) async {
    try {
      final prompt =
          '''
You are DigiVidya AI Assistant.

Reply ONLY in language code: $language.

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
