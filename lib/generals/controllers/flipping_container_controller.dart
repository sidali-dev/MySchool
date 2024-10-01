import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlippingContainerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController flipController;
  late Animation<double> flipAnimation;

  @override
  void onInit() {
    super.onInit();

    // Initialize the animation controller for 1 second
    flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Define the Tween animation for a full rotation (2 * pi)
    flipAnimation = Tween<double>(begin: 0, end: 1).animate(flipController)
      ..addListener(() {
        update(); // Rebuild GetBuilder on every tick
      });
  }

  // Trigger the full flip animation
  void triggerFullFlip() {
    if (flipController.isAnimating) return;
    flipController.forward(from: 0); // Reset and start the animation
  }

  @override
  void onClose() {
    flipController.dispose();
    super.onClose();
  }
}
