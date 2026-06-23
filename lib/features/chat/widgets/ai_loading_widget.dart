import 'package:flutter/material.dart';

class AiLoadingWidget extends StatelessWidget {
  const AiLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 12),
          Text('DigiVidya AI is thinking...'),
        ],
      ),
    );
  }
}
