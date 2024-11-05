import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myschool/controllers/user_controller.dart';
import 'package:myschool/utils/device/device_utility.dart';
import 'package:myschool/views/widgets/bubble.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final double screenHeight = SDeviceUtils.getScreenHeight(context);
    return Scaffold(
      body: Stack(
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
            padding: const EdgeInsets.only(right: 32.0, left: 32.0, top: 88.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 48),
                ),
                Text(
                  userController.user.value!.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 48),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(userController.user.value!.id);
        },
      ),
    );
  }
}
