import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_constants.dart';
import 'image_view.dart';

class ImageListItem extends StatelessWidget {
  const ImageListItem({
    super.key,
    required this.imgUrl,
  });

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ImageView(image: imgUrl,));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorConstants.gray,
            image: DecorationImage(
              image: NetworkImage(imgUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
