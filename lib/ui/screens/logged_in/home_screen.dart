import 'package:connacta/ui/controller/ui_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.find<ThemeController>().darkMoodActivated
            ? ColorConstants.black
            : ColorConstants.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetConstants.iconLogo),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.off(const SettingsScreen());
            },
            icon: Icon(
              Icons.settings,
              color: Get.find<ThemeController>().darkMoodActivated
                  ? ColorConstants.white
                  : ColorConstants.black,
            ),
          ),
        ],
      ),
    );
  }
}
