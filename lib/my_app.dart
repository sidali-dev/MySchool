import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myschool/generals/controllers/user_controller.dart';
import 'package:myschool/onboarding/intro_screen.dart';
import 'package:myschool/test.dart';

import 'generated/l10n.dart';
import 'utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userController.checkIsSignedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: true,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: Locale(Intl.getCurrentLocale()),
          themeMode: ThemeMode.light,
          theme: SAppTheme.getLightTheme(true),
          darkTheme: SAppTheme.getDarkTheme(true),
          home: Obx(() => userController.isSignedIn.value
              ? const Test()
              : const IntroScreen()),
        );
      },
    );
  }
}
