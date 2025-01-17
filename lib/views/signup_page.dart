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
      appBar: CustomAppBar(
        title: '로그인',
      ),
      body: Column(
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            child: TextFormField(
              onChanged: controller.idSave,
              controller: TextEditingController(text: controller.id.value),
              // focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: '이메일',
                hintStyle: const TextStyle(
                  color: Color(0xFFA2A2A2),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  letterSpacing: -0.4,
                ),
                fillColor: const Color(0xFFF2F3F5),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(52),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(52),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(52),
                ),
                // prefixIcon: const Icon(
                //   Icons.search,
                //   color: Color(0xFFA2A2A2),
                // ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            child: TextFormField(
              onChanged: controller.pwdSave,
              controller: TextEditingController(text: controller.pwd.value),
              // focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: '비밀번호',
                hintStyle: const TextStyle(
                  color: Color(0xFFA2A2A2),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  letterSpacing: -0.4,
                ),
                fillColor: const Color(0xFFF2F3F5),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(52),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(52),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(52),
                ),
                // prefixIcon: const Icon(
                //   Icons.search,
                //   color: Color(0xFFA2A2A2),
                // ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("dd"),
          ),
          ElevatedButton(
            onPressed: () {
              // print("d");
              controller.clickedNewAccount(context);
            },
            child: Text("회원가입"),
          ),
        ],
      ),
    );
  }
}
