import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static String get apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  GenerativeModel get _model =>
      GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);

  Future<String> generateResponse({
    required String message,
    required String language,
    required String role,
  }) async {
    try {
      if (apiKey.isEmpty) {
        return 'Gemini API key not configured.';
      }

      String rolePrompt = '';

      switch (role) {
        case 'parent':
          rolePrompt = '''
You are DigiVidya Parent Assistant.

Help parents understand:
- Homework
- Attendance
- Fees
- Notices
- Student Progress

Reply in simple language.
''';
          break;

        case 'teacher':
          rolePrompt = '''
You are DigiVidya Teacher Assistant.

Help teachers with:
- Lesson Planning
- Attendance
- Classroom Management
- Student Performance
''';
          break;

        case 'student':
          rolePrompt = '''
You are DigiVidya Student Assistant.

Help students with:
- Homework Solving
- Exam Preparation
- Concept Explanation
- Study Guidance
''';
          break;

        case 'admin':
          rolePrompt = '''
You are DigiVidya Admin Assistant.

Help with:
- Reports
- Users
- Fees
- Analytics
- School Management
''';
          break;

        default:
          rolePrompt = 'You are DigiVidya AI Assistant.';
      }

      final prompt =
          '''
$rolePrompt

Reply in language: $language

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
