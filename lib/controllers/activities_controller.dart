import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myschool/controllers/user_controller.dart';
import 'package:myschool/generated/l10n.dart';
import 'package:myschool/models/activities.dart';
import 'package:myschool/models/asset_model.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/utils/constants/image_strings.dart';

import '../services/database_service.dart';
import '../views/widgets/spinning_logo.dart';

class ActivitiesController {
  UserController userController = Get.find();
  AssetModel? schoolBook;

  late List<Activity> activities;

  ActivitiesController() {
    activities = getActivities();
  }

  List<Activity> getActivities() {
    switch (userController.student.value!.level) {
      case 12:
        {
          return <Activity>[
            Activity(
                activity: ActivityEnum.schoolBook,
                imagePath: SImageString.activitySchoolBook),
            Activity(
                activity: ActivityEnum.lessons,
                imagePath: SImageString.activityLesson),
            Activity(
                activity: ActivityEnum.exams,
                imagePath: SImageString.activityExams),
            Activity(
                activity: ActivityEnum.exercises,
                imagePath: SImageString.activityExercises),
            Activity(
                activity: ActivityEnum.finals,
                imagePath: SImageString.activityFinals),
            Activity(
                activity: ActivityEnum.videos,
                imagePath: SImageString.activityVideos),
          ];
        }
      case 9:
        {
          return <Activity>[
            Activity(
                activity: ActivityEnum.schoolBook,
                imagePath: SImageString.activitySchoolBook),
            Activity(
                activity: ActivityEnum.lessons,
                imagePath: SImageString.activityLesson),
            Activity(
                activity: ActivityEnum.exams,
                imagePath: SImageString.activityExams),
            Activity(
                activity: ActivityEnum.exercises,
                imagePath: SImageString.activityExercises),
            Activity(
                activity: ActivityEnum.finals,
                imagePath: SImageString.activityFinals),
            Activity(
                activity: ActivityEnum.videos,
                imagePath: SImageString.activityVideos),
          ];
        }
      case 5:
        {
          return <Activity>[
            Activity(
                activity: ActivityEnum.schoolBook,
                imagePath: SImageString.activitySchoolBook),
            Activity(
                activity: ActivityEnum.lessons,
                imagePath: SImageString.activityLesson),
            Activity(
                activity: ActivityEnum.exams,
                imagePath: SImageString.activityExams),
            Activity(
                activity: ActivityEnum.exercises,
                imagePath: SImageString.activityExercises),
            Activity(
                activity: ActivityEnum.finals,
                imagePath: SImageString.activityFinals),
            Activity(
                activity: ActivityEnum.videos,
                imagePath: SImageString.activityVideos),
          ];
        }

      default:
        return <Activity>[
          Activity(
              activity: ActivityEnum.schoolBook,
              imagePath: SImageString.activitySchoolBook),
          Activity(
              activity: ActivityEnum.lessons,
              imagePath: SImageString.activityLesson),
          Activity(
              activity: ActivityEnum.exams,
              imagePath: SImageString.activityExams),
          Activity(
              activity: ActivityEnum.exercises,
              imagePath: SImageString.activityExercises),
          Activity(
              activity: ActivityEnum.videos,
              imagePath: SImageString.activityVideos),
        ];
    }
  }

  static getActivitiesTitle(BuildContext context, ActivityEnum activity) {
    switch (activity) {
      case ActivityEnum.exams:
        return S.of(context).exams;
      case ActivityEnum.exercises:
        return S.of(context).exercises;
      case ActivityEnum.finals:
        return S.of(context).finals;
      case ActivityEnum.lessons:
        return S.of(context).lessons;
      case ActivityEnum.schoolBook:
        return S.of(context).school_book;
      case ActivityEnum.videos:
        return S.of(context).videos;
    }
  }

  Future<int> getSchoolBook({
    required BuildContext context,
    required String activity,
    required String module,
    String? trimester,
  }) async {
    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: SpinningLogo(),
      ),
    );
    UserController userController = Get.find();

    final DatabaseService databaseService = DatabaseService();

    List<Document>? documents =
        await databaseService.getFilesForMaterialsScreen(
      activity: activity,
      module: module,
      trimester: trimester,
      level: userController.student.value!.level.toString(),
      branch: userController.student.value!.branch?.name,
    );
    Get.back();

    if (documents == null) {
      return -1;
    }
    if (documents.isEmpty) {
      return 0;
    }
    schoolBook = AssetModel.fromMap(documents.first.data);
    return 1;
  }
}
