import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/logic_controller/get_own_photos_controller.dart';
import '../../widgets/loading_widgets/image_list_loading.dart';
import '../../widgets/picture_widgets/display_picture.dart';
import '../../widgets/picture_widgets/image_list_item.dart';
import '../../widgets/space.dart';

class ProfilePictureScreen extends StatefulWidget {
  const ProfilePictureScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePictureScreen> createState() => _ProfilePictureScreenState();
}

class _ProfilePictureScreenState extends State<ProfilePictureScreen> {

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) async {
      await Get.find<GetOwnPhotosController>().getPhotos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile Pictures"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Current Profile Picture",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Space.vertical(size: 16.0),
                const DisplayPicture(),
                Space.vertical(size: 32.0),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "All Pictures",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<GetOwnPhotosController>(builder: (controller) {
              if (controller.gettingPhotos) {
                return const ImageListLoading();
              }

              if(controller.imgURLs.isEmpty) {
                return const Center(child: Text("No Image Found"),);
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.getPhotos();
                    },
                    child: Wrap(
                      children: controller.imgURLs
                          .map((imgUrl) => ImageListItem(imgUrl: imgUrl))
                          .toList(),
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
