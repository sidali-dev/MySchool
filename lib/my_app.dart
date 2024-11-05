import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myschool/generated/l10n.dart';
import 'package:myschool/services/authentication_service.dart';
import 'package:myschool/test.dart';
import 'package:myschool/utils/theme/theme.dart';
import 'package:myschool/views/intro_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(Intl.getCurrentLocale()),
      themeMode: ThemeMode.light,
      theme: SAppTheme.getLightTheme(true),
      darkTheme: SAppTheme.getDarkTheme(true),
      home: GetBuilder<AuthenticationService>(
        builder: (controller) {
          if (controller.authStatus == AuthStatus.unauthenticated) {
            return const IntroScreen();
          } else if (controller.authStatus == AuthStatus.authenticated) {
            return const Test();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
