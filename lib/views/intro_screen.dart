import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myschool/utils/constants/colors.dart';
import 'package:myschool/utils/constants/enums.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Image.asset(
                  isDark
                      ? "assets/images/png/intro_top_dark.png"
                      : "assets/images/png/intro_top.png",
                  width: width),
            ),
            SizedBox(height: height * 0.06),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Transform.rotate(
                  angle: -0.4,
                  child: Image.asset("assets/images/png/homework.png",
                      height: height * 0.15),
                ),
              ),
            ),
            SizedBox(height: height * 0.10),
            IntroButton(
              height: height,
              backgroundColor: SColors.primary,
              role: Role.student,
              title: "Start Learning",
              textColor: isDark ? Colors.white : SColors.primary,
            ),
            SizedBox(height: height * 0.05),
            IntroButton(
              height: height,
              backgroundColor: isDark ? SColors.darkerGrey : Colors.white,
              role: Role.teacher,
              title: "Become a Teacher",
              textColor: isDark ? Colors.white : SColors.primary,
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
    );
  }
}

class IntroButton extends StatelessWidget {
  const IntroButton({
    super.key,
    required this.height,
    required this.textColor,
    required this.backgroundColor,
    required this.title,
    required this.role,
  });

  final double height;
  final Color textColor;
  final Color backgroundColor;
  final String title;
  final Role role;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Animate(
        delay: role == Role.student ? 1.seconds : 3.seconds,
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
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => SignInDialog(
                role: role,
              ),
            );
          },
          child: Material(
            elevation: 6.0,
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    elevation: 0,
                    side: BorderSide(color: backgroundColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SignInDialog(
                        role: role,
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Visibility(
                  visible: role == Role.student,
                  child: Positioned(
                    right: 16,
                    top: 10,
                    child: Image.asset("assets/images/png/pen.png",
                        height: height * 0.10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
