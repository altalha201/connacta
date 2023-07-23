import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/color_constants.dart';
import '../space.dart';

class ProfileLoader extends StatelessWidget {
  const ProfileLoader({Key? key, required this.selfProfile}) : super(key: key);

  final bool selfProfile;

  @override
  Widget build(BuildContext context) {
    var color = ColorConstants.gray.withOpacity(0.6);

    return Shimmer.fromColors(
      baseColor: ColorConstants.gray,
      highlightColor: ColorConstants.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      color: color,
                    ),
                  ),
                  Space.vertical(size: 16.0),
                  Container(
                    height: 32,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: color,
                    ),
                  ),
                  Visibility(
                    visible: !selfProfile,
                    replacement: const SizedBox.shrink(),
                    child: Column(
                      children: [
                        Space.vertical(size: 32.0),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: color),
                              ),
                            ),
                            Space.horizontal(size: 8.0),
                            Expanded(
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: color),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Space.vertical(size: 32.0),
                  dividerTitle(color),
                  Space.vertical(size: 8.0),
                  item(color),
                  item(color),
                  Space.vertical(size: 32.0),
                  dividerTitle(color),
                  Space.vertical(size: 8.0),
                  item(color),
                  Space.vertical(size: 32.0),
                  dividerTitle(color),
                  Space.vertical(size: 8.0),
                  item(color),
                  item(color),
                  Space.vertical(size: 32.0),
                  dividerTitle(color),
                  Space.vertical(size: 8.0),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
              child: Wrap(
                children: [
                  for(int i = 0; i < 8; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstants.gray.withOpacity(0.6),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget item(Color color) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: color,
          ),
          title: Row(
            children: [
              Container(
                width: 100,
                height: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: color,
                ),
              ),
              const Expanded(child: SizedBox())
            ],
          ),
          subtitle: Container(
            height: 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(
            color: color,
            height: 2,
          ),
        ),
      ],
    );
  }

  Widget dividerTitle(Color color) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
          ),
        ),
        Space.horizontal(size: 8.0),
        Expanded(
          child: Divider(
            height: 3,
            color: color,
          ),
        ),
      ],
    );
  }
}
