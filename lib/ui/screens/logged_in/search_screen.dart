import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connacta/ui/widgets/appbars/appbars.dart';
import 'package:connacta/ui/widgets/list_item/user_list_item.dart';
import 'package:connacta/ui/widgets/text_fields/search_text_field.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List _searchResult = [];

  Future<void> search(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('search_user')
        .where('user_name_array', arrayContains: query)
        .get();

    setState(() {
      _searchResult = result.docs.map((e) => e.data()).toList();
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
                  var item = _searchResult.elementAt(index);
                  return UserListItem(
                    userName: item["user_name"],
                    userImg: item["user_img"],
                    userID: item["user_id"],
                    fromSearch: true,
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
