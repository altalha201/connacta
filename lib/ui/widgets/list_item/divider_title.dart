import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_constants.dart';
import '../../../controller/ui_controllers/theme_controller.dart';
import '../../utils/text_styles.dart';
import '../space.dart';

class DividerTitle extends StatelessWidget {
  const DividerTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyles.usernameStyle,
        ),
        Space.horizontal(size: 8.0),
        Expanded(
          child: Divider(
            color: Get.find<ThemeController>().darkMoodActivated
                ? ColorConstants.white
                : ColorConstants.black,
          ),
        ),
      ],
    );
  }
}
