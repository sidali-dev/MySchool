import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myschool/controllers/youtube_player_screen_controller.dart';
import 'package:myschool/models/asset_model.dart';
import 'package:myschool/utils/constants/image_strings.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import 'package:myschool/views/widgets/animation/auto_scrolling_gradien_text.dart';
import 'package:myschool/views/widgets/youtube_thumbnail.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../controllers/home_controller.dart';
import '../generated/l10n.dart';
import '../models/student_model.dart';
import 'widgets/bubble.dart';

class YoutubePlayerScreen extends GetView<YoutubePlayerScreenController> {
  final AssetModel assetModel;
  const YoutubePlayerScreen({
    required this.assetModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = SHelperFunctions.isDarkMode(context);
    final double screenHeight = SHelperFunctions.screenHeight();
    final double screenWidth = SHelperFunctions.screenWidth();

    return Obx(
      () => PopScope(
        canPop: controller.videosPlayed.length == 1,
        onPopInvokedWithResult: (didPop, result) async {
          await controller.playPreviousVideo();
        },
        child: YoutubePlayerScaffold(
          controller: controller.youtubeController,
          // Allow landscape ONLY in fullscreen
          fullscreenOrientations: const [
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ],
          // Lock to portrait when NOT in fullscreen
          lockedOrientations: const [
            DeviceOrientation.portraitUp,
          ],
          // Set the default orientation (This might be unnecessary).
          defaultOrientations: const [
            DeviceOrientation.portraitUp,
          ],
          // Optional: Auto-enter fullscreen on device rotation
          autoFullScreen: true,

          // The Actual screen start here
          builder: (context, player) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('APP NAME'),
                iconTheme:
                    IconThemeData(color: isDark ? Colors.white : Colors.black),
                leading: IconButton(
                  onPressed: () async {
                    if (controller.videosPlayed.length == 1) {
                      Get.back();
                    } else {
                      await controller.playPreviousVideo();
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
              body: SingleChildScrollView(
                controller: controller.scrollController,
                child: Stack(
                  children: [
                    Positioned(
                      right: -100,
                      width: 200,
                      top: (screenHeight / 2),
                      child: Bubble(
                        innerColor: isDark ? Colors.black : Colors.white,
                        outterColor: Colors.red,
                        radius: 200,
                        delay: const Duration(milliseconds: 500),
                      ),
                    ),
                    Positioned(
                      left: -50,
                      width: 300,
                      top: 100,
                      child: Bubble(
                        innerColor: isDark ? Colors.black : Colors.white,
                        outterColor: Colors.red,
                        radius: 200,
                        delay: const Duration(milliseconds: 1000),
                      ),
                    ),
                    Positioned(
                      left: 50,
                      width: 250,
                      bottom: -100,
                      child: Bubble(
                        innerColor: isDark ? Colors.black : Colors.white,
                        outterColor: Colors.red,
                        radius: 250,
                        delay: const Duration(milliseconds: 1500),
                      ),
                    ),
                    Obx(
                      () => Column(
                        children: [
                          Material(
                              elevation: 24,
                              shadowColor: isDark ? Colors.red : Colors.black,
                              child: player),
                          const SizedBox(height: 16),
                          AutoScrollGradientText(
                            colorX: isDark ? Colors.white : Colors.black,
                            colorY: Colors.red,
                            alignment: Alignment.center,
                            width: screenWidth * 0.95,
                            text: Text(
                              controller.assetModel.value.title,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      isDark ? Colors.redAccent : Colors.black),
                            ),
                          ),
                          const SizedBox(height: 32),
                          YoutubeScreenLineInfo(
                            title: "${S.of(context).module}:",
                            icon: Iconsax.book,
                            description: HomeController().getModuleTitle(
                                context, controller.assetModel.value.module),
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16),
                          YoutubeScreenLineInfo(
                            title: "${S.of(context).level}:",
                            icon: Iconsax.chart_1,
                            description: StudentModel(
                                    level: int.parse(
                                        controller.assetModel.value.level))
                                .getUserLevel(context),
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16),
                          YoutubeScreenLineInfo(
                            title: "${S.of(context).branch}:",
                            icon: Iconsax.category,
                            description: controller
                                    .assetModel.value.branch!.isEmpty
                                ? S.of(context).no_branch
                                : StudentModel(
                                        level: int.parse(
                                            controller.assetModel.value.level),
                                        branch: controller
                                            .assetModel.value.branch!.first)
                                    .getUserBranch(context),
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16),
                          YoutubeScreenLineInfo(
                            title: "${S.of(context).teacher}:",
                            icon: Iconsax.personalcard,
                            description:
                                controller.assetModel.value.teacher.user.name,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16),
                          YoutubeScreenLineInfo(
                            title: "${S.of(context).upload_date}:",
                            icon: Iconsax.calendar_2,
                            description: SHelperFunctions.formateDate(
                                controller.assetModel.value.createdAt!,
                                context),
                            isDark: isDark,
                          ),
                          const SizedBox(height: 32),
                          Center(
                              child: Image.asset(
                            SImageString.activityVideos,
                            width: screenWidth * 0.21,
                          )
                                  .animate(
                                    onComplete: (controller) {
                                      controller
                                        ..reset()
                                        ..forward();
                                    },
                                  )
                                  .then(delay: const Duration(minutes: 1))
                                  .rotate(
                                      duration:
                                          const Duration(milliseconds: 6000))
                                  .slideX(
                                      begin: 0,
                                      end: 2,
                                      duration:
                                          const Duration(milliseconds: 1500))
                                  .then()
                                  .slideX(
                                      begin: 0,
                                      end: -4,
                                      duration:
                                          const Duration(milliseconds: 3000))
                                  .then()
                                  .slideX(
                                      begin: 0,
                                      end: 2,
                                      duration:
                                          const Duration(milliseconds: 1500))

                              // .rotate(duration: const Duration(milliseconds: 1200))
                              // .shimmer(duration: const Duration(milliseconds: 1800))
                              // .scaleXY(
                              //     begin: 1,
                              //     end: 1.2,
                              //     duration: const Duration(milliseconds: 600))
                              // .then()
                              // .scaleXY(
                              //     begin: 1.2,
                              //     end: 1,
                              //     duration: const Duration(milliseconds: 600)),
                              ),
                          const SizedBox(height: 32),
                          Text(
                              "Other videos by ${assetModel.teacher.user.name}"),
                          CarouselSlider(
                            carouselController:
                                controller.carouselSliderController,
                            options: CarouselOptions(
                                enableInfiniteScroll: false,
                                enlargeCenterPage: true,
                                viewportFraction: 0.6),
                            items: controller.otherVideos
                                .map(
                                  (e) => Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Material(
                                          elevation: 16,
                                          shadowColor: isDark
                                              ? Colors.red
                                              : Colors.black,
                                          child: GestureDetector(
                                            onTap: () async {
                                              controller.playAnotherVideo(e);
                                            },
                                            child: YouTubeThumbnail(
                                                videoId: controller
                                                    .parseVideoId(e.fileLink)!),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        FittedBox(
                                          alignment: Alignment.center,
                                          child: Text(
                                            e.title,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 32)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class YoutubeScreenLineInfo extends StatelessWidget {
  const YoutubeScreenLineInfo({
    super.key,
    required this.isDark,
    required this.title,
    required this.description,
    required this.icon,
  });

  final bool isDark;
  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black),
            ),
            const SizedBox(width: 8),
            Text(
              description,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
