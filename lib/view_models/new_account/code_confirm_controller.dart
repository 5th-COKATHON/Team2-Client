import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team2_client/services/remote_data_source.dart';
import 'package:team2_client/views/new_account/nickname_page.dart';

class CodeConfirmController extends GetxController {
  // 인증번호 입력 컨트롤러
  final TextEditingController codeController = TextEditingController();

  // 인증번호 입력 상태 관리
  var code = ''.obs;
  var email = ''.obs;

  // 인증번호 입력 중일 때 호출되는 함수
  void updateCode(String value) {
    code.value = value;
  }

  // 다음 화면으로 (비밀번호 체크 화면)
  void toPasswordConfirm() {
    Get.toNamed('/new_account/password');
    checkCodeApi();
  }

  void toNickname() {
    checkCodeApi();
    // Get.toNamed('/nickname');
    Get.to(() => const NicknamePage(), arguments: email);
  }

  void toNextBtn() {
    print("next");
  }

  Future<void> checkCodeApi() async {
    try {
      dynamic response = await RemoteDataSource.checkCodeApi(
          email.value.toString(), code.value.toString());
      if (response != null) {
        print("코드 인증 $response");
      } else {
        print("코드 인증 실패");
      }
    } catch (e) {}
  }
}
