// import 'package:go_router/go_router.dart'; // GoRouter import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

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
    Get.toNamed('/new_account/code');
  }
}
