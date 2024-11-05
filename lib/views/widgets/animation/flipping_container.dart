import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myschool/controllers/widgets_controllers/flipping_container_controller.dart';
import 'dart:math' show pi;

class FlippingContainer extends StatelessWidget {
  const FlippingContainer(
      {super.key, required this.widget, required this.flipController});
  final Widget widget;
  final FlippingContainerController flipController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetBuilder<FlippingContainerController>(
        init: flipController,
        builder: (controller) {
          return AnimatedBuilder(
            animation: controller.flipAnimation,
            builder: (context, child) {
              final flipValue = controller.flipAnimation.value;

              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  // ..setEntry(3, 2, 0.001) // Perspective for 3D effect
                  ..rotateY(flipValue * 2 * pi), // Full 360-degree flip
                child: widget,
              );
            },
          );
        },
      ),
    );
  }
}
