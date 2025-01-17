import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team2_client/components/custom_bottom_bar.dart';
import 'package:team2_client/view_models/chat_controller.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 79),
            child: Container(
              width: 240,
              height: 80,
              decoration: ShapeDecoration(
                color: Color(0xFFFBF9F3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Center(
                  child: Obx(
                () => Text(
                  controller.messageText.value,
                  // '하고 싶은 말 있으면 뭐든지 해봐.',
                  style: TextStyle(
                    color: Color(0xFF504F4A),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.60,
                  ),
                ),
              )),
            ),
          ),
          SizedBox(
            height: 48,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 41),
            child: Image.asset(
              'assets/chat_character.png',
              width: 128,
              height: 127,
            ),
          ),
          SizedBox(
            height: 86,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                width: 312,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFA3BE98)),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x4CE3EE93),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: // 텍스트 입력창
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        width: 240,
                        child: Expanded(
                            child: TextField(
                          controller: controller.messageController,
                          onChanged: (value) {
                            controller.updateMessage(value);
                          },
                          decoration: InputDecoration(
                            hintText: '여러분의 감정을 공유해 주세요',
                            hintStyle: const TextStyle(
                              color: Color(0xFFA2A2A2),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.40,
                            ),
                            border: InputBorder.none,
                          ),
                          maxLines: 3, // 최대 줄 수
                          minLines: 1, // 최소 줄 수
                        )),
                      ),
                    ),
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.chatResponseApi();
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: ShapeDecoration(
                              color: controller.messageText.value.isNotEmpty
                                  ? Color(0xFFA3BE98)
                                  : Color(0xFFE0E0E0),
                              shape: OvalBorder(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 7,
                                top: 6,
                                left: 5,
                                bottom: 5,
                              ),
                              child: Image.asset(
                                'assets/send.png',
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(currentIndex: 2),
    );
  }
}
