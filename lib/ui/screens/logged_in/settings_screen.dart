import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../controller/data_controller/user_preferences.dart';
import '../../../controller/logic_controller/profile_data_controller.dart';
import '../../../controller/ui_controllers/theme_controller.dart';
import '../../utils/pop_messages.dart';
import '../../utils/text_styles.dart';
import '../../widgets/appbars/appbars.dart';
import '../../widgets/list_item/settings_list_item.dart';
import '../../widgets/picture_widgets/display_picture.dart';
import '../../widgets/picture_widgets/image_view.dart';
import '../../widgets/space.dart';
import '../auth_create/photo_select_screen.dart';
import 'profile_pictures_screen.dart';
import 'profile_view.dart';

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
      appBar: Appbars.backButtonAppbar(title: "Me"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DisplayPicture(
                imgURL: profileDataInstance.currentUser.userDpUrl ??
                    AssetConstants.defaultProfile,
                onPress: () {
                  Get.bottomSheet(
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: Get.find<ThemeController>().darkMoodActivated
                            ? ColorConstants.black
                            : ColorConstants.white,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text("View Profile Picture"),
                            leading: const Icon(Icons.image_outlined),
                            tileColor: ColorConstants.gray.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onTap: () {
                              Get.to(ImageView(
                                image:
                                    profileDataInstance.currentUser.userDpUrl ??
                                        AssetConstants.defaultProfile,
                              ));
                            },
                          ),
                          Space.vertical(size: 8.0),
                          ListTile(
                            title: const Text("View Profile"),
                            leading: const Icon(Icons.person),
                            tileColor: Colors.grey.shade500,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onTap: () {
                              Get.to(ProfileView(
                                userId:
                                    profileDataInstance.currentUser.userId ??
                                        "",
                                selfProfile: true,
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Space.vertical(size: 16.0),
              Text(profileDataInstance.currentUser.userName ?? "Name",
                  style: TextStyles.titleNameStyle),
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
                  PopMessages.yesNoDialog(
                    title: "Log out",
                    message: "Want to log out?",
                    onNo: () {
                      Get.back();
                    },
                    onYes: () {
                      Get.find<UserPreferences>().logOut();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
