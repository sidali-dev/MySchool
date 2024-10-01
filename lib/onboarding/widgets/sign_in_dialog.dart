import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myschool/onboarding/controllers/sign_in_controller.dart';
import 'package:myschool/utils/device/device_utility.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import '../../utils/constants/colors.dart';
import 'sign_up_1_dialog.dart';

class SignInDialog extends StatelessWidget {
  SignInDialog({super.key});

  final SignInController controller = Get.put(SignInController());

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = SDeviceUtils.getScreenWidth(context);
    final double height = SDeviceUtils.getScreenHeight(context);

    return Dialog(
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
                          'Sign in',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 40.0),
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
                          prefixIcon: Icon(Icons.mail, color: SColors.primary),
                          hintText: "New.User@gmail.com",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
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
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.email.value = emailController.text;
                            controller.password.value = passwordController.text;
                          }
                          //REMOVE LATER
                          else {
                            print('Form is not valid');
                          }
                          //////////////////////
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
                              const Text(
                                "SIGN IN",
                                style: TextStyle(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "New Here?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            const SizedBox(width: 4.0),
                            GestureDetector(
                              onTap: () async {
                                Get.back();
                                await Future.delayed(
                                        const Duration(milliseconds: 300))
                                    .then(
                                  (_) => SHelperFunctions.openDialogAnimation(
                                      context,
                                      SignUp1Dialog(),
                                      "Sign Up Dialog"),
                                );
                              },
                              child: const Text(
                                "SIGN UP",
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
        ));
  }
}
