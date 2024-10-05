import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myschool/utils/helpers/appwrite_helpers.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';

import '../../generals/controllers/user_controller.dart';
import '../../generals/widgets/check_dialog.dart';
import '../constants/colors.dart';
import '../constants/image_strings.dart';

class AppwriteProvider {
  Client client = Client();

  Account? account;

  AppwriteProvider() {
    client
        .setEndpoint(dotenv.get("APPWRITE_ENDPOINT"))
        .setProject(dotenv.get("APPWRITE_PROJECT"))
        .setSelfSigned(
            status:
                true); // For self signed certificates, only use for development

    account = Account(client);
  }

  Future signUp(
      {required BuildContext context,
      required String email,
      required String password}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingAnimationWidget.halfTriangleDot(
            color: SColors.primary, size: 56));
    if (await SHelperFunctions.isInternetConnected()) {
      try {
        await account!
            .create(userId: ID.unique(), email: email, password: password);

        if (context.mounted) {
          await signIn(context: context, email: email, password: password);
          Get.back();
        }
      } on AppwriteException catch (e) {
        Get.back();
        if (context.mounted) {
          AppwriteHelpers.handleAppwriteExceptions(e, context);
        }
      } catch (_) {
        Get.back();
        if (context.mounted) {
          AppwriteHelpers.showSomethingWentWorng(context);
        }
      }
    } else {
      Get.back();
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) => const CheckDialog(
                title: "NO INTERNET CONNECTION",
                imagePath: SImageString.noInternetAnimation,
                color: SColors.primary));
      }
    }
  }

  Future signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingAnimationWidget.halfTriangleDot(
            color: SColors.primary, size: 56));

    if (await SHelperFunctions.isInternetConnected()) {
      try {
        await account!
            .createEmailPasswordSession(email: email, password: password);

        final UserController userController = Get.find();
        userController.isSignedIn.value = true;
        Get.back();
      } on AppwriteException catch (e) {
        Get.back();

        if (context.mounted) {
          AppwriteHelpers.handleAppwriteExceptions(e, context);
        }
      } catch (_) {
        Get.back();
        if (context.mounted) {
          AppwriteHelpers.showSomethingWentWorng(context);
        }
      }
    } else {
      Get.back();
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) => const CheckDialog(
                title: "NO INTERNET CONNECTION",
                imagePath: SImageString.noInternetAnimation,
                color: SColors.primary));
      }
    }
  }

  Future signOut(BuildContext context) async {
    try {
      await account!.deleteSession(sessionId: 'current');

      final UserController userController = Get.find();
      userController.isSignedIn.value = false;
    } on AppwriteException catch (e) {
      if (context.mounted) {
        AppwriteHelpers.handleAppwriteExceptions(e, context);
      }
    } catch (_) {
      if (context.mounted) {
        AppwriteHelpers.showSomethingWentWorng(context);
      }
    }
  }
}
