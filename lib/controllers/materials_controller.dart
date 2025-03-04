import 'package:appwrite/models.dart';
import 'package:get/get.dart';

import '../models/asset_model.dart';
import '../services/database_service.dart';
import 'user_controller.dart';

class MaterialsController extends GetxController {
  RxList<AssetModel> uploadedFiles = <AssetModel>[].obs;
  final UserController userController = Get.find();

  Future<int> getUploadedFiles(
      {required String activity,
      required String module,
      String? trimester}) async {
    final DatabaseService databaseService = DatabaseService();

    List<Document>? documents =
        await databaseService.getFilesForMaterialsScreen(
      activity: activity,
      module: module,
      trimester: trimester,
      level: userController.student.value!.level.toString(),
      branch: userController.student.value!.branch?.name,
    );
    if (documents == null) {
      return -1;
    }

    if (documents.isNotEmpty) {
      uploadedFiles.value =
          documents.map((e) => AssetModel.fromMap(e.data)).toList();

      return 1; // Success
    } else if (documents.isEmpty) {
      return 0; // No files found
    } else {
      return -1; // Error
    }
  }
}
