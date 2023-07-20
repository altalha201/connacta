import 'package:get/get.dart';

import 'controller/data_controller/app_preferences.dart';
import 'controller/data_controller/user_preferences.dart';
import 'controller/logic_controller/get_own_photos_controller.dart';
import 'controller/logic_controller/login_controller.dart';
import 'controller/logic_controller/profile_data_controller.dart';
import 'controller/logic_controller/signup_controller.dart';
import 'controller/ui_controllers/home_screen_controller.dart';
import 'controller/ui_controllers/theme_controller.dart';

class ConnactaBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AppPreferences());
    Get.put(GetOwnPhotosController());
    Get.put(HomeScreenController());
    Get.put(LoginController());
    Get.put(ProfileDataController());
    Get.put(SignupController());
    Get.put(ThemeController());
    Get.put(UserPreferences());
  }
}