import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../controller/data_controller/user_preferences.dart';
import '../../../controller/logic_controller/profile_data_controller.dart';
import '../../../controller/ui_controllers/theme_controller.dart';
import '../../widgets/list_item/settings_list_item.dart';
import '../../widgets/picture_widgets/display_picture.dart';
import '../../widgets/space.dart';
import '../auth_create/photo_select_screen.dart';
import 'home_screen.dart';
import 'profile_pictures_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final profileDataInstance = Get.find<ProfileDataController>();

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
              const DisplayPicture(),
              Space.vertical(size: 16.0),
              Text(
                profileDataInstance.currentUser.userName ?? "Name",
                style: const TextStyle(
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
              SettingsListItem(
                leadingIcon: Icons.change_circle_outlined,
                title: "Update Profile Picture",
                onTap: () {
                  Get.to(
                    PhotoSelectScreen(
                      name: profileDataInstance.currentUser.userName ?? "",
                      email: profileDataInstance.currentUser.userEmail ?? "",
                      imgURL: profileDataInstance.currentUser.userDpUrl ??
                          AssetConstants.defaultProfile,
                      fromSettings: true,
                    ),
                  );
                },
              ),
              const SettingsListItem(
                leadingIcon: Icons.password,
                title: "Update Password",
              ),
              SettingsListItem(
                leadingIcon: Icons.image_outlined,
                title: "My Profile Pictures",
                onTap: () {
                  Get.to(const ProfilePictureScreen());
                },
              ),
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
                  child: GetBuilder<ThemeController>(builder: (controller) {
                    return CupertinoSwitch(
                      value: controller.darkMoodActivated,
                      thumbColor: ColorConstants.primary,
                      activeColor: ColorConstants.secondary,
                      onChanged: (value) {
                        if (value) {
                          controller.activateDarkMood();
                        } else {
                          controller.deactivateDarkMood();
                        }
                      },
                    );
                  }),
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
              SettingsListItem(
                leadingIcon: Icons.logout,
                title: "Logout",
                startItem: true,
                lastItem: true,
                onTap: () {
                  Get.find<UserPreferences>().logOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
