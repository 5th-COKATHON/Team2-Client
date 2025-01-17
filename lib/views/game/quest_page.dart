import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team2_client/view_models/game/quest_controller.dart';

class QuestPage extends StatelessWidget {
  const QuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final QuestController controller = Get.put(QuestController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '일일 퀘스트',
                  style: TextStyle(
                    color: Color(0xFF171717),
                    fontSize: 20,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    height: 1.40,
                  ),
                ),
                // 홈 버튼 (게임으로)
                GestureDetector(
                  onTap: () {
                    controller.toGame();
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: OvalBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/home.png',
                        width: 28,
                        height: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            // 내 코인
            Obx(() {
              return Row(
                children: [
                  Text(
                    '내 코인',
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Image.asset(
                    'assets/coin.png',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    '${controller.userCoin.value}',
                    style: TextStyle(
                      color: Color(0xFF323232),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                    ),
                  ),
                ],
              );
            }),

            SizedBox(
              height: 12,
            ),
            // Quest.1
            QuestContainer(
              questNum: 1,
              coin: 30,
              quest: '1,000 걸음 걷기',
            ),
            // Quest.2
            QuestContainer(
              questNum: 2,
              coin: 10,
              quest: '목 스트레칭 하기',
            ),
            // Quest.3
            QuestContainer(
              questNum: 3,
              coin: 20,
              quest: '플랭크 1분 하기',
            ),
          ],
        ),
      ),
    );
  }
}

class QuestContainer extends StatelessWidget {
  final int questNum;
  final int coin;
  final String quest;

  const QuestContainer({
    super.key,
    required this.questNum,
    required this.coin,
    required this.quest,
  });

  @override
  Widget build(BuildContext context) {
    final QuestController controller = Get.find<QuestController>();

    return Obx(() {
      final isCompleted =
          controller.questStatus[questNum] ?? false; // 퀘스트 상태 확인

      return GestureDetector(
        onTap: isCompleted
            ? null
            : () {
                controller.completeQuest(questNum, coin); // 퀘스트 완료 처리
              },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 85,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quest $questNum',
                            style: TextStyle(
                              color: Color(0xFFA3BE98),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              height: 1.40,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/coin.png',
                                width: 16,
                                height: 16,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                '$coin',
                                style: TextStyle(
                                  color: Color(0xFF323232),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  height: 1.40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            quest,
                            style: TextStyle(
                              color: Color(0xFF171717),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.check,
                                size: 16,
                                color: isCompleted
                                    ? Color(0xFFA3BE98)
                                    : Color(0xFF9E9E9E),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                isCompleted ? '완료됨' : '보상 받기',
                                style: TextStyle(
                                  color: isCompleted
                                      ? Color(0xFFA3BE98)
                                      : Color(0xFF9E9E9E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isCompleted)
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 85,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), // 어두운 레이어
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
