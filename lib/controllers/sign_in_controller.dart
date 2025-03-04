import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:myschool/services/authentication_service.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/utils/helpers/appwrite_helpers.dart';
import 'package:myschool/views/widgets/spinning_logo.dart';

class SignInController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  RxBool passwordIsHidden = true.obs;
  RxBool isSigningUp = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxList<Effect> effects = <Effect>[
    const FlipEffect(
      begin: 1,
      end: 2,
      direction: Axis.horizontal,
      duration: Duration(milliseconds: 500),
    ),
  ].obs;

  @override
  onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  onClose() {
    emailController.dispose();
    passwordController.dispose();
    animationController.dispose();
  }

  changeDialogAnimtion() {
    effects.value = [
      const FlipEffect(
        begin: 0,
        end: 2,
        direction: Axis.horizontal,
        duration: Duration(seconds: 1),
      ),
    ];
  }

  errorDialogAnimtion() {
    effects.value = [
      const ShakeEffect(
        duration: Duration(milliseconds: 370),
      )
    ];
  }

  closeDialogAnimtion() {
    effects.value = [
      const SlideEffect(
        begin: Offset(0, 0),
        end: Offset(-1, 0),
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      )
    ];
  }

  switchSignIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    isSigningUp.value = !isSigningUp.value;
  }

  switchvisibility() {
    passwordIsHidden.value = !passwordIsHidden.value;
  }

// SIGN IN
  Future<bool> appWriteSignIn(
      {required BuildContext context,
      required String email,
      required String password,
      required RoleEnum role}) async {
    AuthenticationService authController = Get.find<AuthenticationService>();

    //start loading indicator
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: SpinningLogo(),
      ),
    );

    //sign the user in
    int response = await authController.createEmailSession(
      email: email.trim(),
      password: password.trim(),
    );

    //close loading indicator
    Get.back();

    //handle possible errors
    if (response != 200 && context.mounted) {
      AppwriteHelpers.handleAppwriteExceptions(response, context);
      return false;
    } else {
      return true;
    }
  }

// SIGN UP
  Future<bool> appWriteSignUp(
      {required BuildContext context,
      required String email,
      required String password}) async {
    AuthenticationService authController = Get.find<AuthenticationService>();

    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: SpinningLogo(),
      ),
    );

    //sign up the user
    int response = await authController
        .createUser(
      email: email,
      password: password,
    )
        .then(
      (int value) async {
        if (value == 200) {
          int result = await authController.createEmailSession(
              email: email.trim(), password: password.trim());
          return result;
        } else {
          return value;
        }
      },
    );

    //close loading indicator
    Get.back();

    //handle possible errors
    if (response != 200 && context.mounted) {
      AppwriteHelpers.handleAppwriteExceptions(response, context);
      return false;
    } else {
      return true;
    }
  }
}
