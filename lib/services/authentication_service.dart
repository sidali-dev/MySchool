import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

enum AuthStatus {
  uninitialized,
  unauthenticated,
  authenticated,
}

class AuthenticationService extends GetxController {
  // static authenticationServiceConstructor() {
  //   init();
  // }
  Client client = Client();
  late final Account account;

  late User _currentUser;

  AuthStatus _status = AuthStatus.uninitialized;

  // Getter methods
  User get currentUser => _currentUser;
  AuthStatus get authStatus => _status;
  String? get username => _currentUser.name;
  String? get userEmail => _currentUser.email;
  String? get userId => _currentUser.$id;

  void init() {
    client
        .setEndpoint(dotenv.get("APPWRITE_ENDPOINT"))
        .setProject(dotenv.get("APPWRITE_PROJECT"))
        .setSelfSigned(status: true);

    account = Account(client);
  }

  @override
  void onInit() {
    init();
    loadUser();
    super.onInit();
  }

  void loadUser() async {
    try {
      final user = await account.get();
      _status = AuthStatus.authenticated;
      _currentUser = user;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
    } finally {
      update();
    }
  }

  Future<int> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return 200;
    } on AppwriteException catch (e) {
      return e.code!;
    } finally {
      update();
    }
  }

  Future<int> createEmailSession({
    required String email,
    required String password,
  }) async {
    try {
      await account.createEmailPasswordSession(
          email: email, password: password);
      _currentUser = await account.get();
      _status = AuthStatus.authenticated;
      return 200;
    } on AppwriteException catch (e) {
      return e.code!;
    } finally {
      update();
    }
  }

  Future<int> signOut() async {
    try {
      await account.deleteSession(sessionId: 'current');
      _status = AuthStatus.unauthenticated;
      return 200;
    } on AppwriteException catch (e) {
      return e.code!;
    } finally {
      update();
    }
  }
}
