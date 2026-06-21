import 'package:flutter/material.dart';

class LotusRing extends StatefulWidget {
  const LotusRing({super.key});

  @override
  State<LotusRing> createState() => _LotusRingState();
}

class _LotusRingState extends State<LotusRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
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
        return Transform.rotate(
          angle: _controller.value * 6.28318,
          child: Container(
            width: 330,
            height: 330,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFFFD700), width: 2.5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x44FFD700),
                  blurRadius: 25,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Stack(
              children: [
                _dot(Alignment.topCenter),
                _dot(Alignment.bottomCenter),
                _dot(Alignment.centerLeft),
                _dot(Alignment.centerRight),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _dot(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 12,
        height: 12,
        decoration: const BoxDecoration(
          color: Color(0xFFFFD700),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}





