class UserModel {
  String id;
  String name;
  int level;
  String? branch;

  UserModel({
    required this.id,
    required this.name,
    required this.level,
    this.branch,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': id,
      'name': name,
      'level': level,
      'branch': branch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['\$id'] as String,
      name: map['name'] as String,
      level: map['level'] as int,
      branch: map['branch'] as String?,
    );
  }
}
