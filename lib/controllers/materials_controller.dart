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
    DatabaseService databaseService = DatabaseService();

    List<Document> documents = await databaseService.getFilesForMaterialsScreen(
      activity: activity,
      module: module,
      trimester: trimester,
      level: userController.student.value!.level.toString(),
      branch: userController.student.value!.branch?.name,
    );

    print("TRIGGERED");
    if (documents.isNotEmpty) {
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

      return 1; // Success
    } else if (documents.isEmpty) {
      return 0; // No files found
    } else {
      return -1; // Error
    }
  }
}
