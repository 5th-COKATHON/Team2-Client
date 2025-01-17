import 'package:flutter/material.dart';
import 'package:team2_client/components/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:team2_client/view_models/new_account_controller.dart';

class NewAccountPage extends StatefulWidget {
  const NewAccountPage({super.key});

  @override
  State<NewAccountPage> createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  final NewAccountController controller = Get.put(NewAccountController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '회원가입'),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            child: TextFormField(
              onChanged: controller.emailSave,
              controller: TextEditingController(text: controller.email.value),
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
              onChanged: controller.codeSave,
              controller: TextEditingController(text: controller.code.value),
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
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("인증코드 전송"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("확인"),
          ),
        ],
      ),
    );
  }
}
