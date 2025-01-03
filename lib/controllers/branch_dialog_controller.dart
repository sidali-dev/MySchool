import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:myschool/services/database_service.dart';
import 'package:myschool/utils/constants/enums.dart';

import '../utils/helpers/appwrite_helpers.dart';

class BranchDialogController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxMap selectedBranch = {}.obs;

  late AnimationController animationController;

  Map<int, List<Map<String, String>>> branches = {
    10: [
      {"branch": Branches.literature.name},
      {"branch": Branches.scientifique.name}
    ],
    11: [
      {"branch": Branches.philosophie.name},
      {"branch": Branches.langue.name},
      {"branch": Branches.gestion.name},
      {"branch": Branches.scientifique.name},
      {"branch": Branches.mathelam.name},
      {"branch": Branches.mathTechnique.name}
    ],
    12: [
      {"branch": Branches.philosophie.name},
      {"branch": Branches.langue.name},
      {"branch": Branches.gestion.name},
      {"branch": Branches.scientifique.name},
      {"branch": Branches.mathelam.name},
      {"branch": Branches.mathTechnique.name}
    ]
  };

  RxList<Effect> effects = <Effect>[
    const SlideEffect(
      begin: Offset(1, 0),
      end: Offset(0, 0),
      duration: Duration(milliseconds: 500),
    )
  ].obs;

  @override
  onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  onClose() {
    animationController.dispose();
    super.onClose();
  }

  errorDialogAnimtion() {
    effects.value = [
      const ShakeEffect(
        duration: Duration(milliseconds: 370),
      )
    ];
  }

  closeDialogAnimtion() {
    effects.value = [
      const SlideEffect(
        begin: Offset(0, 0),
        end: Offset(-1, 0),
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      )
    ];
  }

  openSignInDialog() {
    effects.value = [
      const SlideEffect(
        begin: Offset(0, 0),
        end: Offset(1, 0),
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      )
    ];
  }

  changeBranch(Map branch) {
    selectedBranch.value = branch;
  }

  Future<bool> addCredentials({
    required BuildContext context,
    required String name,
    required int level,
    String? branch,
  }) async {
    //start loading indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //add user data to database
    DatabaseService databaseService = DatabaseService();
    Document? document = await databaseService.addUser(
        name: name.trim(), level: level, branch: branch);

    //close loading indicator
    Get.back();

    //handle possible errors
    if (document == null && context.mounted) {
      AppwriteHelpers.showSomethingWentWorng(context);
      return false;
    } else {
      return true;
    }
  }
}
