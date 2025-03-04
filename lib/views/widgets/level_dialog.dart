import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myschool/controllers/level_dialog_controller.dart';
import 'package:myschool/controllers/sign_in_controller.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/views/widgets/sign_in_dialog.dart';
import 'package:myschool/utils/device/device_utility.dart';

import '../../generated/l10n.dart';
import '../../utils/constants/colors.dart';
import 'branch_dialog.dart';

class LevelDialog extends StatelessWidget {
  final String email;
  final String password;

  const LevelDialog({
    super.key,
    required this.email,
    required this.password,
  });

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = SDeviceUtils.getScreenWidth(context);
    final double height = SDeviceUtils.getScreenHeight(context);

    return GetX<LevelDialogController>(
      init: LevelDialogController(),
      builder: (controller) => Animate(
        effects: controller.effects,
        controller: controller.animationController,
        child: Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: width * 0.8,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    left: 32,
                    child: Transform.rotate(
                      angle: 0.6,
                      child: Image.asset("assets/images/png/school-bag.png",
                          height: height * 0.11),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Transform.rotate(
                      angle: -0.4,
                      child: Image.asset("assets/images/png/book.png",
                          height: height * 0.11),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: height * 0.01),
                        Center(
                          child: Text(
                            S.of(context).about_you,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 40.0),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Text(S.of(context).full_name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16)),
                        SizedBox(height: height * 0.01),
                        TextFormField(
                          controller: controller.nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person,
                                  color: SColors.primary),
                              hintText: S.of(context).new_user),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).enter_your_name;
                            }
                            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                              return S.of(context).name_only_contains_letters;
                            }

                            if (value.length < 3) {
                              return S.of(context).name_is_short;
                            }

                            if (value.length > 25) {
                              return S.of(context).name_is_long;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        Text(S.of(context).level,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16)),
                        SizedBox(height: height * 0.01),
                        DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return S.of(context).select_a_level;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.layer),
                              hintText: S.of(context).pick_your_level),
                          items: controller.levels
                              .map(
                                (Map e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e["title"]),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            controller.changeLevel(value!);
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        GetBuilder(
                          init: SignInController(),
                          builder: (signInController) => InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                if (controller.selectedLevel['level'] < 10) {
                                  bool isSuccess = await signInController
                                      .appWriteSignUp(
                                          context: context,
                                          email: email,
                                          password: password)
                                      .then(
                                    (bool isSuccess) async {
                                      if (isSuccess) {
                                        final response =
                                            await controller.addCredentials(
                                          context: context,
                                          name: controller.nameController.text,
                                          level:
                                              controller.selectedLevel['level'],
                                        );
                                        return response;
                                      } else {
                                        controller.errorDialogAnimtion();
                                        controller.animationController
                                          ..reset()
                                          ..forward();
                                        return false;
                                      }
                                    },
                                  );

                                  if (isSuccess) {
                                    controller.closeDialogAnimtion();
                                    controller.animationController
                                      ..reset()
                                      ..forward();

                                    await Future.delayed(
                                      const Duration(milliseconds: 500),
                                    ).then(
                                      (_) => Get.back(),
                                    );
                                  }
                                } else if (controller.selectedLevel['level'] >=
                                    10) {
                                  controller.closeDialogAnimtion();
                                  controller.animationController
                                    ..reset()
                                    ..forward();

                                  await Future.delayed(
                                    const Duration(milliseconds: 500),
                                  ).then(
                                    (_) => Get.back(),
                                  );

                                  if (context.mounted) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => BranchDialog(
                                        name: controller.nameController.text,
                                        level:
                                            controller.selectedLevel['level'],
                                        email: email,
                                        password: password,
                                      ),
                                    );
                                  }
                                }
                              } else {
                                controller.errorDialogAnimtion();
                                controller.animationController
                                  ..reset()
                                  ..forward();
                              }
                            },
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                  color: SColors.primary,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Obx(
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: width * 0.1),
                                    Text(
                                      controller.selectedLevel['level'] == null
                                          ? S.of(context).next
                                          : controller.selectedLevel['level'] >=
                                                  10
                                              ? S.of(context).next
                                              : S.of(context).finish,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(width: width * 0.03),
                                    Icon(
                                        controller.selectedLevel['level'] ==
                                                null
                                            ? Iconsax.arrow_right_3
                                            : controller.selectedLevel[
                                                        'level'] >=
                                                    10
                                                ? Iconsax.arrow_right_3
                                                : Icons.check,
                                        color: Colors.white,
                                        size: 32.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).have_an_account,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                              const SizedBox(width: 4.0),
                              GestureDetector(
                                onTap: () async {
                                  controller.openSignInDialog();
                                  controller.animationController
                                    ..reset()
                                    ..forward();

                                  await Future.delayed(
                                    const Duration(milliseconds: 500),
                                  ).then(
                                    (_) => Get.back(),
                                  );

                                  if (context.mounted) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => SignInDialog(
                                        role: RoleEnum.student,
                                      ).animate().slideX(
                                          begin: -1,
                                          end: 0,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve:
                                              Curves.fastEaseInToSlowEaseOut),
                                    );
                                  }
                                },
                                child: Text(
                                  S.of(context).sign_in,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: SColors.primary),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
