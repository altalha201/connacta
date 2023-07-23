import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/logic_controller/profile_data_controller.dart';
import '../../../data/model/user_info_model.dart';
import '../../widgets/appbars/appbars.dart';
import '../../widgets/list_item/divider_title.dart';
import '../../widgets/list_item/user_list_item.dart';
import '../../widgets/loading_widgets/center_loading.dart';
import '../../widgets/space.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({Key? key}) : super(key: key);

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  final _store = FirebaseFirestore.instance;
  final List<UserInfoModel> _userList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars.backButtonAppbar(title: "Friend Requests"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const DividerTitle(title: "Response to"),
            Space.vertical(size: 16.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _store
                    .collection('user_items')
                    .doc("requests")
                    .collection(
                        Get.find<ProfileDataController>().currentUser.userId ??
                            "")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CenterLoading();
                  }

                  if (snapshot.hasData) {
                    _userList.clear();
                    for (var doc in snapshot.data!.docs) {
                      var user = UserInfoModel(
                        userId: doc.get('user_id'),
                        userName: doc.get('user_name'),
                        userImg: doc.get('user_img'),
                        // userNameArray: doc.get('user_name_array'),
                      );
                      _userList.add(user);
                      log(user.userName ?? "No Name");
                    }

                    return ListView.builder(
                      itemCount: _userList.length,
                      itemBuilder: (context, index) {
                        return UserListItem(
                            userData: _userList.elementAt(index),
                          fromRequest: true,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("No request"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
