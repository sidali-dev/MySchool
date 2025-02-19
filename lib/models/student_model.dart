import 'package:flutter/material.dart';
import 'package:myschool/utils/constants/enums.dart';

import '../generated/l10n.dart';

class StudentModel {
  final int level;
  final BranchesEnum? branch;
  final String? avatarId;

  StudentModel({
    required this.level,
    this.branch,
    this.avatarId,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
      level: int.parse(json['level']),
      branch: json['branch'] != null
          ? BranchesEnum.values.byName(json['branch'])
          : null,
      avatarId: json["avatar_id"] as String?);

  Map<String, dynamic> toJson() => {
        'level': level,
        'branch': branch?.name,
        'avatar_id': avatarId,
      };
  String getUserLevel(BuildContext context) {
    switch (level) {
      case 1:
        return S.of(context).ap1;
      case 2:
        return S.of(context).ap2;
      case 3:
        return S.of(context).ap3;
      case 4:
        return S.of(context).ap4;
      case 5:
        return S.of(context).ap5;
      case 6:
        return S.of(context).cem1;
      case 7:
        return S.of(context).cem2;
      case 8:
        return S.of(context).cem3;
      case 9:
        return S.of(context).cem4;
      case 10:
        return S.of(context).lycee1;
      case 11:
        return S.of(context).lycee2;
      case 12:
        return S.of(context).lycee3;

      default:
        return "";
    }
  }

  String getUserBranch(BuildContext context) {
    if (branch == BranchesEnum.gestion) {
      return S.of(context).management;
    } else if (branch == BranchesEnum.langue) {
      return S.of(context).languages;
    } else if (branch == BranchesEnum.literature) {
      return S.of(context).literature;
    } else if (branch == BranchesEnum.mathTechnique) {
      return S.of(context).math_technique;
    } else if (branch == BranchesEnum.mathelam) {
      return S.of(context).maths;
    } else if (branch == BranchesEnum.philosophie) {
      return S.of(context).philosophy_branch;
    } else if (branch == BranchesEnum.scientifique) {
      return S.of(context).scientific;
    } else {
      return "";
    }
  }

  List<String> getAllUserLevels(BuildContext context) {
    return <String>[
      S.of(context).ap1,
      S.of(context).ap2,
      S.of(context).ap3,
      S.of(context).ap4,
      S.of(context).ap5,
      S.of(context).cem1,
      S.of(context).cem2,
      S.of(context).cem3,
      S.of(context).cem4,
      S.of(context).lycee1,
      S.of(context).lycee2,
      S.of(context).lycee3,
    ];
  }

  List<Map<String, dynamic>> getAllUserBranches(
      BuildContext context, int? level) {
    switch (level ?? this.level) {
      case (10):
        return [
          {
            "title": S.of(context).literature,
            "value": BranchesEnum.literature,
          },
          {
            "title": S.of(context).scientific,
            "value": BranchesEnum.scientifique
          }
        ];
      case (11 || 12):
        return [
          {
            "title": S.of(context).philosophy_branch,
            "value": BranchesEnum.philosophie
          },
          {
            "title": S.of(context).scientific,
            "value": BranchesEnum.scientifique
          },
          {
            "title": S.of(context).languages,
            "value": BranchesEnum.langue,
          },
          {
            "title": S.of(context).management,
            "value": BranchesEnum.gestion,
          },
          {
            "title": S.of(context).maths,
            "value": BranchesEnum.mathelam,
          },
          {
            "title": S.of(context).math_technique,
            "value": BranchesEnum.mathTechnique
          }
        ];
      default:
        return [];
    }
  }

  int getBranchPosition(BuildContext context) {
    if (branch == BranchesEnum.gestion) {
      return 3;
    } else if (branch == BranchesEnum.langue) {
      return 2;
    } else if (branch == BranchesEnum.literature) {
      return 0;
    } else if (branch == BranchesEnum.mathTechnique) {
      return 5;
    } else if (branch == BranchesEnum.mathelam) {
      return 4;
    } else if (branch == BranchesEnum.philosophie) {
      return 0;
    } else if (branch == BranchesEnum.scientifique) {
      return 1;
    } else {
      return 0;
    }
  }
}
