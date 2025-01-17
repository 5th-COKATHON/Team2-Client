// import 'package:go_router/go_router.dart'; // GoRouter import

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team2_client/services/remote_data_source.dart';

class SignupController extends GetxController {
  var id = ''.obs;
  var pwd = ''.obs;
  var isButtonEnabled = false.obs;
  var key = ''.obs;

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
  // void clickedNewAccount(BuildContext context) {
  //   Get.offNa
  // }

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

  Future<void> loginApi() async {
    print("login 함수 시작");

    try {
      Map<String, String> loginData = {
        "email": id.value,
        "authKey": pwd.value,
      };
      print("아이디 : ${id.value}");
      print("aut : ${pwd.value}");
      String jsonData = json.encode(loginData);
      dynamic response = await RemoteDataSource.loginApi(jsonData);
      if (response != null) {
        print("로그인 완$response");
        Map<String, dynamic> responseData = json.decode(response);

        // sessionKey 출력
        String sessionKey = responseData['sessionKey'] ?? '';
        print("로그인 성공! sessionKey: $sessionKey");
        key.value = sessionKey;
        // await saveSessionKey(sessionKey);
        // print("")
        print(response);
        // Map<String, dynamic> responseData = json.decode(response);
        // print("ddddd${responseData.toString()}");
        if (response is Map<String, dynamic>) {
          // sessionKey 추출
          String sessionKey = response['sessionKey'] ?? '';

          if (sessionKey.isEmpty) {
            throw ErrorDescription('sessionKey is missing or empty');
          } else {
            print('SessionKey: $sessionKey');
            // sessionKey를 활용한 로직 추가 가능
          }
        } else {
          throw ErrorDescription('Response is not a valid JSON object');
        }
      } else {
        print("로그인 실패");
      }
    } catch (e) {
      print("error $e");
    }
  }

  // Future<void> saveSessionKey(String sessionKey) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('sessionkey', sessionKey);
  //   print("sessionkey 저장 완료 : $sessionKey");
  // }
}
