import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlippingContainerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController flipController;
  late Animation<double> flipAnimation;

  @override
  void onInit() {
    super.onInit();

    flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    flipAnimation = Tween<double>(begin: 0, end: 1).animate(flipController);
  }

  // Trigger the full flip animation
  void triggerFullFlip() {
    if (flipController.isAnimating) return;
    flipController
      ..reset() // Reset the animation
      ..forward(); // start the animation
  }

  @override
  void onClose() {
    flipController.dispose();
    super.onClose();
  }
}
