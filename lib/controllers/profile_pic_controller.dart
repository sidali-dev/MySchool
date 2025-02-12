import 'package:appwrite/models.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myschool/controllers/user_controller.dart';
import 'package:myschool/models/teacher_model.dart';
import 'package:myschool/services/database_service.dart';
import 'package:myschool/utils/cache/profile_pic_cache_manager.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';

class ProfilePicController {
  Future addProfilePicture({
    required String teacherId,
    required BuildContext context,
  }) async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

//ADD A CHECK FOR LARGE IMAGES!!!
    final int imageSizeInBytes = await image.length();

    double imageSizeInMegaBytes = imageSizeInBytes / 1000000;
    imageSizeInMegaBytes = (imageSizeInMegaBytes * 10).ceil() / 10;

    if (imageSizeInMegaBytes > 5 && context.mounted) {
      SHelperFunctions.showAwesomeSnackBar(
          title: "Image size is too large",
          content: "Image size must be less then 5MB",
          contentType: ContentType.failure,
          context: context);
      return;
    }

    //start loading indicator
    if (context.mounted) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    DatabaseService databaseService = DatabaseService();
    final Document? document =
        await databaseService.uploadImage(image: image, teacherId: teacherId);

    //close the progress indicator
    Get.back();

    if (document != null) {
      UserController userController = Get.find();
      userController.teacher.value = TeacherModel.fromMap(document.data);
      if (context.mounted) {
        SHelperFunctions.showAwesomeSnackBar(
            title: "SUCCESS",
            content: "Profile picture added successfully",
            contentType: ContentType.success,
            context: context);
      }
    } else {
      if (context.mounted) {
        SHelperFunctions.showAwesomeSnackBar(
            title: "ERROR",
            content: "Something went wrong",
            contentType: ContentType.failure,
            context: context);
      }
    }
  }

  Future<void> deleteProfilePicture(
      {required String fileId, required BuildContext context}) async {
    try {
      DatabaseService databaseService = DatabaseService();

      //start loading indicator
      if (context.mounted) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      await databaseService.deleteImage(fileId: fileId);
      final result = await databaseService.removeTeacherProfilePic();

      if (result != null) {
        UserController userController = Get.find();
        userController.teacher.value = TeacherModel.fromMap(result.data);

        final ProfilePictureCacheManager cacheManager =
            ProfilePictureCacheManager();

        await cacheManager.removeFile('profilePic_$fileId');
        if (context.mounted) {
          Get.back();

          SHelperFunctions.showAwesomeSnackBar(
              title: "SUCCESS",
              content: "Profile picture deleted",
              contentType: ContentType.success,
              context: context);
        }
      } else {
        if (context.mounted) {
          Get.back();

          SHelperFunctions.showAwesomeSnackBar(
              title: "ERROR",
              content: "Failed to delete profile picture",
              contentType: ContentType.failure,
              context: context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        Get.back();

        SHelperFunctions.showAwesomeSnackBar(
            title: "ERROR",
            content: "Failed to delete profile picture",
            contentType: ContentType.failure,
            context: context);
      }
    }
  }
}
