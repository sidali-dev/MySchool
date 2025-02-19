import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:myschool/models/asset_model.dart';
import 'package:myschool/utils/device/file_downloader.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPreviewScreen extends StatelessWidget {
  final AssetModel assetModel;

  const PdfPreviewScreen({super.key, required this.assetModel});

  @override
  Widget build(BuildContext context) {
    final bool isDark = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(assetModel.title),
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //     child: DownloadFileIcon(assetModel: assetModel, isDark: isDark),
        //   )
        // ],
      ),
      body: FutureBuilder<Map>(
        future:
            FileDownloader.isFileDownLoaded(assetModel.title, assetModel.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!["isDownloaded"]!) {
              print('downloaded');
              return SfPdfViewer.file(
                File(snapshot.data!["path"]),
                enableTextSelection: false,
                onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) =>
                    SHelperFunctions.showAwesomeSnackBar(
                        title: "Failed to load file",
                        content: "Check your internet connection and try again",
                        contentType: ContentType.failure,
                        context: context),

                //FOR TESTING ONLY!!! REMOVE LATER.
                // onTap: (details) => SHelperFunctions.showAwesomeSnackBar(
                //     title: "Failed to load file",
                //     content: "Check your internet connection and try again",
                //     contentType: ContentType.failure,
                //     context: context),
              );
            } else {
              print('online');
              return SfPdfViewer.network(
                enableTextSelection: false,
                assetModel.fileLink,
                onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) =>
                    SHelperFunctions.showAwesomeSnackBar(
                        title: "Failed to load file",
                        content: "Check your internet connection and try again",
                        contentType: ContentType.failure,
                        context: context),
              );
            }
          }
        },
      ),
    );
  }
}
