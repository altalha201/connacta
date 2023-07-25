import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../controller/logic_controller/profile_data_controller.dart';
import '../../../data/model/user_info_model.dart';
import '../../utils/pop_messages.dart';
import '../../widgets/appbars/appbars.dart';
import '../../widgets/list_item/divider_title.dart';
import '../../widgets/list_item/user_list_item.dart';
import '../../widgets/loading_widgets/center_loading.dart';
import '../../widgets/space.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen(
      {Key? key,
      this.fromSent = false,
      required this.appBarTitle,
      required this.title})
      : super(key: key);

  final bool fromSent;
  final String appBarTitle;
  final String title;

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  final _store = FirebaseFirestore.instance;
  final List<UserInfoModel> _userList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars.backButtonAppbar(title: widget.appBarTitle),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DividerTitle(title: widget.title),
            Space.vertical(size: 16.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _store
                    .collection('user_items')
                    .doc(widget.fromSent? "sent" : "requests")
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
                          tailingWidget: IconButton(
                            onPressed: () {
                              if(!widget.fromSent) {
                                PopMessages.friendRequestResponse(sender: _userList.elementAt(index));
                              }
                            },
                            icon: Icon(
                              widget.fromSent ? Icons.check : FontAwesomeIcons.userCheck,
                              size: 16,
                            ),
                          ),
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
