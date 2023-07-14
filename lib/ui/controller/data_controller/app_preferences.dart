import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppPreferences extends GetxController {
  bool? _appTheme;

  bool? get appTheme => _appTheme;

  void getAppTheme() {
    _appTheme = GetStorage().read('connacta_theme');
  }

  void setAppTheme(bool theme) {
    _appTheme = theme;
    GetStorage().write('connacta_theme', theme);
  }
}