import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../generated/l10n.dart';
import '../../utils/constants/image_strings.dart';

class NoMaterialsScreen extends StatelessWidget {
  const NoMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          LottieBuilder.asset(
            SImageString.booksAnimation,
            width: 200,
            repeat: false,
          ),
          Text(
            S.of(context).no_content_available,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 8.0),
            child: Text(
              S.of(context).adding_content_soon,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
