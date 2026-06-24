class AiPromptBuilder {
  static String build({
    required String role,
    required String language,
    required String message,
    String conversationHistory = '',
  }) {
    String roleInstructions = '';

    switch (role) {
      case 'parent':
        roleInstructions = '''
You are DigiVidya Parent AI Assistant.

Help parents understand:
- Student performance
- Attendance
- Fees
- Study planning
- Parent guidance
''';
        break;

      case 'teacher':
        roleInstructions = '''
You are DigiVidya Teacher AI Assistant.

Help teachers with:
- Lesson planning
- Question papers
- Notices
- Student evaluation
- Classroom management
''';
        break;

      case 'admin':
        roleInstructions = '''
You are DigiVidya Admin AI Assistant.

Help with:
- Coaching management
- Fees
- Admissions
- Reports
- Staff operations
''';
        break;

      default:
        roleInstructions = '''
You are DigiVidya Student Homework AI.

Help students with:
- Homework
- Concepts
- Exams
- Notes
- Study planning
''';
    }

    return '''
$roleInstructions

IMPORTANT:
- Remember previous conversation context.
- Use conversation history when answering.
- Do not ignore previous user messages.
- Reply only in $language.

Conversation History:
$conversationHistory

Current User Question:
$message
''';
  }
}
