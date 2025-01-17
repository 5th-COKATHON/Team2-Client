import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:team2_client/view_models/start_controller.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final StartController controller = Get.put(StartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/start.svg",
              fit: BoxFit.cover, // 화면 크기에 맞게 배경 조정
            ),
          ),
          Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/logo.png"),
                  SizedBox(
                    height: 412,
                  ),
                  Positioned(
                    bottom: 30,
                    left: 24,
                    right: 24,
                    child: GestureDetector(
                      onTap: () {
                        controller.clickedStartBtn(context);
                      },
                      child: Container(
                        width: 300,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Color(0xFFA3BF98),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            "로그인하기",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                height: 1.4,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
