import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/asset_constants.dart';
import '../../../data/model/user_info_model.dart';
import '../../screens/logged_in/profile_view.dart';
import '../../utils/text_styles.dart';
import '../space.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    Key? key,
    this.verticalPadding = 8.0,
    this.horizontalPadding = 0.0,
    required this.userData,
    this.tailingWidget,
    this.fromRequest = false,
  }) : super(key: key);

  final double verticalPadding;
  final double horizontalPadding;
  final UserInfoModel userData;
  final bool fromRequest;
  final Widget? tailingWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: GestureDetector(
        onTap: () {
          Get.to(
            ProfileView(
              userId: userData.userId ?? "",
              fromRequest: fromRequest,
            ),
          );
        },
        child: Row(
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                image: DecorationImage(
                  image: NetworkImage(
                    userData.userImg ?? AssetConstants.defaultProfile,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Space.horizontal(size: 16.0),
            Expanded(
              child: Text(
                userData.userName ?? "User Name",
                style: TextStyles.usernameStyle,
              ),
            ),
            tailingWidget ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
