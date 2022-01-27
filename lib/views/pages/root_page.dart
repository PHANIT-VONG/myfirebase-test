import 'package:firebase_test/controllers/auth_controller.dart';
import 'package:firebase_test/controllers/user_controller.dart';
import 'package:firebase_test/views/pages/login_page.dart';
import 'package:firebase_test/views/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootPage extends GetWidget<AuthController> {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: UserController(),
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user?.uid != null) {
          return MainPage(user: controller.user);
        } else {
          return LoginPage();
        }
      },
    );

    // return Obx(() {
    //   return (Get.find<AuthController>().user != null)
    //       ? MainPage(user: controller.user)
    //       : LoginPage();
    // });
  }
}
