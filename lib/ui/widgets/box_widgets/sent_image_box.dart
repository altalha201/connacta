import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';

class SentImageBox extends StatelessWidget {
  const SentImageBox({
    Key? key, required this.imgURL,
  }) : super(key: key);

  final String imgURL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
