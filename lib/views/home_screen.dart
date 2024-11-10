import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myschool/controllers/home_controller.dart';
import 'package:myschool/controllers/user_controller.dart';
import 'package:myschool/models/modules.dart';
import 'package:myschool/utils/device/device_utility.dart';
import 'package:myschool/views/activities_screen.dart';
import 'package:myschool/views/widgets/bubble.dart';
import 'package:myschool/views/widgets/squar_button.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final double screenHeight = SDeviceUtils.getScreenHeight(context);

    return Scaffold(
      body: FutureBuilder(
        future: userController.onInit(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final HomeController homeController = HomeController(
              level: userController.user.value!.level,
              branch: userController.user.value!.branch);

          return SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: -100,
                  width: 200,
                  top: (screenHeight / 2) - 100,
                  child: Bubble(
                    innerColor: Colors.white,
                    outterColor: Colors.lightBlue,
                    radius: 200,
                    delay: 500.milliseconds,
                  ),
                ),
                Positioned(
                  left: -50,
                  width: 300,
                  top: -100,
                  child: Bubble(
                    innerColor: Colors.white,
                    outterColor: Colors.lightBlue,
                    radius: 300,
                    delay: 1.seconds,
                  ),
                ),
                Positioned(
                  left: 50,
                  width: 250,
                  bottom: -100,
                  child: Bubble(
                    innerColor: Colors.white,
                    outterColor: Colors.lightBlue,
                    radius: 250,
                    delay: 1500.milliseconds,
                  ),
                ),
                SizedBox(width: SDeviceUtils.getScreenWidth(context)),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 32.0, left: 32.0, top: 88.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 48),
                      ),
                      Text(
                        userController.user.value!.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 48),
                      ),
                      const Text(
                        "What are we learning today?",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22),
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 32,
                          mainAxisSpacing: 24,
                        ),
                        itemCount: homeController.modules.length,
                        itemBuilder: (context, index) {
                          final Module module = homeController.modules[index];
                          return SquarButton(
                            image: module.imagePath,
                            title: module.module.name,
                            onTap: () {
                              Get.to(
                                // PageTransition(
                                //       type: PageTransitionType.rightToLeft,
                                //       child: ActivitiesScreen(
                                //           module: module,
                                //           activityImage: module.imagePath))

                                () => ActivitiesScreen(
                                    activityImage: module.imagePath,
                                    module: module),
                                transition: Transition.downToUp,
                                duration: 370.milliseconds,
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //      AuthenticationService authenticationService = Get.find();
      //      authenticationService.signOut();
      //   },
      // ),
    );
  }
}
