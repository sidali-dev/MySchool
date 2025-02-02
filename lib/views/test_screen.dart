import 'package:flutter/material.dart';
import 'package:myschool/controllers/uploaded_file_screen_controller.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              UploadedFileScreenController().getUploadedFiles();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("get files"),
            )),
      ),
    );
  }
}
