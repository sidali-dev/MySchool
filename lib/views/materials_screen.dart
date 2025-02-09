import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:myschool/controllers/materials_controller.dart';
import 'package:myschool/models/activities.dart';
import 'package:myschool/models/asset_model.dart';
import 'package:myschool/models/modules.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/utils/constants/image_strings.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import 'package:myschool/views/pdf_preview_screen.dart';
import 'package:myschool/views/teacher_profile.dart';
import 'package:myschool/views/widgets/download_file_button.dart';
import 'package:myschool/views/youtube_player_screen.dart';

import '../controllers/youtube_player_screen_controller.dart';
import '../generated/l10n.dart';
import '../utils/constants/colors.dart';
import '../utils/device/device_utility.dart';
import 'widgets/animation/auto_scrolling_text.dart';
import 'widgets/bubble.dart';

class MaterialsScreen extends StatelessWidget {
  MaterialsScreen({
    super.key,
    required this.activity,
    this.trimester,
    required this.module,
    required this.activityTag,
    required this.moduleTag,
  });

  final String activityTag;
  final Module module;
  final Activity activity;
  final int? trimester;
  final String moduleTag;

  final MaterialsController controller = Get.put(MaterialsController());

  @override
  Widget build(BuildContext context) {
    final double screenHeight = SDeviceUtils.getScreenHeight(context);
    final double screenWidth = SDeviceUtils.getScreenWidth(context);
    final bool isRtl = SHelperFunctions.isRtl(context);
    final bool isDark = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(height: screenHeight),
            Positioned(
              right: -100,
              width: 200,
              top: (screenHeight / 2) - 100,
              child: Bubble(
                innerColor: isDark ? Colors.black : Colors.white,
                outterColor: Colors.yellow,
                radius: 200,
                delay: const Duration(milliseconds: 500),
              ),
            ),
            Positioned(
              left: -50,
              width: 300,
              top: -100,
              child: Bubble(
                innerColor: isDark ? Colors.black : Colors.white,
                outterColor: Colors.yellow,
                radius: 300,
                delay: const Duration(seconds: 1),
              ),
            ),
            Positioned(
              left: 50,
              width: 250,
              bottom: -100,
              child: Bubble(
                innerColor: isDark ? Colors.black : Colors.white,
                outterColor: Colors.yellow,
                radius: 250,
                delay: const Duration(milliseconds: 1500),
              ),
            ),
            SizedBox(width: SDeviceUtils.getScreenWidth(context)),
            Padding(
              padding: const EdgeInsets.only(right: 0.0, left: 0.0, top: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 32.0, left: 32.0, top: 88.0),
                    child: Row(
                      children: [
                        AutoScrollText(
                            alignment: isRtl
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            text: Text(
                              activityTag,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 48),
                            ),
                            width: screenWidth / 2),
                        Animate(
                          effects: const [
                            ShakeEffect(
                              duration: Duration(milliseconds: 500),
                            ),
                            RotateEffect(
                              begin: 0,
                              end: .00,
                              duration: Duration(milliseconds: 500),
                            ),
                          ],
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                right: isRtl ? null : -50,
                                left: isRtl ? -50 : null,
                                bottom: 0,
                                child: Hero(
                                  tag: moduleTag,
                                  child: Image.asset(
                                    module.imagePath,
                                    width: screenWidth / 5,
                                  ),
                                ),
                              ),
                              Hero(
                                tag: activityTag,
                                child: Image.asset(
                                  activity.imagePath,
                                  width: screenWidth / 3.5,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      "Get the best marks by training with our 100+ exams",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                    ),
                  ),
                  FutureBuilder(
                    future: controller.getUploadedFiles(
                        activity: activity.activity.name,
                        module: module.module.name,
                        trimester: trimester.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 168),
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == 1) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.uploadedFiles.length,
                              itemBuilder: (context, index) {
                                AssetModel assetModel =
                                    controller.uploadedFiles[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      onTap: () {
                                        if (assetModel.documentType ==
                                            ActivityEnum.videos) {
                                          Get.to(
                                              () => YoutubePlayerScreen(
                                                    assetModel: assetModel,
                                                  ),
                                              binding: BindingsBuilder(() {
                                            Get.lazyPut<
                                                YoutubePlayerScreenController>(
                                              () {
                                                List<AssetModel>
                                                    filteredVideos = controller
                                                        .uploadedFiles
                                                        .where((video) =>
                                                            video.id !=
                                                            assetModel.id)
                                                        .toList();

                                                return YoutubePlayerScreenController(
                                                    otherVideos:
                                                        filteredVideos.obs,
                                                    assetModel: assetModel.obs);
                                              },
                                            );
                                          }), transition: Transition.downToUp);
                                        } else {
                                          Get.to(
                                              () => PdfPreviewScreen(
                                                  assetModel: assetModel),
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      trailing: Icon(
                                        isRtl
                                            ? Icons.arrow_back_ios
                                            : Icons.arrow_forward_ios,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (snapshot.data == 0) {
                          return Center(
                            child: Column(
                              children: [
                                LottieBuilder.asset(
                                    SImageString.emptyScreenAnimation),
                                const FittedBox(
                                  child: Text(
                                    "This Place feels empty",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text("ERROR"),
                          );
                        }
                      }
                      return const SizedBox();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaterialInfoBottomSheet extends StatelessWidget {
  const MaterialInfoBottomSheet({
    super.key,
    required this.isDark,
    required this.screenWidth,
    required this.assetModel,
    required this.isRtl,
  });

  final bool isDark;
  final double screenWidth;
  final AssetModel assetModel;
  final bool isRtl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? SColors.dark : SColors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AutoScrollText(
                width: screenWidth * 0.8,
                alignment: Alignment.center,
                text: Text(
                  assetModel.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              MaterialInfo(
                  icon: const Icon(Icons.person),
                  title: "Teacher",
                  trailing: InkWell(
                    onTap: () {
                      Get.back();
                      Get.to(
                          () =>
                              TeacherProfile(teacherModel: assetModel.teacher),
                          transition: Transition.downToUp);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          child: Text(
                            assetModel.teacher.user.name,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Icon(isRtl
                            ? Icons.arrow_back_ios
                            : Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  isRtl: isRtl),
              MaterialInfo(
                  icon: const Icon(Iconsax.calendar_1),
                  title: "Upload Date",
                  trailing: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: FittedBox(
                      child: Text(
                        SHelperFunctions.formateDate(
                            assetModel.createdAt!, context),
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  isRtl: isRtl),
              if (assetModel.hasSolution != null)
                MaterialInfo(
                  trailing: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      assetModel.hasSolution!
                          ? S.of(context).yes
                          : S.of(context).no,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  isRtl: isRtl,
                  title: S.of(context).has_solution,
                  icon: const Icon(Iconsax.paperclip),
                ),
              if (assetModel.documentType != ActivityEnum.videos)
                const SizedBox(height: 16),
              if (assetModel.documentType != ActivityEnum.videos)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DownloadFileButton(assetModel: assetModel),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class MaterialInfo extends StatelessWidget {
  const MaterialInfo({
    super.key,
    required this.trailing,
    required this.isRtl,
    required this.title,
    required this.icon,
  });

  final bool isRtl;
  final String title;
  final Widget trailing;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: icon,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      trailing: trailing,
    );
  }
}
