import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../constants/paths.dart';
import '../data_controller/user_preferences.dart';

class GetOwnPhotosController extends GetxController {
  bool _gettingPhotos = false;

  final List<String> _imgUrls = [];

  bool get gettingPhotos => _gettingPhotos;

  List<String> get imgURLs => _imgUrls;

  Future<void> getPhotos() async {
    _gettingPhotos = true;
    update();

    final storage = FirebaseStorage.instance.ref();
    List items = [];
    await storage
        .child('${Paths.profilePictures}/${Get.find<UserPreferences>().userID}')
        .listAll()
        .then((value) {
          items = value.items;
    });

    _imgUrls.clear();
    for (var element in items) {
      _imgUrls.add(await element.getDownloadURL());
    }

    _gettingPhotos = false;
    update();
  }
}
