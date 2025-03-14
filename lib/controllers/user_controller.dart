import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myschool/models/student_model.dart';
import 'package:myschool/models/teacher_model.dart';
import 'package:myschool/models/user_model.dart';
import 'package:myschool/services/database_service.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/views/widgets/spinning_logo.dart';

import '../services/authentication_service.dart';
import '../utils/helpers/appwrite_helpers.dart';

class UserController extends GetxController {
  Rx<UserModel?> user = Rx<UserModel?>(null);
  Rx<StudentModel?> student = Rx<StudentModel?>(null);
  Rx<TeacherModel?> teacher = Rx<TeacherModel?>(null);
  late List<String> levels;

  Future<void> loadUpUser(BuildContext context) async {
    await _getUser();
    if (context.mounted && user.value!.role == RoleEnum.student) {
      levels = student.value!.getAllUserLevels(context);

      student.value!.getAllUserBranches(context, null);
    }
  }

  clearUserData() {
    user = Rx<UserModel?>(null);
    student = Rx<StudentModel?>(null);
    teacher = Rx<TeacherModel?>(null);
  }

  Future<void> _getUser() async {
    DatabaseService databaseService = DatabaseService();

    do {
      user.value = await databaseService.getUser();
      if (user.value == null) Future.delayed(1.seconds);
    } while (user.value == null);

    if (user.value!.role == RoleEnum.student) {
      do {
        student.value = await databaseService.geStudent();
        if (student.value == null) Future.delayed(1.seconds);
      } while (student.value == null);
    } else if (user.value!.role == RoleEnum.teacher) {
      do {
        teacher.value = await databaseService.getTeacher();
        if (teacher.value == null) Future.delayed(1.seconds);
      } while (teacher.value == null);
    }
  }

  Future<bool> updateStudentInfo(
      {required BuildContext context,
      required int level,
      String? branch,
      String? avatarId}) async {
    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: SpinningLogo(),
      ),
    );

    //update the user
    DatabaseService databaseService = DatabaseService();
    try {
      final response = await databaseService.updateStudentData(
        userID: user.value!.id,
        level: level,
        branch: branch,
        avatarId: avatarId,
      );

//close loading indicator
      Get.back();

      //handle possible errors
      if (response == null && context.mounted) {
        AppwriteHelpers.showSomethingWentWorng(context);
        return false;
      } else {
        student.value = StudentModel.fromJson(response!.data);
        return true;
      }
    } catch (e) {
      //close loading indicator
      Get.back();

      if (context.mounted) {
        AppwriteHelpers.showSomethingWentWorng(context);
      }
      return false;
    }
  }

  Future<Document?> updateTeacherInfo(
      {required BuildContext context,
      int? uploadsCount,
      String? description}) async {
    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: SpinningLogo(),
      ),
    );

    //update the user
    DatabaseService databaseService = DatabaseService();
    Document? document;
    try {
      document = await databaseService.updateTeacherData(
          userID: user.value!.id, description: description);

      //close loading indicator
      Get.back();

      //handle possible errors
      if (document == null && context.mounted) {
        AppwriteHelpers.showSomethingWentWorng(context);
        return document;
      } else {
        teacher.value = TeacherModel.fromMap(document!.data);
        return document;
      }
    } catch (_) {
      if (context.mounted) {
        AppwriteHelpers.showSomethingWentWorng(context);
        return document;
      }
    }
    return document;
  }

  incrementTeacherUploads() {
    teacher.value!.uploadsCount++;

    update();
  }

  decrementTeacherUploads() {
    teacher.value!.uploadsCount--;

    update();
  }

  Future<void> deleteUser(BuildContext context) async {
    DatabaseService databaseService = DatabaseService();

    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinningLogo(),
              SizedBox(height: 16.0),
              Text("DELETING ACCOUNT..."),
            ],
          ),
        ),
      ),
    );

    try {
      final String response =
          await databaseService.deleteUserWithAllRelatedData();

      if (response == "completed") {
        clearUserData();
        AuthenticationService authenticationService = Get.find();
        authenticationService.clearAuthStatus();
      }

      // close the loading indicator.
      Get.back();
    } catch (_) {
      //close the loading indicator.
      Get.back();
      if (context.mounted) {
        AppwriteHelpers.showSomethingWentWorng(context);
      }
    }
  }

// SIGN OUT
  Future<int> signOut({required BuildContext context}) async {
    AuthenticationService authController = Get.find<AuthenticationService>();

    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: SpinningLogo(),
      ),
    );

    late int response;
    try {
      response = await authController.signOut();
    } catch (_) {
      response = 401;
    }

    //close loading indicator
    Get.back();

    //handle possible errors
    if (response != 200 && context.mounted) {
      AppwriteHelpers.handleAppwriteExceptions(response, context);
    }

    if (response == 200) {
      authController.loadUser();
      Get.back();
      return 200;
    } else {
      return 401;
    }
  }
}
