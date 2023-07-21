import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/paths.dart';
import '../../../controller/data_controller/user_preferences.dart';
import '../../../controller/logic_controller/profile_data_controller.dart';
import '../../../controller/ui_controllers/theme_controller.dart';
import '../../../data/services/storage_helper.dart';
import '../../utils/pop_messages.dart';
import '../../widgets/appbars/appbars.dart';
import '../../widgets/buttons/wide_button.dart';
import '../../widgets/loading_widgets/center_loading.dart';
import '../../widgets/space.dart';
import '../logged_in/home_screen.dart';

class PhotoSelectScreen extends StatefulWidget {
  const PhotoSelectScreen(
      {Key? key,
      required this.name,
      required this.email,
      this.fromSettings = false,
      required this.imgURL})
      : super(key: key);

  final String name, email, imgURL;
  final bool fromSettings;

  @override
  State<PhotoSelectScreen> createState() => _PhotoSelectScreenState();
}

class _PhotoSelectScreenState extends State<PhotoSelectScreen> {
  String _imageURL = "";

  bool _isLoading = false;

  Future<void> _getImage(ImageSource from) async {
    XFile? pickedImage = await ImagePicker().pickImage(
      source: from,
      imageQuality: 50,
      maxWidth: 1040,
      maxHeight: 1040,
    );

    if (pickedImage != null) {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      );

      String newImgURL = await StorageHelper().uploadImage(
          '${Paths.profilePictures}${Get.find<UserPreferences>().userID}/${pickedImage.name}',
          File(croppedImage!.path));

      await Get.find<ProfileDataController>()
          .updateProfileData({'user_dp_url': newImgURL});
      await Get.find<ProfileDataController>()
          .updateInSearch({'user_img': newImgURL});

      setState(() {
        _imageURL = newImgURL;
      });

      PopMessages.showSnackBarMessage(
          title: "Success", messages: "New Profile Picture Upload Successful");

      Get.offAll(const HomeScreen());
    }
  }

  @override
  void initState() {
    _imageURL = widget.imgURL;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars.centerTitled(title: "Select Profile Photo"),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: GetBuilder<ProfileDataController>(builder: (dataController) {
          if (dataController.updatingData) {
            return const CenterLoading();
          }

          return Visibility(
            visible: !_isLoading,
            replacement: const CenterLoading(),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Get.find<ThemeController>().darkMoodActivated
                                ? ColorConstants.white
                                : ColorConstants.black,
                          ),
                          image:
                              DecorationImage(image: NetworkImage(_imageURL)),
                        ),
                      ),
                      title: Text(widget.name),
                      subtitle: Text(widget.email),
                      trailing: const Icon(
                        Icons.circle,
                        color: ColorConstants.green,
                        size: 10,
                      ),
                      tileColor: Get.find<ThemeController>().darkMoodActivated
                          ? ColorConstants.black
                          : ColorConstants.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: WideButton(
                        onPressed: () {
                          PopMessages.showAlertMessage(
                            title: "Select From",
                            content: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(
                                    FontAwesomeIcons.camera,
                                    color: ColorConstants.primary,
                                  ),
                                  title: const Text("Camera"),
                                  onTap: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    Get.back();
                                    await _getImage(ImageSource.camera);
                                  },
                                  tileColor:
                                      ColorConstants.gray.withOpacity(0.4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Space.vertical(size: 8.0),
                                ListTile(
                                  leading: const Icon(
                                    FontAwesomeIcons.photoFilm,
                                    color: ColorConstants.primary,
                                  ),
                                  title: const Text("Gallery"),
                                  onTap: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    Get.back();
                                    await _getImage(ImageSource.gallery);
                                  },
                                  tileColor:
                                      ColorConstants.gray.withOpacity(0.4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                )
                              ],
                            ),
                            confirmText: "Cancel",
                            confirmColor: ColorConstants.red,
                          );
                        },
                        buttonText: "Select a photo",
                      ),
                    ),
                    Visibility(
                      visible: !widget.fromSettings,
                      replacement: const SizedBox.shrink(),
                      child: Space.horizontal(size: 8.0),
                    ),
                    Visibility(
                      visible: !widget.fromSettings,
                      replacement: const SizedBox.shrink(),
                      child: Expanded(
                        child: WideButton(
                          onPressed: () {
                            Get.offAll(const HomeScreen());
                          },
                          buttonText: "Skip",
                          backgroundColor: ColorConstants.gray,
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: widget.fromSettings,
                  replacement: const SizedBox.shrink(),
                  child: Space.vertical(size: 16.0),
                ),
                Visibility(
                  visible: widget.fromSettings,
                  replacement: const SizedBox.shrink(),
                  child: WideButton(
                    buttonText: "Cancel",
                    backgroundColor: ColorConstants.red,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
