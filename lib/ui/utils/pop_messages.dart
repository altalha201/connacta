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

  static void showAlertMessage({String title = "Alert", String message = "Give Your Message"}) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      contentPadding: const EdgeInsets.all(16.0),
      confirm: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text("OK", style: TextStyle(color: Colors.green),),
      ),
      radius: 8.0
    );
  }
}
