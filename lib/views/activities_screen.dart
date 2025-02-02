import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:myschool/controllers/activities_controller.dart';
import 'package:myschool/generated/l10n.dart';
import 'package:myschool/models/activities.dart';
import 'package:myschool/models/modules.dart';
import 'package:myschool/utils/constants/image_strings.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import 'package:myschool/views/materials_screen.dart';
import 'package:myschool/views/widgets/animation/auto_scrolling_text.dart';

import '../utils/device/device_utility.dart';
import 'widgets/bubble.dart';
import 'widgets/numbers_card.dart';
import 'widgets/squar_button.dart';

class ActivitiesScreen extends StatelessWidget {
  final Module module;
  final String activityImage;
  final String moduleTitle;
  const ActivitiesScreen({
    super.key,
    required this.module,
    required this.activityImage,
    required this.moduleTitle,
  });

  @override
  Widget build(BuildContext context) {
    ActivitiesController controller = ActivitiesController();

    final double screenHeight = SDeviceUtils.getScreenHeight(context);
    final double screenWidth = SDeviceUtils.getScreenWidth(context);
    final bool isRtl = SHelperFunctions.isRtl(context);
    final bool isDark = SHelperFunctions.isDarkMode(context);

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
              child: Bubble(
                innerColor: isDark ? Colors.black : Colors.white,
                outterColor: Colors.red,
                radius: 200,
                delay: const Duration(milliseconds: 500),
              ),
            ),
            Positioned(
              left: -50,
              width: 300,
              top: -100,
              child: Bubble(
                innerColor: isDark ? Colors.black : Colors.white,
                outterColor: Colors.red,
                radius: 300,
                delay: const Duration(seconds: 1),
              ),
            ),
            Positioned(
              left: 50,
              width: 250,
              bottom: -100,
              child: Bubble(
                innerColor: isDark ? Colors.black : Colors.white,
                outterColor: Colors.red,
                radius: 250,
                delay: const Duration(milliseconds: 1500),
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
                          text: Text(
                            moduleTitle,
                            style: const TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 48),
                          ),
                          width: screenWidth / 2),
                      Animate(
                        effects: const [
                          ShakeEffect(
                            duration: Duration(milliseconds: 500),
                          ),
                        ],
                        child: Hero(
                          tag: moduleTitle,
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
                        title: ActivitiesController.getActivitiesTitle(
                            context, activity.activity),
                        onTap: () {
                          Get.bottomSheet(
                            BottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(36),
                                ),
                              ),
                              enableDrag: false,
                              onClosing: () {},
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 8),
                                      AutoScrollText(
                                        text: Text(
                                          S.of(context).pick_trimester,
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        width: screenWidth * 0.7,
                                        alignment: Alignment.center,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Animate(
                                            effects: const [
                                              FlipEffect(
                                                begin: 1,
                                                end: 2,
                                                direction: Axis.horizontal,
                                                delay: Duration(seconds: 0),
                                                duration:
                                                    Duration(milliseconds: 370),
                                              )
                                            ],
                                            child: NumbersCard(
                                              imagePath: SImageString.numberOne,
                                              screenHeight: screenHeight,
                                              screenWidth: screenWidth,
                                              onTap: () async {
                                                await openMaterialsScreen(
                                                  module: module,
                                                  activity: activity,
                                                  trimester: 1,
                                                  activityTitle:
                                                      ActivitiesController
                                                          .getActivitiesTitle(
                                                              context,
                                                              activity
                                                                  .activity),
                                                );
                                              },
                                            ),
                                          ),
                                          Animate(
                                            effects: const [
                                              FlipEffect(
                                                begin: 1,
                                                end: 2,
                                                direction: Axis.horizontal,
                                                delay:
                                                    Duration(milliseconds: 100),
                                                duration:
                                                    Duration(milliseconds: 370),
                                              )
                                            ],
                                            child: NumbersCard(
                                              imagePath: SImageString.numberTwo,
                                              screenHeight: screenHeight,
                                              screenWidth: screenWidth,
                                              onTap: () async {
                                                await openMaterialsScreen(
                                                  module: module,
                                                  activity: activity,
                                                  trimester: 2,
                                                  activityTitle:
                                                      ActivitiesController
                                                          .getActivitiesTitle(
                                                              context,
                                                              activity
                                                                  .activity),
                                                );
                                              },
                                            ),
                                          ),
                                          Animate(
                                            effects: const [
                                              FlipEffect(
                                                begin: 1,
                                                end: 2,
                                                direction: Axis.horizontal,
                                                delay:
                                                    Duration(milliseconds: 200),
                                                duration:
                                                    Duration(milliseconds: 370),
                                              )
                                            ],
                                            child: NumbersCard(
                                              imagePath:
                                                  SImageString.numberThree,
                                              screenHeight: screenHeight,
                                              screenWidth: screenWidth,
                                              onTap: () async {
                                                await openMaterialsScreen(
                                                  module: module,
                                                  activity: activity,
                                                  trimester: 3,
                                                  activityTitle:
                                                      ActivitiesController
                                                          .getActivitiesTitle(
                                                              context,
                                                              activity
                                                                  .activity),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16)
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
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

  Future<void> openMaterialsScreen(
      {required Module module,
      required Activity activity,
      required int trimester,
      required String activityTitle}) async {
    Get.back();
    await Future.delayed(
      const Duration(milliseconds: 200),
    ).then(
      (value) {
        Get.to(
          () => MaterialsScreen(
            module: module,
            activity: activity,
            trimester: trimester,
            activityTitle: activityTitle,
            moduleTitle: moduleTitle,
          ),
          transition: Transition.downToUp,
          duration: const Duration(
            milliseconds: 370,
          ),
        );
      },
    );
  }
}
