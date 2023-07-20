import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../controller/logic_controller/profile_data_controller.dart';

class DisplayPicture extends StatelessWidget {
  const DisplayPicture({
    super.key,
    this.size = 180,
    this.borderWidth = 2,
  });

  final double size;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: ColorConstants.white,
        border: Border.all(width: borderWidth, color: ColorConstants.primary),
        image: DecorationImage(
          image: NetworkImage(
              Get.find<ProfileDataController>().currentUser.userDpUrl ??
                  AssetConstants.defaultProfile),
        ),
      ),
    );
  }
}
