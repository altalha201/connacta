class UserDetailsModel {
  String? userId;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userDob;
  String? userDpUrl;
  String? userGender;
  String? userAddress;
  String? joinedTime;

  UserDetailsModel(
      {this.userId,
        this.userName,
        this.userEmail,
        this.userPhone,
        this.userDob,
        this.userDpUrl,
        this.userGender,
        this.userAddress,
        this.joinedTime,
      });

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    userDob = json['user_dob'];
    userDpUrl = json['user_dp_url'];
    userGender = json['user_gender'];
    userAddress = json['user_address'];
    joinedTime = json['created_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['user_phone'] = userPhone;
    data['user_dob'] = userDob;
    data['user_dp_url'] = userDpUrl;
    data['user_gender'] = userGender;
    data['user_address'] = userAddress;
    data['created_time'] = joinedTime;
    return data;
  }
}
