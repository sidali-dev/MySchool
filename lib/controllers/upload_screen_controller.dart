import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite/models.dart' as appwrite;

import '../services/database_service.dart';
import '../utils/constants/enums.dart';
import '../utils/helpers/appwrite_helpers.dart';

class UploadScreenController extends GetxController {
  File? file;
  RxBool isFileSelected = false.obs;
  RxBool fileHasSolution = false.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController videoLinkController = TextEditingController();

  RxInt selectedLevel = 1.obs;
  List<int> levels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  RxInt selectedTrimester = 1.obs;
  List<int> trimesters = [1, 2, 3];

  RxList<int> selectedBranches = <int>[].obs;
  Map<int, List<Map<String, BranchesEnum>>> branches = {
    10: [
      {"branch": BranchesEnum.literature},
      {"branch": BranchesEnum.scientifique}
    ],
    11: [
      {"branch": BranchesEnum.philosophie},
      {"branch": BranchesEnum.langue},
      {"branch": BranchesEnum.gestion},
      {"branch": BranchesEnum.scientifique},
      {"branch": BranchesEnum.mathelam},
      {"branch": BranchesEnum.mathTechnique}
    ],
    12: [
      {"branch": BranchesEnum.philosophie},
      {"branch": BranchesEnum.langue},
      {"branch": BranchesEnum.gestion},
      {"branch": BranchesEnum.scientifique},
      {"branch": BranchesEnum.mathelam},
      {"branch": BranchesEnum.mathTechnique}
    ]
  };

  @override
  onClose() {
    super.onClose();
    titleController.dispose();
    videoLinkController.dispose();
  }

  changeLevel(int level) {
    selectedLevel.value = level;
    update();
  }

  changeTrimester(int trimester) {
    selectedTrimester.value = trimester;
    update();
  }

  changeBranches(int index) {
    if (selectedBranches.contains(index)) {
      selectedBranches.remove(index);
    } else {
      selectedBranches.add(index);
    }
    update();
  }

  Future<bool> uploadFile({
    required String filePath,
    required String fileName,
    required BuildContext context,
  }) async {
    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //start uploading the file
    DatabaseService databaseService = DatabaseService();
    appwrite.File? file =
        await databaseService.addFile(filePath: filePath, fileName: fileName);

    //close loading indicator
    Get.back();

    //handle possible errors
    if (file == null && context.mounted) {
      AppwriteHelpers.showSomethingWentWorng(context);
      return false;
    } else {
      return true;
    }
  }

  fileIsSelected() {
    isFileSelected.value = true;
    update();
  }

  switchFileHasSolution() {
    fileHasSolution.value = !fileHasSolution.value;
    update();
  }
}
