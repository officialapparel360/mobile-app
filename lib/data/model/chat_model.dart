import 'dart:convert';

List<ChatModel> chatModelFromJson(String str) => List<ChatModel>.from(json.decode(str).map((x) => ChatModel.fromJson(x)));

String chatModelToJson(List<ChatModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatModel {
  String? receiverUserID;
  String? senderUserID;
  String? chatMessage;

  ChatModel({
    this.chatMessage,
    this.receiverUserID,
    this.senderUserID,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    chatMessage: json["chatMessage"],
    receiverUserID: json["receiverUserID"],
    senderUserID: json["senderUserID"],
  );

  Map<String, dynamic> toJson() => {
    "chatMessage": chatMessage,
    "senderUserID": senderUserID,
    "receiverUserID": receiverUserID,
  };
}