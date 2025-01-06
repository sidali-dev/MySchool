import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myschool/utils/constants/colors.dart';
import 'package:myschool/views/settings_screen.dart';

import '../utils/device/device_utility.dart';
import '../utils/helpers/helper_functions.dart';
import 'upload_screen.dart';
import 'widgets/bubble.dart';

class TeacherHomeScreen extends StatelessWidget {
  final String name;
  const TeacherHomeScreen({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = SDeviceUtils.getScreenHeight(context);
    final bool isDark = SHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
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
              bottom: -350,
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
                  const Text(
                    "Welcome",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 48),
                  ),
                  Text(
                    name.capitalizeFirst!,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 48),
                  ),
                  const Text(
                    "What will you be sharing today?",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(
                          () => UploadScreen(
                                canHaveSolution: false,
                                title: "UPLOAD A NEW LESSON",
                                themeColor: Colors.greenAccent,
                              ),
                          transition: Transition.rightToLeft);
                    },
                    child: const Center(
                      child: Text("LESSON"),
                    ),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(
                          () => UploadScreen(
                                canHaveSolution: true,
                                title: "UPLOAD A NEW EXERCISE",
                                themeColor: Colors.purpleAccent,
                              ),
                          transition: Transition.rightToLeft);
                    },
                    child: const Center(
                      child: Text("EXERCISE"),
                    ),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(
                          () => UploadScreen(
                                canHaveSolution: true,
                                title: "UPLOAD A NEW TEST",
                                themeColor: Colors.yellow,
                              ),
                          transition: Transition.rightToLeft);
                    },
                    child: const Center(
                      child: Text("TEST"),
                    ),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(
                          () => UploadScreen(
                                canHaveSolution: false,
                                title: "UPLOAD A NEW VIDEO",
                                themeColor: Colors.redAccent,
                              ),
                          transition: Transition.rightToLeft);
                    },
                    child: const Center(
                      child: Text("VIDEO"),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 40, right: 24.0),
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

            // Padding(
            //   padding:
            //       const EdgeInsets.only(left: 24.0, top: 40, right: 24.0),
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(100),
            //     ),
            //     elevation: 10,
            //     child: InkWell(
            //       onTap: () => Get.to(() => SettingsScreen(),
            //           transition: Transition.leftToRight),
            //       child: Container(
            //         decoration: const BoxDecoration(
            //           borderRadius: BorderRadius.all(
            //             Radius.circular(100),
            //           ),
            //         ),
            //         child: const Padding(
            //           padding: EdgeInsets.all(8.0),
            //           child: Icon(
            //             Iconsax.setting_2,
            //             color: SColors.primary,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
