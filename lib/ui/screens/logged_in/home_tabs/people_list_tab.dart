import 'package:connacta/ui/widgets/list_item/settings_list_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../constants/asset_constants.dart';
import '../../../widgets/list_item/user_list_item.dart';
import '../../../widgets/space.dart';
import '../search_screen.dart';

class PeopleListTab extends StatefulWidget {
  const PeopleListTab({Key? key}) : super(key: key);

  @override
  State<PeopleListTab> createState() => _PeopleListTabState();
}

class _PeopleListTabState extends State<PeopleListTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SettingsListItem(
              leadingIcon: Icons.people_alt_outlined,
              title: "See Friend Requests",
            startItem: true,
            lastItem: true,
          ),
          Space.vertical(size: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "My Friends",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(const SearchScreen());
                },
                child: Row(
                  children: [
                    const Text("Add Friends"),
                    Space.horizontal(size: 8.0),
                    const Icon(
                      FontAwesomeIcons.userPlus,
                      size: 12,
                    )
                  ],
                ),
              ),
            ],
          ),
          Space.vertical(size: 16.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < 20; i++)
                    const UserListItem(
                      userName: 'User Name',
                      userImg: AssetConstants.defaultProfile,
                      userID: '',
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
