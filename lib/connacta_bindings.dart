import 'package:get/get.dart';

import 'ui/controller/data_controller/app_preferences.dart';
import 'ui/controller/ui_controllers/home_screen_controller.dart';
import 'ui/controller/ui_controllers/theme_controller.dart';

class ConnactaBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AppPreferences());
    Get.put(HomeScreenController());
    Get.put(ThemeController());
  }
}