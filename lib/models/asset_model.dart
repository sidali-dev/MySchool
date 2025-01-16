import 'package:myschool/models/teacher_model.dart';
import 'package:myschool/utils/constants/enums.dart';

class AssetModel {
  String? id;
  String title;
  String? trimester;
  bool? hasSolution;
  String fileLink;
  ActivityEnum documentType;
  ModuleEnum module;
  String level;
  List<BranchesEnum>? branch;
  TeacherModel teacher;

  AssetModel({
    this.id,
    this.trimester,
    this.hasSolution,
    required this.fileLink,
    required this.documentType,
    required this.module,
    required this.level,
    this.branch,
    required this.teacher,
    required this.title,
  });

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    return AssetModel(
      id: map['\$id'] as String,
      title: map['title'] as String,
      trimester: map['trimester'] as String?,
      hasSolution: map['has_solution'] as bool?,
      fileLink: map['file_link'] as String,
      documentType: ActivityEnum.values.firstWhere(
          (e) => e.name == map['document_type'],
          orElse: () => throw ArgumentError('Invalid document type')),
      module: ModuleEnum.values.firstWhere((e) => e.name == map['module'],
          orElse: () => throw ArgumentError('Invalid module')),
      level: map['level'] as String,
      branch: (map['branch'] as List<dynamic>)
          .map((e) => BranchesEnum.values.firstWhere(
              (enumValue) => enumValue.name == e,
              orElse: () => throw ArgumentError('Invalid branch value')))
          .toList(),
      teacher: TeacherModel.fromMap(map['teacher'] as Map<String, dynamic>),
    );
  }
}
