class SingleChatModel {
  String? roomId;
  String? roomType;
  String? participantOne;
  String? participantTwo;
  String? createdTime;

  SingleChatModel(
      {this.roomId, this.roomType, this.createdTime, this.participantOne, this.participantTwo});

  SingleChatModel.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    roomType = json['room_type'];
    createdTime = json['created_time'];
    participantOne = json['p_one'];
    participantTwo = json['p_two'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room_id'] = roomId;
    data['room_type'] = roomType;
    data['p_one'] = participantOne;
    data['p_two'] = participantTwo;
    data['created_time'] = createdTime;
    return data;
  }
}
