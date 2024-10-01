import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/services/firebase_authentication.dart';

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

  firebaseSignUp(BuildContext context) async {
    UserCredential credential = await FirebaseAuthentication.signUp(
        email: email.value, password: password.value, context: context);
    return credential;
  }

  firebaseSignIn(BuildContext context) async {
    UserCredential credential = await FirebaseAuthentication.signIn(
        email: email.value, password: password.value, context: context);
    return credential;
  }
}
