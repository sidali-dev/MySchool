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

    if (await SHelperFunctions.isInternetConnected()) {
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Get.back();
        return credential;
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
    } else {
      Get.back();
      if (context.mounted) {
        await SHelperFunctions.checkInternetConnection(context);
      }
    }
  }

  static Future signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingAnimationWidget.halfTriangleDot(
            color: SColors.primary, size: 56));

    if (await SHelperFunctions.isInternetConnected()) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Get.back();
        return credential;
      } on FirebaseAuthException catch (e) {
        Get.back();

        if (e.code == 'invalid-email') {
          if (context.mounted) {
            SHelperFunctions.showAwesomeSnackBar(
                title: "Invalid Email",
                content: "The email you entered isn't valid",
                contentType: ContentType.failure,
                context: context);
          }
        } else if (e.code == 'user-disabled') {
          if (context.mounted) {
            SHelperFunctions.showAwesomeSnackBar(
                title: "User Disabled",
                content: "This user account is disabled",
                contentType: ContentType.failure,
                context: context);
          }
        } else if (e.code == 'user-not-found') {
          if (context.mounted) {
            SHelperFunctions.showAwesomeSnackBar(
                title: "User Not Found",
                content: "Try Creating a new account",
                contentType: ContentType.failure,
                context: context);
          }
        } else if (e.code == 'wrong-password') {
          if (context.mounted) {
            SHelperFunctions.showAwesomeSnackBar(
                title: "Wrong Password",
                content: "Try another password",
                contentType: ContentType.failure,
                context: context);
          }
        } else if (e.code == 'too-many-requests') {
          if (context.mounted) {
            SHelperFunctions.showAwesomeSnackBar(
                title: "Too Many Request",
                content: "Try again in a while",
                contentType: ContentType.failure,
                context: context);
          }
        } else if (e.code == 'network-request-failed') {
          if (context.mounted) {
            SHelperFunctions.showAwesomeSnackBar(
                title: "Network Request Error",
                content: "Try again in a while",
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
    } else {
      Get.back();
      if (context.mounted) {
        await SHelperFunctions.checkInternetConnection(context);
      }
    }
  }

  static Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
