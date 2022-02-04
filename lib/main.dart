import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test/controllers/bindings/auth_binding.dart';
import 'package:firebase_test/controllers/theme_controller.dart';
import 'package:firebase_test/views/pages/google_login.dart';
import 'package:firebase_test/views/pages/root_page.dart';
import 'package:firebase_test/views/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeController = Get.put<ThemeController>(ThemeController());
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
      themeMode: _themeController.theme,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      title: 'Flutter Firebase Test',
      //home: const RootPage(),
      home: GoogleLogin(),
    );
  }
}
