import 'package:get/get.dart';

class SignInController extends GetxController {
  RxBool passwordIsHidden = true.obs;
  RxString email = "".obs;
  RxString password = "".obs;

  switchvisibility() {
    passwordIsHidden.value = !passwordIsHidden.value;
  }
}
