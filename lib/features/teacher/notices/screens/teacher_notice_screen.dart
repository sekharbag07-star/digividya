import 'package:flutter/material.dart';

import 'package:digividya/features/notices/screens/notice_board_screen.dart';

class TeacherNoticeScreen extends StatelessWidget {
  const TeacherNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NoticeBoardScreen(
      role: 'teacher',
    );
  }
}





