// import 'package:go_router/go_router.dart'; // GoRouter import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:team2_client/services/remote_data_source.dart';

class SignupController extends GetxController {
  var id = ''.obs;
  var pwd = ''.obs;
  var isButtonEnabled = false.obs;

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
    _updateButtonState();
  }

  void clickedNewAccount(BuildContext context) {
    Get.offNamed('/new_account');
    print("dd");
  }

  void _updateButtonState() {
    isButtonEnabled.value = id.value.isNotEmpty && pwd.value.isNotEmpty;
  }

  Future<void> testApi() async {
    print("sfd");
    try {
      dynamic response = await RemoteDataSource.testApi();
      print("출력");
      print(response);
    } catch (e) {
      print("에러");
    }
  }
}
