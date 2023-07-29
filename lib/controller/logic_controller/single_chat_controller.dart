import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../data/model/single_chat_model.dart';
import '../../data/model/user_chat_info_model.dart';
import '../../data/model/user_info_model.dart';

class SingleChatController extends GetxController {
  final _storageRef = FirebaseFirestore.instance;

  Future<String?> findChatRoom({
    required String p1,
    required String p2,
  }) async {
    final List<SingleChatModel> listOfData = [];
    await _storageRef
        .collection("chat_rooms")
        .where("p_one", isEqualTo: p1)
        .get()
        .then((value) {
      final data = value.docs;
      if (data.isNotEmpty) {
        for (var element in data) {
          var room = SingleChatModel.fromJson(element.data());
          listOfData.add(room);
        }
      }
    });
    await _storageRef
        .collection("chat_rooms")
        .where("p_two", isEqualTo: p1)
        .get()
        .then((value) {
      final data = value.docs;
      if (data.isNotEmpty) {
        for (var element in data) {
          var room = SingleChatModel.fromJson(element.data());
          listOfData.add(room);
        }
      }
    });
    log(listOfData.toString());
    String? returnStr;
    for (var element in listOfData) {
      if ((element.participantOne == p1 && element.participantTwo == p2) ||
          (element.participantOne == p2 && element.participantTwo == p1)) {
        returnStr = element.roomId;
        break;
      }
    }

    if (returnStr != null) {
      return returnStr;
    }

    return null;
  }

  Future<String> createChatRoom({
    required UserInfoModel p1,
    required UserInfoModel p2,
  }) async {
    final newChatRoom = SingleChatModel(
        roomId: const Uuid().v1(),
        roomType: 'single',
        participantOne: p1.userId,
        participantTwo: p2.userId,
        createdTime: DateTime.now().toString());

    await _storageRef
        .collection("chat_rooms")
        .doc(newChatRoom.roomId)
        .set(newChatRoom.toJson());

    final chatInfo = UserChatInfoModel(
      roomId: newChatRoom.roomId,
      roomType: newChatRoom.roomType,
      latestMessageTime: newChatRoom.createdTime,
    );

    chatInfo.user = p2;

    await _storageRef
        .collection("user_items")
        .doc("chats")
        .collection(p1.userId!)
        .doc(chatInfo.roomId)
        .set(chatInfo.toJson());

    chatInfo.user = p1;

    await _storageRef
        .collection("user_items")
        .doc("chats")
        .collection(p2.userId!)
        .doc(chatInfo.roomId)
        .set(chatInfo.toJson());

    return newChatRoom.roomId!;
  }
}
