import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/upload_screen_controller.dart';
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
  });

  final DatabaseService databaseService = DatabaseService();
  final bool canHaveSolution;
  final String title;
  final Color themeColor;
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
            Form(
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
                    const Text(
                      "Trimester",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    GetBuilder<UploadScreenController>(
                      init: UploadScreenController(),
                      builder: (controller) => Row(
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
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Level",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    GetBuilder<UploadScreenController>(
                      builder: (controller) => DropdownButtonFormField(
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
                            hintText: "CHOOSE A LEVEL"),
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
                    ),
                    GetBuilder<UploadScreenController>(
                      builder: (controller) {
                        if (controller.selectedLevel.value >= 10) {
                          return Column(
                            children: [
                              const SizedBox(height: 24),
                              const Text(
                                "Branch",
                                style: TextStyle(
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
                                            : Colors.white,
                                        child: InkWell(
                                          onTap: () {
                                            controller.changeBranches(index);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 16,
                                            ),
                                            child: Text(
                                              branch["branch"]!.name,
                                              style: TextStyle(
                                                color: controller
                                                        .selectedBranches
                                                        .contains(index)
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
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      "Lesson's Title",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    GetBuilder<UploadScreenController>(
                      builder: (controller) => TextFormField(
                        controller: controller.titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a title";
                          } else if (value.length < 10) {
                            return "Please enter a valid title";
                          }
                          return null;
                        },
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Title",
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
                    ),
                    const SizedBox(height: 32),
                    GetBuilder<UploadScreenController>(
                      builder: (controller) => Visibility(
                        visible: themeColor != Colors.redAccent,
                        replacement: Column(
                          children: [
                            const Text(
                              "Video Link",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 24),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: controller.videoLinkController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a URL.";
                                }
                                if (!RegExp(
                                        r'^(https?:\/\/)?(www\.)?(youtube\.com|youtu\.be)\/(watch\?v=|embed\/|v\/)?[\w-]{11}$')
                                    .hasMatch(value)) {
                                  return "Please enter a valid YouTube URL.";
                                }
                                return null;
                              },
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: "Link",
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

                              // if (context.mounted) {
                              //   // bool isSucces =
                              //   await controller.uploadFile(
                              //       filePath: controller.file!.path,
                              //       fileName: "fileName",
                              //       context: context);
                              // }
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
                                        ? "File Added"
                                        : "Pick a file",
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
                    ),
                    const SizedBox(height: 32),
                    GetBuilder<UploadScreenController>(
                      builder: (controller) => canHaveSolution
                          ? Row(
                              children: [
                                AutoScrollText(
                                  alignment: Alignment.centerLeft,
                                  width: screenWidth * 0.7,
                                  text: const Text(
                                      'The solution to this file is included within'),
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
                            )
                          : const SizedBox(),
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
                              UploadScreenController controller = Get.find();

                              bool isSucces = await controller.uploadFile(
                                  filePath: controller.file!.path,
                                  fileName: "fileName",
                                  context: context);

                              if (isSucces) {
                                if (context.mounted) {
                                  SHelperFunctions.showAwesomeSnackBar(
                                      title: "SUCCESS",
                                      content:
                                          "File has been added successfully",
                                      contentType: ContentType.success,
                                      context: context);

                                  Get.back();
                                }
                              }
                            }
                          }
                        },
                        child: const Center(
                          child: Text(
                            "UPLOAD FILE",
                            style: TextStyle(
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
          ],
        ),
      ),
    );
  }
}
