import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/color_constants.dart';
import '../space.dart';

class UserListLoading extends StatelessWidget {
  const UserListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConstants.gray,
      highlightColor: ColorConstants.white,
      child: ListView.builder(
        itemCount: 25,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: ColorConstants.gray.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                Space.horizontal(size: 16.0),
                Container(
                  height: 24,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorConstants.gray.withOpacity(0.6),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
