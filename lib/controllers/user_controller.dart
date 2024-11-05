import 'package:get/get.dart';
import 'package:myschool/models/user_model.dart';
import 'package:myschool/services/database_service.dart';

class UserController extends GetxController {
  Rx<UserModel?> user = Rx<UserModel?>(null);

  @override
  void onInit() async {
    super.onInit();
    await _getUser();
  }

  Future<void> _getUser() async {
    DatabaseService databaseService = DatabaseService();
    UserModel fetchedUser = await databaseService.getUser();
    user.value = fetchedUser;
  }
}
