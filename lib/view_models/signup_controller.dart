import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team2_client/services/remote_data_source.dart';

class SignupController extends GetxController {
  var id = ''.obs;
  var pwd = ''.obs;
  var isButtonEnabled = false.obs;
  var key = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSessionKey(); // 앱 초기화 시 저장된 sessionKey 로드
  }

  void clickedBottomBtn(BuildContext context) {
    // Get.to(() => LearningConceptPage(currentStep: currentStepIdx));
  }

  void idSave(String value) {
    id.value = value;
    print("ID 저장: $id");
  }

  void pwdSave(String value) {
    pwd.value = value;
    print("PWD 저장: $pwd");
    _updateButtonState();
  }

  void clickedNewAccount(BuildContext context) {
    Get.offNamed('/new_account');
    print("New Account 페이지 이동");
  }

  void _updateButtonState() {
    isButtonEnabled.value = id.value.isNotEmpty && pwd.value.isNotEmpty;
  }

  Future<void> testApi() async {
    print("API 테스트 시작");
    try {
      dynamic response = await RemoteDataSource.testApi();
      print("API 테스트 성공: $response");
    } catch (e) {
      print("API 테스트 실패: $e");
    }
  }

  Future<void> loginApi() async {
    print("로그인 API 호출 시작");

    try {
      Map<String, String> loginData = {
        "email": id.value,
        "authKey": pwd.value,
      };
      print("로그인 데이터: $loginData");

      String jsonData = json.encode(loginData);
      dynamic response = await RemoteDataSource.loginApi(jsonData);
//response.body
      if (response != null) {
        print("로그인 성공, 응답: $response");
        Map<String, dynamic> responseData = json.decode(response);

        // sessionKey 출력 및 저장
        String sessionKey = responseData['sessionKey'] ?? '';
        if (sessionKey.isNotEmpty) {
          print("로그인 성공! sessionKey: $sessionKey");
          key.value = sessionKey;
          await saveSessionKey(sessionKey); // sessionKey 저장
          // 메인 (괴롭히기) 화면으로 이동
          Get.toNamed('/game');
        } else {
          throw ErrorDescription('sessionKey is missing or empty');
        }
      } else {
        print("로그인 실패");
      }
    } catch (e) {
      print("로그인 에러: $e");
    }
  }

  Future<void> saveSessionKey(String sessionKey) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('sessionKey', sessionKey);
      print("sessionKey 저장 완료: $sessionKey");
    } catch (e) {
      print("sessionKey 저장 에러: $e");
    }
  }

  Future<void> _loadSessionKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedKey = prefs.getString('sessionKey');
      if (savedKey != null && savedKey.isNotEmpty) {
        key.value = savedKey;
        print("저장된 sessionKey 로드 완료: $savedKey");
      } else {
        print("저장된 sessionKey가 없습니다.");
      }
    } catch (e) {
      print("sessionKey 로드 에러: $e");
    }
  }

  Future<void> clearSessionKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('sessionKey');
      key.value = '';
      print("sessionKey 삭제 완료");
    } catch (e) {
      print("sessionKey 삭제 에러: $e");
    }
  }
}
