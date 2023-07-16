import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../screens/logged_in/chat_screen.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(const ChatScreen());
      },
      leading: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(52),
            image: const DecorationImage(
              image: NetworkImage(
                AssetConstants.defaultProfile,
              ),
              fit: BoxFit.cover,
            ),
            color: ColorConstants.gray
        ),
      ),
      title: const Text("User Name"),
      subtitle: Row(
        children: [
          const Text("From: "),
          const Text("Latest Message"),
          Text(" ${DateFormat.MMMd().format(DateTime.now())}")
        ],
      ),
    );
  }
}