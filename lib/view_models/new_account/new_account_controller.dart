// import 'package:go_router/go_router.dart'; // GoRouter import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:team2_client/services/remote_data_source.dart';
import 'package:team2_client/view_models/new_account/code_confirm_controller.dart';
import 'package:team2_client/views/new_account/code_confirm_page.dart';
import 'package:team2_client/views/new_account/new_account_page.dart';

class NewAccountController extends GetxController {
  // 이메일 입력 컨트롤러
  final TextEditingController emailController = TextEditingController();
  // 이메일 입력 상태 관리
  var email = ''.obs;
  // 이메일 유효성 관리
  var isEmailValid = false.obs;

  // 이메일 입력 중일 때 호출되는 함수
  void updateEmail(String value) {
    email.value = value;
    isEmailValid.value = _validateEmail(value);
  }

  // 이메일 유효성 검사 함수
  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // 다음 화면으로 (인증번호 체크 화면)
  void toCodeConfirm() {
    print("ddsssss");
    authSignUpApi();
    // Get.toNamed('/new_account/code');
    Get.to(() => const CodeConfirmPage(), arguments: email);
  }

  Future<void> authSignUpApi() async {
    try {
      Map<String, String> emailData = {
        "email": email.value,
      };
      String jsonData = json.encode(emailData);
      dynamic response =
          await RemoteDataSource.authSignUpApi(email.value, jsonData);
      if (response != null) {
        print("sign-up$response");
      } else {
        print("회원가입 실패");
      }
    } catch (e) {
      print("Error during sign-up API request: $e");
    }
  }
}
