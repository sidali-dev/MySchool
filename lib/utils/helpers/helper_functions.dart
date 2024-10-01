import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../local_storage/services/sharedpreferences_service.dart';

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

  static formatDate(String timeStamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(timeStamp) * 1000,
        isUtc: false);

    final dateFormatter = DateFormat('dd MMM yyyy');
    final formattedDate = dateFormatter.format(dateTime);

    return formattedDate;
  }

  static Future<bool> isFirstRun() async {
    return SharedPrefService.getBool('isFirstRun') ?? true;
  }

  static Future<void> saveInitialValues() async {
    final isFirstRun = await SHelperFunctions.isFirstRun();
    if (isFirstRun) {
      await SharedPrefService.setBool('isFirstRun', false);
      await SharedPrefService.setBool('fajr', true);
      await SharedPrefService.setBool('chourouk', false);
      await SharedPrefService.setBool('dhuhr', true);
      await SharedPrefService.setBool('asr', true);
      await SharedPrefService.setBool('maghrib', true);
      await SharedPrefService.setBool('isha', true);
      await SharedPrefService.setString('country', "");
      await SharedPrefService.setString('state', "");
      await SharedPrefService.setString('city', "");
      await SharedPrefService.setString(
          'adhan_sound_path', "assets/sounds/ahmad_alnafees.mp3");
      await SharedPrefService.setString(
          'adhan_sound_name', "أذان الشيخ النفيس");
      await SharedPrefService.setInt('last_read_quran', 1);
      await SharedPrefService.setString('quran_bookmark', "");
    }
  }

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
              scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                child: dialog,
              )),
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
            fontFamily: "Poppins", fontSize: 20, fontWeight: FontWeight.w700),
        title: title,
        messageTextStyle: const TextStyle(
            fontFamily: "Poppins", fontSize: 14, fontWeight: FontWeight.w400),
        message: content,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
