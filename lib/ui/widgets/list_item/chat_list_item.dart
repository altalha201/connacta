import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/color_constants.dart';
import '../../../controller/logic_controller/profile_data_controller.dart';
import '../../../data/model/user_chat_info_model.dart';
import '../../screens/logged_in/chat_screen.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    Key? key,
    required this.chatInfo,
  }) : super(key: key);

  final UserChatInfoModel chatInfo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(ChatScreen(
          roomID: chatInfo.roomId ?? "",
        ));
      },
      leading: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(52),
            image: DecorationImage(
              image: NetworkImage(
                chatInfo.user?.userImg ?? "",
              ),
              fit: BoxFit.cover,
            ),
            color: ColorConstants.gray),
      ),
      title: Text(chatInfo.user?.userName ?? ""),
      subtitle: Row(
        children: [
          Text(
            chatInfo.latestMessage?.senderId ==
                    Get.find<ProfileDataController>().currentUser.userId
                ? "You: "
                : "${chatInfo.latestMessage?.senderName}",
          ),
          Expanded(
            child: Text(
              chatInfo.latestMessage?.messageType == "img"
                  ? "Sent a Photo "
                  : "${chatInfo.latestMessage?.mainMessage} ",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Text(DateFormat("MMM dd, hh:mm a").format(DateTime.parse(chatInfo.latestMessageTime ?? ""))),
        ],
      ),
    );
  }
}
