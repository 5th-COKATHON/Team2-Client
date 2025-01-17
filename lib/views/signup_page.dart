import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team2_client/components/custom_app_bar.dart';
import 'package:team2_client/view_models/signup_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FocusNode _focusNode = FocusNode();
  final SignupController controller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: CustomAppBar(
      //   title: '로그인',
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   width: 200,
              //   child: Obx(() {
              //     return TextField(
              //       onChanged: controller.test,
              //       controller: TextEditingController(text: controller.id.value),
              //       maxLines: 1,
              //       decoration: InputDecoration(
              //         border: OutlineInputBorder(
              //           borderSide: BorderSide(color: Colors.black),
              //         ),
              //         // hintText: '한 줄 소개를 입력하세요.',
              //       ),
              //     );
              //   }),
              // ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 160,
                height: 60,
                color: Colors.grey,
              ),
              SizedBox(
                height: 38,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 48,
                width: 312,
                child: TextFormField(
                  onChanged: controller.idSave,
                  controller: TextEditingController(text: controller.id.value),
                  // focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: '이메일을 입력해주세요',
                    hintStyle: const TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      letterSpacing: -0.4,
                    ),
                    fillColor: Colors.white, // 배경색을 흰색으로 변경
                    filled: true,
                    border: const UnderlineInputBorder(
                      // 아래에만 테두리 추가
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      // 활성화된 상태에서 아래에만 테두리
                      borderSide:
                          BorderSide(color: Color(0xFFE0E0E0)), // 아래에 검은색 테두리
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      // 포커스 상태에서 아래에만 테두리
                      borderSide:
                          BorderSide(color: Color(0xFFA3BF98)), // 아래에 검은색 테두리
                    ),
                    // prefixIcon: const Icon(
                    //   Icons.search,
                    //   color: Color(0xFFA2A2A2),
                    // ),
                  ),
                ),
              ),
              SizedBox(
                height: 19,
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 48,
                width: 312,
                child: TextFormField(
                  onChanged: controller.pwdSave,
                  controller: TextEditingController(text: controller.pwd.value),
                  // focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: '비밀번호를 입력해주세요',
                    hintStyle: const TextStyle(
                      color: Color(0xFFA2A2A2),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      letterSpacing: -0.4,
                    ),
                    fillColor: Colors.white, // 배경색을 흰색으로 변경
                    filled: true,
                    border: const UnderlineInputBorder(
                      // 아래에만 테두리 추가
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      // 활성화된 상태에서 아래에만 테두리
                      borderSide:
                          BorderSide(color: Color(0xFFE0E0E0)), // 아래에 검은색 테두리
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      // 포커스 상태에서 아래에만 테두리
                      borderSide:
                          BorderSide(color: Color(0xFFA3BF98)), // 아래에 검은색 테두리
                    ),
                    // prefixIcon: const Icon(
                    //   Icons.search,
                    //   color: Color(0xFFA2A2A2),
                    // ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text("dd"),
              // ),
              // Obx(
              //   () => GestureDetector(
              //     onTap: controller.isButtonEnabled.value
              //         ? () {
              //             // 로그인 동작 실행
              //           }
              //         : null,
              //     child: Container(
              //       width: 312,
              //       height: 56,
              //       decoration: BoxDecoration(
              //         color: controller.isButtonEnabled.value
              //             ? Color(0xFFA3BF98)
              //             : Color(0xFFE0E0E0), // 비활성화 상태일 때 색상
              //         borderRadius: BorderRadius.circular(16),
              //       ),
              //       child: Center(
              //         child: Text(
              //           "로그인하기",
              //           style: TextStyle(
              //             fontSize: 16,
              //             color: Colors.white,
              //             height: 1.4,
              //             fontWeight: FontWeight.w700,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {},
              //   child: Container(
              //     width: 312,
              //     height: 56,
              //     decoration: BoxDecoration(
              //       color: Color.fromARGB(255, 255, 255, 255),
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     child: Center(
              //       child: Text(
              //         "회원가입",
              //         style: TextStyle(
              //             fontSize: 16,
              //             color: Color(0xFF757575),
              //             height: 1.4,
              //             fontWeight: FontWeight.w700),
              //       ),
              //     ),
              //   ),
              // ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom +
                        16, // 키보드 높이 + 여백
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // 콘텐츠 크기에 맞게 높이 조정
                    children: [
                      Obx(
                        () => GestureDetector(
                          onTap: controller.isButtonEnabled.value
                              ? () {
                                  // 로그인 동작 실행
                                  controller.testApi();
                                  print("dd");
                                }
                              : null,
                          child: Container(
                            width: 312,
                            height: 56,
                            decoration: BoxDecoration(
                              color: controller.isButtonEnabled.value
                                  ? Color(0xFFA3BF98)
                                  : Color(0xFFE0E0E0), // 비활성화 상태일 때 색상
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                "로그인하기",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  height: 1.4,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          // 회원가입 동작 실행
                        },
                        child: Container(
                          width: 312,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              "회원가입",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF757575),
                                height: 1.4,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
