import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../ui/screens/login_screen.dart';
import '../ui_controllers/home_screen_controller.dart';

class UserPreferences extends GetxController {
  String? _userID;

  String? get userID => _userID;

  bool isLogIn() {
    return _userID != null;
  }

  void saveUserID(String uID) {
    _userID = uID;
    GetStorage().write("connacta_user", uID);
  }

  void getUserID() {
    _userID = GetStorage().read("connacta_user");
  }

  void logOut() {
    GetStorage().remove("connacta_user");
    _userID = null;
    Get.find<HomeScreenController>().resetHome();
    Get.offAll(const LoginScreen());
  }
}