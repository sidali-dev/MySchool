import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:myschool/services/database_service.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/views/widgets/spinning_logo.dart';

import '../utils/helpers/appwrite_helpers.dart';

class TeacherInfoDialogController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  RxInt charCount = 0.obs;

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

    descriptionController.addListener(() {
      charCount.value = descriptionController.text.length;
    });

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  onClose() {
    animationController.dispose();
    nameController.dispose();
    descriptionController.dispose();

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

  Future<bool> addTeacherCredentials({
    required BuildContext context,
    required String name,
    String? description,
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
        .addUser(name: name.trim(), role: RoleEnum.teacher)
        .then(
      (value) async {
        return await databaseService.addTeacherData(
          userID: value!.$id,
          description: description,
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
