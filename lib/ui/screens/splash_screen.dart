import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/asset_constants.dart';
import '../../controller/data_controller/app_preferences.dart';
import '../../controller/data_controller/user_preferences.dart';
import '../../controller/logic_controller/profile_data_controller.dart';
import '../../controller/ui_controllers/theme_controller.dart';
import 'logged_in/home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) async {
      Get.find<AppPreferences>().getAppTheme();
      if(Get.find<AppPreferences>().appTheme != null) {
        Get.find<ThemeController>().setTheme(Get.find<AppPreferences>().appTheme!);
      } else {
        var brightness = MediaQuery.of(context).platformBrightness;
        Get.find<ThemeController>().setTheme(brightness == Brightness.dark);
      }
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = true;
        });
        Future.delayed(const Duration(seconds: 2)).then((value) async {
          if(Get.find<UserPreferences>().isLogIn()) {
            await Get.find<ProfileDataController>().getUser();
            Get.offAll(const HomeScreen(), transition: Transition.downToUp);
          } else {
            Get.offAll(const LoginScreen(), transition: Transition.downToUp);
          }
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  AssetConstants.iconLogo,
                  width: 180,
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              replacement: const SizedBox.shrink(),
              child: const SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            ),
            Visibility(
              visible: isLoading,
              replacement: const SizedBox.shrink(),
              child: const SizedBox(
                height: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
