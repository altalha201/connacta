import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../controller/logic_controller/profile_data_controller.dart';
import '../../utils/text_styles.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({
    Key? key,
    this.self = false,
  }) : super(key: key);

  final bool self;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.gray,
        image: DecorationImage(
            image: NetworkImage(self
                ? (Get.find<ProfileDataController>().currentUser.userDpUrl ??
                    AssetConstants.defaultProfile)
                : AssetConstants.defaultDay),
            colorFilter: ColorFilter.mode(
              ColorConstants.black.withOpacity(0.4),
              BlendMode.darken,
            ),
            fit: BoxFit.cover),
      ),
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: !self,
            replacement: const Icon(
              Icons.add_circle,
              size: 32,
              color: ColorConstants.white,
            ),
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                image: const DecorationImage(
                  image: NetworkImage(
                    AssetConstants.defaultProfile,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Text(
              self
                  ? (Get.find<ProfileDataController>().currentUser.userName ??
                      "")
                  : "User Name",
              style: TextStyles.usernameStyle
                  .copyWith(color: ColorConstants.white),
            ),
          ),
        ],
      ),
    );
  }
}
