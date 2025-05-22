import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  String type;
  String code;
  String message;
  ProfileData data;

  ProfileResponse({
    required this.type,
    required this.code,
    required this.message,
    required this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        type: json["type"],
        code: json["code"],
        message: json["message"],
        data: ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class ProfileData {
  String? userId;
  dynamic name;
  dynamic profilePicPath;
  dynamic shopName;
  dynamic gstNo;
  dynamic city;
  dynamic pinCode;
  dynamic userType;
  dynamic purchaseQty;
  int? isSucess;

  ProfileData({
    this.userId,
    this.name,
    this.profilePicPath,
    this.shopName,
    this.gstNo,
    this.city,
    this.pinCode,
    this.userType,
    this.purchaseQty,
    this.isSucess,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        userId: json["userId"],
        name: json["name"],
        profilePicPath: json["profilePicPath"],
        shopName: json["shopName"],
        gstNo: json["gstNo"],
        city: json["city"],
        pinCode: json["pinCode"],
        userType: json["userType"],
        purchaseQty: json["purchaseQty"],
        isSucess: json["isSucess"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "profilePicPath": profilePicPath,
        "shopName": shopName,
        "gstNo": gstNo,
        "city": city,
        "pinCode": pinCode,
        "userType": userType,
        "purchaseQty": purchaseQty,
        "isSucess": isSucess,
      };
}
