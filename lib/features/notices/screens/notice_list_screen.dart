import 'package:flutter/material.dart';

import '../models/notice_model.dart';
import 'package:digividya/core/services/notice_service.dart';

class NoticeListScreen extends StatelessWidget {
  const NoticeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NoticeService noticeService = NoticeService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Notices"),
      ),
      body: StreamBuilder<List<NoticeModel>>(
        stream: noticeService.getNotices(),
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
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.notifications,
                    color: Colors.blue,
                  ),
                  title: Text(notice.title),
                  subtitle: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(notice.description),
                      const SizedBox(height: 4),
                      Text(
                        "Type: ${notice.type}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Role: ${notice.targetRole}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      await noticeService.deleteNotice(
                        notice.id,
                      );
                    },
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





