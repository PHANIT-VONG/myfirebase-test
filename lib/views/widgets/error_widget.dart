import 'package:firebase_test/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildError extends StatelessWidget {
  const BuildError({Key? key, this.message = 'Something went wrong'})
      : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Something went wrong'),
          const SizedBox(height: 10.0),
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
