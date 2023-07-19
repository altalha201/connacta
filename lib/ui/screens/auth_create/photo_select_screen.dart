import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../widgets/appbars/appbars.dart';
import '../../widgets/buttons/wide_button.dart';
import '../../widgets/space.dart';
import '../logged_in/home_screen.dart';

class PhotoSelectScreen extends StatefulWidget {
  const PhotoSelectScreen({Key? key, required this.name, required this.email}) : super(key: key);

  final String name, email;

  @override
  State<PhotoSelectScreen> createState() => _PhotoSelectScreenState();
}

class _PhotoSelectScreenState extends State<PhotoSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars.centerTitled(title: "Select Profile Photo"),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Ink(
                  color: ColorConstants.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Image.asset(
                      AssetConstants.phoneFrame2,
                      height: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 52.0, vertical: 120.0),
                  child: ListTile(
                    leading: Image.network(AssetConstants.defaultProfile, fit: BoxFit.cover,),
                    title: Text(widget.name),
                    subtitle: Text(widget.email),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                Expanded(
                  child: WideButton(
                    onPressed: () {},
                    buttonText: "Select a photo",
                  ),
                ),
                Space.horizontal(size: 8.0),
                Expanded(
                  child: WideButton(
                    onPressed: () {
                      Get.offAll(const HomeScreen());
                    },
                    buttonText: "Skip",
                    backgroundColor: ColorConstants.gray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
