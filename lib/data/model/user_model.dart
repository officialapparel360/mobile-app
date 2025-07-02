import 'dart:convert';

List<UserDetail> userDetailFromJson(String str) =>
    List<UserDetail>.from(json.decode(str).map((x) => UserDetail.fromJson(x)));

String userDetailToJson(List<UserDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDetail {
  String? mappedUserId;
  String? name;
  String? mobileNo;
  String? status;
  String? shopName;
  String? profilePicPath;

  UserDetail(
      {this.mappedUserId,
      this.name,
      this.mobileNo,
      this.status,
      this.shopName,
      this.profilePicPath});

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
      mappedUserId: json["mappedUserId"],
      name: json["name"],
      status: json["status"],
      mobileNo: json["mobileNo"],
      shopName: json["shopName"],
      profilePicPath: json["profilePicPath"]);

  Map<String, dynamic> toJson() => {
        "mappedUserId": mappedUserId,
        "name": name,
        "status": status,
        "mobileNo": mobileNo,
      };
}
