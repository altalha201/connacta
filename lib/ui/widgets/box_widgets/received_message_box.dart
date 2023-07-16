import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';
import '../space.dart';

class ReceivedMessageBox extends StatelessWidget {
  const ReceivedMessageBox({
    Key? key,
    required this.message,
    required this.senderImg,
  }) : super(key: key);

  final String message;
  final String senderImg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                    senderImg,
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
              color: ColorConstants.secondary,
            ),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
