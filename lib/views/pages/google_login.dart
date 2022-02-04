import 'package:firebase_test/controllers/googel_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoogleLogin extends StatelessWidget {
  GoogleLogin({Key? key}) : super(key: key);
  final controller = Get.put<GoogleLoginController>(GoogleLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log In'), centerTitle: true),
      body: Center(
        child: Obx(() {
          if (controller.googleAccount.value == null) {
            return buildLoginButton();
          } else {
            return buildProfileView();
          }
        }),
      ),
    );
  }

  Column buildProfileView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage: Image.network(
            controller.googleAccount.value?.photoUrl ?? '',
          ).image,
          radius: 100.0,
        ),
        Text(
          controller.googleAccount.value?.displayName ?? '',
          style: Get.textTheme.headline2,
        ),
        Text(
          controller.googleAccount.value?.email ?? '',
          style: Get.textTheme.headline3,
        ),
        ActionChip(
          label: const Text('Logout'),
          onPressed: () => controller.logout(),
        ),
      ],
    );
  }

  FloatingActionButton buildLoginButton() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.white,
      onPressed: () => controller.login(),
      icon: const SizedBox(
        height: 40.0,
        width: 40.0,
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/google-icon.jpg'),
        ),
      ),
      label: const Text(
        'Google Sign In',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
