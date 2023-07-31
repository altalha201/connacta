class MessageModel {
  String? messageId;
  String? chatID;
  String? senderId;
  String? senderName;
  String? senderDpUrl;
  String? messageType;
  String? mainMessage;
  String? createdTime;

  MessageModel(
      {this.messageId,
        this.chatID,
        this.senderId,
        this.senderName,
        this.senderDpUrl,
        this.messageType,
        this.mainMessage,
        this.createdTime});

  MessageModel.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    chatID = json['chat_id'];
    senderId = json['sender_id'];
    senderName = json['sender_name'];
    senderDpUrl = json['sender_dp_url'];
    messageType = json['message_type'];
    mainMessage = json['main_message'];
    createdTime = json['created_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_id'] = messageId;
    data['chat_id'] = chatID;
    data['sender_id'] = senderId;
    data['sender_name'] = senderName;
    data['sender_dp_url'] = senderDpUrl;
    data['message_type'] = messageType;
    data['main_message'] = mainMessage;
    data['created_time'] = createdTime;
    return data;
  }
}
