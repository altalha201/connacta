import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_constants.dart';
import '../../../data/model/message_model.dart';
import '../../../data/utils/functions.dart';
import '../../utils/pop_messages.dart';
import 'image_view.dart';

class MessageImageView extends StatelessWidget {
  const MessageImageView({Key? key, required this.message}) : super(key: key);

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.secondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              await Functions.downloadImage(imageURL: message.mainMessage ?? "");
            },
            icon: const Icon(Icons.file_download_sharp),
          ),
          IconButton(
            onPressed: () {
              PopMessages.showMessageInfo(message: message, fromImg: true,);
            },
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              Get.to(ImageView(image: message.mainMessage ?? ""));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                message.mainMessage ?? "",
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
