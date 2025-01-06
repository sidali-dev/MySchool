import 'package:flutter/material.dart';

import '../../controllers/user_controller.dart';
import '../../utils/constants/colors.dart';

class SettingsSwitchRow extends StatelessWidget {
  const SettingsSwitchRow({
    super.key,
    required this.userController,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.value,
  });

  final UserController userController;
  final IconData icon;
  final String title;
  final bool value;
  final VoidCallback onTap;

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
        const SizedBox(
          width: 16,
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        const Spacer(),
        Switch(
          activeColor: SColors.primary,
          value: value,
          onChanged: (value) {
            onTap();
          },
        )
      ],
    );
  }
}
