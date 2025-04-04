import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myschool/controllers/teacher_profile_controller.dart';
import 'package:myschool/models/activities.dart';
import 'package:myschool/models/asset_model.dart';
import 'package:myschool/models/teacher_model.dart';
import 'package:myschool/utils/constants/image_strings.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import 'package:myschool/views/materials_screen.dart';
import 'package:myschool/views/widgets/profile_picture.dart';
import 'package:myschool/views/widgets/spinning_logo.dart';

import '../controllers/activities_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/user_controller.dart';
import '../controllers/youtube_player_screen_controller.dart';
import '../generated/l10n.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/enums.dart';
import 'pdf_preview_screen.dart';
import 'widgets/animation/auto_scrolling_text.dart';
import 'widgets/empty_screen.dart';
import 'widgets/error_screen.dart';
import 'widgets/squar_button.dart';
import 'youtube_player_screen.dart';

class TeacherProfile extends StatelessWidget {
  final TeacherModel teacherModel;

  const TeacherProfile({
    required this.teacherModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = SHelperFunctions.screenWidth();
    final double screenHeight = SHelperFunctions.screenHeight();

    final bool isDark = SHelperFunctions.isDarkMode(context);
    final bool isRtl = SHelperFunctions.isRtl(context);

    final UserController userController = Get.find();
    final TeacherProfileController controller = TeacherProfileController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).teacher_profile,
          style: const TextStyle(fontSize: 24),
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
            Positioned(
              top: 20,
              left: -10,
              child: Transform.rotate(
                angle: -0.2,
                child: Image.asset(
                  SImageString.activityExercises,
                  height: 100,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                ProfilePicture(
                    profilePic: teacherModel.profilePic,
                    screenWidth: screenWidth),
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
                const SizedBox(height: 24),
                FutureBuilder(
                  future: controller.getTeacherAssets(
                    level: userController.student.value!.level.toString(),
                    teacherID: teacherModel.id,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinningLogo(),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError || snapshot.data == -1) {
                        return ErrorScreen(
                            isDark: isDark, showLogo: false, onTap: null);
                      }

                      if (controller.assetsbyModuleThanActivity.isEmpty) {
                        return const EmptyScreen();
                      } else {
                        return DefaultTabController(
                          length: controller.assetsbyModuleThanActivity.length,
                          child: Column(
                            children: [
                              TabBar(
                                tabAlignment: TabAlignment.center,
                                isScrollable: true,
                                labelColor:
                                    isDark ? Colors.white : Colors.black,
                                unselectedLabelColor: Colors.grey,
                                labelStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                                unselectedLabelStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                dividerColor: Colors.transparent,
                                indicatorColor:
                                    isDark ? Colors.white : Colors.black,
                                indicatorPadding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                tabs: controller.assetsbyModuleThanActivity
                                    .map(
                                      (e) => Tab(
                                        text: HomeController().getModuleTitle(
                                            context, e.first.first.module),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: screenHeight * 0.6,
                                child: TabBarView(
                                  children: controller
                                      .assetsbyModuleThanActivity
                                      .map(
                                        (moduleActivities) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0),
                                          child: GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 32,
                                              mainAxisSpacing: 32,
                                            ),
                                            itemCount: moduleActivities.length,
                                            itemBuilder: (context, index) {
                                              final Activity activity =
                                                  controller.getActivity(
                                                      moduleActivities[index]
                                                          .first
                                                          .documentType);
                                              return SquarButton(
                                                image: activity.imagePath,
                                                title: ActivitiesController
                                                    .getActivitiesTitle(context,
                                                        activity.activity),
                                                onTap: () {
                                                  Get.bottomSheet(
                                                    TeacherSpecificUploadsWidget(
                                                        assets:
                                                            moduleActivities[
                                                                index],
                                                        isDark: isDark,
                                                        activity: activity,
                                                        screenWidth:
                                                            screenWidth,
                                                        isRtl: isRtl),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
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

class TeacherSpecificUploadsWidget extends StatelessWidget {
  const TeacherSpecificUploadsWidget({
    required this.isDark,
    required this.activity,
    required this.screenWidth,
    required this.isRtl,
    required this.assets,
    super.key,
  });

  final List<AssetModel> assets;
  final bool isDark;
  final Activity activity;
  final double screenWidth;
  final bool isRtl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? SColors.dark : SColors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            ActivitiesController.getActivitiesTitle(context, activity.activity),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: assets.length,
              itemBuilder: (context, index2) {
                AssetModel assetModel = assets[index2];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      onTap: () {
                        if (assetModel.documentType == ActivityEnum.videos) {
                          Get.to(
                              () => YoutubePlayerScreen(
                                    assetModel: assetModel,
                                  ), binding: BindingsBuilder(
                            () {
                              Get.lazyPut<YoutubePlayerScreenController>(
                                () {
                                  List<AssetModel> filteredVideos = assets
                                      .where(
                                          (video) => video.id != assetModel.id)
                                      .toList();
                                  return YoutubePlayerScreenController(
                                      otherVideos: filteredVideos.obs,
                                      assetModel: assetModel.obs);
                                },
                              );
                            },
                          ), transition: Transition.downToUp);
                        } else {
                          Get.to(() => PdfPreviewScreen(assetModel: assetModel),
                              transition: Transition.downToUp);
                        }
                      },
                      leading: IconButton(
                        onPressed: () => Get.bottomSheet(
                          MaterialInfoBottomSheet(
                              isDark: isDark,
                              screenWidth: screenWidth,
                              assetModel: assetModel,
                              isRtl: isRtl),
                        ),
                        icon: const Icon(
                          Icons.info_outline,
                          color: Colors.lightBlue,
                        ),
                      ),
                      title: Center(
                        child: AutoScrollText(
                          alignment: Alignment.center,
                          width: screenWidth * 0.7,
                          text: Text(
                            assetModel.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                      ),
                      trailing: Icon(
                        isRtl ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
