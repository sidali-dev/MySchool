import 'package:appwrite/models.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:myschool/controllers/user_controller.dart';
import 'package:myschool/models/asset_model.dart';
import 'package:myschool/services/database_service.dart';
import 'package:myschool/utils/constants/image_strings.dart';
import 'package:myschool/utils/helpers/appwrite_helpers.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';

import '../utils/constants/enums.dart';

class UploadedFileScreenController extends GetxController {
  RxList<AssetModel> uploadedFiles = <AssetModel>[].obs;
  RxList<List<AssetModel>> uploadedFilesByModel = <List<AssetModel>>[].obs;
  UserController user = Get.find();
  Future<int>? uploadedFilesResult;

  @override
  onInit() {
    super.onInit();
    uploadedFilesResult = getUploadedFiles();
  }

  Future deleteFile({
    required BuildContext context,
    required String id,
  }) async {
    DatabaseService databaseService = DatabaseService();

    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //delete file from database and storage
    final bool isSuccess =
        await databaseService.deleteFileFromDatabase(id).then(
      (value) async {
        print("database: $value");
        if (value == true) {
          return await databaseService.deleteFileFromStorage(id);
        } else {
          return false;
        }
      },
    );

    print("storage: $isSuccess");

    //close loading indicator
    Get.back();

    //handle possible errors
    if (!isSuccess) {
      if (context.mounted) {
        AppwriteHelpers.showSomethingWentWorng(context);
      }
    } else {
      Get.back();
      removeFileFromList(id);
      user.decrementTeacherUploads();
      if (context.mounted) {
        SHelperFunctions.showAwesomeSnackBar(
            title: "File Deleted",
            content: "File has been removed successfully",
            contentType: ContentType.success,
            context: context);
      }
    }
  }

  void removeFileFromList(String id) {
    uploadedFiles.removeWhere((element) => element.id == id);

    // Regroup files
    Map<String, List<AssetModel>> groupedFilesMap = {};
    for (AssetModel asset in uploadedFiles) {
      String moduleName = asset.module.name;
      if (!groupedFilesMap.containsKey(moduleName)) {
        groupedFilesMap[moduleName] = [];
      }
      groupedFilesMap[moduleName]!.add(asset);
    }
    uploadedFilesByModel.value = groupedFilesMap.values.toList();

    update();
  }

  Future<int> getUploadedFiles() async {
    DatabaseService databaseService = DatabaseService();

    List<Document>? documents =
        await databaseService.getAllFilesByTeacher(user.teacher.value!.id);

    if (documents != null && documents.isNotEmpty) {
      uploadedFiles.value =
          documents.map((e) => AssetModel.fromMap(e.data)).toList();

      Map<String, List<AssetModel>> groupedFilesMap = {};

      for (AssetModel asset in uploadedFiles) {
        if (groupedFilesMap.containsKey(asset.module.name)) {
          groupedFilesMap[asset.module.name]!.add(asset);
        } else {
          groupedFilesMap[asset.module.name] = [asset];
        }
      }

      uploadedFilesByModel.value = groupedFilesMap.values.toList();

      return 1; // Success
    } else if (documents != null && documents.isEmpty) {
      return 0; // No files found
    } else {
      return -1; // Error
    }
  }

  List<AssetModel> getTeacherUploadsByActivity(ActivityEnum activity) {
    List<AssetModel> list = [];
    int i = 0;
    for (AssetModel assetModel in uploadedFiles) {
      print(assetModel.documentType);
      if (assetModel.documentType == activity) {
        i++;
        print(i);
        list.add(assetModel);
      }
    }
    print(list.length);
    return list;
  }

  String getActivityImage(ActivityEnum activity) {
    switch (activity) {
      case ActivityEnum.exams:
        return SImageString.activityExams;
      case ActivityEnum.exercises:
        return SImageString.activityExercises;
      case ActivityEnum.lessons:
        return SImageString.activityLesson;
      case ActivityEnum.videos:
        return SImageString.activityVideos;
      default:
        return "";
    }
  }
}
