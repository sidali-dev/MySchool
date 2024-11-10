import 'package:flutter/material.dart';
import 'package:myschool/utils/device/device_utility.dart';
import 'package:myschool/views/widgets/animation/auto_scrolling_text.dart';

class SquarButton extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const SquarButton({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double width = (SDeviceUtils.getScreenWidth(context) / 2.5);
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 10,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          width: width,
          height: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                flightShuttleBuilder: (flightContext, animation,
                    flightDirection, fromHeroContext, toHeroContext) {
                  switch (flightDirection) {
                    case HeroFlightDirection.push:
                      return ScaleTransition(
                          scale: animation.drive(
                            Tween<double>(begin: 1.0, end: 1.0).chain(
                              CurveTween(curve: Curves.decelerate),
                            ),
                          ),
                          child: toHeroContext.widget);
                    case HeroFlightDirection.pop:
                      return ScaleTransition(
                          scale: animation.drive(
                            Tween<double>(begin: 1.0, end: 1.0).chain(
                              CurveTween(curve: Curves.decelerate),
                            ),
                          ),
                          child: fromHeroContext.widget);
                  }
                },
                tag: title,
                child: Image.asset(image, width: width - 80),
              ),
              const SizedBox(height: 8),
              AutoScrollText(
                  alignment: Alignment.center,
                  duration: const Duration(seconds: 2),
                  text: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  width: width - 48)
            ],
          ),
        ),
      ),
    );
  }
}
