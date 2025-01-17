import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NicknameController extends GetxController {
  // 닉네임 입력 컨트롤러
  final TextEditingController nicknameController = TextEditingController();
  // 닉네임 입력 상태 관리
  var nickname = ''.obs;
  // 닉네임 유효성 관리
  var isNicknameValid = false.obs;

  // 닉네임 입력 중일 때 호출되는 함수
  void updateNickname(String value) {
    nickname.value = value;
    isNicknameValid.value = _validateNickname(value);
  }

  // 닉네임 유효성 검사 함수 (길이 체크)
  bool _validateNickname(String email) {
    if (nickname.value.length > 10) {
      return false;
    }
    return true;
  }

  // 다음 화면으로 (홈 (괴롭히기) 화면)
  void toGame() {
    Get.toNamed('/game');
  }
}
