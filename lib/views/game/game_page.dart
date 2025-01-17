import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:team2_client/components/custom_bottom_bar.dart';
import 'package:team2_client/view_models/game/motion_controller.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  final MotionController controller = Get.put(MotionController());

  bool isDialogShown = false; // 다이얼로그 중복 표시 방지 플래그

  Timer? gameTimer; // 제한 시간

  late Timer _clickTimer; // 초당 클릭 횟수 측정용 타이머
  int _clickCount = 0; // 현재 초당 클릭 횟수 카운트
  late AnimationController _tiltAnimationController; // 캐릭터 기울기 애니메이션 컨트롤러
  late Animation<double> _tiltAnimation; // 캐릭터 기울기 애니메이션
  late AnimationController _shakeAnimationController; // 흔들기 애니메이션 컨트롤러
  bool isTilted = false; // 캐릭터가 쓰러졌는지 여부

  @override
  void initState() {
    super.initState();

    // 하트가 모두 사라졌을 때 다이얼로그 표시
    ever(controller.heartCount, (value) {
      print('GamePage에서 감지된 heartCount 값: $value');
      if (value == 0 && !isDialogShown) {
        isDialogShown = true;
        _showRechargeDialog();
      }
    });

    // 딱밤 클릭 타이머
    _clickTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_clickCount > 0) {
        _sendClickRateToServer(_clickCount); // 서버에 클릭 데이터 전송
        _clickCount = 0; // 카운트 초기화
      }
    });

    // 흔들림 감지
    accelerometerEvents.listen((event) {
      final magnitude =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      if (magnitude > 15.0) {
        controller.incrementShake();
        controller
            .changeCharacterImage('assets/shake_character.png'); // 흔들기 캐릭터 변경
        _shakeAnimationController.forward(from: 0); // 흔들기 애니메이션 시작
      }
    });

    // 캐릭터 쓰러짐 애니메이션 초기화
    _tiltAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _tiltAnimation =
        Tween<double>(begin: 0, end: pi / 2).animate(_tiltAnimationController);

    // 흔들기 애니메이션 초기화
    _shakeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _clickTimer.cancel();
    _tiltAnimationController.dispose();
    _shakeAnimationController.dispose();
    gameTimer?.cancel(); // 타이머 정리
    super.dispose();
  }

  // 게임 시작
  void startGame() {
    controller.resetMotionCount();
    controller.timerValue.value = 5000; // 5초 (5000ms)
    controller.isButtonDisabled.value = true; // 버튼 비활성화

    gameTimer?.cancel(); // 기존 타이머 종료
    gameTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (controller.timerValue.value > 0) {
        controller.timerValue.value -= 10; // 10ms 감소
      } else {
        timer.cancel();
        _evaluateGameResult(); // 제한 시간 종료 시 결과 평가
        controller.isButtonDisabled.value = false; // 버튼 활성화
      }
    });
  }

  // 타이머 포맷
  String formatTime(int milliseconds) {
    final seconds = (milliseconds ~/ 1000).toString().padLeft(2, '0');
    final millis =
        ((milliseconds % 1000) ~/ 10).toString().padLeft(2, '0'); // 10ms 단위
    return '$seconds:$millis';
  }

  // 게임 결과
  void _evaluateGameResult() {
    if (controller.motionCount.value >= controller.targetMotionCount) {
      controller.levelUp(); // 레벨업
      Get.snackbar(
        '레벨업!',
        '축하합니다! ${controller.level.value} 레벨에 도달했습니다!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      controller.decrementHeart(); // 하트 감소
      Get.snackbar(
        '실패',
        '목표를 달성하지 못했습니다. 하트가 줄어듭니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // 게임 종료 후 버튼 활성화
    setState(() {
      controller.isButtonDisabled.value = false;
    });

    // 게임 타이머 종료
    gameTimer?.cancel();
  }

  // 하트 충전 안내창
  void _showRechargeDialog() {
    print('다이얼로그를 표시합니다.');
    showDialog(
      context: context,
      barrierDismissible: false, // 다이얼로그 밖을 눌러도 닫히지 않도록 설정
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: Container(
            width: 240,
            height: 220,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '하트가 부족해요',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF171717),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.40,
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (controller.coinCount.value >= 50) {
                            // 코인이 충분할 경우
                            controller.decrementCoin(50); // 코인 50개 차감
                            controller.incrementHeart(); // 하트 1개 충전
                            Navigator.of(context).pop(); // 다이얼로그 닫기
                          } else {
                            // 코인이 부족할 경우 퀘스트 창으로 이동
                            Navigator.of(context).pop(); // 다이얼로그 닫기
                            controller.toQuestPage();
                          }
                        },
                        child: Container(
                          width: 180,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Color(0xFFA3BE98),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '50 코인 사용하기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                height: 1.40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        },
                        child: Container(
                          width: 180,
                          height: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFFE0E0E0)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '그만하기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 서버로 클릭 횟수 전송
  void _sendClickRateToServer(int clickRate) {
    print('서버로 초당 클릭 횟수 전송: $clickRate');
    // TODO: 서버로 데이터 전송 로직 추가
  }

  // 캐릭터 밀기(슬라이드 동작)
  void onSlide() {
    if (!isTilted) {
      setState(() {
        isTilted = true;
      });
      _tiltAnimationController.forward().then((_) {
        Future.delayed(const Duration(seconds: 1), () {
          resetCharacter(); // 캐릭터 초기화
        });
      });
      controller.incrementSlide(); // 슬라이드 횟수 증가
    }
  }

  // 캐릭터 초기화
  void resetCharacter() {
    _tiltAnimationController.reverse();
    setState(() {
      isTilted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcfdf7),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 레벨
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Lv. ${controller.level.value}',
                      style: TextStyle(
                        color: Color(0xFF76746D),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.40,
                      ),
                    ),
                  );
                }),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // 코인 버튼
                    Padding(
                      padding: const EdgeInsets.only(right: 7.5),
                      child: GestureDetector(
                        onTap: () {
                          controller.toQuestPage();
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
                              'assets/coin.png',
                              width: 28,
                              height: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        width: 220,
                        height: 62,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/coin_bubble.png'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0A000000),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '데일리 퀘스트를 완료하고 코인을 모아\n하트를 충전하세요!',
                            style: TextStyle(
                              color: Color(0xFF757575),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // 타이머
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/clock.png',
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  width: 6,
                ),
                Obx(() {
                  return Text(
                    formatTime(controller.timerValue.value),
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          // 하트 상태 표시
          Center(
            child: Obx(() {
              print('Obx에서 하트 개수: ${controller.heartCount.value}');
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(controller.maxHeart, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      index < controller.heartCount.value
                          ? 'assets/heart_filled.png'
                          : 'assets/heart.png',
                      width: 36,
                      height: 36,
                    ),
                  );
                }),
              );
            }),
          ),
          SizedBox(
            height: 70,
          ),
          // 캐릭터 부분
          GestureDetector(
            onTap: () {
              if (controller.timerValue.value > 0) {
                controller.incrementMotion(); // 모션 카운트 증가
                controller.changeCharacterImage(
                    'assets/touch_character.png'); // 이미지 변경
              }
              // controller.incrementTouch(); // 딱밤 횟수 증가
              // _clickCount++; // 클릭 횟수 증가
              // controller.decrementHeart(); // 하트 감소 (임시)
            },
            onPanUpdate: (details) {
              if (controller.timerValue.value > 0 &&
                  details.delta.dx.abs() > 10) {
                controller.incrementMotion(); // 슬라이드 모션
                // 좌우 슬라이드 감지
                onSlide();
                controller.changeCharacterImage(
                    'assets/slide_character.png'); // 슬라이드 이미지 변경
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 캐릭터 그림자
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 152,
                    height: 9,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFEAEBEA),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                // 캐릭터
                Obx(() {
                  return AnimatedBuilder(
                    animation: Listenable.merge([
                      _tiltAnimation,
                      _shakeAnimationController,
                    ]),
                    builder: (context, child) {
                      final shakeOffset =
                          _shakeAnimationController.value * 10.0;
                      return Transform.translate(
                        offset: Offset(
                          Random().nextDouble() * shakeOffset -
                              (shakeOffset / 2), // 좌우 흔들림
                          Random().nextDouble() * shakeOffset -
                              (shakeOffset / 2), // 상하 흔들림
                        ),
                        child: Transform.rotate(
                          angle: _tiltAnimation.value *
                              (controller.slideCount.value % 2 == 0 ? 1 : -1),
                          // 방향 전환
                          child: child,
                        ),
                      );
                    },
                    child: Image.asset(
                      controller.currentImage.value,
                      width: 177.13,
                      height: 175.86,
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // 괴롭히기 버튼 (타이머 시작)
          Obx(() {
            return GestureDetector(
              onTap: () {
                if (controller.heartCount.value > 0 &&
                    !controller.isButtonDisabled.value) {
                  startGame();
                }
              },
              child: Container(
                width: 312,
                height: 56,
                decoration: ShapeDecoration(
                  color: (controller.heartCount.value > 0 &&
                          !controller.isButtonDisabled.value)
                      ? const Color(0xFFA3BE98)
                      : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Center(
                  child: Text(
                    '괴롭히기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.40,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: const CustomBottomBar(
        currentIndex: 0,
      ),
    );
  }
}
