import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:myschool/models/asset_model.dart';
import 'package:myschool/utils/device/file_downloader.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';
import 'package:myschool/views/widgets/spinning_logo.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../generated/l10n.dart';

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
      ),
      body: FutureBuilder<Map>(
        future:
            FileDownloader.isFileDownLoaded(assetModel.title, assetModel.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinningLogo(),
            );
          } else {
            if (snapshot.data!["isDownloaded"]!) {
              return SfPdfViewer.file(
                File(snapshot.data!["path"]),
                enableTextSelection: false,
                onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) =>
                    SHelperFunctions.showAwesomeSnackBar(
                        title: S.of(context).failed_load_file,
                        content: S.of(context).something_went_wrong,
                        contentType: ContentType.failure,
                        context: context),
              );
            } else {
              return SfPdfViewer.network(
                enableTextSelection: false,
                assetModel.fileLink,
                onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) =>
                    SHelperFunctions.showAwesomeSnackBar(
                        title: S.of(context).failed_load_file,
                        content: S.of(context).check_internet_connection,
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
