import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myschool/utils/constants/colors.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';

class FirebaseAuthentication {
  static Future signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingAnimationWidget.halfTriangleDot(
            color: SColors.primary, size: 56));

    try {
      // final credential =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Get.back();
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'weak-password') {
        if (context.mounted) {
          SHelperFunctions.showAwesomeSnackBar(
              title: "Weak Password",
              content: "Try a stronger password",
              contentType: ContentType.failure,
              context: context);
        }
      } else if (e.code == 'email-already-in-use') {
        if (context.mounted) {
          SHelperFunctions.showAwesomeSnackBar(
              title: "Email In Use",
              content: "An account already exists for this email",
              contentType: ContentType.failure,
              context: context);
        }
      }
    } catch (e) {
      Get.back();
      if (context.mounted) {
        SHelperFunctions.showAwesomeSnackBar(
            title: "ERROR",
            content: "Something went wrong",
            contentType: ContentType.failure,
            context: context);
      }
    }
  }
}
