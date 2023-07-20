import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopMessages {
  static void showSnackBarMessage(
      {String? title, String? messages, int sec = 3}) {
    Get.showSnackbar(GetSnackBar(
      title: title,
      message: messages,
      duration: Duration(seconds: sec),
    ));
  }

  static void showAlertMessage(
      {String title = "Alert",
      String message = "Give Your Message",
      String confirmText = "OK",
      Color confirmColor = Colors.green,
      Widget? content}) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      contentPadding: const EdgeInsets.all(16.0),
      confirm: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          confirmText,
          style: TextStyle(color: confirmColor),
        ),
      ),
      radius: 8.0,
      content: content,
    );
  }
}
