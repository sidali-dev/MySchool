import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myschool/controllers/language_controller.dart';
import 'package:myschool/controllers/theme_controller.dart';
import 'package:myschool/controllers/user_controller.dart';
import 'package:myschool/services/authentication_service.dart';
import 'package:myschool/utils/constants/colors.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/utils/device/device_utility.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import 'package:myschool/views/widgets/animation/auto_scrolling_text.dart';

import '../generated/l10n.dart';
import 'uploaded_file_screen.dart';
import 'widgets/settings_options_row.dart';
import 'widgets/settings_switch_row.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final UserController userController = Get.find();
  final AuthenticationService authenticationService = Get.find();
  final ThemeController themeController = Get.find();
  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = SDeviceUtils.getScreenWidth(context);
    final double screenheight = SDeviceUtils.getScreenHeight(context);
    final bool isRtl = SHelperFunctions.isRtl(context);
    final TextEditingController descriptionController = TextEditingController(
        text: userController.teacher.value?.description ?? "");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).settings,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 32.0),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: SColors.primary,
              size: 32,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 32),
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
                Text(
                  userController.user.value!.name
                      .split(" ")
                      .map((e) => e.capitalizeFirst)
                      .join(" "),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 32),
                ),
                AutoScrollText(
                  alignment: Alignment.center,
                  width: screenWidth * 0.8,
                  text: Text(
                    authenticationService.userEmail!,
                    style: const TextStyle(
                        color: SColors.darkGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment:
                      isRtl ? Alignment.centerRight : Alignment.centerLeft,
                  child: Text(
                    S.of(context).profile,
                    style: const TextStyle(
                        color: SColors.darkGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                  ),
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: userController.user.value!.role == Role.student,
                  replacement: Column(
                    children: [
                      SettingsOptionsRow(
                        icon: Icons.description_outlined,
                        title: S.of(context).description,
                        trailingTitle: userController.teacher.value?.description
                                ?.split("\n")
                                .first ??
                            S.of(context).add_description,
                        userController: userController,
                        onTap: () {
                          Get.bottomSheet(
                            BottomSheet(
                              enableDrag: false,
                              onClosing: () {},
                              builder: (context) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 16),
                                        Text(
                                          S.of(context).description,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24),
                                        ),
                                        const SizedBox(height: 32),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0),
                                          child: TextFormField(
                                            maxLines: 5,
                                            minLines: 1,
                                            controller: descriptionController,
                                            decoration: InputDecoration(
                                                hintText: S
                                                    .of(context)
                                                    .add_description),
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              await userController
                                                  .updateTeacherInfo(
                                                      context: context,
                                                      description:
                                                          descriptionController
                                                              .text);
                                            },
                                            child: Center(
                                              child: Text(S
                                                  .of(context)
                                                  .update_description),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        isRtl: isRtl,
                        screenWidth: screenWidth,
                      ),
                      const SizedBox(height: 16),
                      GetBuilder<UserController>(
                        builder: (_) {
                          return SettingsOptionsRow(
                            icon: Icons.history,
                            title: S.of(context).my_uploads,
                            trailingTitle: userController
                                    .teacher.value!.uploadsCount
                                    .isEqual(1)
                                ? "${userController.teacher.value!.uploadsCount} ${S.of(context).upload}"
                                : "${userController.teacher.value!.uploadsCount} ${S.of(context).uploads}",
                            userController: userController,
                            onTap: () {
                              Get.to(() => const UploadedFileScreen(),
                                  transition: isRtl
                                      ? Transition.leftToRight
                                      : Transition.rightToLeft);
                            },
                            isRtl: isRtl,
                            screenWidth: screenWidth,
                          );
                        },
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Obx(
                        () => SettingsOptionsRow(
                          userController: userController,
                          icon: Icons.bar_chart,
                          onTap: () {
                            Get.bottomSheet(
                              ChangeLevelBottomSheet(
                                  sheetTitle: S.of(context).pick_a_level,
                                  buttonTitle: S.of(context).update_level,
                                  listOfItems: userController.levels,
                                  onTap: (level, _) async {
                                    if (level < 10) {
                                      await userController.updateStudentInfo(
                                          context: context, level: level);
                                      Get.back();
                                    } else {
                                      Get.back();

                                      Get.bottomSheet(
                                        ChangeBranchBottomSheet(
                                            sheetTitle:
                                                S.of(context).pick_branch,
                                            buttonTitle:
                                                S.of(context).update_branch,
                                            listOfItems: userController
                                                .student.value!
                                                .getAllUserBranches(
                                                    context, level),
                                            onTap: (level, branch) async {
                                              await userController
                                                  .updateStudentInfo(
                                                      context: context,
                                                      level: level,
                                                      branch: branch);

                                              Get.back();
                                            },
                                            userController: userController,
                                            level: level,
                                            scrollController:
                                                FixedExtentScrollController(
                                              initialItem: userController
                                                  .student.value!
                                                  .getBranchPosition(context),
                                            ),
                                            screenheight: screenheight),
                                      );
                                    }
                                  },
                                  userController: userController,
                                  scrollController: FixedExtentScrollController(
                                      initialItem:
                                          userController.student.value!.level -
                                              1),
                                  screenheight: screenheight),
                            );
                          },
                          title: S.of(context).level,
                          trailingTitle: userController.student.value!
                              .getUserLevel(context),
                          isRtl: isRtl,
                          screenWidth: screenWidth,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => Visibility(
                          visible: userController.student.value!.branch != null,
                          child: SettingsOptionsRow(
                            userController: userController,
                            icon: Icons.category,
                            onTap: () {
                              Get.bottomSheet(
                                ChangeBranchBottomSheet(
                                    sheetTitle: S.of(context).pick_branch,
                                    buttonTitle: S.of(context).update_branch,
                                    listOfItems: userController.student.value!
                                        .getAllUserBranches(context, null),
                                    onTap: (level, branch) async {
                                      await userController.updateStudentInfo(
                                          context: context,
                                          level: level,
                                          branch: branch);

                                      Get.back();
                                    },
                                    userController: userController,
                                    scrollController:
                                        FixedExtentScrollController(
                                      initialItem: userController.student.value!
                                          .getBranchPosition(context),
                                    ),
                                    screenheight: screenheight),
                              );
                            },
                            title: S.of(context).branch,
                            trailingTitle: userController.student.value!
                                .getUserBranch(context),
                            isRtl: isRtl,
                            screenWidth: screenWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Align(
                  alignment:
                      isRtl ? Alignment.centerRight : Alignment.centerLeft,
                  child: Text(
                    S.of(context).prefernces,
                    style: const TextStyle(
                        color: SColors.darkGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                  ),
                ),
                const SizedBox(height: 16),
                SettingsOptionsRow(
                  userController: userController,
                  icon: Icons.translate,
                  onTap: () {
                    Get.bottomSheet(
                      ChangeLanguageBottomSheet(
                          languageController: languageController),
                    );
                  },
                  title: S.of(context).language,
                  trailingTitle: languageController.getLanguageTitle(
                      languageController.getCurrentLanguage()),
                  isRtl: isRtl,
                  screenWidth: screenWidth,
                ),
                const SizedBox(height: 16),
                GetBuilder<ThemeController>(
                  builder: (controller) => SettingsSwitchRow(
                    userController: userController,
                    icon: Icons.nights_stay,
                    title: S.of(context).dark_mode,
                    value: controller.isDark.value,
                    onTap: () {
                      controller.switchTheme();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SettingsSwitchRow(
                  userController: userController,
                  icon: Iconsax.notification,
                  title: S.of(context).notifications,
                  value: true,
                  onTap: () {},
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
                  child: ElevatedButton(
                    onPressed: () async {
                      final bool? confirm = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Logout'),
                            content:
                                const Text('Are you sure you want to log out?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(S.of(context).cancel),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text(
                                  S.of(context).log_out,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirm == true && context.mounted) {
                        await userController.signOut(context: context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(S.of(context).log_out),
                      ],
                    ),
                  ),
                )
                // SettingsSwitchRow(
                //   userController: userController,
                //   icon: Icons.wifi,
                //   title: "Download via WIFI only",
                //   value: false,
                //   onTap: () {},
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef OnTapCallback = void Function(int selectedIndex, String? branch);

class ChangeLevelBottomSheet extends StatelessWidget {
  const ChangeLevelBottomSheet({
    super.key,
    required this.userController,
    required this.screenheight,
    required this.scrollController,
    required this.listOfItems,
    required this.sheetTitle,
    required this.onTap,
    required this.buttonTitle,
  });

  final String sheetTitle;
  final String buttonTitle;
  final UserController userController;
  final double screenheight;
  final FixedExtentScrollController scrollController;
  final List listOfItems;
  final OnTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    int index = userController.student.value!.level - 1;
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                sheetTitle,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: screenheight * 0.2,
                child: CupertinoPicker(
                  scrollController: scrollController,
                  looping: false,
                  itemExtent: 50,
                  onSelectedItemChanged: (value) {
                    index = value;
                  },
                  children: listOfItems.map(
                    (e) {
                      return Center(child: Text(e));
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton(
                  onPressed: () => onTap(index + 1, null),
                  child: Center(
                    child: Text(
                      buttonTitle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class ChangeBranchBottomSheet extends StatelessWidget {
  const ChangeBranchBottomSheet({
    super.key,
    required this.userController,
    required this.screenheight,
    required this.scrollController,
    required this.listOfItems,
    required this.sheetTitle,
    required this.onTap,
    required this.buttonTitle,
    this.level,
  });

  final String sheetTitle;
  final String buttonTitle;
  final UserController userController;
  final double screenheight;
  final FixedExtentScrollController scrollController;
  final List<Map> listOfItems;
  final OnTapCallback onTap;
  final int? level;

  @override
  Widget build(BuildContext context) {
    BranchesEnum branchesEnum = userController.student.value!
        .getAllUserBranches(context, level)
        .first["value"];
    String? branch =
        userController.student.value!.branch?.name ?? branchesEnum.name;
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                sheetTitle,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: screenheight * 0.2,
                child: CupertinoPicker(
                  scrollController: scrollController,
                  looping: false,
                  itemExtent: 50,
                  onSelectedItemChanged: (value) {
                    BranchesEnum branchEnum = listOfItems[value]["value"];
                    branch = branchEnum.name;
                  },
                  children: listOfItems.map(
                    (e) {
                      return Center(
                        child: Text(e["title"]),
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    onTap(level ?? userController.student.value!.level, branch);
                  },
                  child: Center(
                    child: Text(
                      buttonTitle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class ChangeLanguageBottomSheet extends StatelessWidget {
  const ChangeLanguageBottomSheet({
    super.key,
    required this.languageController,
  });

  final LanguageController languageController;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.translate,
                  size: 32,
                ),
                const SizedBox(width: 8),
                Text(
                  S.of(context).language,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 24),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            CarouselSlider(
              options: CarouselOptions(
                  initialPage: languageController.getInitialFlag(),
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.5),
              items: languageController.languages.map(
                (e) {
                  return Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          languageController.changeCurrentLanguage(e);
                          Get.back();
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              languageController.getLanguageFlag(e),
                              height: 100,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              languageController.getLanguageTitle(e),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 24),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ).toList(),
            )
          ],
        ),
      ),
    );
  }
}
