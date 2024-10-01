import 'package:flutter/material.dart';

class AnimatedChangingText extends StatelessWidget {
  const AnimatedChangingText(
      {super.key,
      required this.value,
      required this.text1,
      required this.text2,
      required this.textStyle,
      required this.duration});

  final bool value;
  final String text1;
  final String text2;
  final TextStyle textStyle;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: Text(value ? text1 : text2,
          key: ValueKey<String>(value ? text1 : text2), style: textStyle),
    );
  }
}
