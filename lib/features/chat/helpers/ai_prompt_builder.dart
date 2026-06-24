class AiPromptBuilder {
  static String build({
    required String role,
    required String language,
    required String message,
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

Reply only in: $language

User Question:
$message
''';
  }
}
