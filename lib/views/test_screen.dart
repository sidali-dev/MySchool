import 'package:flutter/material.dart';
import 'package:myschool/controllers/uploaded_file_screen_controller.dart';
import 'package:myschool/utils/constants/enums.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              UploadedFileScreenController()
                  .getTeacherUploadsByActivity(ActivityEnum.videos);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("get files"),
            )),
      ),
    );
  }
}
