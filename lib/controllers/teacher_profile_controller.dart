import 'package:appwrite/models.dart';
import 'package:myschool/models/asset_model.dart';
import 'package:myschool/models/modules.dart';
import 'package:myschool/services/database_service.dart';
import 'package:myschool/utils/constants/enums.dart';

import '../models/activities.dart';
import '../utils/constants/image_strings.dart';

class TeacherProfileController {
  List<AssetModel> assets = [];
  List<ActivityEnum> activities = [];
  List<List<AssetModel>> assetsByModule = [];
  List<List<List<AssetModel>>> assetsbyModuleThanActivity = [];

  Future<int> getTeacherAssets(
      {required String level,
      required String teacherID,
      String? branch}) async {
    final DatabaseService database = DatabaseService();

    List<Document>? list = await database.getTeacherAssetsPerLevel(
        level: level, teacherID: teacherID, branch: branch);

    if (list == null) {
      return -1;
    }

    if (list.isNotEmpty) {
      assets = list.map((e) => AssetModel.fromMap(e.data)).toList();

      Map<String, List<AssetModel>> groupedFilesByModuleMap = {};

      for (AssetModel asset in assets) {
        if (groupedFilesByModuleMap.containsKey(asset.module.name)) {
          groupedFilesByModuleMap[asset.module.name]!.add(asset);
        } else {
          groupedFilesByModuleMap[asset.module.name] = [asset];
        }
      }
      assetsByModule = groupedFilesByModuleMap.values.toList();

      for (List<AssetModel> list in assetsByModule) {
        Map<String, List<AssetModel>> groupedFilesByActivityMap = {};
        for (AssetModel asset in list) {
          if (groupedFilesByActivityMap.containsKey(asset.documentType.name)) {
            groupedFilesByActivityMap[asset.documentType.name]!.add(asset);
          } else {
            groupedFilesByActivityMap[asset.documentType.name] = [asset];
          }
        }
        assetsbyModuleThanActivity
            .add(groupedFilesByActivityMap.values.toList());
      }
      return 1;
    } else {
      return 0;
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

  Module getModule(ModuleEnum moduleEnum) {
    switch (moduleEnum) {
      case ModuleEnum.accounting:
        return Module(
          module: ModuleEnum.accounting,
          imagePath: SImageString.moduleAccounting,
        );
      case ModuleEnum.arabic:
        return Module(
          module: ModuleEnum.arabic,
          imagePath: SImageString.moduleArabic,
        );
      case ModuleEnum.civil:
        return Module(
          module: ModuleEnum.civil,
          imagePath: SImageString.moduleCivil,
        );
      case ModuleEnum.civilEngineering:
        return Module(
          module: ModuleEnum.civilEngineering,
          imagePath: SImageString.moduleCivilEngineering,
        );
      case ModuleEnum.computerScience:
        return Module(
          module: ModuleEnum.computerScience,
          imagePath: SImageString.moduleComputerScience,
        );
      case ModuleEnum.economy:
        return Module(
          module: ModuleEnum.economy,
          imagePath: SImageString.moduleEconomy,
        );
      case ModuleEnum.electricalEngineering:
        return Module(
          module: ModuleEnum.electricalEngineering,
          imagePath: SImageString.moduleElectricalEngineering,
        );
      case ModuleEnum.english:
        return Module(
          module: ModuleEnum.english,
          imagePath: SImageString.moduleEnglish,
        );
      case ModuleEnum.french:
        return Module(
          module: ModuleEnum.french,
          imagePath: SImageString.moduleFrench,
        );
      case ModuleEnum.geography:
        return Module(
          module: ModuleEnum.geography,
          imagePath: SImageString.moduleGeography,
        );
      case ModuleEnum.german:
        return Module(
          module: ModuleEnum.german,
          imagePath: SImageString.moduleGerman,
        );
      case ModuleEnum.history:
        return Module(
          module: ModuleEnum.history,
          imagePath: SImageString.moduleHistory,
        );
      case ModuleEnum.italian:
        return Module(
          module: ModuleEnum.italian,
          imagePath: SImageString.moduleItalian,
        );
      case ModuleEnum.law:
        return Module(
          module: ModuleEnum.law,
          imagePath: SImageString.moduleLaw,
        );
      case ModuleEnum.maths:
        return Module(
          module: ModuleEnum.maths,
          imagePath: SImageString.moduleMaths,
        );
      case ModuleEnum.mechanicalEngineering:
        return Module(
          module: ModuleEnum.mechanicalEngineering,
          imagePath: SImageString.moduleMichanicalEngineering,
        );
      case ModuleEnum.philosophy:
        return Module(
          module: ModuleEnum.philosophy,
          imagePath: SImageString.modulePhilosophy,
        );
      case ModuleEnum.physics:
        return Module(
          module: ModuleEnum.physics,
          imagePath: SImageString.modulePhysics,
        );
      case ModuleEnum.processEngineering:
        return Module(
          module: ModuleEnum.processEngineering,
          imagePath: SImageString.moduleProcessEngineering,
        );
      case ModuleEnum.science:
        return Module(
          module: ModuleEnum.science,
          imagePath: SImageString.moduleScience,
        );
      case ModuleEnum.sharia:
        return Module(
          module: ModuleEnum.sharia,
          imagePath: SImageString.moduleShariaa,
        );
      case ModuleEnum.spanish:
        return Module(
          module: ModuleEnum.spanish,
          imagePath: SImageString.moduleSpanish,
        );
      case ModuleEnum.technology:
        return Module(
          module: ModuleEnum.technology,
          imagePath: SImageString.moduleTechnology,
        );
    }
  }
}
