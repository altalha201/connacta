import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../constants/asset_constants.dart';
import '../../data/model/user_model.dart';
import '../../data/utils/conversion.dart';
import '../../ui/utils/pop_messages.dart';
import '../data_controller/user_preferences.dart';
import 'device_key_controller.dart';

class SignupController extends GetxController {
  bool _creatingAuth = false, _creatingProfile = false;
  String _email = "";

  bool get creatingAuth => _creatingAuth;

  bool get creatingProfile => _creatingProfile;

  String get email => _email;

  Future<bool> createAuth({
    required String email,
    required String password,
  }) async {
    _creatingAuth = true;
    update();
    bool returnBool = false;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        Get.find<UserPreferences>().saveUserID(credential.user!.uid);
        log(credential.user?.uid.toString() ?? "");
        _email = email;
        await DeviceKeyController().saveDeviceToken();
        returnBool = true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        PopMessages.showAlertMessage(
          title: "User create failed",
          message: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        PopMessages.showAlertMessage(
          title: "User create failed",
          message: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      log(e.toString());
    }
    _creatingAuth = false;
    update();
    return returnBool;
  }

  Future<bool> createProfile({
    required String name,
    required String phoneNumber,
    required String dob,
    required String gender,
  }) async {
    _creatingProfile = true;
    update();
    bool returnBool = true;
    final UserModel newUser = UserModel(
        userId: Get.find<UserPreferences>().userID,
        userName: name,
        userDob: dob,
        userEmail: _email,
        userGender: gender,
        userPhone: phoneNumber,
        userAddress: "",
        userDpUrl: AssetConstants.defaultProfile);
    final db = FirebaseFirestore.instance;

    await db
        .collection("user_details")
        .doc(newUser.userId)
        .set(newUser.toJson())
        .onError((error, stackTrace) {
      log(error.toString());
      returnBool = false;
    });

    await db.collection('search_user').doc(newUser.userId).set({
      'user_id': newUser.userId,
      'user_name': newUser.userName,
      'user_name_array': Conversion.stringToArray(newUser.userName!),
      'user_img': newUser.userDpUrl
    });

    _creatingProfile = false;
    update();
    return returnBool;
  }
}
