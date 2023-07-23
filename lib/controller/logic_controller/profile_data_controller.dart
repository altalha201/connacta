import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../data/model/user_details_model.dart';
import '../data_controller/user_preferences.dart';

class ProfileDataController extends GetxController {
  bool _gettingUser = false;
  bool _updatingData = false;

  bool get gettingUser => _gettingUser;

  bool get updatingData => _updatingData;

  UserDetailsModel _currentUser = UserDetailsModel();

  UserDetailsModel get currentUser => _currentUser;

  final _dbInstance = FirebaseFirestore.instance;

  Future<void> getUser() async {
    _gettingUser = true;
    update();

    late final Map<String, dynamic>? data;
    await _dbInstance
        .collection('user_details')
        .doc(Get.find<UserPreferences>().userID)
        .get()
        .then((value) {
      data = value.data();
    });

    _currentUser = UserDetailsModel.fromJson(data!);

    _gettingUser = false;
    update();
  }

  Future<bool> updateProfileData(Map<String, dynamic> data) async {
    _updatingData = true;
    update();

    bool success = true;

    await _dbInstance
        .collection('user_details')
        .doc(Get.find<UserPreferences>().userID)
        .update(data)
        .onError((error, stackTrace) {
      success = false;
    });

    _updatingData = false;
    update();

    return success;
  }

  Future<void> updateInSearch(Map<String, dynamic> data) async {
    await _dbInstance
        .collection('search_user')
        .doc(Get.find<UserPreferences>().userID)
        .update(data);
  }
}
