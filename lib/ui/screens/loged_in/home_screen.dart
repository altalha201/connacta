import 'package:connacta/constants/asset_constants.dart';
import 'package:connacta/constants/color_constants.dart';
import 'package:connacta/ui/screens/loged_in/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        backgroundColor: ColorConstants.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetConstants.iconLogo),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const SettingsScreen());
            },
            icon: const Icon(
              Icons.settings,
              color: ColorConstants.black,
            ),
          ),
        ],
      ),
    );
  }
}
