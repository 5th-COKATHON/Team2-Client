import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordConfirmController extends GetxController {
  // 비밀번호 입력 컨트롤러
  final TextEditingController passwordController = TextEditingController();
  // 비밀번호 입력 상태 관리
  var password = ''.obs;
  // 비밀번호 가시성 관리
  Rx<bool> isPasswordVisible = false.obs;

  // 비밀번호 입력 중일 때 호출되는 함수
  void updateEmail(String value) {
    password.value = value;
  }

  // 닉네임 입력 화면으로
  void toNickname() {
    Get.toNamed('/new_account/nickname');
  }
}
