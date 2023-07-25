import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_constants.dart';
import '../../controller/logic_controller/friend_request_controller.dart';
import '../../controller/ui_controllers/theme_controller.dart';
import '../../data/model/user_info_model.dart';
import '../screens/logged_in/home_screen.dart';
import '../screens/logged_in/profile_view.dart';
import '../widgets/buttons/wide_icon_elevated_button.dart';
import '../widgets/space.dart';

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

  static void friendRequestResponse({required UserInfoModel sender}) {
    Get.bottomSheet(
      Container(
        height: 180,
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Get.find<ThemeController>().darkMoodActivated
              ? ColorConstants.black
              : ColorConstants.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          children: [
            WideIconElevatedButton(
              onPressed: () async {
                Get.back();
                await Get.find<FriendRequestController>()
                    .acceptRequest(sender: sender);
                Future.delayed(const Duration(seconds: 2))
                    .then((value) => Get.offAll(const HomeScreen()));
              },
              icon: const Icon(Icons.check_circle_outline, size: 32,),
              labelText: 'Confirm Request',
              backgroundColor: ColorConstants.green,
            ),
            Space.vertical(size: 16.0),
            WideIconElevatedButton(
              icon: const Icon(Icons.cancel_outlined, size: 32,),
              labelText: "Cancel Request",
              onPressed: () async {
                Get.back();
                await Get.find<FriendRequestController>()
                    .cancelRequest(senderID: sender.userId ?? "");
                Get.offUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfileView(userId: sender.userId ?? "")),
                    (route) => false);
              },
              backgroundColor: ColorConstants.red,
            ),
          ],
        ),
      ),
    );
  }
}
