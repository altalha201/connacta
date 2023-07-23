import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';

class DisplayPicture extends StatelessWidget {
  const DisplayPicture({
    super.key,
    this.size = 180,
    this.borderWidth = 2,
    required this.imgURL,
    this.onPress,
  });

  final double size;
  final double borderWidth;
  final String imgURL;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: ColorConstants.white,
          border: Border.all(width: borderWidth, color: ColorConstants.primary),
          image: DecorationImage(
            image: NetworkImage(imgURL),
          ),
        ),
      ),
    );
  }
}
