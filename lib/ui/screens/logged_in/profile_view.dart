import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../controller/logic_controller/friend_request_controller.dart';
import '../../../controller/logic_controller/profile_data_controller.dart';
import '../../../controller/logic_controller/profile_view_controller.dart';
import '../../../data/model/user_info_model.dart';
import '../../../data/utils/conversion.dart';
import '../../../data/utils/functions.dart';
import '../../utils/pop_messages.dart';
import '../../utils/text_styles.dart';
import '../../widgets/appbars/appbars.dart';
import '../../widgets/buttons/wide_icon_elevated_button.dart';
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
                                        child: WideIconElevatedButton(
                                          icon: Icon(
                                            widget.fromRequest
                                                ? FontAwesomeIcons.userCheck
                                                : FontAwesomeIcons.userPlus,
                                            size: 12,
                                          ),
                                          labelText: widget.fromRequest
                                              ? "Response"
                                              : "Add Friend",
                                          onPressed: () {
                                            final user = UserInfoModel(
                                              userName:
                                                  controller.user.userName,
                                              userId: controller.user.userId,
                                              userImg:
                                                  controller.user.userDpUrl,
                                              userNameArray:
                                                  Conversion.stringToArray(
                                                      controller
                                                              .user.userName ??
                                                          ""),
                                            );
                                            if (widget.fromRequest) {
                                              PopMessages.friendRequestResponse(
                                                  sender: user);
                                            } else {
                                              Get.find<
                                                      FriendRequestController>()
                                                  .sendRequest(receiver: user);
                                            }
                                          },
                                        ),
                                      ),
                                      Space.horizontal(size: 8.0),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: WideIconElevatedButton(
                                  icon: const ImageIcon(
                                    AssetImage(AssetConstants.iconLogo),
                                  ),
                                  labelText: "Message",
                                  backgroundColor: ColorConstants.green,
                                  onPressed: () async {
                                    var p1D = controller.user;
                                    var p2D = Get.find<ProfileDataController>().currentUser;

                                    var p1 = UserInfoModel(
                                      userId: p1D.userId,
                                      userName: p1D.userName,
                                      userImg: p1D.userDpUrl,
                                      userNameArray: Conversion.stringToArray(p1D.userName ?? ""),
                                    );
                                    var p2 = UserInfoModel(
                                      userId: p2D.userId,
                                      userName: p2D.userName,
                                      userImg: p2D.userDpUrl,
                                      userNameArray: Conversion.stringToArray(p2D.userName ?? ""),
                                    );
                                    await Functions.gotoChatRoom(
                                      p1: p1,
                                      p2: p2,
                                    );
                                  },
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
                      title: "Joining Info",
                    ),
                    Space.vertical(size: 8.0),
                    ProfileDetailsItem(
                      icon: Icons.date_range_rounded,
                      title: 'Joining Date',
                      value: DateFormat("MMM dd, yyyy").format(DateTime.parse(controller.user.joinedTime ?? "")),
                    ),
                    Space.vertical(size: 32.0),
                    const DividerTitle(
                      title: "Uploaded Profile Pictures",
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
