import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/logged_in/home_screen.dart';

class Appbars {
  static AppBar centerTitled({required String title, bool? leadBackButton}) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: leadBackButton ?? false,
      centerTitle: true,
    );
  }

  static AppBar backButtonAppbar({required String title,}) {
    return AppBar(
      title: Text(title),
      leading: BackButton(
        onPressed: () {
          Get.off(const HomeScreen());
        },
      ),
    );
  }
}