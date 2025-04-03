import 'dart:convert';

List<UserDetail> userDetailFromJson(String str) => List<UserDetail>.from(json.decode(str).map((x) => UserDetail.fromJson(x)));

String userDetailToJson(List<UserDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDetail {
  String? mappedUserId;
  String? name;
  String? mobileNo;
  String? status;


  UserDetail({
    this.mappedUserId,
    this.name,
    this.mobileNo,
    this.status,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    mappedUserId: json["mappedUserId"],
    name: json["name"],
    status: json["status"],
    mobileNo: json["mobileNo"],
     );

  Map<String, dynamic> toJson() => {
    "mappedUserId": mappedUserId,
    "name": name,
    "status": status,
    "mobileNo": mobileNo,
  };
}
