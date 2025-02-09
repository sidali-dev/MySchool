import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myschool/controllers/teacher_profile_controller.dart';
import 'package:myschool/models/activities.dart';
import 'package:myschool/models/teacher_model.dart';
import 'package:myschool/utils/constants/image_strings.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';

import '../controllers/activities_controller.dart';
import '../controllers/user_controller.dart';
import 'widgets/squar_button.dart';

class TeacherProfile extends StatelessWidget {
  final TeacherModel teacherModel;

  const TeacherProfile({
    required this.teacherModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = SHelperFunctions.screenWidth();
    final bool isDark = SHelperFunctions.isDarkMode(context);

    final UserController userController = Get.find();
    final TeacherProfileController controller = TeacherProfileController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Teacher's profile",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 40,
              right: -10,
              child: Transform.rotate(
                angle: 0.2,
                child: Image.asset(
                  SImageString.activityExams,
                  height: 100,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                CircleAvatar(
                  backgroundColor: Colors.lightBlue.shade100,
                  radius: screenWidth / 6,
                  child: Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: screenWidth / 4,
                  ),
                ),
                const SizedBox(height: 16),
                FittedBox(
                  child: Text(
                    teacherModel.user.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  teacherModel.description!,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                FutureBuilder(
                  future: controller.getTeacherAssets(
                    level: userController.student.value!.level.toString(),
                    teacherID: teacherModel.id,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }

                      if (controller.activities.isEmpty) {
                        return const Center(child: Text("No activities found"));
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 32,
                              mainAxisSpacing: 24,
                            ),
                            itemCount: controller.activities.length,
                            itemBuilder: (context, index) {
                              final Activity activity = controller
                                  .getActivity(controller.activities[index]);
                              return SquarButton(
                                image: activity.imagePath,
                                title: ActivitiesController.getActivitiesTitle(
                                    context, activity.activity),
                                onTap: () {},
                              );
                            },
                          ),
                        );
                      }
                    }

                    // Handle other states (e.g., ConnectionState.active)
                    return const SizedBox.shrink();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
