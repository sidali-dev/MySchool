import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myschool/models/activities.dart';
import 'package:myschool/models/modules.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';

import '../utils/device/device_utility.dart';
import 'widgets/animation/auto_scrolling_text.dart';
import 'widgets/bubble.dart';

class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({
    super.key,
    required this.activity,
    required this.trimester,
    required this.module,
    required this.activityTitle,
  });

  final String activityTitle;
  final Module module;
  final Activity activity;
  final int trimester;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = SDeviceUtils.getScreenHeight(context);
    final double screenWidth = SDeviceUtils.getScreenWidth(context);
    final bool isRtl = SHelperFunctions.isRtl(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(height: screenHeight),
            Positioned(
              right: -100,
              width: 200,
              top: (screenHeight / 2) - 100,
              child: const Bubble(
                innerColor: Colors.white,
                outterColor: Colors.yellow,
                radius: 200,
                delay: Duration(milliseconds: 500),
              ),
            ),
            const Positioned(
              left: -50,
              width: 300,
              top: -100,
              child: Bubble(
                innerColor: Colors.white,
                outterColor: Colors.yellow,
                radius: 300,
                delay: Duration(seconds: 1),
              ),
            ),
            const Positioned(
              left: 50,
              width: 250,
              bottom: -100,
              child: Bubble(
                innerColor: Colors.white,
                outterColor: Colors.yellow,
                radius: 250,
                delay: Duration(milliseconds: 1500),
              ),
            ),
            SizedBox(width: SDeviceUtils.getScreenWidth(context)),
            Padding(
              padding:
                  const EdgeInsets.only(right: 32.0, left: 32.0, top: 88.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AutoScrollText(
                          alignment: isRtl
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          duration: const Duration(seconds: 1),
                          text: Text(
                            activityTitle,
                            style: const TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 48),
                          ),
                          width: screenWidth / 2),
                      Animate(
                        effects: const [
                          ShakeEffect(
                            duration: Duration(milliseconds: 500),
                          ),
                          RotateEffect(
                            begin: 0,
                            end: .00,
                            duration: Duration(milliseconds: 500),
                          ),
                        ],
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              right: isRtl ? null : -50,
                              left: isRtl ? -50 : null,
                              bottom: 0,
                              child: Hero(
                                tag: module.module.name,
                                child: Image.asset(
                                  module.imagePath,
                                  width: screenWidth / 5,
                                ),
                              ),
                            ),
                            Hero(
                              tag: activity.activity.name,
                              child: Image.asset(
                                activity.imagePath,
                                width: screenWidth / 3.5,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Text(
                    "Get the best marks by training with our 100+ exams",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
