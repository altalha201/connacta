import 'package:connacta/ui/controller/data_controller/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController{
  bool _darkMoodActivated = false;

  bool get darkMoodActivated => _darkMoodActivated;

  void activateDarkMood() {
    _darkMoodActivated = true;
    Get.changeThemeMode(ThemeMode.dark);
    Get.find<AppPreferences>().setAppTheme(true);
    update();
  }

  void deactivateDarkMood() {
    _darkMoodActivated = false;
    Get.changeThemeMode(ThemeMode.light);
    Get.find<AppPreferences>().setAppTheme(false);
    update();
  }

  void setTheme(bool theme) {
    _darkMoodActivated = theme;
    Get.changeThemeMode(theme ? ThemeMode.dark : ThemeMode.light);
    update();
  }
}