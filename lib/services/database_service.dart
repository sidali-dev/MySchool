import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myschool/models/student_model.dart';
import 'package:myschool/models/teacher_model.dart';
import 'package:myschool/models/user_model.dart';
import 'package:myschool/services/authentication_service.dart';
import 'package:myschool/utils/constants/enums.dart' as enums;

class DatabaseService {
  Client client = Client();
  late final Account _account;
  late final Databases _databases;
  late final Storage _storage;

  final AuthenticationService auth = AuthenticationService();

  DatabaseService() {
    client
        .setEndpoint(dotenv.get("APPWRITE_ENDPOINT"))
        .setProject(dotenv.get("APPWRITE_PROJECT"))
        .setSelfSigned(status: true);

    _account = Account(client);
    _databases = Databases(client);
    _storage = Storage(client);
  }

  Future<Document?> addUser({
    required String name,
    required enums.Role role,
  }) async {
    User currentUser = await _account.get();

    Document? document;

    try {
      document = await _databases.createDocument(
          databaseId: dotenv.get("APPWRITE_DB_ID"),
          collectionId: dotenv.get("APPWRITE_DB_USERS"),
          documentId: currentUser.$id,
          data: {
            "name": name,
            "role": role.name,
          });
      return document;
    } catch (_) {
      return document;
    }
  }

  Future<Document?> addStudentData({
    required userID,
    required int level,
    String? branch,
  }) async {
    User currentUser = await _account.get();

    Document? document;

    try {
      document = await _databases.createDocument(
          databaseId: dotenv.get("APPWRITE_DB_ID"),
          collectionId: dotenv.get("APPWRITE_DB_STUDENTS"),
          documentId: currentUser.$id,
          data: {"user": userID, "level": level.toString(), "branch": branch});
      return document;
    } catch (e) {
      return document;
    }
  }

  Future<Document?> addTeacherData({
    required userID,
    String? description,
  }) async {
    User currentUser = await _account.get();

    Document? document;

    try {
      document = await _databases.createDocument(
          databaseId: dotenv.get("APPWRITE_DB_ID"),
          collectionId: dotenv.get("APPWRITE_DB_TEACHERS"),
          documentId: currentUser.$id,
          data: {"user": userID, "description": description});
      return document;
    } catch (e) {
      return document;
    }
  }

  Future<Document?> updateStudentData({
    required userID,
    required int level,
    String? branch,
  }) async {
    User currentUser = await _account.get();

    Document? document;

    try {
      document = await _databases.updateDocument(
          databaseId: dotenv.get("APPWRITE_DB_ID"),
          collectionId: dotenv.get("APPWRITE_DB_STUDENTS"),
          documentId: currentUser.$id,
          data: {"user": userID, "level": level.toString(), "branch": branch});
      return document;
    } catch (e) {
      return document;
    }
  }

  Future<Document?> updateTeacherData({
    required userID,
    String? description,
    int? uploadsCount,
  }) async {
    User currentUser = await _account.get();

    Document? document;

    try {
      document = await _databases.updateDocument(
          databaseId: dotenv.get("APPWRITE_DB_ID"),
          collectionId: dotenv.get("APPWRITE_DB_TEACHERS"),
          documentId: currentUser.$id,
          data: {
            "user": userID,
            "description": description?.trim(),
            "uploads_count": uploadsCount,
          });

      return document;
    } catch (e) {
      print(e);
      return document;
    }
  }

  Future<Document?> updateUserData({
    required String userID,
    required String name,
    required enums.Role role,
  }) async {
    User currentUser = await _account.get();

    Document? document;

    try {
      document = await _databases.updateDocument(
          databaseId: dotenv.get("APPWRITE_DB_ID"),
          collectionId: dotenv.get("APPWRITE_DB_USERS"),
          documentId: currentUser.$id,
          data: {"name": name, "role": role.name});
      return document;
    } catch (_) {
      return document;
    }
  }

  Future<UserModel> getUser() async {
    User currentUser = await _account.get();
    late final UserModel userModel;

    final response = await _databases.getDocument(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        collectionId: dotenv.get("APPWRITE_DB_USERS"),
        documentId: currentUser.$id);

    userModel = UserModel.fromJson(response.data);

    return userModel;
  }

  Future<StudentModel> geStudent() async {
    User currentUser = await _account.get();
    late final StudentModel studentModel;

    final response = await _databases.getDocument(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        collectionId: dotenv.get("APPWRITE_DB_STUDENTS"),
        documentId: currentUser.$id);

    studentModel = StudentModel.fromJson(response.data);

    return studentModel;
  }

  Future<TeacherModel> getTeacher() async {
    User currentUser = await _account.get();
    late final TeacherModel teacherModel;

    final response = await _databases.getDocument(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        collectionId: dotenv.get("APPWRITE_DB_TEACHERS"),
        documentId: currentUser.$id);

    teacherModel = TeacherModel.fromMap(response.data);

    return teacherModel;
  }

  Future<File?> addFile(
      {required String filePath, required String fileName}) async {
    try {
      File result = await _storage.createFile(
        bucketId: dotenv.get("APPWRITE_STORAGE_BUCKET"),
        fileId: ID.unique(),
        file: InputFile.fromPath(path: filePath, filename: fileName),
      );
      return result;
    } catch (e) {
      File? file;
      return file;
    }
  }
}
