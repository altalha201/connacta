import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_constants.dart';
import '../../../controller/ui_controllers/theme_controller.dart';
import '../space.dart';

class SettingsListItem extends StatelessWidget {
  const SettingsListItem({
    Key? key,
    required this.leadingIcon,
    required this.title,
    this.startItem = false,
    this.lastItem = false,
    this.tailingWidget,
    this.onTap,
  }) : super(key: key);

  final IconData leadingIcon;
  final String title;
  final bool? startItem;
  final bool? lastItem;
  final Widget? tailingWidget;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (controller) {
        return GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: controller.darkMoodActivated
                      ? ColorConstants.black
                      : ColorConstants.white,
                  borderRadius: BorderRadius.only(
                    topRight: (startItem ?? false)
                        ? const Radius.circular(10)
                        : Radius.zero,
                    topLeft: (startItem ?? false)
                        ? const Radius.circular(10)
                        : Radius.zero,
                    bottomLeft: (lastItem ?? false)
                        ? const Radius.circular(10)
                        : Radius.zero,
                    bottomRight: (lastItem ?? false)
                        ? const Radius.circular(10)
                        : Radius.zero,
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      leadingIcon,
                      color: controller.darkMoodActivated
                          ? ColorConstants.white
                          : ColorConstants.black,
                    ),
                    Space.horizontal(size: 16.0),
                    Text(title),
                    const Spacer(),
                    tailingWidget ?? const SizedBox.shrink(),
                  ],
                ),
              ),
              Visibility(
                visible: !(lastItem ?? false),
                replacement: const SizedBox.shrink(),
                child: Ink(
                  height: 0.3,
                  width: double.infinity,
                  color: controller.darkMoodActivated
                      ? ColorConstants.gray
                      : ColorConstants.black.withOpacity(0.6),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
