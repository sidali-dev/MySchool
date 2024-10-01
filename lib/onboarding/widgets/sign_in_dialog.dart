import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myschool/generals/controllers/flipping_container_controller.dart';
import 'package:myschool/generals/widgets/animated_changing_text.dart';
import 'package:myschool/generals/widgets/flipping_container.dart';
import 'package:myschool/onboarding/controllers/sign_in_controller.dart';
import 'package:myschool/utils/device/device_utility.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import '../../utils/constants/colors.dart';

class SignInDialog extends StatelessWidget {
  SignInDialog({super.key});

  final SignInController controller = Get.put(SignInController());

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final FlippingContainerController flippingContainerController =
      FlippingContainerController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = SDeviceUtils.getScreenWidth(context);
    final double height = SDeviceUtils.getScreenHeight(context);

    return FlippingContainer(
        flipController: flippingContainerController,
        widget: Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24))),
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
                          child: Obx(
                            () => AnimatedChangingText(
                                value: controller.isSigningUp.value,
                                duration: const Duration(milliseconds: 500),
                                text1: "Sign up",
                                text2: "Sign in",
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 40.0)),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        const Text("Email",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16)),
                        SizedBox(height: height * 0.01),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.mail, color: SColors.primary),
                            hintText: "New.User@gmail.com",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        const Text(
                          "Password",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        SizedBox(height: height * 0.01),
                        Obx(
                          () => TextFormField(
                            controller: passwordController,
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
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                        Obx(
                          () => GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                controller.email.value = emailController.text;
                                controller.password.value =
                                    passwordController.text;

                                await SHelperFunctions.checkInternetConnection(
                                    context);

                                try {
                                  if (context.mounted) {
                                    if (controller.isSigningUp.value) {
                                      await controller.firebaseSignUp(context);
                                    } else {
                                      await controller.firebaseSignIn(context);
                                    }
                                  }
                                  Get.back();
                                } catch (_) {}
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
                                    text1: "SIGN UP",
                                    text2: "SIGN IN",
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Center(
                            child: Column(
                              children: [
                                Obx(
                                  () => AnimatedChangingText(
                                    value: controller.isSigningUp.value,
                                    duration: const Duration(milliseconds: 500),
                                    text1: "Already Have an Account?",
                                    text2: "New Here?",
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                GestureDetector(
                                  onTap: () async {
                                    controller.switchSignIn();

                                    flippingContainerController
                                        .triggerFullFlip();
                                  },
                                  child: Obx(
                                    () => AnimatedChangingText(
                                      value: controller.isSigningUp.value,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      text1: "SIGN IN",
                                      text2: "SIGN UP",
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color: SColors.primary),
                                    ),
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
        ));
  }
}
