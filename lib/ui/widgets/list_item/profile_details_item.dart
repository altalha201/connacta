import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';

class ProfileDetailsItem extends StatelessWidget {
  const ProfileDetailsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.tailingButton,
  });

  final IconData icon;
  final String title;
  final String value;
  final Widget? tailingButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: ColorConstants.gray,
            child: Icon(
              icon,
              color: ColorConstants.white,
              size: 20,
            ),
          ),
          title: Text(title),
          subtitle: Text(value),
          trailing: tailingButton,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(
            color: ColorConstants.gray,
            height: 2,
          ),
        ),
      ],
    );
  }
}
