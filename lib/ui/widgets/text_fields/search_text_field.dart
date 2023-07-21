import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    this.controller, this.onChange,
  }) : super(key: key);

  final TextEditingController? controller;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: ColorConstants.gray.withOpacity(0.6),
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                onChanged: onChange,
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search for New People",
                    hintStyle:
                        TextStyle(color: ColorConstants.gray.withOpacity(0.6))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
