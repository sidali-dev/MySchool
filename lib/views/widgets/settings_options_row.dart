import 'package:flutter/material.dart';
import 'package:myschool/views/widgets/animation/auto_scrolling_text.dart';

import '../../controllers/user_controller.dart';
import '../../utils/constants/colors.dart';

class SettingsOptionsRow extends StatelessWidget {
  const SettingsOptionsRow({
    super.key,
    required this.userController,
    required this.icon,
    required this.title,
    required this.trailingTitle,
    required this.onTap,
    required this.isRtl,
    required this.screenWidth,
  });

  final UserController userController;
  final IconData icon;
  final String title;
  final String trailingTitle;
  final VoidCallback onTap;

  final bool isRtl;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Icon(
            icon,
            color: SColors.darkGrey,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              AutoScrollText(
                alignment: isRtl ? Alignment.centerLeft : Alignment.centerRight,
                width: screenWidth * 0.25,
                text: Text(
                  trailingTitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              Icon(
                isRtl ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
                color: Colors.grey,
              )
            ],
          ),
        )
      ],
    );
  }
}
