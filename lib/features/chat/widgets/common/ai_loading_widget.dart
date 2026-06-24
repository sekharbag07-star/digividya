import 'package:flutter/material.dart';

class AiLoadingWidget extends StatefulWidget {
  const AiLoadingWidget({super.key});

  @override
  State<AiLoadingWidget> createState() => _AiLoadingWidgetState();
}

class _AiLoadingWidgetState extends State<AiLoadingWidget> {
  int _dots = 1;

  @override
  void initState() {
    super.initState();

    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) {
        return false;
      }

      setState(() {
        _dots = (_dots % 3) + 1;
      });

      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            child: Icon(Icons.smart_toy, size: 18),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              'DigiVidya AI is thinking${'.' * _dots}',
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ),

          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      ),
    );
  }
}
