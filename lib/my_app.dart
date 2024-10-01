import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myschool/test.dart';

import 'generated/l10n.dart';
import 'utils/theme/theme.dart';

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
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(Intl.getCurrentLocale()),
      themeMode: ThemeMode.light,
      theme: SAppTheme.getLightTheme(true),
      darkTheme: SAppTheme.getDarkTheme(true),
      home: const Test(),
    );
  }
}
