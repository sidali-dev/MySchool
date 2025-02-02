import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:appwrite/models.dart' as appwrite;
import 'package:myschool/models/asset_model.dart';

import '../models/teacher_model.dart';
import '../services/database_service.dart';
import '../utils/constants/enums.dart';
import '../utils/helpers/appwrite_helpers.dart';

class UploadScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  File? file;
  AssetModel? assetModel;

  RxBool isFileSelected = false.obs;
  RxBool fileHasSolution = false.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController videoLinkController = TextEditingController();

  RxInt selectedLevel = 1.obs;
  List<int> levels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  RxInt selectedTrimester = 1.obs;
  List<int> trimesters = [1, 2, 3];

  RxString selectedModule = "".obs;

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
  onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  onClose() {
    super.onClose();
    animationController.dispose();
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

  changeModule(String module) {
    selectedModule.value = module;
    update();
  }

  getFirstSelectedBranch() {
    if (selectedBranches.isNotEmpty && selectedLevel.value >= 10) {
      return branches[selectedLevel.value]![selectedBranches.first]["branch"]!
          .name;
    } else {
      return null;
    }
  }

  void loadAsset(
    String id,
    String fileLink,
    ActivityEnum documentType,
    ModuleEnum module,
    TeacherModel teacher,
    bool? hasSolution,
  ) {
    assetModel = AssetModel(
        id: id,
        fileLink: fileLink,
        title: titleController.text,
        trimester: selectedTrimester.value.toString(),
        hasSolution: hasSolution,
        documentType: documentType,
        module: module,
        level: selectedLevel.value.toString(),
        branch: selectedBranches
            .map((index) => branches[selectedLevel.value]![index]['branch']!)
            .toList(),
        teacher: teacher);
  }

  Future<appwrite.File?> uploadFile({
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
    appwrite.File? file = await databaseService.uploadFile(
        filePath: filePath, fileName: fileName);

    //close loading indicator
    Get.back();

    //handle possible errors
    if (file == null && context.mounted) {
      AppwriteHelpers.showSomethingWentWorng(context);
      return file;
    } else {
      return file;
    }
  }

  Future<appwrite.Document?> addFile({
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

    //start adding the file to DB
    DatabaseService databaseService = DatabaseService();
    appwrite.Document? document = await databaseService.addFile(assetModel!);

    //close loading indicator
    Get.back();

    //handle possible errors
    if (file == null && context.mounted) {
      AppwriteHelpers.showSomethingWentWorng(context);
      return document;
    } else {
      return document;
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
