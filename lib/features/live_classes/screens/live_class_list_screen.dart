import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/live_class_model.dart';
import '../services/live_class_service.dart';

class LiveClassListScreen extends StatelessWidget {
  const LiveClassListScreen({super.key});

  Future<void> joinClass(String link) async {
    final uri = Uri.parse(link);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = LiveClassService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Classes"),
      ),
      body: StreamBuilder<List<LiveClassModel>>(
        stream: service.getLiveClasses(),
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
                "No Live Classes Available",
              ),
            );
          }

          final classes = snapshot.data!;

          return ListView.builder(
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final liveClass = classes[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        liveClass.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Teacher: ${liveClass.teacher}",
                      ),

                      Text(
                        "Date: ${liveClass.date}",
                      ),

                      Text(
                        "Time: ${liveClass.time}",
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.video_call,
                          ),
                          label: const Text(
                            "Join Class",
                          ),
                          onPressed: liveClass
                                  .isActive
                              ? () => joinClass(
                                    liveClass
                                        .meetingLink,
                                  )
                              : null,
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