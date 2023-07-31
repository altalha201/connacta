import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/color_constants.dart';

class ChatListLoading extends StatelessWidget {
  const ChatListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConstants.gray,
      highlightColor: ColorConstants.white,
      child: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, _) {
          return ListTile(
            leading: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: ColorConstants.gray.withOpacity(0.6),
                borderRadius: BorderRadius.circular(52),
              ),
            ),
            title: Row(
              children: [
                Container(
                  height: 18,
                  width: 80,
                  decoration: BoxDecoration(
                    color: ColorConstants.gray.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const Spacer(),
              ],
            ),
            subtitle: Row(
              children: [
                Container(
                  height: 18,
                  width: 120,
                  decoration: BoxDecoration(
                    color: ColorConstants.gray.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 18,
                  width: 60,
                  decoration: BoxDecoration(
                    color: ColorConstants.gray.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
