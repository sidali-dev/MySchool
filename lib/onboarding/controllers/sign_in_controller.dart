import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myschool/utils/services/appwrite_provider.dart';

class SignInController extends GetxController {
  RxBool passwordIsHidden = true.obs;
  RxString email = "".obs;
  RxString password = "".obs;

  RxBool isSigningUp = false.obs;

  switchSignIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    isSigningUp.value = !isSigningUp.value;
  }

  switchvisibility() {
    passwordIsHidden.value = !passwordIsHidden.value;
  }

  appWriteSignIn(BuildContext context) async {
    AppwriteProvider appwriteProvider = AppwriteProvider();
    await appwriteProvider.signIn(
        context: context, email: email.value, password: password.value);
  }

  appWriteSignUp(BuildContext context) async {
    AppwriteProvider appwriteProvider = AppwriteProvider();
    await appwriteProvider.signUp(
        context: context, email: email.value, password: password.value);
  }
}
