import 'dart:io';

abstract class NetworkCallInterface {
  Future<dynamic> get(String url, {Map<String, dynamic>? data}) async {}

  Future<dynamic> post(String url, Map<String, dynamic> body) async {}

  Future<void> uploadProfilePicture(
      {required String userId,
      required File profileImage,
      required String picturePath}) async {}
}
