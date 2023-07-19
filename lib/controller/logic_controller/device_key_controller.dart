import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../data_controller/user_preferences.dart';

class DeviceKeyController {
  final _messageInstance = FirebaseMessaging.instance;
  final _cloudInstance = FirebaseFirestore.instance;

  Future<void> saveDeviceToken() async {
    final userId = Get.find<UserPreferences>().userID;
    final token = await _messageInstance.getToken();
    await _cloudInstance.collection('device_token').doc(userId).set({
      'user_id' : userId,
      'device_token' : token
    });
  }

  Future<void> updateToken() async {
    final userId = Get.find<UserPreferences>().userID;
    final token = await _messageInstance.getToken();
    await _cloudInstance.collection('device_token').doc(userId).update({
      'device_token' : token
    });
  }
}