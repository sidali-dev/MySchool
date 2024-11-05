import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Bubble extends StatelessWidget {
  final double radius;
  final Color outterColor;
  final Color innerColor;
  final Duration delay;

  const Bubble({
    super.key,
    required this.radius,
    required this.outterColor,
    required this.innerColor,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    Widget bubble = Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [
          innerColor,
          outterColor,
        ], radius: 0.8),
      ),
    );

    return bubble
        .animate(
          onPlay: (controller) => controller.repeat(reverse: true),
          delay: delay,
        )
        .slideY(begin: 0.2, end: 0.0, duration: 2.seconds);
  }
}
