import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:team2_client/view_models/motion_controller.dart';

class MotionTest extends StatefulWidget {
  const MotionTest({super.key});

  @override
  State<MotionTest> createState() => _MotionTestState();
}

class _MotionTestState extends State<MotionTest> with TickerProviderStateMixin {
  // 변경: SingleTickerProviderStateMixin → TickerProviderStateMixin
  final MotionController controller = Get.put(MotionController());

  late Timer _clickTimer; // 초당 클릭 횟수 측정용 타이머
  int _clickCount = 0; // 현재 초당 클릭 횟수 카운트
  late AnimationController _tiltAnimationController; // 캐릭터 기울기 애니메이션 컨트롤러
  late Animation<double> _tiltAnimation; // 캐릭터 기울기 애니메이션
  late AnimationController _shakeAnimationController; // 흔들기 애니메이션 컨트롤러
  bool isTilted = false; // 캐릭터가 쓰러졌는지 여부

  @override
  void initState() {
    super.initState();

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
    super.dispose();
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
      appBar: AppBar(
        title: const Text("감정 해소 테스트"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.reset();
              resetCharacter(); // 캐릭터 초기화
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              controller.incrementTouch(); // 딱밤 횟수 증가
              _clickCount++; // 클릭 횟수 증가
            },
            onPanUpdate: (details) {
              if (details.delta.dx.abs() > 10) {
                // 좌우 슬라이드 감지
                onSlide();
              }
            },
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _tiltAnimation,
                _shakeAnimationController,
              ]),
              builder: (context, child) {
                final shakeOffset = _shakeAnimationController.value * 10.0;
                return Transform.translate(
                  offset: Offset(
                    Random().nextDouble() * shakeOffset -
                        (shakeOffset / 2), // 좌우 흔들림
                    Random().nextDouble() * shakeOffset -
                        (shakeOffset / 2), // 상하 흔들림
                  ),
                  child: Transform.rotate(
                    angle: _tiltAnimation.value *
                        (controller.slideCount.value % 2 == 0
                            ? 1
                            : -1), // 방향 전환
                    child: child,
                  ),
                );
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "캐릭터",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Obx(() => Text(
                controller.actionMessage.value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 20),
          Obx(() => Text(
                "딱밤: ${controller.touchCount.value}번\n"
                "밀기: ${controller.slideCount.value}번\n"
                "흔들기: ${controller.shakeCount.value}번",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              )),
        ],
      ),
    );
  }
}
