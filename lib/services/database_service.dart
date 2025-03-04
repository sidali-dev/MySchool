import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myschool/models/asset_model.dart';
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
  late final Functions _functions;

  final AuthenticationService auth = AuthenticationService();

  DatabaseService() {
    client
        .setEndpoint(dotenv.get("APPWRITE_ENDPOINT"))
        .setProject(dotenv.get("APPWRITE_PROJECT"))
        .setSelfSigned(status: true);

    _account = Account(client);
    _databases = Databases(client);
    _storage = Storage(client);
    _functions = Functions(client);
  }

  Future<Document?> addUser({
    required String name,
    required enums.RoleEnum role,
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
          },
          permissions: [
            Permission.update(Role.user(currentUser.$id)),
          ]);

      return document;
    } catch (e) {
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
          data: {
            "user": userID,
            "level": level.toString(),
            "branch": branch
          },
          permissions: [
            Permission.read(Role.user(currentUser.$id)),
            Permission.update(Role.user(currentUser.$id)),
          ]);
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
          data: {
            "user": userID,
            "description": description
          },
          permissions: [
            Permission.update(
                Role.user(currentUser.$id)), // Only this user can update
          ]);
      return document;
    } catch (e) {
      return document;
    }
  }

  Future<Document?> updateStudentData({
    required userID,
    required int level,
    String? branch,
    String? avatarId,
  }) async {
    User currentUser = await _account.get();

    Document? document;

    try {
      document = await _databases.updateDocument(
          databaseId: dotenv.get("APPWRITE_DB_ID"),
          collectionId: dotenv.get("APPWRITE_DB_STUDENTS"),
          documentId: currentUser.$id,
          data: {
            "user": userID,
            "level": level.toString(),
            "branch": branch,
            "avatar_id": avatarId,
          });
      return document;
    } catch (e) {
      return document;
    }
  }

  Future<Document?> updateTeacherData({
    required userID,
    String? description,
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
          });

      return document;
    } catch (e) {
      print(e);
      return document;
    }
  }

  Future<Document?> removeTeacherProfilePic() async {
    User currentUser = await _account.get();

    Document? document;

    try {
      document = await _databases.updateDocument(
          databaseId: dotenv.get("APPWRITE_DB_ID"),
          collectionId: dotenv.get("APPWRITE_DB_TEACHERS"),
          documentId: currentUser.$id,
          data: {
            "profile_pic": null,
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
    required enums.RoleEnum role,
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

  Future<UserModel?> getUser() async {
    User currentUser = await _account.get();

    try {
      final response = await _databases.getDocument(
          databaseId: dotenv.get("APPWRITE_DB_ID"),
          collectionId: dotenv.get("APPWRITE_DB_USERS"),
          documentId: currentUser.$id);

      final UserModel userModel = UserModel.fromJson(response.data);

      return userModel;
    } catch (e) {
      return null;
    }
  }

  Future<StudentModel?> geStudent() async {
    User currentUser = await _account.get();
    final StudentModel? studentModel;

    try {
      final response = await _databases.getDocument(
          databaseId: dotenv.get("APPWRITE_DB_ID"),
          collectionId: dotenv.get("APPWRITE_DB_STUDENTS"),
          documentId: currentUser.$id);
      print(response.data);

      studentModel = StudentModel.fromJson(response.data);
      return studentModel;
    } catch (e) {
      return null;
    }
  }

  Future<TeacherModel?> getTeacher() async {
    User currentUser = await _account.get();
    final TeacherModel? teacherModel;

    try {
      final response = await _databases.getDocument(
          databaseId: dotenv.get("APPWRITE_DB_ID"),
          collectionId: dotenv.get("APPWRITE_DB_TEACHERS"),
          documentId: currentUser.$id);

      teacherModel = TeacherModel.fromMap(response.data);

      return teacherModel;
    } catch (e) {
      return null;
    }
  }

  Future<File?> uploadFile(
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

  Future<Document?> uploadImage({
    required XFile image,
    required String teacherId,
  }) async {
    try {
      // Delete existing profile picture
      final teacherDoc = await _databases.getDocument(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        collectionId: dotenv.get("APPWRITE_DB_TEACHERS"),
        documentId: teacherId,
      );

      if (teacherDoc.data['profile_pic'] != null &&
          teacherDoc.data['profile_pic'] != "") {
        print("PIC FOUND ERROR");
        await _storage.deleteFile(
          bucketId: dotenv.get("APPWRITE_STROAGE_IMAGES"),
          fileId: teacherDoc.data['profile_pic'],
        );
      }

      // Upload new image
      final uploadedFile = await _storage.createFile(
        bucketId: dotenv.get("APPWRITE_STROAGE_IMAGES"),
        fileId: ID.unique(),
        file: InputFile.fromPath(path: image.path),
        permissions: [
          Permission.write(Role.user(teacherId)),
          Permission.delete(Role.user(teacherId))
        ],
      );
      print("PHOTO UPLOADED SUCCESSFULLY");

      // Update database record
      final Document document = await _databases.updateDocument(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        collectionId: dotenv.get("APPWRITE_DB_TEACHERS"),
        documentId: teacherId,
        data: {'profile_pic': uploadedFile.$id},
      );
      print("RECORD UPDATED SUCCESSFULLY");

      return document;
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }

  Future<Uint8List> getImageLink({required String fileId}) async {
    return await _storage.getFilePreview(
        bucketId: dotenv.get("APPWRITE_STROAGE_IMAGES"), fileId: fileId);
  }

  Future deleteImage({required String fileId}) async {
    try {
      final result = await _storage.deleteFile(
          bucketId: dotenv.get("APPWRITE_STROAGE_IMAGES"), fileId: fileId);
      print(result);
    } catch (e) {
      print(e);
    }
  }

  Future<Document?> addFile(AssetModel asset) async {
    Document? document;
    try {
      document = await _databases.createDocument(
          databaseId: dotenv.get("APPWRITE_DB_ID"),
          collectionId: dotenv.get("APPWRITE_DB_ASSETS"),
          documentId: asset.id!,
          data: {
            "file_link": asset.fileLink,
            "title": asset.title,
            "trimester": asset.trimester,
            "has_solution": asset.hasSolution,
            "document_type": asset.documentType.name,
            "module": asset.module.name,
            "level": asset.level,
            "branch": asset.branch?.map((e) => e.name).toList(),
            "teacher": asset.teacher.id,
          },
          permissions: [
            Permission.delete(Role.user(asset.teacher.id))
          ]);
      return document;
    } catch (e) {
      print(e);

      return document;
    }
  }

  Future<List<Document>?> getAllFilesByTeacher(String teacherId) async {
    List<Document> documents = [];
    try {
      final result = await _databases.listDocuments(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        collectionId: dotenv.get("APPWRITE_DB_ASSETS"),
        queries: [
          Query.equal('teacher', teacherId),
        ],
      );
      documents = result.documents;
    } catch (e) {
      print(e);
      return null;
    }
    return documents;
  }

  Future<List<Document>?> getFilesForMaterialsScreen({
    required String activity,
    required String module,
    required String level,
    String? branch,
    String? trimester,
  }) async {
    List<Document> documents = [];
    try {
      final result = await _databases.listDocuments(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        collectionId: dotenv.get("APPWRITE_DB_ASSETS"),
        queries: [
          Query.equal('document_type', activity),
          Query.equal('module', module),
          Query.equal('level', level),
          if (trimester != null) Query.equal('trimester', trimester),
          if (branch != null) Query.contains('branch', branch),
        ],
      );
      documents = result.documents;
      return documents;
    } catch (e) {
      print("======================================");
      print("DATABASE SERVICE/getFilesForMaterialsScreen()");
      print(e);
      return null;
    }
  }

  Future<List<Document>?> getTeacherAssetsPerLevel({
    required String level,
    required String teacherID,
    String? branch,
  }) async {
    List<Document> documents = [];
    try {
      final result = await _databases.listDocuments(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        collectionId: dotenv.get("APPWRITE_DB_ASSETS"),
        queries: [
          Query.equal('level', level),
          Query.equal('teacher', teacherID),
          if (branch != null) Query.contains('branch', branch),
        ],
      );
      documents = result.documents;
      return documents;
    } catch (e) {
      print("======================================");
      print("DATABASE SERVICE/getTeacherAssetsPerLevel()");
      print(e);
      return null;
    }
  }

  Future<bool> deleteFileFromStorage(String fileId) async {
    try {
      final response = await _storage.deleteFile(
        fileId: fileId,
        bucketId: dotenv.get("APPWRITE_STORAGE_BUCKET"),
      );
      print(response);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String> deleteUserWithAllRelatedData() async {
    try {
      final Execution response = await _functions.createExecution(
          functionId: dotenv.get("APPWRITE_FUNCTION_DELETE_ACCOUNT"));

      return response.status;
    } catch (e) {
      return "failed";
    }
  }

  Future<dynamic> deleteFileFromDatabase(String documentId) async {
    try {
      final response = await _databases.deleteDocument(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        collectionId: dotenv.get("APPWRITE_DB_ASSETS"),
        documentId: documentId,
      );
      print(response);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
