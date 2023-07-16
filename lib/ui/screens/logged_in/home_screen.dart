import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../controller/ui_controllers/home_screen_controller.dart';
import '../../controller/ui_controllers/theme_controller.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (homeController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Get.find<ThemeController>().darkMoodActivated
              ? ColorConstants.black
              : ColorConstants.white,
          elevation: 0,
          title: Text(homeController.title),
          leading: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(AssetConstants.iconLogo),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.off(const SettingsScreen());
              },
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ],
        ),
        body: homeController.currentTab,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: homeController.currentTabIndex,
          onTap: (index) {
            homeController.updateTab(index);
          },
          unselectedItemColor: ColorConstants.gray.withOpacity(0.5),
          selectedItemColor: ColorConstants.primary,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: "Chats",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              label: "People",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.amp_stories_outlined),
              label: "Stories",
            ),
          ],
        ),
      );
    });
  }
}
