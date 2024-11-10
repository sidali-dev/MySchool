import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:myschool/controllers/activities_controller.dart';
import 'package:myschool/models/activities.dart';
import 'package:myschool/models/modules.dart';
import 'package:myschool/views/widgets/animation/auto_scrolling_text.dart';

import '../utils/device/device_utility.dart';
import 'widgets/bubble.dart';
import 'widgets/squar_button.dart';

class ActivitiesScreen extends StatelessWidget {
  final Module module;
  final String activityImage;
  const ActivitiesScreen({
    super.key,
    required this.module,
    required this.activityImage,
  });

  @override
  Widget build(BuildContext context) {
    ActivitiesController controller = ActivitiesController();
    final double screenHeight = SDeviceUtils.getScreenHeight(context);
    final double screenWidth = SDeviceUtils.getScreenWidth(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: screenHeight,
            ),
            Positioned(
              right: -100,
              width: 200,
              top: (screenHeight / 2) - 100,
              child: const Bubble(
                innerColor: Colors.white,
                outterColor: Colors.green,
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
                outterColor: Colors.green,
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
                outterColor: Colors.green,
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
                          alignment: Alignment.centerLeft,
                          duration: const Duration(seconds: 1),
                          text: Text(
                            module.module.name.capitalizeFirst!,
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
                            end: .04,
                            duration: Duration(milliseconds: 500),
                          ),
                        ],
                        child: Hero(
                          tag: module.module.name,
                          child: Image.asset(
                            activityImage,
                            width: screenWidth / 3.5,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Text(
                    "Lorem ipsum some things i don't know",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 32,
                      mainAxisSpacing: 24,
                    ),
                    itemCount: controller.activities.length,
                    itemBuilder: (context, index) {
                      final Activity activity = controller.activities[index];
                      return SquarButton(
                        image: activity.imagePath,
                        title: activity.activity.name,
                        onTap: () {},
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
