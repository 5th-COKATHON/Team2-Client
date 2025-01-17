import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class StartController extends GetxController {
  void clickedStartBtn(BuildContext context) {
    Get.offNamed('/signup');
  }
}
