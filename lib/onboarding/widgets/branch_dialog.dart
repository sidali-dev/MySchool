import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myschool/onboarding/controllers/credentials_controller.dart';
import 'package:myschool/onboarding/widgets/sign_in_dialog.dart';
import 'package:myschool/utils/device/device_utility.dart';

import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';

class BranchDialog extends StatelessWidget {
  BranchDialog({super.key});

  final CredentialsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final double width = SDeviceUtils.getScreenWidth(context);
    final double height = SDeviceUtils.getScreenHeight(context);

    final formKey = GlobalKey<FormState>();

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
                  key: formKey,
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

                      //
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
                        items: controller
                            .branches[controller.selectedLevel['level']]!
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

                      //
                      SizedBox(height: height * 0.02),
                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                          }

                          //DELETE LATER
                          else {
                            print('FORM KEY NOT VALIDATED');
                          }
                          //
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
                                "NEXT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(width: width * 0.03),
                              const Icon(Iconsax.arrow_right_3,
                                  color: Colors.white, size: 32.0),
                            ],
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
                                      SignInDialog(),
                                      "Sign In Dialog"),
                                );
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
        ));
  }
}
