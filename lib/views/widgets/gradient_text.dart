import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final Color colorX;
  final Color colorY;
  final Text text;

  const GradientText({
    required this.colorX,
    required this.colorY,
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: [
              colorX,
              colorY,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcIn,
        child: text);
  }
}
