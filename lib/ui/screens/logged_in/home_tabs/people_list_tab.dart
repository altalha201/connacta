import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../constants/asset_constants.dart';
import '../../../../controller/logic_controller/profile_data_controller.dart';
import '../../../../data/model/user_info_model.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/list_item/settings_list_item.dart';
import '../../../widgets/list_item/user_list_item.dart';
import '../../../widgets/loading_widgets/user_list_loading.dart';
import '../../../widgets/space.dart';
import '../request_list_screen.dart';
import '../search_screen.dart';

class PeopleListTab extends StatefulWidget {
  const PeopleListTab({Key? key}) : super(key: key);

  @override
  State<PeopleListTab> createState() => _PeopleListTabState();
}

class _PeopleListTabState extends State<PeopleListTab> {
  final _storageRef =
      FirebaseFirestore.instance.collection("user_items").doc("friends");
  final List<UserInfoModel> _friendList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SettingsListItem(
            leadingIcon: Icons.people_alt_outlined,
            title: "See Friend Requests",
            startItem: true,
            onTap: () {
              Get.off(const RequestListScreen(
                appBarTitle: "Friend Requests",
                title: "Response to",
              ));
            },
          ),
          SettingsListItem(
            leadingIcon: Icons.person_outline,
            title: "See sent request",
            lastItem: true,
            onTap: () {
              Get.off(const RequestListScreen(
                appBarTitle: "Sent Requests",
                title: "Waiting to response",
                fromSent: true,
              ));
            },
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
            child: StreamBuilder<QuerySnapshot>(
              stream: _storageRef
                  .collection(
                      Get.find<ProfileDataController>().currentUser.userId ??
                          "")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const UserListLoading();
                }

                if (snapshot.hasData) {
                  _friendList.clear();
                  for (var doc in snapshot.data!.docs) {
                    var user = UserInfoModel(
                      userId: doc.get('user_id'),
                      userName: doc.get('user_name'),
                      userImg: doc.get('user_img'),
                      // userNameArray: doc.get('user_name_array'),
                    );
                    _friendList.add(user);
                    log(user.userName ?? "No Name");
                  }

                  if(_friendList.isEmpty) {
                    return Center(
                      child: Text(
                        "No Friends",
                        style: TextStyles.usernameStyle,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: _friendList.length,
                    itemBuilder: (context, index) {
                      return UserListItem(
                        userData: _friendList.elementAt(index),
                        tailingWidget: IconButton(
                          onPressed: () {},
                          icon: const ImageIcon(AssetImage(AssetConstants.iconLogo)),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      "No Friends",
                      style: TextStyles.usernameStyle,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
