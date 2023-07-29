import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/paths.dart';
import '../../controller/logic_controller/chat_controller.dart';
import '../../controller/logic_controller/single_chat_controller.dart';
import '../../ui/screens/logged_in/chat_screen.dart';
import '../model/user_info_model.dart';
import '../services/storage_helper.dart';

class Functions {
  static Future<void> gotoChatRoom({
    required UserInfoModel p1,
    required UserInfoModel p2,
  }) async {
    var chatID =
        await Get.find<SingleChatController>().findChatRoom(p1: p1.userId!, p2: p2.userId!);

    if (chatID != null) {
      Get.to(ChatScreen(
        roomID: chatID,
      ));
    } else {
      chatID =
          await Get.find<SingleChatController>().createChatRoom(p1: p1, p2: p2);
      Get.to(ChatScreen(roomID: chatID));
    }
  }

  static Future<void> sendImgMsg(
      {required ImageSource source, required String chatID}) async {
    XFile? pickedImg = await ImagePicker().pickImage(
      source: source,
      imageQuality: 25,
      maxWidth: 525,
      maxHeight: 525,
    );

    if (pickedImg != null) {
      String imgUtl = await StorageHelper().uploadImage(
          "${Paths.chatImages}$chatID/${pickedImg.name}", File(pickedImg.path));

      Get.find<ChatController>().sendMessage(type: "img", mMessage: imgUtl, chatID: chatID);
    }
  }
}
