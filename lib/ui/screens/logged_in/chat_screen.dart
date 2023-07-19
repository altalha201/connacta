import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../controller/ui_controllers/theme_controller.dart';
import '../../utils/text_styles.dart';
import '../../widgets/box_widgets/received_image_box.dart';
import '../../widgets/box_widgets/received_message_box.dart';
import '../../widgets/box_widgets/sent_image_box.dart';
import '../../widgets/box_widgets/sent_message_box.dart';
import '../../widgets/space.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _messageOnFocus = false;

  final TextEditingController _messageET = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  image: const DecorationImage(
                      image: NetworkImage(AssetConstants.defaultProfile))),
            ),
            Space.horizontal(size: 8.0),
            Expanded(
              child: Text(
                "User name",
                overflow: TextOverflow.ellipsis,
                style: TextStyles.usernameStyle,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  ReceivedMessageBox(
                    senderImg: AssetConstants.defaultProfile,
                    message: "Received Message",
                  ),
                  SentMessageBox(
                    message: 'Sent Message',
                  ),
                  ReceivedImageBox(
                    userImg: AssetConstants.defaultProfile,
                    imgURL: AssetConstants.landScape,
                  ),
                  SentImageBox(
                    imgURL: AssetConstants.defaultDay,
                  )
                ],
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
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt),
                    splashRadius: 28,
                  ),
                ),
                Visibility(
                  visible: !_messageOnFocus,
                  replacement: const SizedBox.shrink(),
                  child: IconButton(
                    onPressed: () {},
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
                        onChanged: (value) {
                          setState(() {
                            _messageOnFocus = true;
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
                  onPressed: () {
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
  }
}
