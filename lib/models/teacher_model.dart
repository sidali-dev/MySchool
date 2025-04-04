import 'user_model.dart';

class TeacherModel {
  final String id;
  final String databaseId;
  final String collectionId;
  final String? description;
  int uploadsCount;
  final UserModel user;
  final String? profilePic;

  TeacherModel({
    required this.id,
    required this.databaseId,
    required this.collectionId,
    this.description,
    required this.uploadsCount,
    required this.user,
    this.profilePic,
  });

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      id: map['\$id'] as String,
      databaseId: map['\$databaseId'] as String,
      collectionId: map['\$collectionId'] as String,
      description: map['description'] as String?,
      uploadsCount: map['uploads_count'] as int,
      user: UserModel.fromJson(map['user'] as Map<String, dynamic>),
      profilePic: map['profile_pic'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'description': description,
      'uploads_count': uploadsCount,
    };
  }
}
