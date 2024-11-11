import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myschool/views/widgets/animation/animated_changing_text.dart';
import 'package:myschool/controllers/sign_in_controller.dart';
import 'package:myschool/views/widgets/level_dialog.dart';
import 'package:myschool/utils/device/device_utility.dart';
import '../../generated/l10n.dart';
import '../../utils/constants/colors.dart';

class SignInDialog extends StatelessWidget {
  SignInDialog({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = SDeviceUtils.getScreenWidth(context);
    final double height = SDeviceUtils.getScreenHeight(context);

    return GetX<SignInController>(
      init: SignInController(),
      builder: (controller) => Animate(
        controller: controller.animationController,
        effects: controller.effects,
        child: Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: width * 0.8,
            height: height * 0.55,
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
                          child: AnimatedChangingText(
                              value: controller.isSigningUp.value,
                              duration: const Duration(milliseconds: 500),
                              text1: S.of(context).sign_up,
                              text2: S.of(context).sign_in,
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 40.0)),
                        ),
                        SizedBox(height: height * 0.02),
                        Text(S.of(context).email,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16)),
                        SizedBox(height: height * 0.01),
                        TextFormField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.mail, color: SColors.primary),
                            hintText: "New.User@gmail.com",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).enter_email;
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return S.of(context).valid_email;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        Text(
                          S.of(context).password,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        SizedBox(height: height * 0.01),
                        TextFormField(
                          controller: controller.passwordController,
                          obscureText: controller.passwordIsHidden.value,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "****************",
                            suffixIcon: IconButton(
                              icon: Icon(controller.passwordIsHidden.value
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye),
                              onPressed: () => controller.switchvisibility(),
                            ),
                            prefixIcon:
                                const Icon(Icons.key, color: SColors.primary),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).enter_password;
                            }
                            if (value.length < 8) {
                              return S.of(context).password_at_least_8;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.04),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              if (context.mounted) {
                                if (controller.isSigningUp.value) {
                                  controller.closeDialogAnimtion();
                                  controller.animationController
                                    ..reset()
                                    ..forward();

                                  await Future.delayed(
                                    const Duration(milliseconds: 500),
                                  ).then((value) => Get.back());

                                  if (context.mounted) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => LevelDialog(
                                            email:
                                                controller.emailController.text,
                                            password: controller
                                                .passwordController.text));
                                  }
                                } else {
                                  bool isSucceed =
                                      await controller.appWriteSignIn(
                                    context: context,
                                    email: controller.emailController.text,
                                    password:
                                        controller.passwordController.text,
                                  );

                                  if (isSucceed) {
                                    controller.closeDialogAnimtion();
                                    controller.animationController
                                      ..reset()
                                      ..forward();

                                    await Future.delayed(
                                      const Duration(milliseconds: 500),
                                    ).then((value) => Get.back());
                                  } else {
                                    controller.errorDialogAnimtion();
                                    controller.animationController
                                      ..reset()
                                      ..forward();
                                  }
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Iconsax.arrow_right_3,
                                    color: Colors.white, size: 32.0),
                                SizedBox(width: width * 0.05),
                                AnimatedChangingText(
                                  value: controller.isSigningUp.value,
                                  duration: const Duration(milliseconds: 500),
                                  text1: S.of(context).sign_up,
                                  text2: S.of(context).sign_in,
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(width: width * 0.06)
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Center(
                            child: Column(
                              children: [
                                AnimatedChangingText(
                                  value: controller.isSigningUp.value,
                                  duration: const Duration(milliseconds: 500),
                                  text1: S.of(context).have_an_account,
                                  text2: S.of(context).new_here,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                const SizedBox(width: 4.0),
                                GestureDetector(
                                  onTap: () async {
                                    controller.switchSignIn();

                                    controller.changeDialogAnimtion();

                                    controller.animationController
                                      ..reset()
                                      ..forward();
                                  },
                                  child: AnimatedChangingText(
                                    value: controller.isSigningUp.value,
                                    duration: const Duration(milliseconds: 500),
                                    text1: S.of(context).sign_in,
                                    text2: S.of(context).sign_up,
                                    textStyle: const TextStyle(
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
