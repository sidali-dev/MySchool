import 'dart:async';

import 'package:flutter/material.dart';

class AutoScrollText extends StatefulWidget {
  final Text text;
  final double? width;
  final Alignment alignment;

  const AutoScrollText({
    super.key,
    required this.text,
    this.width,
    required this.alignment,
  });

  @override
  State<AutoScrollText> createState() => _AutoScrollTextState();
}

class _AutoScrollTextState extends State<AutoScrollText> {
  late final ScrollController _scrollController;
  late Timer _scrollTimer;
  bool _scrollForward = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    int baseTimePerCharacter = 50; // Adjust this for speed
    int textLength = widget.text.data?.length ?? 0;
    Duration dynamicDuration =
        Duration(milliseconds: baseTimePerCharacter * textLength);

    _scrollTimer = Timer.periodic(dynamicDuration, (_) {
      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      double currentScrollPosition = _scrollController.offset;

      if (_scrollForward && currentScrollPosition < maxScrollExtent) {
        _scrollController.animateTo(
          maxScrollExtent,
          duration: dynamicDuration,
          curve: Curves.linear,
        );
      } else if (!_scrollForward && currentScrollPosition > 0) {
        _scrollController.animateTo(
          0,
          duration: dynamicDuration,
          curve: Curves.linear,
        );
      } else {
        _scrollForward = !_scrollForward;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Align(
        alignment: widget.alignment,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: widget.text),
      ),
    );
  }
}
