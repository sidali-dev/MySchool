import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myschool/services/database_service.dart';
import 'package:path_provider/path_provider.dart';

import '../../generated/l10n.dart';

class FileDownloader {
  static Future<void> downloadFile({
    required BuildContext context,
    required String fileId,
    required String fileName,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final String savePath = '${directory.path}/$fileName-$fileId';

      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text(S.of(context).downloading),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(S.of(context).downloading),
              ],
            ),
          ),
        );
      }
      DatabaseService databaseService = DatabaseService();

      // Get file data from Appwrite
      final Uint8List fileData = await databaseService.downloadFilePreview(
        fileId,
      );

      // Save to local file
      final File file = File(savePath);
      await file.writeAsBytes(fileData);

      Get.back();
    } catch (e) {
      print("===FILE DOWNLOAD ERROR===");
      print(e);
      Get.back();
      // Add error handling snackbar/notification here
    }
  }

  static Future<Map<String, dynamic>> isFileDownLoaded(
      String fileName, String fileId) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String savePath = '${directory.path}/$fileName-$fileId';
    final File existingFile = File(savePath);
    return {"isDownloaded": await existingFile.exists(), "path": savePath};
  }
}
