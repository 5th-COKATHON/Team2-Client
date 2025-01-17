import 'package:get/get.dart';

class MotionController extends GetxController {
  // 상태 변수
  var touchCount = 0.obs; // 딱밤 때리기 카운트
  var slideCount = 0.obs; // 꼬집기 카운트
  var shakeCount = 0.obs; // 흔들림 카운트
  var actionMessage = "대기 중...".obs; // 현재 상태 메시지

  // 기기 흔들림 감지 상태
  var isShaking = false;

  // 터치 이벤트
  void incrementTouch() {
    touchCount++;
    actionMessage.value = "딱밤을 때렸어요! (${touchCount.value}번)";
  }

  // 슬라이드 이벤트
  void incrementSlide() {
    slideCount++;
    actionMessage.value = "꼬집기를 했어요! (${slideCount.value}번)";
  }

  // 흔들림 이벤트
  void incrementShake() {
    if (!isShaking) {
      isShaking = true;
      shakeCount++;
      actionMessage.value = "기기를 흔들었어요! (${shakeCount.value}번)";
      Future.delayed(Duration(seconds: 1), () {
        isShaking = false; // 흔들림 상태 초기화
      });
    }
  }

  // 상태 초기화
  void reset() {
    touchCount.value = 0;
    slideCount.value = 0;
    shakeCount.value = 0;
    actionMessage.value = "대기 중...";
  }
}
