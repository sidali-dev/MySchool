import 'package:get/get.dart';

class UserController extends GetxController {
  RxBool isSignedIn = false.obs;
  RxString email = "".obs;
  RxString name = "".obs;
  RxString uid = "".obs;
  RxString level = "".obs;
  RxString? branch = "".obs;
}
