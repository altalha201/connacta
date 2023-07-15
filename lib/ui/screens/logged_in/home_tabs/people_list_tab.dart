import 'package:flutter/material.dart';

import '../../../widgets/list_item/user_list_item.dart';
import '../../../widgets/space.dart';
import '../../../widgets/text_fields/search_text_field.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchTextField(),
          Space.vertical(size: 16.0),
          const Text(
            "My Friends",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Space.vertical(size: 16.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < 20; i++)
                    const UserListItem()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}