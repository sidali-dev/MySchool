import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:myschool/services/database_service.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/views/widgets/spinning_logo.dart';

import '../utils/helpers/appwrite_helpers.dart';

class LevelDialogController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxMap selectedLevel = {}.obs;

  late AnimationController animationController;

  final TextEditingController nameController = TextEditingController();

  List<Map<String, dynamic>> levels = [
    {"level": 1, "title": "1 AP"},
    {"level": 2, "title": "2 AP"},
    {"level": 3, "title": "3 AP"},
    {"level": 4, "title": "4 AP"},
    {"level": 5, "title": "5 AP"},
    {"level": 6, "title": "1 CEM"},
    {"level": 7, "title": "2 CEM"},
    {"level": 8, "title": "3 CEM"},
    {"level": 9, "title": "4 CEM"},
    {"level": 10, "title": "1 LYCEE"},
    {"level": 11, "title": "2 LYCEE"},
    {"level": 12, "title": "3 LYCEE"}
  ];

  RxList<Effect> effects = <Effect>[
    const SlideEffect(
      begin: Offset(1, 0),
      end: Offset(0, 0),
      duration: Duration(milliseconds: 500),
    )
  ].obs;

  @override
  onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  onClose() {
    animationController.dispose();
    nameController.dispose();
    super.onClose();
  }

  errorDialogAnimtion() {
    effects.value = [
      const ShakeEffect(
        duration: Duration(milliseconds: 370),
      )
    ];
  }

  closeDialogAnimtion() {
    effects.value = [
      const SlideEffect(
        begin: Offset(0, 0),
        end: Offset(-1, 0),
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      )
    ];
  }

  openSignInDialog() {
    effects.value = [
      const SlideEffect(
        begin: Offset(0, 0),
        end: Offset(1, 0),
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      )
    ];
  }

  changeLevel(Map level) {
    selectedLevel.value = level;
  }

  Future<bool> addCredentials({
    required BuildContext context,
    required String name,
    required int level,
  }) async {
    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: SpinningLogo(),
      ),
    );

    //add user data to database
    DatabaseService databaseService = DatabaseService();
    Document? document = await databaseService
        .addUser(name: name.trim(), role: RoleEnum.student)
        .then((value) async {
      await Future.delayed(const Duration(seconds: 1));
      return value;
    }).then(
      (value) async {
        return await databaseService.addStudentData(
          userID: value!.$id,
          level: level,
        );
      },
    );

    //close loading indicator
    Get.back();

    //handle possible errors
    if (document == null && context.mounted) {
      AppwriteHelpers.showSomethingWentWorng(context);
      return false;
    } else {
      return true;
    }
  }
}
