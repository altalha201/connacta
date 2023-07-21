import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/text_styles.dart';
import '../space.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    Key? key,
    this.verticalPadding = 8.0,
    this.horizontalPadding = 0.0,
    required this.userName,
    required this.userImg,
    required this.userID,
    this.fromSearch = false,
  }) : super(key: key);

  final double verticalPadding;
  final double horizontalPadding;
  final String userName;
  final String userImg;
  final String userID;
  final bool fromSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              image: DecorationImage(
                image: NetworkImage(
                  userImg,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Space.horizontal(size: 16.0),
          Expanded(
            child: Text(
              userName,
              style: TextStyles.usernameStyle,
            ),
          ),
          Visibility(
            visible: fromSearch,
            replacement: const SizedBox.shrink(),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.userPlus,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
