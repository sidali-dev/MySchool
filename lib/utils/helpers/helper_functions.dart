import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myschool/views/widgets/check_dialog.dart';
import 'package:myschool/utils/constants/colors.dart';
import 'package:myschool/utils/constants/get_keys.dart';
import 'package:myschool/utils/constants/image_strings.dart';

class SHelperFunctions {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getLangluageCode() {
    return Get.locale!.languageCode;
  }

  static bool isRtl(BuildContext context) {
    return Localizations.localeOf(context).languageCode == "ar";
  }

  static String removeTimeZone(String timeString) {
    List<String> parts = timeString.split(' ');

    return parts.first;
  }

  static Future<bool> isInternetConnected() async {
    try {
      final response = await http
          .head(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 30));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future checkInternetConnection(BuildContext context) async {
    if (!await isInternetConnected()) {
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

  static formatDate(String timeStamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(timeStamp) * 1000,
        isUtc: false);

    final dateFormatter = DateFormat('dd MMM yyyy');
    final formattedDate = dateFormatter.format(dateTime);

    return formattedDate;
  }

  static bool isFirstRun() {
    final box = GetStorage();

    return box.read(GetKeys.isFirstRun) ?? true;
  }

  static saveInitialValues() {
    final box = GetStorage();

    final isFirstRun = SHelperFunctions.isFirstRun();

    if (isFirstRun) {
      box.write(GetKeys.isFirstRun, false);
      box.write(GetKeys.isCredentialsIn, false);
    }
  }

//CONSIDER DELETING !!!!!
  static openDialogAnimation(
      BuildContext context, Widget dialog, String dialogLabel) {
    showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: dialogLabel,
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => const SizedBox(),
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
          child: dialog,
        ),
      ),
    );
  }

  static showAwesomeSnackBar(
      {required String title,
      required String content,
      required ContentType contentType,
      required BuildContext context}) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        titleTextStyle: const TextStyle(
            fontFamily: "Poppins", fontSize: 18, fontWeight: FontWeight.w700),
        title: title,
        messageTextStyle: const TextStyle(
            fontFamily: "Poppins", fontSize: 12, fontWeight: FontWeight.w500),
        message: content,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
