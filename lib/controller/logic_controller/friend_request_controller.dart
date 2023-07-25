import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../data/model/user_info_model.dart';
import '../../data/utils/conversion.dart';
import '../../ui/utils/pop_messages.dart';
import 'profile_data_controller.dart';

class FriendRequestController extends GetxController {
  final _storage = FirebaseFirestore.instance;

  Future<void> sendRequest({required UserInfoModel receiver}) async {
    final userInstance = Get.find<ProfileDataController>().currentUser;
    final user = UserInfoModel(
      userId: userInstance.userId,
      userImg: userInstance.userDpUrl,
      userName: userInstance.userName,
      userNameArray: Conversion.stringToArray(userInstance.userName ?? ""),
    );

    await _storage
        .collection('user_items')
        .doc('sent')
        .collection(user.userId ?? "")
        .doc(receiver.userId)
        .set(receiver.toJson());

    await _storage
        .collection('user_items')
        .doc('requests')
        .collection(receiver.userId ?? "")
        .doc(user.userId)
        .set(user.toJson())
        .then((value) {
      PopMessages.showSnackBarMessage(
          title: "Success", messages: "Friend request sent");
    });
  }

  Future<void> acceptRequest({required UserInfoModel sender}) async {
    final userInstance = Get.find<ProfileDataController>().currentUser;
    final user = UserInfoModel(
      userId: userInstance.userId,
      userImg: userInstance.userDpUrl,
      userName: userInstance.userName,
      userNameArray: Conversion.stringToArray(userInstance.userName ?? ""),
    );

    await _storage
        .collection('user_items')
        .doc('friends')
        .collection(user.userId ?? "")
        .doc(sender.userId)
        .set(sender.toJson());

    await _storage
        .collection('user_items')
        .doc('friends')
        .collection(sender.userId ?? "")
        .doc(user.userId)
        .set(user.toJson());

    await _storage
        .collection("user_items")
        .doc("requests")
        .collection(user.userId ?? "")
        .doc(sender.userId)
        .delete();

    await _storage
        .collection("user_items")
        .doc("sent")
        .collection(sender.userId ?? "")
        .doc(user.userId)
        .delete();

    PopMessages.showSnackBarMessage(
      title: "Success",
      messages: "Friend request accepted",
    );
  }

  Future<void> cancelRequest({required String senderID}) async {
    await _storage
        .collection("user_items")
        .doc("requests")
        .collection(Get.find<ProfileDataController>().currentUser.userId ?? "")
        .doc(senderID)
        .delete();

    await _storage
        .collection("user_items")
        .doc("sent")
        .collection(senderID)
        .doc(Get.find<ProfileDataController>().currentUser.userId)
        .delete();

    PopMessages.showSnackBarMessage(
      title: "Success",
      messages: "Friend request Canceled",
    );
  }
}
