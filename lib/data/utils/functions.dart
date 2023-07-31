import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
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
    var chatID = await Get.find<SingleChatController>()
        .findChatRoom(p1: p1.userId!, p2: p2.userId!);

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

  static Future<void> sendImgMsg({
    required ImageSource source,
    required String chatID,
  }) async {
    XFile? pickedImg = await ImagePicker().pickImage(
      source: source,
      imageQuality: 25,
      maxWidth: 525,
      maxHeight: 525,
    );

    if (pickedImg != null) {
      String imgUtl = await StorageHelper().uploadImage(
          "${Paths.chatImages}$chatID/${pickedImg.name}", File(pickedImg.path));

      Get.find<ChatController>()
          .sendMessage(type: "img", mMessage: imgUtl, chatID: chatID);
    }
  }

  static Future<void> downloadImage({required String imageURL}) async {
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/Connacta/${getRandomString(10)}.png';
    await Dio().download(imageURL, path);

    await GallerySaver.saveImage(path, albumName: "Connacta");

    Fluttertoast.showToast(msg: "Image Save to Gallery");
  }

  static String getRandomString(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(
          rnd.nextInt(chars.length),
        ),
      ),
    );
  }
}
