import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myschool/models/student_model.dart';
import 'package:myschool/models/teacher_model.dart';
import 'package:myschool/models/user_model.dart';
import 'package:myschool/services/database_service.dart';
import 'package:myschool/utils/constants/enums.dart';

import '../services/authentication_service.dart';
import '../utils/helpers/appwrite_helpers.dart';

class UserController extends GetxController {
  Rx<UserModel?> user = Rx<UserModel?>(null);
  Rx<StudentModel?> student = Rx<StudentModel?>(null);
  Rx<TeacherModel?> teacher = Rx<TeacherModel?>(null);
  late List<String> levels;

  @override
  Future onInit() async {
    super.onInit();
  }

  Future<void> loadUpUser(BuildContext context) async {
    await _getUser();
    if (context.mounted && user.value!.role == Role.student) {
      levels = student.value!.getAllUserLevels(context);

      student.value!.getAllUserBranches(context, null);
    }
  }

  Future<void> _getUser() async {
    DatabaseService databaseService = DatabaseService();

    await Future.delayed(1.seconds);

    user.value = await databaseService.getUser();

    if (user.value!.role == Role.student) {
      student.value = await databaseService.geStudent();
    } else if (user.value!.role == Role.teacher) {
      teacher.value = await databaseService.getTeacher();
    }
  }

  Future<bool> updateStudentInfo(
      {required BuildContext context,
      required int level,
      String? branch}) async {
    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //update the user
    DatabaseService databaseService = DatabaseService();
    final response = await databaseService.updateStudentData(
        userID: user.value!.id, level: level, branch: branch);

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
  }

  Future<bool> updateTeacherInfo(
      {required BuildContext context,
      int? uploadsCount,
      String? description}) async {
    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //update the user
    DatabaseService databaseService = DatabaseService();
    final response = await databaseService.updateTeacherData(
        userID: user.value!.id,
        description: description,
        uploadsCount: uploadsCount);

    //close loading indicator
    Get.back();

    //handle possible errors
    if (response == null && context.mounted) {
      AppwriteHelpers.showSomethingWentWorng(context);
      return false;
    } else {
      teacher.value = TeacherModel.fromMap(response!.data);
      return true;
    }
  }

  updateTeacherLocally(TeacherModel teacherModel) {
    teacher.value = teacherModel;
    "=================================".printInfo();
    teacher.value!.uploadsCount.printInfo();
    teacherModel.uploadsCount.printInfo();
    update();
  }

// SIGN OUT
  Future<int> signOut({required BuildContext context}) async {
    AuthenticationService authController = Get.find<AuthenticationService>();

    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    int response = await authController.signOut().then(
      (value) {
        if (value == 200) {
          authController.loadUser();
          // Get.delete<UserController>();
          Get.back();
          return 200;
        } else {
          return 401;
        }
      },
    );

    //close loading indicator
    Get.back();

    //handle possible errors
    if (response != 200 && context.mounted) {
      AppwriteHelpers.handleAppwriteExceptions(response, context);
    }
    return response;
  }
}
