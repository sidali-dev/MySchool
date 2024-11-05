import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myschool/controllers/level_dialog_controller.dart';
import 'package:myschool/controllers/sign_in_controller.dart';
import 'package:myschool/views/widgets/sign_in_dialog.dart';
import 'package:myschool/utils/device/device_utility.dart';

import '../../utils/constants/colors.dart';
import 'branch_dialog.dart';

class LevelDialog extends StatelessWidget {
  final String email;
  final String password;
  LevelDialog({
    super.key,
    required this.email,
    required this.password,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                          const Center(
                            child: Text(
                              'About You',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 40.0),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          const Text("Full Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16)),
                          SizedBox(height: height * 0.01),
                          TextFormField(
                            controller: controller.nameController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                prefixIcon:
                                    Icon(Icons.person, color: SColors.primary),
                                hintText: "New User"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                return 'Name should only contain letters';
                              }

                              if (value.length < 3) {
                                return 'Name is too short';
                              }

                              if (value.length > 25) {
                                return 'Name is too long';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: height * 0.02),
                          const Text("Level",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16)),
                          SizedBox(height: height * 0.01),
                          DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a level';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.layer),
                                hintText: "Pick Your Level"),
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
                                            name:
                                                controller.nameController.text,
                                            level: controller
                                                .selectedLevel['level'],
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
                                  } else if (controller
                                          .selectedLevel['level'] >=
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
                                        controller.selectedLevel['level'] ==
                                                null
                                            ? "NEXT"
                                            : controller.selectedLevel[
                                                        'level'] >=
                                                    10
                                                ? "NEXT"
                                                : "FINISH",
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
                                const Text(
                                  "Already Have an Account?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
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
                                        builder: (context) => SignInDialog()
                                            .animate()
                                            .slideX(
                                                begin: -1,
                                                end: 0,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves
                                                    .fastEaseInToSlowEaseOut),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "SIGN IN",
                                    style: TextStyle(
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
            )),
      ),
    );
  }
}
