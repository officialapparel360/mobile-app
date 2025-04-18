import 'dart:convert';

import 'package:apparel_360/core/network/network_call_interface.dart';
import 'package:http/http.dart' as http;

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
}
