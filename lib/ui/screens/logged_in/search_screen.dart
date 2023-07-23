import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/model/user_info_model.dart';
import '../../widgets/appbars/appbars.dart';
import '../../widgets/list_item/user_list_item.dart';
import '../../widgets/text_fields/search_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<UserInfoModel> _searchResult = [];

  Future<void> search(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('search_user')
        .where('user_name_array', arrayContains: query)
        .get();

    setState(() {
      _searchResult = result.docs.map((e) => UserInfoModel.fromJson(e.data())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars.centerTitled(title: "Search For friends"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchTextField(
              onChange: (value) async {
                await search(value);
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResult.length,
                itemBuilder: (context, index) {
                  return UserListItem(
                    userData: _searchResult.elementAt(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
