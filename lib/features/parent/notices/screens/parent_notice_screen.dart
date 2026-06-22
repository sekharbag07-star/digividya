import 'package:flutter/material.dart';
import 'package:digividya/core/services/notice_service.dart';
import 'package:digividya/features/notices/models/notice_model.dart';

class ParentNoticeScreen extends StatelessWidget {
  const ParentNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notices')),
      body: StreamBuilder<List<NoticeModel>>(
        stream: NoticeService().getNotices(role: 'parent'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notices = snapshot.data!;

          if (notices.isEmpty) {
            return const Center(child: Text('No Notices Available'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notices.length,
            itemBuilder: (context, index) {
              final notice = notices[index];

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.campaign),
                  title: Text(notice.title),
                  subtitle: Text(notice.description),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
