import 'package:get/get.dart';

import '../utils/device/file_downloader.dart';

class DownloadController extends GetxController {
  final String fileName;
  final String fileUrl;
  final String fileID;

  // Track download status
  RxBool isDownloaded = false.obs;
  RxBool isDownloading = false.obs;

  DownloadController({
    required this.fileName,
    required this.fileUrl,
    required this.fileID,
  });

  // Initialize: Check if the file is already downloaded
  @override
  void onInit() {
    _checkDownloadStatus();
    super.onInit();
  }

  // Check if the file exists locally
  Future<void> _checkDownloadStatus() async {
    final response = await FileDownloader.isFileDownLoaded(fileName, fileID);
    isDownloaded.value = response["isDownloaded"];
  }

  // Download the file and update status
  Future<void> downloadFile() async {
    isDownloading.value = true;
    try {
      await FileDownloader.downloadFile(
        url: fileUrl,
        fileName: fileName,
        fileID: fileID,
        context: Get.context!,
      );
      // Re-check status after download
      await _checkDownloadStatus();
    } finally {
      isDownloading.value = false;
    }
  }
}
