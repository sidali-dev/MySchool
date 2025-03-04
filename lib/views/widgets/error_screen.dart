import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../generated/l10n.dart';
import '../../utils/constants/image_strings.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.isDark,
    required this.showLogo,
    required this.onTap,
  });

  final bool isDark;
  final bool showLogo;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Visibility(
            visible: showLogo,
            child: Column(
              children: [
                Image.asset(isDark
                    ? SImageString.bannerLogoImageDark
                    : SImageString.bannerLogoImage),
                const SizedBox(height: 32),
              ],
            ),
          ),
          LottieBuilder.asset(
            SImageString.errorAnimation,
            width: 200,
          ),
          const SizedBox(height: 32),
          Text(S.of(context).something_went_wrong),
          if (onTap != null)
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                onPressed: () async {
                  onTap!();
                },
                child: Center(
                  child: Text(S.of(context).try_again_caps),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
