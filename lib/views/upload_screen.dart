import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:appwrite/models.dart' as appwrite;
import 'package:myschool/controllers/home_controller.dart';
import 'package:myschool/controllers/user_controller.dart';
import 'package:myschool/models/asset_model.dart';
import 'package:myschool/models/modules.dart';
import 'package:myschool/utils/helpers/appwrite_helpers.dart';

import '../controllers/upload_screen_controller.dart';
import '../generated/l10n.dart';
import '../services/database_service.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/enums.dart';
import '../utils/device/device_utility.dart';
import '../utils/helpers/helper_functions.dart';
import 'widgets/animation/auto_scrolling_text.dart';
import 'widgets/bubble.dart';

class UploadScreen extends StatelessWidget {
  UploadScreen({
    super.key,
    required this.canHaveSolution,
    required this.title,
    required this.themeColor,
    required this.activityEnum,
  });

  final DatabaseService databaseService = DatabaseService();
  final bool canHaveSolution;
  final String title;
  final Color themeColor;
  final ActivityEnum activityEnum;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final bool isDark = SHelperFunctions.isDarkMode(context);
    final double screenHeight = SDeviceUtils.getScreenHeight(context);
    final double screenWidth = SDeviceUtils.getScreenWidth(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -100,
              width: 200,
              top: (screenHeight / 2) - 100,
              child: Bubble(
                innerColor: isDark ? Colors.black : Colors.white,
                outterColor: themeColor,
                radius: 200,
                delay: 500.milliseconds,
              ),
            ),
            Positioned(
              left: -50,
              width: 300,
              top: -100,
              child: Bubble(
                innerColor: isDark ? Colors.black : Colors.white,
                outterColor: themeColor,
                radius: 300,
                delay: 1.seconds,
              ),
            ),
            Positioned(
              left: 50,
              width: 250,
              bottom: -350,
              child: Bubble(
                innerColor: isDark ? Colors.black : Colors.white,
                outterColor: themeColor,
                radius: 250,
                delay: 1500.milliseconds,
              ),
            ),
            GetBuilder<UploadScreenController>(
              init: UploadScreenController(),
              builder: (controller) => Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.document_upload),
                          const SizedBox(width: 8),
                          AutoScrollText(
                            alignment: Alignment.center,
                            width: screenWidth * 0.8,
                            text: Text(
                              title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 28),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Text(
                        S.of(context).trimester,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: controller.trimesters
                            .map(
                              (e) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Card(
                                    color:
                                        controller.selectedTrimester.value == e
                                            ? themeColor
                                            : isDark
                                                ? SColors.darkerGrey
                                                : Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        controller.changeTrimester(e);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 16,
                                        ),
                                        child: Text(
                                          e.toString(),
                                          style: TextStyle(
                                            color: controller.selectedTrimester
                                                        .value ==
                                                    e
                                                ? Colors.white
                                                : isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        S.of(context).level,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField(
                        value: controller.selectedLevel.value,
                        decoration: InputDecoration(
                            focusColor: themeColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: themeColor, width: 2.0),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: themeColor),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            prefixIcon: Icon(Iconsax.layer, color: themeColor),
                            hintText: S.of(context).choose_level),
                        items: controller.levels
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.toString(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          controller.changeLevel(value!);
                        },
                      ),
                      if (controller.selectedLevel.value >= 10)
                        Column(
                          children: [
                            const SizedBox(height: 24),
                            Text(
                              S.of(context).branch,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 24),
                            ),
                            const SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: controller
                                    .branches[controller.selectedLevel.value]!
                                    .asMap()
                                    .entries
                                    .map(
                                  (entry) {
                                    final int index = entry.key;
                                    final Map<String, BranchesEnum> branch =
                                        entry.value;

                                    return Card(
                                      color: controller.selectedBranches
                                              .contains(index)
                                          ? themeColor
                                          : isDark
                                              ? SColors.darkerGrey
                                              : Colors.white,
                                      child: InkWell(
                                        onTap: () {
                                          controller.changeBranches(index);
                                        },
                                        borderRadius: BorderRadius.circular(12),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 24,
                                            vertical: 16,
                                          ),
                                          child: Text(
                                            branch["branch"]!.name,
                                            style: TextStyle(
                                              color: controller.selectedBranches
                                                      .contains(index)
                                                  ? isDark
                                                      ? Colors.black
                                                      : Colors.white
                                                  : isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 32),
                      const Text(
                        "Module",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: HomeController()
                              .getUserModules(
                                  level: controller.selectedLevel.value,
                                  branch: controller.getFirstSelectedBranch())
                              .asMap()
                              .entries
                              .map(
                            (entry) {
                              final Module module = entry.value;

                              return Card(
                                color: controller.selectedModule.value ==
                                        module.module.name
                                    ? themeColor
                                    : isDark
                                        ? SColors.darkerGrey
                                        : Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    controller.changeModule(module.module.name);
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 16,
                                    ),
                                    child: Text(
                                      module.module.name,
                                      style: TextStyle(
                                        color:
                                            controller.selectedModule.value ==
                                                    module.module.name
                                                ? isDark
                                                    ? Colors.black
                                                    : Colors.white
                                                : isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        S.of(context).lesson_title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: controller.titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).please_enter_title;
                          } else if (value.trim().length < 10) {
                            return S.of(context).please_enter_valid_title;
                          }
                          return null;
                        },
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: S.of(context).title,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: themeColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                BorderSide(color: themeColor, width: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Visibility(
                        visible: themeColor != Colors.redAccent,
                        replacement: Column(
                          children: [
                            Text(
                              S.of(context).video_link,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 24),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: controller.videoLinkController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).please_enter_link;
                                }
                                if (!RegExp(
                                        r'^(https?:\/\/)?(www\.)?(youtube\.com|youtu\.be)\/(watch\?v=|embed\/|v\/)?[\w-]{11}$')
                                    .hasMatch(value)) {
                                  return S
                                      .of(context)
                                      .please_enter_valid_youtube_link;
                                }
                                return null;
                              },
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: S.of(context).link,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: themeColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: themeColor, width: 2.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              controller.file = File(result.files.single.path!);
                              controller.fileIsSelected();
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.isFileSelected.value == true
                                  ? themeColor
                                  : null,
                              border: Border.all(color: themeColor, width: 3),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(children: [
                                  Icon(
                                    controller.isFileSelected.value == true
                                        ? Icons.check_circle_outline_outlined
                                        : Iconsax.add_circle,
                                    size: 32,
                                    color:
                                        controller.isFileSelected.value == true
                                            ? Colors.white
                                            : themeColor,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    controller.isFileSelected.value == true
                                        ? S.of(context).file_added
                                        : S.of(context).pick_a_file,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: controller.isFileSelected.value ==
                                              true
                                          ? Colors.white
                                          : themeColor,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (canHaveSolution)
                        Row(
                          children: [
                            AutoScrollText(
                              alignment: Alignment.centerLeft,
                              width: screenWidth * 0.7,
                              text: Text(S.of(context).solution_included),
                            ),
                            const Spacer(),
                            Switch(
                              activeColor: themeColor,
                              value: controller.fileHasSolution.value,
                              onChanged: (value) {
                                controller.switchFileHasSolution();
                              },
                            )
                          ],
                        ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeColor,
                            side: BorderSide(color: themeColor),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (context.mounted) {
                                String fileUrl = '';
                                if (activityEnum == ActivityEnum.videos) {
                                  fileUrl = controller.videoLinkController.text;
                                } else if (controller.isFileSelected.value) {
                                  appwrite.File? uploadedFile =
                                      await controller.uploadFile(
                                          filePath: controller.file!.path,
                                          fileName:
                                              controller.titleController.text,
                                          context: context);

                                  if (uploadedFile != null) {
                                    fileUrl = AppwriteHelpers.getFileUrl(
                                        uploadedFile.$id);
                                  } else {
                                    if (context.mounted) {
                                      AppwriteHelpers.showSomethingWentWorng(
                                          context);
                                    }
                                    return;
                                  }
                                }

                                if (fileUrl.isNotEmpty) {
                                  UserController userController = Get.find();
                                  controller.loadAsset(
                                      fileUrl,
                                      activityEnum,
                                      ModuleEnum.values.firstWhere(
                                        (element) =>
                                            element.name ==
                                            controller.selectedModule.value,
                                      ),
                                      userController.teacher.value!);

                                  if (context.mounted) {
                                    appwrite.Document? document =
                                        await controller.addFile(
                                            context: context);

                                    if (document != null) {
                                      UserController userController =
                                          Get.find();

                                      AssetModel asset =
                                          AssetModel.fromMap(document.data);

                                      userController
                                          .updateTeacherLocally(asset.teacher);

                                      if (context.mounted) {
                                        SHelperFunctions.showAwesomeSnackBar(
                                            title: S.of(context).success,
                                            content: S
                                                .of(context)
                                                .file_added_successfully,
                                            contentType: ContentType.success,
                                            context: context);
                                      }

                                      Get.back();
                                    }
                                  }
                                }
                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              S.of(context).upload_file,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
