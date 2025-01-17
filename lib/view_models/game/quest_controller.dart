import 'package:get/get.dart';

class QuestController extends GetxController {
  // 게임으로 돌아가기
  void toGame() {
    Get.toNamed('/game');
  }

  var userCoin = 20.obs; // 초기 사용자 코인
  var questStatus = <int, bool>{1: false, 2: false, 3: false}.obs; // 퀘스트 상태

  // 퀘스트 완료 처리
  void completeQuest(int questNum, int coinReward) {
    if (questStatus[questNum] == false) {
      questStatus[questNum] = true; // 퀘스트 완료 상태로 변경
      userCoin.value += coinReward; // 사용자 코인 업데이트
    }
  }
}
