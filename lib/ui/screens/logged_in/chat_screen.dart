import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/color_constants.dart';
import '../../../controller/logic_controller/chat_controller.dart';
import '../../../controller/logic_controller/profile_data_controller.dart';
import '../../../controller/ui_controllers/theme_controller.dart';
import '../../../data/model/message_model.dart';
import '../../../data/utils/functions.dart';
import '../../utils/text_styles.dart';
import '../../widgets/box_widgets/received_image_box.dart';
import '../../widgets/box_widgets/received_message_box.dart';
import '../../widgets/box_widgets/sent_image_box.dart';
import '../../widgets/box_widgets/sent_message_box.dart';
import '../../widgets/loading_widgets/center_loading.dart';
import '../../widgets/space.dart';
import 'chat_info_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.roomID}) : super(key: key);

  final String roomID;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _messageOnFocus = false;

  final TextEditingController _messageET = TextEditingController();

  final _storageRef = FirebaseFirestore.instance.collection("chat_rooms");

  final List<MessageModel> _messages = [];

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      Get.find<ChatController>().getChatProfile(chatID: widget.roomID);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (viewController) {
      if (viewController.gettingChat) {
        return const SafeArea(child: CenterLoading());
      }
      return Scaffold(
        appBar: AppBar(
          leadingWidth: 32,
          title: Row(
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    image: DecorationImage(
                        image: NetworkImage(viewController.recipientImg))),
              ),
              Space.horizontal(size: 8.0),
              Expanded(
                child: Text(
                  viewController.recipientName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.usernameStyle,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(const ChatInfoScreen());
              },
              icon: const Icon(Icons.info),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _storageRef
                      .doc(widget.roomID)
                      .collection("messages")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CenterLoading();
                    }

                    if (snapshot.hasData) {
                      _messages.clear();
                      for (var doc in snapshot.data!.docs) {
                        var message = MessageModel(
                          messageId: doc.get("message_id"),
                          chatID: doc.get("chat_id"),
                          messageType: doc.get("message_type"),
                          mainMessage: doc.get("main_message"),
                          senderId: doc.get("sender_id"),
                          senderName: doc.get("sender_name"),
                          senderDpUrl: doc.get("sender_dp_url"),
                          createdTime: doc.get("created_time"),
                        );
                        _messages.add(message);
                      }
                      _messages.sort((a, b) => a.createdTime!.compareTo(b.createdTime!));

                      return SingleChildScrollView(
                        reverse: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            var ms = _messages.elementAt(index);
                            if(ms.senderId == Get.find<ProfileDataController>().currentUser.userId) {
                              if(ms.messageType == "txt") {
                                return SentMessageBox(message: ms);
                              } else {
                                return SentImageBox(message: ms,);
                              }
                            } else {
                              if(ms.messageType == "txt") {
                                return ReceivedMessageBox(message: ms);
                              } else {
                                return ReceivedImageBox(message: ms,);
                              }
                            }
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "No message Yet",
                          style: TextStyles.usernameStyle,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Container(
              color: Get.find<ThemeController>().darkMoodActivated
                  ? ColorConstants.black
                  : ColorConstants.white,
              height: 60,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Visibility(
                    visible: !_messageOnFocus,
                    replacement: const SizedBox.shrink(),
                    child: IconButton(
                      onPressed: () async {
                        await Functions.sendImgMsg(source: ImageSource.camera, chatID: widget.roomID);
                      },
                      icon: const Icon(Icons.camera_alt),
                      splashRadius: 28,
                    ),
                  ),
                  Visibility(
                    visible: !_messageOnFocus,
                    replacement: const SizedBox.shrink(),
                    child: IconButton(
                      onPressed: () async {
                        await Functions.sendImgMsg(source: ImageSource.gallery, chatID: widget.roomID);
                      },
                      icon: const Icon(Icons.image),
                      splashRadius: 28,
                    ),
                  ),
                  Visibility(
                    visible: _messageOnFocus,
                    replacement: const SizedBox.shrink(),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _messageOnFocus = false;
                        });
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                      splashRadius: 28,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Get.find<ThemeController>().darkMoodActivated
                            ? ColorConstants.white.withOpacity(0.2)
                            : ColorConstants.black.withOpacity(0.2),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 16),
                      child: Center(
                        child: TextFormField(
                          controller: _messageET,
                          onTap: () {
                            setState(() {
                              _messageOnFocus = true;
                            });
                          },
                          onEditingComplete: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            setState(() {
                              _messageOnFocus = false;
                            });
                          },
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: "Message",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await viewController.sendMessage(type: "txt", mMessage: _messageET.text, chatID: widget.roomID);
                      _messageET.clear();
                      setState(() {
                        _messageOnFocus = false;
                      });
                    },
                    icon: const Icon(Icons.send),
                    splashRadius: 28,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
