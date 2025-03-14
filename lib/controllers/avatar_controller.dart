import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myschool/controllers/user_controller.dart';
import 'package:myschool/models/avatar.dart';
import 'package:myschool/models/student_model.dart';
import 'package:myschool/utils/constants/image_strings.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import 'package:myschool/views/widgets/spinning_logo.dart';

import '../services/database_service.dart';

class AvatarController extends GetxController {
  List<Avatar> avatars = [
    Avatar(id: "male_with_glasses_1", image: SImageString.avatarMaleOne),
    Avatar(id: "male_with_glasses_2", image: SImageString.avatarMaleTwo),
    Avatar(id: "male_bald_head_beard_1", image: SImageString.avatarMaleThree),
    Avatar(id: "male_bald_head_beard_2", image: SImageString.avatarMaleFour),
    Avatar(id: "female_with_hijab_1", image: SImageString.avatarFemaleOne),
    Avatar(id: "female_with_hijab_2", image: SImageString.avatarFemaleTwo),
    Avatar(id: "female_with_glasses_1", image: SImageString.avatarFemaleThree),
    Avatar(id: "female_with_glasses_2", image: SImageString.avatarFemaleFour),
  ];
  Rx<Avatar?> selectedAvatar = Rx<Avatar?>(null);

  @override
  onInit() {
    super.onInit();
    UserController userController = Get.find();
    if (userController.student.value!.avatarId != null) {
      selectedAvatar.value = avatars.firstWhere(
          (element) => element.id == userController.student.value!.avatarId);
    }
  }

  selectAvatar(Avatar avatar) {
    selectedAvatar.value = avatar;
  }

  getAvatarImageById(String avatarId) {
    Avatar avatar = avatars.firstWhere((element) => element.id == avatarId);
    return avatar.image;
  }

  Future updateAvatar({
    required String avatarId,
    required BuildContext context,
    required String userID,
    required int level,
    String? branch,
  }) async {
    DatabaseService databaseService = DatabaseService();

    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: SpinningLogo(),
      ),
    );

    try {
      final response = await databaseService.updateStudentData(
          userID: userID, level: level, branch: branch, avatarId: avatarId);

      //close the progress indicator.
      Get.back();

      if (response != null && context.mounted) {
        final StudentModel student = StudentModel.fromJson(response.data);
        UserController userController = Get.find();
        userController.student.value = student;

        SHelperFunctions.showAwesomeSnackBar(
            title: "SUCCESS",
            content: "Profile avatar updated",
            contentType: ContentType.success,
            context: context);
      } else {
        if (context.mounted) {
          SHelperFunctions.showAwesomeSnackBar(
              title: "ERROR",
              content: "Something went wrong",
              contentType: ContentType.failure,
              context: context);
        }
      }
    } catch (e) {
      //close the progress indicator.
      Get.back();
      if (context.mounted) {
        SHelperFunctions.showAwesomeSnackBar(
            title: "ERROR",
            content: "Something went wrong",
            contentType: ContentType.failure,
            context: context);
      }
    }
  }
}
