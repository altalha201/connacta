import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_constants.dart';
import '../../../data/model/message_model.dart';
import '../picture_widgets/message_image_view.dart';
import '../space.dart';

class ReceivedImageBox extends StatelessWidget {
  const ReceivedImageBox({
    Key? key, required this.message,
  }) : super(key: key);

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: () {
          Get.to(MessageImageView(message: message));
        },
        child: Row(
          children: [
            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: ColorConstants.gray,
                image: DecorationImage(
                  image: NetworkImage(
                    message.senderDpUrl ?? "",
                  ),
                ),
              ),
            ),
            Space.horizontal(size: 12.0),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorConstants.gray,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  message.mainMessage ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}