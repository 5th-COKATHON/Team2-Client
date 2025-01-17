import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team2_client/services/remote_data_source.dart';

class ChatController extends GetxController {
  // 텍스트 입력 컨트롤러
  final TextEditingController messageController = TextEditingController();

  // 메시지 입력 상태 관리
  var messageText = ''.obs;
  var answer = ''.obs;
  // 메시지 입력 중일 때 호출되는 함수
  void updateMessage(String value) {
    messageText.value = value;
  }

  Future<void> chatResponseApi() async {
    try {
      final sessionKey = await getSessionKey();

      // sessionKey가 null인지 확인
      if (sessionKey == null) {
        print("SessionKey가 없습니다. 로그인을 확인하세요.");
        return;
      }

      // chatApi 호출
      dynamic response = await RemoteDataSource.chatApi(
        sessionKey,
        messageText.value.toString(),
      );
      messageText.value = response;
      print("dfmsk $messageText");
      // 응답 처리
      if (response != null) {
        print("챗봇 응답: $response");
      } else {
        print("챗 실패");
      }
    } catch (e) {
      print("chatResponseApi 예외 발생: $e");
    }
  }

  Future<String?> getSessionKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionKey = prefs.getString('sessionKey');
      print('가져온 SessionKey: $sessionKey');
      return sessionKey;
    } catch (e) {
      print("getSessionKey 예외 발생: $e");
      return null;
    }
  }
}
