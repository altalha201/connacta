import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/color_constants.dart';

class ImageListLoading extends StatelessWidget {
  const ImageListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConstants.gray,
      highlightColor: ColorConstants.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              for(int i = 0; i <= 14; i++)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.gray.withOpacity(0.6),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
