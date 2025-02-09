import 'package:appwrite/models.dart';
import 'package:myschool/models/asset_model.dart';
import 'package:myschool/services/database_service.dart';
import 'package:myschool/utils/constants/enums.dart';

import '../models/activities.dart';
import '../utils/constants/image_strings.dart';

class TeacherProfileController {
  List<AssetModel> assets = [];
  List<ActivityEnum> activities = [];
  List<List<AssetModel>> assetsByActivity = [];

  Future<void> getTeacherAssets(
      {required String level,
      required String teacherID,
      String? branch}) async {
    final DatabaseService database = DatabaseService();

    List<Document> list = await database.getTeacherAssetsPerLevel(
        level: level, teacherID: teacherID, branch: branch);

    if (list.isNotEmpty) {
      assets = list.map((e) => AssetModel.fromMap(e.data)).toList();

      Map<String, List<AssetModel>> groupedFilesMap = {};

      for (AssetModel asset in assets) {
        if (groupedFilesMap.containsKey(asset.documentType.name)) {
          groupedFilesMap[asset.documentType.name]!.add(asset);
        } else {
          groupedFilesMap[asset.documentType.name] = [asset];
          activities.add(asset.documentType);
        }
      }
      assetsByActivity = groupedFilesMap.values.toList();
    }
  }

  getActivity(ActivityEnum activityEnum) {
    switch (activityEnum) {
      case ActivityEnum.exams:
        return Activity(
            activity: ActivityEnum.exams,
            imagePath: SImageString.activityExams);
      case ActivityEnum.exercises:
        return Activity(
            activity: ActivityEnum.exercises,
            imagePath: SImageString.activityExercises);
      case ActivityEnum.finals:
        return Activity(
            activity: ActivityEnum.finals,
            imagePath: SImageString.activityFinals);
      case ActivityEnum.lessons:
        return Activity(
            activity: ActivityEnum.lessons,
            imagePath: SImageString.activityLesson);
      case ActivityEnum.schoolBook:
        return Activity(
            activity: ActivityEnum.schoolBook,
            imagePath: SImageString.activitySchoolBook);
      case ActivityEnum.videos:
        return Activity(
            activity: ActivityEnum.videos,
            imagePath: SImageString.activityVideos);
    }
  }
}
