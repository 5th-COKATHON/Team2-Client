import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team2_client/services/remote_data_source.dart';

class NicknameController extends GetxController {
  // 닉네임 입력 컨트롤러
  final TextEditingController nicknameController = TextEditingController();
  // 닉네임 입력 상태 관리
  var nickname = ''.obs;
  // 닉네임 유효성 관리
  var isNicknameValid = false.obs;
  var email = ''.obs;

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
    nickSaveApi();
    Get.toNamed('/signup');
  }

  Future<void> nickSaveApi() async {
    try {
      Map<String, String> nickData = {
        "email": email.value,
        "nickname": nickname.value,
      };
      print("이메일 : ${email.value}");
      print("닉네임 : ${nickname.value}");
      String jsonData = json.encode(nickData);
      print("json data : $jsonData");
      dynamic response = await RemoteDataSource.saveNickNameApi(jsonData);
      if (response != null) {
        print("닉네임 완 $response");
      } else {
        print("닉 실패");
      }
    } catch (e) {
      print("error $e");
    }
  }
}
