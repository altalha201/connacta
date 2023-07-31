import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';
import '../../../data/model/message_model.dart';
import '../../utils/pop_messages.dart';

class SentMessageBox extends StatelessWidget {
  const SentMessageBox({
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.60,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: ColorConstants.primary.withOpacity(0.6),
                border: Border.all(width: 1, color: ColorConstants.primary)
              ),
              child: Text(
                message.mainMessage ?? "",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
