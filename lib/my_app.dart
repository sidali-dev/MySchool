import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:myschool/controllers/language_controller.dart';
import 'package:myschool/controllers/theme_controller.dart';
import 'package:myschool/generated/l10n.dart';
import 'package:myschool/services/authentication_service.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import 'package:myschool/views/student_home_screen.dart';
import 'package:myschool/utils/theme/theme.dart';
import 'package:myschool/views/intro_screen.dart';
import 'package:myschool/views/teacher_home_screen.dart';
import 'package:myschool/views/widgets/spinning_logo.dart';
import 'controllers/user_controller.dart';
import 'views/widgets/error_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.find();
  final LanguageController languageController = Get.find();
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(languageController.getCurrentLanguage()),
      themeMode:
          themeController.isDarkMode() ? ThemeMode.dark : ThemeMode.light,
      theme: SAppTheme.getLightTheme(true),
      darkTheme: SAppTheme.getDarkTheme(true),
      home: GetBuilder<AuthenticationService>(
        builder: (controller) {
          if (controller.authStatus == AuthStatus.unauthenticated) {
            return const IntroScreen();
          } else {
            return Builder(
              builder: (context) => FutureBuilder(
                future: userController.loadUpUser(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(
                        child: SpinningLogo(),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      final isDark = SHelperFunctions.isDarkMode(context);
                      return Scaffold(
                        body: ErrorScreen(
                          isDark: isDark,
                          showLogo: true,
                          onTap: () {
                            controller.update();
                          },
                        ),
                      );
                    } else {
                      return userController.user.value!.role == RoleEnum.student
                          ? StudentHomeScreen()
                          : TeacherHomeScreen(
                              name: userController.user.value!.name);
                    }
                  }
                  return const Scaffold(
                    body: Center(
                      child: SpinningLogo(),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
