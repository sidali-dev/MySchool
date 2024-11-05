import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myschool/controllers/sign_in_controller.dart';
import 'package:myschool/utils/constants/colors.dart';
import 'package:myschool/utils/device/device_utility.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';

import 'widgets/sign_in_dialog.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = SDeviceUtils.getScreenHeight(context);
    final double width = SDeviceUtils.getScreenWidth(context);
    final bool isDark = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.1),
              Image.asset(
                  isDark
                      ? "assets/images/png/intro_top_dark.png"
                      : "assets/images/png/intro_top.png",
                  width: width),
              SizedBox(height: height * 0.06),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Transform.rotate(
                    angle: -0.4,
                    child: Image.asset("assets/images/png/homework.png",
                        height: height * 0.15)),
              ),
              SizedBox(height: height * 0.10),
              InkWell(
                borderRadius: BorderRadius.circular(24.0),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => SignInDialog(),
                  );
                },
                child: Animate(
                  delay: 1.seconds,
                  onComplete: (controller) {
                    if (context.mounted && !controller.isDismissed) {
                      Future.delayed(5.seconds).then((_) => controller
                        ..reset()
                        ..forward());
                    }
                  },
                  effects: [
                    ShimmerEffect(duration: 1800.milliseconds),
                    const ShakeEffect(hz: 2, curve: Curves.easeInOutCubic),
                  ],
                  child: Stack(
                    children: [
                      Container(
                        height: height * 0.08,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: SColors.primary,
                            borderRadius: BorderRadius.circular(24)),
                        child: const Text(
                          "START LEARNING !",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: 10,
                        child: Image.asset("assets/images/png/pen.png",
                            height: height * 0.12),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
              Image.asset(
                  height: height * 0.2,
                  isDark
                      ? "assets/images/png/intro_bottom_dark.png"
                      : "assets/images/png/intro_bottom.png",
                  width: width),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await SignInController().signOut(context: context);
        },
      ),
    );
  }
}
