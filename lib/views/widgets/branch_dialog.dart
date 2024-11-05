import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:myschool/controllers/branch_dialog_controller.dart';
import 'package:myschool/views/widgets/level_dialog.dart';
import 'package:myschool/utils/device/device_utility.dart';

import '../../utils/constants/colors.dart';
import '../../controllers/sign_in_controller.dart';

class BranchDialog extends StatelessWidget {
  final String email;
  final String password;
  final int level;
  final String name;
  BranchDialog({
    super.key,
    required this.email,
    required this.password,
    required this.name,
    required this.level,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = SDeviceUtils.getScreenWidth(context);
    final double height = SDeviceUtils.getScreenHeight(context);

    return GetX<BranchDialogController>(
      init: BranchDialogController(),
      builder: (controller) => Animate(
        controller: controller.animationController,
        effects: controller.effects,
        child: Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24))),
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
                            'Sign up',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 40.0),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        const Text("Level",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16)),
                        SizedBox(height: height * 0.01),
                        DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Please select a branch";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.category),
                              hintText: "Pick Your Branch"),
                          items: controller.branches[level]!
                              .map(
                                (Map e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e["branch"]),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            controller.changeBranch(value!);
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        GetBuilder(
                          init: SignInController(),
                          builder: (signInController) => InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                bool isSuccess = await signInController
                                    .appWriteSignUp(
                                        context: context,
                                        email: email,
                                        password: password)
                                    .then(
                                  (bool value) async {
                                    if (value) {
                                      bool isSuccess =
                                          await controller.addCredentials(
                                        context: context,
                                        name: name,
                                        level: level,
                                        branch:
                                            controller.selectedBranch['branch'],
                                      );
                                      return isSuccess;
                                    } else {
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: width * 0.1),
                                  const Text(
                                    "FINSIH",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(width: width * 0.03),
                                  const Icon(Icons.check,
                                      color: Colors.white, size: 32.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Forgot Something?",
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
                                      const Duration(milliseconds: 450),
                                    ).then(
                                      (_) => Get.back(),
                                    );

                                    if (context.mounted) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => LevelDialog(
                                          email: email,
                                          password: password,
                                        ).animate().slideX(
                                            begin: -1,
                                            end: 0,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve:
                                                Curves.fastEaseInToSlowEaseOut),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "GO BACK",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: SColors.primary),
                                  ),
                                )
                              ],
                            ),
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
