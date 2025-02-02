import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../generated/l10n.dart';

class FileDownloader {
  static Future<void> downloadFile({
    required String url,
    required String fileName,
    required BuildContext context,
  }) async {
    try {
      // Get the downloads directory path
      final directory = await getApplicationDocumentsDirectory();
      final String savePath = '${directory.path}/$fileName';

      // Show progress dialog
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
                StreamBuilder<double>(
                  stream: _downloadProgressStream(url, savePath),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData) {
                      return Text(S.of(context).start_download);
                    }
                    final progress = snapshot.data ?? 0.0;
                    return Text('${(progress * 100).toStringAsFixed(1)}%');
                  },
                ),
              ],
            ),
          ),
        );
      }

      // Wait for the download to complete
      await _downloadFileWithProgress(url, savePath);

      // Close the dialog
      Get.back();
    } catch (e) {
      print("===FILE: FILE_DOWNLOADER===");
      print(e);
    }
  }

  static Stream<double> _downloadProgressStream(
    String url,
    String savePath,
  ) async* {
    final Dio dio = Dio();
    final StreamController<double> controller =
        StreamController<double>.broadcast();

    final cancelToken = CancelToken();
    dio.download(
      url,
      savePath,
      cancelToken: cancelToken,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          final progress = received / total;
          controller.add(progress);
        }
      },
    ).whenComplete(() => controller.close());

    await for (final progress in controller.stream) {
      yield progress;
    }
  }

  static Future<void> _downloadFileWithProgress(
    String url,
    String savePath,
  ) async {
    final Dio dio = Dio();
    await dio.download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print('Progress: ${(received / total * 100).toStringAsFixed(1)}%');
        }
      },
    );
  }

  static Future<Map<String, dynamic>> isFileDownLoaded(String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String savePath = '${directory.path}/$fileName';

    final File existingFile = File(savePath);
    return {"isDownloaded": await existingFile.exists(), "path": savePath};
  }
}
