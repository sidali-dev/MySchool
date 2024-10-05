import 'package:get/get.dart';
import 'package:myschool/utils/services/appwrite_provider.dart';

class UserController extends GetxController {
  RxBool isSignedIn = false.obs;
  RxBool isEnteredCredentials = false.obs;
  RxString email = "".obs;
  RxString name = "".obs;
  RxString uid = "".obs;
  RxString level = "".obs;
  RxString branch = "".obs;

  Future checkIsSignedIn() async {
    try {
      await AppwriteProvider().account!.get();
      isSignedIn.value = true;

      return true;
    } catch (_) {
      isSignedIn.value = false;
      return false;
    }
  }

  setUserId(String uid) {
    this.uid.value = uid;
  }

  setUserEmail(String email) {
    this.email.value = email;
  }

  cleanUserData() {
    email.value = "";
    name.value = "";
    uid.value = "";
    level.value = "";
    branch.value = "";
  }
}
