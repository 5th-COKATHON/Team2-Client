// import 'package:go_router/go_router.dart'; // GoRouter import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignupController extends GetxController {
  var id = ''.obs;
  var pwd = ''.obs;

  void clickedBottomBtn(BuildContext context) {
    // Get.to(() => LearningConceptPage(currentStep: currentStepIdx));
  }
  void idSave(String value) {
    id.value = value;
    print(id);
  }

  void pwdSave(String value) {
    pwd.value = value;
    print(pwd);
  }

  void clickedNewAccount(BuildContext context) {
    Get.offNamed('/new_account');
    print("dd");
  }
}
