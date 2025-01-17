import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team2_client/view_models/new_account/nickname_controller.dart';

class NicknamePage extends StatelessWidget {
  const NicknamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final NicknameController controller = Get.put(NicknameController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 132),
                  child: SizedBox(
                    width: 312,
                    child: Text(
                      '서비스에서 사용할\n닉네임을 입력해 주세요',
                      style: TextStyle(
                        color: Color(0xFF171717),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.40,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                // 닉네임 입력 창
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 312,
                        child: TextField(
                          controller: controller.nicknameController,
                          onChanged: (value) {
                            controller.updateNickname(value);
                          },
                          decoration: InputDecoration(
                            hintText: '닉네임을 입력해 주세요 (10자 이내)',
                            hintStyle: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 1.40,
                            ),
                            // 기본 밑줄 스타일
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFe0e0e0), // 기본 밑줄 색상
                                width: 1, // 기본 밑줄 두께
                              ),
                            ),
                            // 포커스 시 밑줄 스타일
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: controller.isNicknameValid.value
                                    ? Color(0xFFa3bf98) // 유효한 상태
                                    : Color(0xFFfd7b71), // 유효하지 않은 상태
                                width: 1, // 포커스 시 밑줄 두께
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (!controller.isNicknameValid.value &&
                          controller.nickname.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            '10자 이내의 닉네임을 입력해 주세요',
                            style: TextStyle(
                              color: Color(0xFFFD7A71),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ],
            ),
            // 시작하기 버튼
            Padding(
              padding: const EdgeInsets.only(bottom: 56),
              child: Obx(
                () => GestureDetector(
                  onTap: controller.isNicknameValid.value
                      ? () {
                          controller.toGame();
                        }
                      : null,
                  child: Container(
                    width: 312,
                    height: 56,
                    decoration: ShapeDecoration(
                      color: controller.isNicknameValid.value
                          ? Color(0xFFa3bf98) // 활성화 색상
                          : Color(0xFFE0E0E0), // 비활성화 색상
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '시작하기',
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
