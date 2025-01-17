import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  // 텍스트 입력 컨트롤러
  final TextEditingController messageController = TextEditingController();

  // 메시지 입력 상태 관리
  var messageText = ''.obs;

  // 메시지 입력 중일 때 호출되는 함수
  void updateMessage(String value) {
    messageText.value = value;
  }
}
