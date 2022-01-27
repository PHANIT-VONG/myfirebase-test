import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  // Get the instance of GetStorage
  final _box = GetStorage();
  final _key = 'isDarkMode';

  // Get the them mode from local Storage
  bool _loadTheme() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;

  void saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);
  void changeTheme(ThemeData themeData) => Get.changeTheme(themeData);
  void changeThemeMode(ThemeMode themeMode) => Get.changeThemeMode(themeMode);
}
