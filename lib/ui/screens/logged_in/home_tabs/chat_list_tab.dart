import 'package:flutter/material.dart';

import '../../../widgets/list_item/chat_list_item.dart';

class ChatListTab extends StatefulWidget {
  const ChatListTab({Key? key}) : super(key: key);

  @override
  State<ChatListTab> createState() => _ChatListTabState();
}

class _ChatListTabState extends State<ChatListTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < 10; i++)
            const ChatListItem(),
        ],
      ),
    );
  }
}