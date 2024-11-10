import 'package:get/get.dart';
import 'package:myschool/controllers/user_controller.dart';
import 'package:myschool/models/activities.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/utils/constants/image_strings.dart';

class ActivitiesController {
  UserController userController = Get.find();

  late List<Activity> activities;

  ActivitiesController() {
    activities = getActivities();
  }

  List<Activity> getActivities() {
    switch (userController.user.value!.level) {
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
}
