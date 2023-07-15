import 'package:flutter/material.dart';

class ChatListTab extends StatefulWidget {
  const ChatListTab({Key? key}) : super(key: key);

  @override
  State<ChatListTab> createState() => _ChatListTabState();
}

class _ChatListTabState extends State<ChatListTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Chats"),);
  }
}
