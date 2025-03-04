import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myschool/utils/constants/image_strings.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';

class SpinningLogo extends StatelessWidget {
  const SpinningLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = SHelperFunctions.isDarkMode(context);
    final double screenWidth = SHelperFunctions.screenWidth();
    final Widget image = Image.asset(
      isDark ? SImageString.bannerLogoImageDark : SImageString.bannerLogoImage,
      width: screenWidth * 0.4,
    );

    return image
        .animate(
          onComplete: (controller) => controller.repeat(),
        )
        .rotate(duration: 2.seconds)
        .scaleXY(duration: 2.seconds, begin: 0.3, end: 1.8)
        .scaleXY(duration: 2.seconds, begin: 1.8, end: 0.3);
  }
}
