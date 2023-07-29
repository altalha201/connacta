import 'package:get/get.dart';

import 'controller/data_controller/app_preferences.dart';
import 'controller/data_controller/user_preferences.dart';
import 'controller/logic_controller/chat_controller.dart';
import 'controller/logic_controller/single_chat_controller.dart';
import 'controller/logic_controller/friend_request_controller.dart';
import 'controller/logic_controller/get_own_photos_controller.dart';
import 'controller/logic_controller/login_controller.dart';
import 'controller/logic_controller/profile_data_controller.dart';
import 'controller/logic_controller/profile_view_controller.dart';
import 'controller/logic_controller/signup_controller.dart';
import 'controller/ui_controllers/home_screen_controller.dart';
import 'controller/ui_controllers/theme_controller.dart';

class ConnactaBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AppPreferences());
    Get.put(SingleChatController());
    Get.put(FriendRequestController());
    Get.put(ChatController());
    Get.put(GetOwnPhotosController());
    Get.put(HomeScreenController());
    Get.put(LoginController());
    Get.put(ProfileDataController());
    Get.put(ProfileViewController());
    Get.put(SignupController());
    Get.put(ThemeController());
    Get.put(UserPreferences());
  }
}