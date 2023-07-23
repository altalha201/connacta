import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../controller/logic_controller/profile_view_controller.dart';
import '../../utils/text_styles.dart';
import '../../widgets/appbars/appbars.dart';
import '../../widgets/list_item/divider_title.dart';
import '../../widgets/list_item/profile_details_item.dart';
import '../../widgets/loading_widgets/profile_loader.dart';
import '../../widgets/picture_widgets/display_picture.dart';
import '../../widgets/picture_widgets/image_list_item.dart';
import '../../widgets/space.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key? key,
    required this.userId,
    this.selfProfile = false,
    this.fromRequest = false,
  }) : super(key: key);

  final String userId;
  final bool selfProfile;
  final bool fromRequest;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized()
        .addPostFrameCallback((timeStamp) async {
      await Get.find<ProfileViewController>()
          .getProfile(widget.userId, widget.selfProfile);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars.centerTitled(
        title: "Profile",
      ),
      body: GetBuilder<ProfileViewController>(builder: (controller) {
        if (controller.profileGetting) {
          return ProfileLoader(selfProfile: widget.selfProfile);
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: Column(
                  children: [
                    DisplayPicture(
                      imgURL: controller.user.userDpUrl ??
                          AssetConstants.defaultProfile,
                    ),
                    Space.vertical(size: 16.0),
                    Text(
                      controller.user.userName ?? "User Name",
                      style: TextStyles.titleNameStyle,
                    ),
                    Visibility(
                      visible: !widget.selfProfile,
                      replacement: const SizedBox.shrink(),
                      child: Column(
                        children: [
                          Space.vertical(size: 32.0),
                          Row(
                            children: [
                              Visibility(
                                visible: !controller.isFriend,
                                replacement: const SizedBox.shrink(),
                                child: Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(16.0),
                                          ),
                                          icon: Icon(
                                            widget.fromRequest ? FontAwesomeIcons.userCheck : FontAwesomeIcons.userPlus,
                                            size: 12,
                                          ),
                                          label: Text(widget.fromRequest ? "Response" : "Add Friend"),
                                        ),
                                      ),
                                      Space.horizontal(size: 8.0),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(16.0),
                                      backgroundColor: ColorConstants.green),
                                  icon: const Icon(
                                    FontAwesomeIcons.facebookMessenger,
                                    size: 12,
                                  ),
                                  label: const Text("Message"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Space.vertical(size: 32.0),
                    const DividerTitle(
                      title: "Contact Info",
                    ),
                    Space.vertical(size: 8.0),
                    ProfileDetailsItem(
                      icon: FontAwesomeIcons.at,
                      title: 'Email',
                      value: controller.user.userEmail ?? "No email provided",
                    ),
                    ProfileDetailsItem(
                      icon: FontAwesomeIcons.phone,
                      title: 'Phone',
                      value: controller.user.userPhone ??
                          "No phone number provided",
                    ),
                    Space.vertical(size: 32.0),
                    const DividerTitle(
                      title: "Locations",
                    ),
                    Space.vertical(size: 8.0),
                    ProfileDetailsItem(
                      icon: FontAwesomeIcons.house,
                      title: 'Home',
                      value: controller.user.userAddress ?? "No location",
                    ),
                    Space.vertical(size: 32.0),
                    const DividerTitle(
                      title: "Basic Info",
                    ),
                    Space.vertical(size: 8.0),
                    ProfileDetailsItem(
                      icon: FontAwesomeIcons.person,
                      title: 'Gender',
                      value: (controller.user.userGender ?? "").toUpperCase(),
                    ),
                    ProfileDetailsItem(
                      icon: FontAwesomeIcons.cakeCandles,
                      title: 'Birth Date',
                      value: controller.user.userDob ?? "",
                    ),
                    Space.vertical(size: 32.0),
                    const DividerTitle(
                      title: "Uploaded Pictures",
                    ),
                    Space.vertical(size: 8.0),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                child: Wrap(
                  children: controller.pPhotos
                      .map((img) => ImageListItem(imgUrl: img))
                      .toList(),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
