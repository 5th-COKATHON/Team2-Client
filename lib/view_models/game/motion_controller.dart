import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team2_client/models/user_data.dart';
import 'package:team2_client/services/remote_data_source.dart';

class MotionController extends GetxController {
  // // 유저 데이터
  // var userData = UserData(
  //   userId: 0,
  //   email: '',
  //   nickname: '',
  //   userPoint: 0,
  //   level: 0,
  // ).obs;

  // void updateUserState(UserData newUserData) {
  //   userData.value = newUserData;
  // }

  // 하트
  var heartCount = 3.obs; // 초기 하트 개수
  var maxHeart = 3; // 최대 하트 개수

  // 코인
  var coinCount = 100.obs; // 초기 코인 개수

  var isButtonDisabled = false.obs; // 시작 버튼 활성화 여부

  @override
  void onInit() {
    super.onInit();
    // heartCount 값 변경 시 로그 출력
    ever(heartCount, (value) {
      print('현재 하트 개수: $value');
    });

    // coinCount 값 변경 시 로그 출력
    ever(coinCount, (value) {
      print('현재 코인 개수: $value');
    });

    // // 앱 초기화 시 유저 데이터 가져오기
    // fetchUserDataApi();
  }

  void decrementHeart() {
    if (heartCount > 0) {
      heartCount.value--;
      print('하트 감소: ${heartCount.value}');
    } else {
      print('하트가 이미 0입니다.');
    }
  }

  void incrementHeart() {
    if (heartCount.value < maxHeart) {
      heartCount.value++;
    }
  }

  void resetHeart() {
    heartCount.value = maxHeart; // 하트를 최대 개수로 충전
    print('하트 충전 완료: ${heartCount.value}');
  }

  void decrementCoin(int amount) {
    if (coinCount.value >= amount) {
      coinCount.value -= amount; // 코인 차감
      print('코인 감소: ${coinCount.value}');
    } else {
      print('코인이 부족합니다.');
    }
  }

  // 상태 변수
  var touchCount = 0.obs; // 딱밤 때리기 카운트
  var slideCount = 0.obs; // 꼬집기 카운트
  var shakeCount = 0.obs; // 흔들림 카운트
  var actionMessage = "대기 중...".obs; // 현재 상태 메시지

  // 기기 흔들림 감지 상태
  var isShaking = false;

  var level = 1.obs; // 초기 레벨
  var motionCount = 0.obs; // 모션 카운트
  var timerValue = 5.obs; // 남은 시간 (초)

  void resetMotionCount() {
    motionCount.value = 0;
  }

  void incrementMotion() {
    motionCount.value++;
  }

  void resetTimer() {
    timerValue.value = 5;
  }

  void levelUp() {
    level.value++;
  }

  int get targetMotionCount => level.value * 10; // 목표 모션 수

  var currentImage = 'assets/default_character.png'.obs; // 캐릭터 이미지 상태

  // 이미지 변경 함수
  void changeCharacterImage(String newImage) {
    currentImage.value = newImage;
    Future.delayed(const Duration(seconds: 1), () {
      currentImage.value = 'assets/default_character.png';
    });
  }

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
      Future.delayed(const Duration(seconds: 1), () {
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

  // 퀘스트 (코인 충전) 화면으로 이동
  void toQuestPage() {
    Get.toNamed('/game/quest');
  }

  // // 세션 키 받아오기
  // Future<String?> getSessionKey() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final sessionKey = prefs.getString('sessionKey');
  //   print('가져온 SessionKey: $sessionKey');
  //   return sessionKey;
  // }

  // // 유저 데이터 가져오기
  // Future<void> fetchUserDataApi() async {
  //   final sessionKey = await getSessionKey();

  //   if (sessionKey != null) {
  //     print("유저 데이터 API 호출 시작");

  //     try {
  //       dynamic response = await RemoteDataSource.fetchUserData(sessionKey);

  //       if (response != null) {
  //         // JSON 데이터를 디코딩하여 UserData 객체로 변환
  //         Map<String, dynamic> responseData = json.decode(response);
  //         UserData newUserData = UserData.fromJson(responseData);

  //         // 데이터 업데이트
  //         updateUserState(newUserData);

  //         print('유저 데이터: $responseData');
  //       } else {
  //         print("API 호출 실패: 응답 없음");
  //       }
  //     } catch (e) {
  //       print("API 에러: $e");
  //     }
  //   } else {
  //     print('SessionKey가 저장되어 있지 않습니다.');
  //   }
  // }

  // // 레벨업
  // Future<void> levelUpApi() async {
  //   final sessionKey = await getSessionKey();

  //   if (sessionKey != null) {
  //     print("레벨업 API 호출 시작");

  //     try {
  //       Map<String, String> data = {
  //         "sessionKey": sessionKey,
  //       };

  //       String jsonData = json.encode(data);
  //       dynamic response = await RemoteDataSource.levelUpApi(jsonData);

  //       if (response != null) {
  //         // JSON 데이터를 UserData 객체로 변환
  //         Map<String, dynamic> responseData = json.decode(response);
  //         UserData updatedUserData = UserData.fromJson(responseData);

  //         // 레벨업 이후 데이터 업데이트
  //         updateUserState(updatedUserData);

  //         print('레벨업 성공: ${updatedUserData.level}');
  //       } else {
  //         print("API 호출 실패");
  //       }
  //     } catch (e) {
  //       print("API 에러: $e");
  //     }
  //   } else {
  //     print('SessionKey가 저장되어 있지 않습니다.');
  //   }
  // }
}
