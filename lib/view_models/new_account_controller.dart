// import 'package:go_router/go_router.dart'; // GoRouter import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NewAccountController extends GetxController {
  var email = ''.obs;
  var code = ''.obs;

  void clickedBottomBtn(BuildContext context) {
    // Get.to(() => LearningConceptPage(currentStep: currentStepIdx));
  }
  void emailSave(String value) {
    email.value = value;
    print(email);
  }

  void codeSave(String value) {
    code.value = value;
    print(code);
  }

  void codeSend() {
    //인증 코드 전송
  }
  void codeCheck() {
    // 인증 코드 확인
  }
  // void clickedNewAccount(BuildContext context) {
  //   Get.offNamed('/new_account');
  //   print("dd");
  // }
}
