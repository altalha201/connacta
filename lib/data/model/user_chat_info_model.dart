import 'message_model.dart';
import 'user_info_model.dart';

class UserChatInfoModel {
  String? roomId;
  String? roomType;
  MessageModel? latestMessage;
  String? latestMessageTime;
  UserInfoModel? user;

  UserChatInfoModel({
    this.roomId,
    this.roomType,
    this.latestMessage,
    this.latestMessageTime,
    this.user,
  });

  UserChatInfoModel.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    roomType = json['room_type'];
    latestMessage = json['latest_message'] != null
        ? MessageModel.fromJson(json['latest_message'])
        : null;
    latestMessageTime = json['latest_message_time'];
    user = json['user'] != null ? UserInfoModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room_id'] = roomId;
    data['room_type'] = roomType;
    if (latestMessage != null) {
      data['latest_message'] = latestMessage!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['latest_message_time'] = latestMessageTime;
    return data;
  }
}
