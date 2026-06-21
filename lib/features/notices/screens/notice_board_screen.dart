import 'package:flutter/material.dart';

import 'package:digividya/core/services/notice_service.dart';
import 'package:digividya/features/notices/models/notice_model.dart';

class NoticeBoardScreen extends StatelessWidget {
  final String role;

  const NoticeBoardScreen({
    super.key,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final noticeService = NoticeService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notice Board"),
      ),
      body: StreamBuilder<List<NoticeModel>>(
        stream: noticeService.getNotices(
          role: role,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No Notices Available",
              ),
            );
          }

          final notices = snapshot.data!;

          return ListView.builder(
            itemCount: notices.length,
            itemBuilder: (context, index) {
              final notice = notices[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(
                    Icons.notifications_active,
                    color: Colors.orange,
                  ),
                  title: Text(
                    notice.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(notice.description),
                      const SizedBox(height: 5),
                      Text(
                        "Type: ${notice.type}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}







