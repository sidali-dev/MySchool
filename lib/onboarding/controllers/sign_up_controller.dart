import 'package:get/get.dart';

class SignUpController extends GetxController {
  RxBool passwordIsVisible = true.obs;

  RxString name = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;

  RxMap selectedLevel = {}.obs;
  RxMap selectedBranch = {}.obs;

  List<Map<String, dynamic>> levels = [
    {"level": 1, "title": "1 AP"},
    {"level": 2, "title": "2 AP"},
    {"level": 3, "title": "3 AP"},
    {"level": 4, "title": "4 AP"},
    {"level": 5, "title": "5 AP"},
    {"level": 6, "title": "1 CEM"},
    {"level": 7, "title": "2 CEM"},
    {"level": 8, "title": "3 CEM"},
    {"level": 9, "title": "4 CEM"},
    {"level": 10, "title": "1 LYCEE"},
    {"level": 11, "title": "2 LYCEE"},
    {"level": 12, "title": "3 LYCEE"}
  ];

  Map<int, List<Map<String, String>>> branches = {
    10: [
      {"branch": "Literature"},
      {"branch": "Scientifique"}
    ],
    11: [
      {"branch": "Philosophie"},
      {"branch": "Langue"},
      {"branch": "Gestion"},
      {"branch": "Scientifique"},
      {"branch": "Mathelam"},
      {"branch": "Math-Technique"}
    ],
    12: [
      {"branch": "Philosophie"},
      {"branch": "Langue"},
      {"branch": "Gestion"},
      {"branch": "Scientifique"},
      {"branch": "Mathelam"},
      {"branch": "Math-Technique"}
    ]
  };

  changeLevel(Map level) {
    selectedLevel.value = level;
  }

  changeBranch(Map branch) {
    selectedBranch.value = branch;
  }

  switchvisibility() {
    passwordIsVisible.value = !passwordIsVisible.value;
  }
}
