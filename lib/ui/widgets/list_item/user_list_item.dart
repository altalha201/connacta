import 'package:flutter/material.dart';

import '../../../constants/asset_constants.dart';
import '../../utils/text_styles.dart';
import '../space.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    Key? key,
    this.verticalPadding = 8.0,
    this.horizontalPadding = 0.0,
  }) : super(key: key);

  final double verticalPadding;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              image: const DecorationImage(
                image: NetworkImage(
                  AssetConstants.defaultProfile,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Space.horizontal(size: 16.0),
          Expanded(
            child: Text(
              "User Name",
              style: TextStyles.usernameStyle,
            ),
          )
        ],
      ),
    );
  }
}
