import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeConfirmController extends GetxController {
  // 인증번호 입력 컨트롤러
  final TextEditingController codeController = TextEditingController();
  // 인증번호 입력 상태 관리
  var code = ''.obs;

  // 인증번호 입력 중일 때 호출되는 함수
  void updateCode(String value) {
    code.value = value;
  }

  // 다음 화면으로 (비밀번호 체크 화면)
  void toPasswordConfirm() {
    Get.toNamed('/new_account/password');
  }
}
