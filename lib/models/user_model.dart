import 'package:myschool/utils/constants/enums.dart';

class UserModel {
  final String id;
  final String name;
  final Role role;

  UserModel({
    required this.id,
    required this.name,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['\$id'],
      name: json['name'],
      role: Role.values.byName(json['role']),
    );
  }

  Map<String, dynamic> toJson() => {
        '\$id': id,
        'name': name,
        'role': role.name,
      };
}
