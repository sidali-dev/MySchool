import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myschool/controllers/activities_controller.dart';
import 'package:myschool/controllers/home_controller.dart';
import 'package:myschool/models/asset_model.dart';
import 'package:myschool/models/student_model.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import 'package:myschool/views/pdf_preview_screen.dart';
import 'package:myschool/views/widgets/animation/auto_scrolling_text.dart';
import 'package:myschool/views/widgets/spinning_logo.dart';
import 'package:myschool/views/youtube_player_screen.dart';

import '../controllers/uploaded_file_screen_controller.dart';
import '../controllers/youtube_player_screen_controller.dart';
import '../generated/l10n.dart';
import 'widgets/download_file_button.dart';
import 'widgets/empty_screen.dart';
import 'widgets/error_screen.dart';

class UploadedFileScreen extends StatelessWidget {
  const UploadedFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = SHelperFunctions.isDarkMode(context);
    final double screenWidth = SHelperFunctions.screenWidth();
    final bool isRtl = SHelperFunctions.isRtl(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, color: isDark ? Colors.white : Colors.black),
            const SizedBox(width: 8),
            Text(S.of(context).my_uploads),
          ],
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      body: GetBuilder<UploadedFileScreenController>(
        init: UploadedFileScreenController(),
        builder: (controller) => FutureBuilder(
          future: controller.uploadedFilesResult,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinningLogo(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError || snapshot.data == -1) {
                return ErrorScreen(
                    isDark: isDark, showLogo: false, onTap: null);
              }
              if (snapshot.data == 0) {
                return const EmptyScreen();
              }

              return DefaultTabController(
                length: controller.uploadedFilesByModel.length,
                child: Column(
                  children: [
                    TabBar(
                      tabAlignment: TabAlignment.center,
                      isScrollable: true,
                      labelColor: isDark ? Colors.white : Colors.black,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                      unselectedLabelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      dividerColor: Colors.transparent,
                      indicatorColor: isDark ? Colors.white : Colors.black,
                      indicatorPadding:
                          const EdgeInsets.symmetric(horizontal: 8),
                      tabs: controller.uploadedFilesByModel
                          .map(
                            (e) => Tab(
                              text: HomeController()
                                  .getModuleTitle(context, e.first.module),
                            ),
                          )
                          .toList(),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: controller.uploadedFilesByModel
                            .map(
                              (files) => ListView.builder(
                                itemCount: files.length,
                                itemBuilder: (context, index) {
                                  AssetModel assetModel = files[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Image.asset(
                                        controller.getActivityImage(
                                            assetModel.documentType),
                                      ),
                                    ),
                                    title: Text(assetModel.title),
                                    subtitle: Text(
                                      SHelperFunctions.formateDate(
                                          assetModel.createdAt!, context),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Iconsax.menu),
                                      onPressed: () {
                                        Get.bottomSheet(
                                          AssetInfoSheet(
                                            similarVideos: controller
                                                .getTeacherUploadsByActivity(
                                                    ActivityEnum.videos),
                                            assetModel: assetModel,
                                            screenWidth: screenWidth,
                                            isRtl: isRtl,
                                            controller: controller,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class AssetInfoSheet extends StatelessWidget {
  const AssetInfoSheet({
    super.key,
    required this.assetModel,
    required this.isRtl,
    required this.screenWidth,
    required this.controller,
    required this.similarVideos,
  });

  final AssetModel assetModel;
  final double screenWidth;
  final bool isRtl;
  final List<AssetModel>? similarVideos;
  final UploadedFileScreenController controller;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      child: Image.asset(
                        controller.getActivityImage(assetModel.documentType),
                      ),
                    ),
                    const SizedBox(width: 16),
                    AutoScrollText(
                      width: screenWidth * 0.5,
                      alignment: Alignment.center,
                      text: Text(
                        assetModel.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: ListTile(
                            title: Text(S.of(context).level),
                            subtitle: Text(
                              StudentModel(level: int.parse(assetModel.level))
                                  .getUserLevel(context),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.5,
                          child: ListTile(
                            title: Text(S.of(context).branch),
                            subtitle: AutoScrollText(
                              alignment: isRtl
                                  ? Alignment.bottomRight
                                  : Alignment.bottomLeft,
                              width: screenWidth * 0.5,
                              text: Text(
                                assetModel.branch!.isEmpty
                                    ? S.of(context).no_branch
                                    : assetModel.branch!
                                        .map(
                                          (e) => StudentModel(
                                                  level: int.parse(
                                                      assetModel.level),
                                                  branch: e)
                                              .getUserBranch(context),
                                        )
                                        .join(", "),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: ListTile(
                            title: Text(S.of(context).upload_date),
                            subtitle: Text(SHelperFunctions.formateDate(
                                assetModel.createdAt!, context)),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: ListTile(
                            title: Text(S.of(context).activity),
                            subtitle: Text(
                                ActivitiesController.getActivitiesTitle(
                                    context, assetModel.documentType)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (assetModel.trimester != null)
                          SizedBox(
                            width: screenWidth * 0.4,
                            child: ListTile(
                              title: Text(S.of(context).trimester),
                              subtitle: Text(assetModel.trimester!),
                            ),
                          ),
                        if (assetModel.hasSolution != null)
                          SizedBox(
                            width: screenWidth * 0.4,
                            child: ListTile(
                              title: Text(S.of(context).has_solution),
                              subtitle: Text(assetModel.hasSolution!
                                  ? S.of(context).yes
                                  : S.of(context).no),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                            ),
                            onPressed: () async {
                              // Show confirmation dialog
                              final bool confirmDelete = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(S.of(context).delete_file),
                                  content: Text(
                                      S.of(context).delete_file_confirmation),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: Text(S.of(context).cancel),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: Text(
                                        S.of(context).delete,
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              // If user confirms deletion, proceed
                              if (confirmDelete == true) {
                                if (context.mounted &&
                                    assetModel.documentType !=
                                        ActivityEnum.videos) {
                                  await controller.deleteFile(
                                      context: context, id: assetModel.id!);
                                } else if (context.mounted &&
                                    assetModel.documentType ==
                                        ActivityEnum.videos) {
                                  await controller.deleteVideo(
                                      context: context, id: assetModel.id!);
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Iconsax.trash, color: Colors.red),
                                const SizedBox(width: 8),
                                Text(
                                  S.of(context).delete_all_caps,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.lightBlue),
                            ),
                            onPressed: () {
                              if (assetModel.documentType !=
                                  ActivityEnum.videos) {
                                Get.to(
                                    () => PdfPreviewScreen(
                                        assetModel: assetModel),
                                    transition: Transition.downToUp);
                              } else {
                                Get.to(
                                    () => YoutubePlayerScreen(
                                          assetModel: assetModel,
                                        ), binding: BindingsBuilder(() {
                                  Get.lazyPut<YoutubePlayerScreenController>(
                                    () => YoutubePlayerScreenController(
                                        otherVideos: similarVideos!.obs,
                                        assetModel: assetModel.obs),
                                  );
                                }), transition: Transition.downToUp);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Iconsax.eye,
                                    color: Colors.lightBlue),
                                const SizedBox(width: 8),
                                Text(
                                  S.of(context).view_all_caps,
                                  style:
                                      const TextStyle(color: Colors.lightBlue),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (assetModel.documentType != ActivityEnum.videos)
                      DownloadFileButton(assetModel: assetModel),
                    if (assetModel.documentType != ActivityEnum.videos)
                      const SizedBox(height: 16),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
