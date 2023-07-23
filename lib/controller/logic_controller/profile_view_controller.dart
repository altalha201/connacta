import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../constants/paths.dart';
import '../../data/model/user_details_model.dart';
import 'profile_data_controller.dart';

class ProfileViewController extends GetxController {
  bool _profileGetting = false;
  bool _isFriend = false;

  UserDetailsModel _user = UserDetailsModel();
  final List<String> _photos = [];

  bool get profileGetting => _profileGetting;
  bool get isFriend => _isFriend;

  UserDetailsModel get user => _user;

  List<String> get pPhotos => _photos;

  final _dbInstance = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance.ref();

  Future<void> getProfile(String userID, bool self) async {
    _profileGetting = true;
    update();

    late final Map<String, dynamic>? data;
    await _dbInstance
        .collection('user_details')
        .doc(userID)
        .get()
        .then((value) {
      data = value.data();
    });

    _user = UserDetailsModel.fromJson(data!);

    List items = [];
    await _storage
        .child('${Paths.profilePictures}/$userID')
        .listAll()
        .then((value) {
      items = value.items;
    });

    _photos.clear();
    for (var element in items) {
      _photos.add(await element.getDownloadURL());
    }

    if (!self) {
      late final Map<String, dynamic>? userData;
      await _dbInstance
      .collection('user_items')
      .doc('friend_list')
      .collection(Get.find<ProfileDataController>().currentUser.userId ?? "").doc(userID)
      .get().then((value) {
        userData = value.data();
      });

      if (userData != null) {
        _isFriend = true;
      }
    }

    _profileGetting = false;
    update();
  }
}
