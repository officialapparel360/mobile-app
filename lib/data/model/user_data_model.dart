import 'dart:convert';

UserList userListFromJson(String str) => UserList.fromJson(json.decode(str));

String userListToJson(UserList data) => json.encode(data.toJson());

class UserList {
  String? type;
  String? code;
  String? message;
  List<Datum>? data;

  UserList({
    this.type,
    this.code,
    this.message,
    this.data,
  });

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
    type: json["type"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "code": code,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? mappedUserId;
  String? mobileNo;
  String? name;
  String? status;

  Datum({
    this.mappedUserId,
    this.mobileNo,
    this.name,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    mappedUserId: json["mappedUserId"],
    mobileNo: json["mobileNo"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "mappedUserId": mappedUserId,
    "mobileNo": mobileNo,
    "name": name,
    "status": status,
  };
}
