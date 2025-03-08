import 'dart:convert';

List<UserDetail> userDetailFromJson(String str) => List<UserDetail>.from(json.decode(str).map((x) => UserDetail.fromJson(x)));

String userDetailToJson(List<UserDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDetail {
  int? id;
  String? name;
  String? profileImage;
  String? lastMessage;
  bool? isRead;
  DateTime? timestamp;

  UserDetail({
    this.id,
    this.name,
    this.profileImage,
    this.lastMessage,
    this.isRead,
    this.timestamp,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    id: json["id"],
    name: json["name"],
    profileImage: json["profile_image"],
    lastMessage: json["last_message"],
    isRead: json["is_read"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_image": profileImage,
    "last_message": lastMessage,
    "is_read": isRead,
    "timestamp": timestamp?.toIso8601String(),
  };
}
