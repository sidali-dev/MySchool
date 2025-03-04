import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../generated/l10n.dart';
import '../../utils/constants/image_strings.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          LottieBuilder.asset(
            SImageString.emptyScreenAnimation,
            width: 200,
          ),
          FittedBox(
            child: Text(
              S.of(context).feels_empty,
            ),
          ),
        ],
      ),
    );
  }
}
