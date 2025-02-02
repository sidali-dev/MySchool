import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myschool/models/asset_model.dart';

import '../../controllers/download_file_button_controller.dart';
import '../../generated/l10n.dart';

class DownloadFileButton extends StatelessWidget {
  final AssetModel assetModel;

  const DownloadFileButton({
    super.key,
    required this.assetModel,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the controller for this specific file
    final DownloadController controller = Get.put(
      DownloadController(
        fileName: assetModel.title,
        fileUrl: assetModel.fileLink,
      ),
      tag: assetModel.title, // Unique tag for each file
    );

    return Obx(() {
      if (controller.isDownloading.value) {
        // Show loading state
        return const OutlinedButton(
          onPressed: null, // Disable button during download
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (controller.isDownloaded.value) {
        // Show "Already Downloaded" state
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.green,
            side: const BorderSide(color: Colors.green),
          ),
          onPressed: null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.check, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                S.of(context).already_downloaded,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      } else {
        // Show "Download" button
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.green),
          ),
          onPressed: controller.downloadFile,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.document_download, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                S.of(context).download,
                style: const TextStyle(color: Colors.green),
              ),
            ],
          ),
        );
      }
    });
  }
}
