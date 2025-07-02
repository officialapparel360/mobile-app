import 'dart:convert';
import 'dart:io';

import 'package:apparel_360/core/network/network_call_interface.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

class BaseClient implements NetworkCallInterface {
  final String baseUrl = "http://apparels360.in/api/";

  @override
  Future<dynamic> get(String url, {Map<String, dynamic>? data}) async {
    try {
      Uri uri = Uri.parse('$baseUrl$url').replace(queryParameters: data);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  @override
  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl$url'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  @override
  Future<void> uploadProfilePicture({
    required String userId,
    required File profileImage,
    required String picturePath,
  }) async {
    try {
      var uri =
          Uri.parse('http://apparels360.in/api/Account/UpdateProfileImage');
      var request = http.MultipartRequest('POST', uri);

      request.fields['UserId'] = userId;
      request.fields['PicturePath'] = picturePath;

      String extension = path.extension(profileImage.path).toLowerCase();

      MediaType? contentType;
      if (extension == '.jpg' || extension == '.jpeg') {
        contentType = MediaType('image', 'jpeg');
      } else if (extension == '.png') {
        contentType = MediaType('image', 'png');
      } else {
        throw Exception('Unsupported file format');
      }
      request.files.add(
        await http.MultipartFile.fromPath(
          'ProfileImage',
          profileImage.path,
          contentType: contentType,
        ),
      );

      var response = await request.send();

      // Read and handle response
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var parseResponse = jsonDecode(responseBody);
        return parseResponse;
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception('Failed to post data');
    }
  }
}
