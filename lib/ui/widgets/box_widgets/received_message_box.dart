import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';
import '../../../data/model/message_model.dart';
import '../../utils/pop_messages.dart';
import '../space.dart';

class ReceivedMessageBox extends StatelessWidget {
  const ReceivedMessageBox({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: () {
          PopMessages.showMessageInfo(message: message);
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
                  )),
            ),
            Space.horizontal(size: 12.0),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.50,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: ColorConstants.secondary.withOpacity(0.6),
                border: Border.all(color: ColorConstants.secondary)
              ),
              child: Text(
                message.mainMessage ?? "",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
