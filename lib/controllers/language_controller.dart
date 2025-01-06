import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myschool/utils/constants/get_keys.dart';
import 'package:myschool/utils/constants/image_strings.dart';

class LanguageController {
  List languages = ["en", "fr", "ar"];
  final GetStorage box = GetStorage();

  String getCurrentLanguage() {
    return box.read(GetKeys.selectedLanguage) ?? "en";
  }

  changeCurrentLanguage(String language) {
    box.write(GetKeys.selectedLanguage, language);
    Get.updateLocale(Locale(language));
  }

  getLanguageFlag(String language) {
    switch (language) {
      case "en":
        return SImageString.moduleEnglish;
      case "fr":
        return SImageString.moduleFrench;
      case "ar":
        return SImageString.moduleArabic;
    }
  }

  getLanguageTitle(String language) {
    switch (language) {
      case "en":
        return "English";
      case "fr":
        return "Francais";
      case "ar":
        return "العربية";
    }
  }

  int getInitialFlag() {
    String currentLanguage = box.read(GetKeys.selectedLanguage) ?? "en";
    return currentLanguage == "en"
        ? 0
        : currentLanguage == "fr"
            ? 1
            : 2;
  }
}
