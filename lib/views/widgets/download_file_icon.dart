import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myschool/models/asset_model.dart';
import 'package:myschool/views/widgets/spinning_logo.dart';

import '../../controllers/download_file_button_controller.dart';

class DownloadFileIcon extends StatelessWidget {
  final AssetModel assetModel;
  final bool isDark;

  const DownloadFileIcon({
    required this.isDark,
    required this.assetModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the controller for this specific file
    final DownloadController controller = Get.put(
      DownloadController(
          fileName: assetModel.title,
          fileUrl: assetModel.fileLink,
          fileID: assetModel.id!),
      tag: assetModel.title, // Unique tag for each file
    );

    return Obx(
      () {
        if (controller.isDownloading.value) {
          // Show loading state
          return const Center(
            child: SpinningLogo(),
          );
        } else if (controller.isDownloaded.value) {
          // Show "Already Downloaded" state
          return const Icon(Icons.check, color: Colors.lightBlue);
        } else {
          // Show "Download" icon

          return IconButton(
            onPressed: () async => await controller.downloadFile(),
            icon: Icon(
              Icons.download,
              color: isDark ? Colors.white : Colors.black,
            ),
          );
        }
      },
    );
  }
}
