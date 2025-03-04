import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:myschool/controllers/sign_in_controller.dart';
import 'package:myschool/controllers/teacher_info_dialog_controller.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/views/widgets/sign_in_dialog.dart';
import 'package:myschool/utils/device/device_utility.dart';

import '../../generated/l10n.dart';
import '../../utils/constants/colors.dart';

class TeacherInfoDialog extends StatelessWidget {
  final String email;
  final String password;
  const TeacherInfoDialog({
    super.key,
    required this.email,
    required this.password,
  });

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = SDeviceUtils.getScreenWidth(context);
    final double height = SDeviceUtils.getScreenHeight(context);

    return GetX<TeacherInfoDialogController>(
      init: TeacherInfoDialogController(),
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
                        const Text("Description",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16)),
                        SizedBox(height: height * 0.01),
                        TextFormField(
                          controller: controller.descriptionController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.description_outlined,
                              color: SColors.primary,
                            ),
                            hintText: "Tell us about yourself",
                            alignLabelWithHint: true,
                            counter: Obx(
                              () => Text(
                                '${controller.charCount.value}/150',
                                style: TextStyle(
                                  color: controller.charCount.value > 150
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          maxLength: 150,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Tell us about yourself";
                            }
                            return null;
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
                                  (bool isSuccess) async {
                                    if (isSuccess) {
                                      final response = await controller
                                          .addTeacherCredentials(
                                        context: context,
                                        name: controller.nameController.text,
                                        description: controller
                                            .descriptionController.text,
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
                                  Text(
                                    S.of(context).finish,
                                    style: const TextStyle(
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
