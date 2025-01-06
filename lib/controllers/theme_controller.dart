import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myschool/utils/constants/get_keys.dart';

class ThemeController extends GetxController {
  final GetStorage box = GetStorage();
  late RxBool isDark;

  @override
  onInit() {
    super.onInit();
    isDark = isDarkMode().obs;
  }

  _saveThemeMode(bool isDarkMode) {
    box.write(GetKeys.themeMode, isDarkMode);
  }

  bool isDarkMode() {
    return box.read(GetKeys.themeMode) ?? false;
  }

  switchTheme() async {
    bool isDarkModeVar = isDarkMode();
    Get.changeThemeMode(isDarkModeVar ? ThemeMode.light : ThemeMode.dark);

    await _saveThemeMode(!isDarkModeVar);
    isDark.value = !isDarkModeVar;
    update();
  }
}
