import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myschool/controllers/home_controller.dart';
import 'package:myschool/controllers/user_controller.dart';
import 'package:myschool/generated/l10n.dart';
import 'package:myschool/models/modules.dart';
import 'package:myschool/utils/device/device_utility.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import 'package:myschool/views/activities_screen.dart';
import 'package:myschool/views/settings_screen.dart';
import 'package:myschool/views/widgets/bubble.dart';
import 'package:myschool/views/widgets/squar_button.dart';

import '../utils/constants/colors.dart';

class StudentHomeScreen extends StatelessWidget {
  StudentHomeScreen({super.key});

  final UserController userController = Get.find();
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final double screenHeight = SDeviceUtils.getScreenHeight(context);
    final bool isDark = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Obx(
        () {
          if (userController.user.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          homeController.updateUserModules(
            level: userController.student.value!.level,
            branch: userController.student.value!.branch?.name,
          );

          return SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: -100,
                  width: 200,
                  top: (screenHeight / 2) - 100,
                  child: Bubble(
                    innerColor: isDark ? Colors.black : Colors.white,
                    outterColor: Colors.lightBlue,
                    radius: 200,
                    delay: 500.milliseconds,
                  ),
                ),
                Positioned(
                  left: -50,
                  width: 300,
                  top: -100,
                  child: Bubble(
                    innerColor: isDark ? Colors.black : Colors.white,
                    outterColor: Colors.lightBlue,
                    radius: 300,
                    delay: 1.seconds,
                  ),
                ),
                Positioned(
                  left: 50,
                  width: 250,
                  bottom: -100,
                  child: Bubble(
                    innerColor: isDark ? Colors.black : Colors.white,
                    outterColor: Colors.lightBlue,
                    radius: 250,
                    delay: 1500.milliseconds,
                  ),
                ),
                SizedBox(width: SDeviceUtils.getScreenWidth(context)),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 32.0, left: 32.0, top: 88.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).welcome,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 48),
                      ),
                      Text(
                        userController.user.value!.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 48),
                      ),
                      Text(
                        S.of(context).learning_today,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22),
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
                        itemCount: homeController.modules.length,
                        itemBuilder: (context, index) {
                          final Module module = homeController.modules[index];
                          return SquarButton(
                            image: module.imagePath,
                            title: homeController.getModuleTitle(
                                context, module.module),
                            onTap: () {
                              Get.to(
                                () => ActivitiesScreen(
                                    activityImage: module.imagePath,
                                    moduleTitle: homeController.getModuleTitle(
                                        context, module.module),
                                    module: module),
                                transition: Transition.downToUp,
                                duration: 370.milliseconds,
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, top: 40, right: 24.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 10,
                    child: InkWell(
                      onTap: () => Get.to(() => SettingsScreen(),
                          transition: Transition.leftToRight),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Iconsax.setting_2,
                            color: SColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
