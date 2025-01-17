import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team2_client/view_models/new_account/password_confirm_controller.dart';

class PasswordConfirmPage extends StatelessWidget {
  const PasswordConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PasswordConfirmController controller =
        Get.put(PasswordConfirmController());

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
                      '회원가입 완료',
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
                // 비밀번호 입력 창

                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         SizedBox(
                //           width: 312,
                //           child: Obx(() {
                //             return TextField(
                //               controller: controller.passwordController,
                //               onChanged: (value) {
                //                 controller.updateEmail(value);
                //               },
                //               obscureText: !controller
                //                   .isPasswordVisible.value, // 비밀번호 가시성 설정
                //               decoration: InputDecoration(
                //                 hintText: '비밀번호를 입력해 주세요',
                //                 hintStyle: TextStyle(
                //                   color: Color(0xFF9E9E9E),
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.w400,
                //                   height: 1.40,
                //                 ),
                //                 // 기본 밑줄 스타일
                //                 enabledBorder: UnderlineInputBorder(
                //                   borderSide: BorderSide(
                //                     color: Color(0xFFe0e0e0), // 기본 밑줄 색상
                //                     width: 1, // 기본 밑줄 두께
                //                   ),
                //                 ),
                //                 // 포커스 시 밑줄 스타일
                //                 focusedBorder: UnderlineInputBorder(
                //                   borderSide: BorderSide(
                //                     color: Color(0xFFa3bf98),
                //                     width: 1, // 포커스 시 밑줄 두께
                //                   ),
                //                 ),
                //                 // 비밀번호 가시성 토글 아이콘 추가
                //                 suffixIcon: IconButton(
                //                   icon: Icon(
                //                     controller.isPasswordVisible.value
                //                         ? Icons.visibility_outlined // 가시성 ON
                //                         : Icons.visibility_off_outlined, // 가시성 OFF
                //                     color: Color(0xFF9E9E9E),
                //                   ),
                //                   onPressed: () {
                //                     controller.isPasswordVisible.value =
                //                         !controller.isPasswordVisible.value;
                //                   },
                //                 ),
                //               ),
                //             );
                //           }),
                //         ),
                //       ],
                //     ),
              ],
            ),
            // 다음으로 버튼
            Padding(
              padding: const EdgeInsets.only(bottom: 56),
              child: Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.toNickname();
                  },
                  child: Container(
                    width: 312,
                    height: 56,
                    decoration: ShapeDecoration(
                      color: controller.password.value != ""
                          ? Color(0xFFa3bf98) // 활성화 색상
                          : Color(0xFFE0E0E0), // 비활성화 색상
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '다음으로',
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
