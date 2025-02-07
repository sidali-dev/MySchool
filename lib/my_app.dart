import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:myschool/controllers/language_controller.dart';
import 'package:myschool/controllers/theme_controller.dart';
import 'package:myschool/generated/l10n.dart';
import 'package:myschool/services/authentication_service.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/views/student_home_screen.dart';
import 'package:myschool/utils/theme/theme.dart';
import 'package:myschool/views/intro_screen.dart';
import 'package:myschool/views/teacher_home_screen.dart';

import 'controllers/user_controller.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.find();
  final LanguageController languageController = Get.find();
  final UserController userController = Get.put(UserController());

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
      locale: Locale(languageController.getCurrentLanguage()),
      themeMode:
          themeController.isDarkMode() ? ThemeMode.dark : ThemeMode.light,
      theme: SAppTheme.getLightTheme(true),
      darkTheme: SAppTheme.getDarkTheme(true),
      home: GetBuilder<AuthenticationService>(
        builder: (controller) {
          if (controller.authStatus == AuthStatus.unauthenticated) {
            return const IntroScreen();
          } else if (controller.authStatus == AuthStatus.authenticated) {
            return Builder(
              builder: (context) => FutureBuilder(
                future: userController.loadUpUser(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      print(snapshot.error);

                      return Scaffold(
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Error: ${snapshot.error}'),
                            const SizedBox(height: 32),
                            ElevatedButton(
                                onPressed: () async {
                                  await UserController()
                                      .signOut(context: context);
                                },
                                child: const Text("DICONNECT"))
                          ],
                        ),
                      );
                    } else {
                      return userController.user.value!.role == Role.student
                          ? StudentHomeScreen()
                          : TeacherHomeScreen(
                              name: userController.user.value!.name);
                    }
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
