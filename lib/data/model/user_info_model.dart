class UserInfoModel {
  String? userId;
  String? userName;
  List<String>? userNameArray;
  String? userImg;

  UserInfoModel({this.userId, this.userName, this.userNameArray, this.userImg});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userNameArray = json['user_name_array'].cast<String>();
    userImg = json['user_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_name_array'] = userNameArray;
    data['user_img'] = userImg;
    return data;
  }
}
