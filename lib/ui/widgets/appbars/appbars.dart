import 'package:flutter/material.dart';

class Appbars {
  static AppBar centerTitled({required String title, bool? leadBackButton}) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: leadBackButton ?? false,
      centerTitle: true,
    );
  }
}