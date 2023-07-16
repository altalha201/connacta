import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';
import '../space.dart';

class ReceivedImageBox extends StatelessWidget {
  const ReceivedImageBox({
    Key? key,
    required this.userImg,
    required this.imgURL,
  }) : super(key: key);

  final String userImg;
  final String imgURL;

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
                  userImg,
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
                imgURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}