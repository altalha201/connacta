import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/logic_controller/profile_data_controller.dart';
import '../../../../data/model/message_model.dart';
import '../../../../data/model/user_chat_info_model.dart';
import '../../../../data/model/user_info_model.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/list_item/chat_list_item.dart';
import '../../../widgets/loading_widgets/chat_list_loading.dart';

class ChatListTab extends StatefulWidget {
  const ChatListTab({Key? key}) : super(key: key);

  @override
  State<ChatListTab> createState() => _ChatListTabState();
}

class _ChatListTabState extends State<ChatListTab> {
  final _storageRef = FirebaseFirestore.instance
      .collection("user_items")
      .doc("chats")
      .collection(Get.find<ProfileDataController>().currentUser.userId ?? "");

  final List<UserChatInfoModel> _chats = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _storageRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ChatListLoading();
        }

        if (snapshot.hasData) {
          _chats.clear();
          for (var doc in snapshot.data!.docs) {
            var chat = UserChatInfoModel(
              roomId: doc.get("room_id"),
              roomType: doc.get("room_type"),
              latestMessageTime: doc.get("latest_message_time"),
              user: UserInfoModel.fromJson(doc.get("user")),
              latestMessage: MessageModel.fromJson(doc.get("latest_message")),
            );
            _chats.add(chat);
          }

          _chats.sort(
              (b, a) => a.latestMessageTime!.compareTo(b.latestMessageTime!));

          if(_chats.isEmpty) {
            return Center(
              child: Text(
                "No Chats Yet.",
                style: TextStyles.usernameStyle,
              ),
            );
          }

          return ListView.builder(
            itemCount: _chats.length,
            itemBuilder: (context, index) {
              return ChatListItem(chatInfo: _chats.elementAt(index),);
            },
          );
        } else {
          return Center(
            child: Text(
              "No Chats Yet.",
              style: TextStyles.usernameStyle,
            ),
          );
        }
      },
    );
  }
}
