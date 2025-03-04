import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:myschool/services/database_service.dart';
import 'package:myschool/utils/constants/enums.dart';
import 'package:myschool/views/widgets/spinning_logo.dart';

import '../utils/helpers/appwrite_helpers.dart';

class BranchDialogController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  RxMap selectedBranch = {}.obs;
  Map<int, List<Map<String, String>>> branches = {
    10: [
      {"branch": BranchesEnum.literature.name},
      {"branch": BranchesEnum.scientifique.name}
    ],
    11: [
      {"branch": BranchesEnum.philosophie.name},
      {"branch": BranchesEnum.langue.name},
      {"branch": BranchesEnum.gestion.name},
      {"branch": BranchesEnum.scientifique.name},
      {"branch": BranchesEnum.mathelam.name},
      {"branch": BranchesEnum.mathTechnique.name}
    ],
    12: [
      {"branch": BranchesEnum.philosophie.name},
      {"branch": BranchesEnum.langue.name},
      {"branch": BranchesEnum.gestion.name},
      {"branch": BranchesEnum.scientifique.name},
      {"branch": BranchesEnum.mathelam.name},
      {"branch": BranchesEnum.mathTechnique.name}
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
        child: SpinningLogo(),
      ),
    );

    //add user data to database
    DatabaseService databaseService = DatabaseService();
    Document? document = await databaseService
        .addUser(name: name.trim(), role: RoleEnum.student)
        .then(
          (value) async => await databaseService.addStudentData(
            userID: value?.$id,
            level: level,
            branch: branch,
          ),
        );

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
