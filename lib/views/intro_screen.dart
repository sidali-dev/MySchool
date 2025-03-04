import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myschool/utils/constants/colors.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/utils/constants/image_strings.dart';
import 'package:myschool/utils/device/device_utility.dart';

import '../generated/l10n.dart';
import 'widgets/sign_in_dialog.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = SDeviceUtils.getScreenHeight(context);
    final double width = SDeviceUtils.getScreenWidth(context);
    // final bool isDark = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 150,
              right: -40,
              child: Transform.rotate(
                angle: -0.4,
                child: Image.asset(SImageString.activityExams,
                    height: height * 0.13),
              ),
            ),
            Positioned(
              bottom: 00,
              right: 00,
              child: Transform.rotate(
                angle: -0.2,
                child: Image.asset(SImageString.activityExercises,
                    height: height * 0.10),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.13),
                Center(
                  child: Image.asset(
                    SImageString.introBanner,
                    width: width * 0.6,
                  ),
                ),
                SizedBox(height: height * 0.1),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Transform.rotate(
                    angle: 0.4,
                    child: Image.asset("assets/images/png/homework.png",
                        height: height * 0.15),
                  ),
                ),
                SizedBox(height: height * 0.15),
                IntroButton(
                  height: height,
                  backgroundColor: SColors.primary,
                  role: RoleEnum.student,
                  title: S.of(context).start_learning,
                  textColor: SColors.white,
                ),
                SizedBox(height: height * 0.05),
                // IntroButton(
                //   height: height,
                //   backgroundColor: isDark ? SColors.darkerGrey : Colors.white,
                //   role: RoleEnum.teacher,
                //   title: S.of(context).become_teacher,
                //   textColor: isDark ? Colors.white : SColors.primary,
                // ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Access a variety of lessons, exercises, test and videos to help you excel at your studies and get the best marks",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: height * 0.05),
              ],
            ),
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
  final RoleEnum role;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Animate(
        delay: role == RoleEnum.student ? 1.seconds : 3.seconds,
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
              builder: (context) => SignInDialog(role: role),
            );
          },
          child: Material(
            elevation: 6.0,
            borderRadius: BorderRadius.circular(24),
            child: ElevatedButton(
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
          ),
        ),
      ),
    );
  }
}
