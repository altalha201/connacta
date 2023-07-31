import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../data/model/message_model.dart';
import '../../data/model/single_chat_model.dart';
import '../../data/model/user_info_model.dart';
import 'profile_data_controller.dart';

class ChatController extends GetxController {
  bool _gettingChat = false;
  String _recipientName = "";
  String _recipientImg = "";
  String _recipientID = "";

  bool get gettingChat => _gettingChat;

  String get recipientName => _recipientName;

  String get recipientImg => _recipientImg;

  String get recipientID => _recipientID;

  final _storageInstance = FirebaseFirestore.instance;

  Future<void> getChatProfile({
    required String chatID,
  }) async {
    _gettingChat = true;
    update();
    _clearData();
    String? senderID;
    await _storageInstance
        .collection("chat_rooms")
        .doc(chatID)
        .get()
        .then((value) {
      if (value.data() != null) {
        var chatRoom = SingleChatModel.fromJson(value.data()!);
        if (chatRoom.participantOne !=
            Get.find<ProfileDataController>().currentUser.userId) {
          senderID = chatRoom.participantOne;
        }
        if (chatRoom.participantTwo !=
            Get.find<ProfileDataController>().currentUser.userId) {
          senderID = chatRoom.participantTwo;
        }
      }
    });
    if (senderID != null) {
      await _getUser(senderID);
    }

    _gettingChat = false;
    update();
  }

  Future<void> _getUser(String? userID) async {
    await _storageInstance
        .collection("search_user")
        .doc(userID)
        .get()
        .then((value) {
      if (value.data() != null) {
        var user = UserInfoModel.fromJson(value.data()!);
        _recipientName = user.userName ?? "";
        _recipientImg = user.userImg ?? "";
        _recipientID = userID ?? "";
      }
    });
  }

  void _clearData() {
    _recipientName = "";
    _recipientImg = "";
    _recipientID = "";
    update();
  }

  Future<void> sendMessage(
      {required String type,
      required String mMessage,
      required String chatID}) async {
    var currentUser = Get.find<ProfileDataController>().currentUser;
    var message = MessageModel(
      messageId: const Uuid().v1(),
      chatID: chatID,
      senderId: currentUser.userId,
      senderName: currentUser.userName,
      senderDpUrl: currentUser.userDpUrl,
      messageType: type,
      mainMessage: mMessage,
      createdTime: DateTime.now().toString(),
    );
    await _storageInstance
        .collection("chat_rooms")
        .doc(chatID)
        .collection("messages")
        .doc(message.messageId)
        .set(message.toJson());

    await _updateLatestMessage(chatID, message);
  }

  Future<void> _updateLatestMessage(String chatID, MessageModel message) async {
    await _storageInstance
        .collection("user_items")
        .doc("chats")
        .collection(Get.find<ProfileDataController>().currentUser.userId ?? "")
        .doc(chatID)
        .update({
      "latest_message": message.toJson(),
      "latest_message_time": message.createdTime,
    });

    await _storageInstance
        .collection("user_items")
        .doc("chats")
        .collection(_recipientID)
        .doc(chatID)
        .update({
      "latest_message": message.toJson(),
      "latest_message_time": message.createdTime
    });
  }
}
