import 'package:connacta/ui/screens/logged_in/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../controller/ui_controllers/theme_controller.dart';
import '../../widgets/list_item/settings_list_item.dart';
import '../../widgets/space.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Me"),
        leading: BackButton(
          onPressed: () {
            Get.off(const HomeScreen());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: ColorConstants.white,
                  image: const DecorationImage(
                    image: NetworkImage(AssetConstants.defaultProfile),
                  ),
                ),
              ),
              Space.vertical(size: 16.0),
              const Text(
                "Name",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w200,
                  fontFamily: 'barlow',
                ),
              ),
              Space.vertical(size: 32.0),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Profile Settings",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Space.vertical(size: 8.0),
              const SettingsListItem(
                leadingIcon: Icons.person,
                title: 'Profile Info Update',
                startItem: true,
              ),
              const SettingsListItem(
                  leadingIcon: Icons.image_outlined,
                  title: "Update Profile Picture"),
              const SettingsListItem(
                  leadingIcon: Icons.password, title: "Update Password"),
              const SettingsListItem(
                leadingIcon: Icons.book_outlined,
                title: "Stories Archives",
                lastItem: true,
              ),
              Space.vertical(size: 16.0),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "App Settings",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Space.vertical(size: 8.0),
              SettingsListItem(
                leadingIcon: Icons.brightness_4_outlined,
                title: "Dark Mood",
                startItem: true,
                tailingWidget: SizedBox(
                  height: 15,
                  child: GetBuilder<ThemeController>(
                    builder: (controller) {
                      return CupertinoSwitch(
                        value: controller.darkMoodActivated,
                        thumbColor: ColorConstants.primary,
                        activeColor: ColorConstants.secondary,
                        onChanged: (value) {
                          if(value) {
                            controller.activateDarkMood();
                          } else {
                            controller.deactivateDarkMood();
                          }
                          // print(Get.isDarkMode);
                          // /*Get.changeTheme(Get.isDarkMode
                          //     ? AppTheme.lightTheme
                          //     : AppTheme.darkTheme);
                          // print(Get.isDarkMode);*/
                          // Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                          // print(Get.isDarkMode);

                        },
                      );
                    }
                  ),
                ),
              ),
              const SettingsListItem(
                  leadingIcon: Icons.feedback_outlined, title: "Send Feedback"),
              const SettingsListItem(
                leadingIcon: Icons.info_outline,
                title: "About Us",
                lastItem: true,
              ),
              Space.vertical(size: 16.0),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Space.vertical(size: 8.0),
              const SettingsListItem(
                leadingIcon: Icons.logout,
                title: "Logout",
                startItem: true,
                lastItem: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
