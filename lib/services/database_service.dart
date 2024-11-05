import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myschool/services/authentication_service.dart';

class DatabaseService {
  Client client = Client();
  late final Account account;
  late final Databases databases;
  final AuthenticationService auth = AuthenticationService();

  DatabaseService() {
    client
        .setEndpoint(dotenv.get("APPWRITE_ENDPOINT"))
        .setProject(dotenv.get("APPWRITE_PROJECT"))
        .setSelfSigned(status: true);

    account = Account(client);
    databases = Databases(client);
  }

  Future<Document?> addUser({
    required String name,
    required int level,
    String? branch,
  }) async {
    User currentUser = await account.get();

    Document? document;

    try {
      document = await databases.createDocument(
          databaseId: dotenv.get("APPWRITE_DB_ID"),
          collectionId: dotenv.get("APPWRITE_DB_USERS"),
          documentId: currentUser.$id,
          data: {"name": name, "level": level, "branch": branch});
      return document;
    } catch (_) {
      return document;
    }
  }

  Future<Document> getUser() async {
    User currentUser = await account.get();
    final response = await databases.getDocument(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        collectionId: dotenv.get("APPWRITE_DB_USERS"),
        documentId: currentUser.$id);

    return response;
  }
}
