import 'package:flutter/material.dart';

class LotusCenter extends StatefulWidget {
  const LotusCenter({super.key});

  @override
  State<LotusCenter> createState() => _LotusCenterState();
}

class _LotusCenterState extends State<LotusCenter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 1 + (_controller.value * 0.12);

        return Transform.scale(
          scale: scale,
          child: Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF0B1033), Color(0xFF132B5E)],
              ),
              border: Border.all(color: const Color(0xFFFFD700), width: 3),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    0xFFFFD700,
                  ).withValues(alpha: 0.25 + (_controller.value * 0.35)),
                  blurRadius: 25,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.admin_panel_settings,
                  size: 38,
                  color: Color(0xFFFFD700),
                ),

                SizedBox(height: 8),

                Text(
                  "ADMIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
