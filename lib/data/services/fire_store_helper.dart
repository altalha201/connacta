import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../ui/utils/pop_messages.dart';

class FireStoreHelper {
  final _database = FirebaseFirestore.instance;

  void deleteMessage(String chatId, String messageID) {
    PopMessages.yesNoDialog(
      title: "Delete Message",
      message: "Want to delete this message?",
      onNo: () {
        Get.back();
      },
      onYes: () async {
        await _database
            .collection("chat_rooms")
            .doc(chatId)
            .collection("messages")
            .doc(messageID)
            .delete();
      }
    );
  }
}
