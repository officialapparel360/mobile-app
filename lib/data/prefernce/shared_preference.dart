import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _tokenKey = "auth_token";
  static const String _isLoggedInKey = "is_logged_in";

  // Save Token
  static Future<void> saveUserId(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Get Token
  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Save Login Status
  static Future<void> setLoginStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  // Get Login Status
  static Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false; // Default to false
  }

  // Clear All Data (Logout)
  static Future<void> clearPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Save Login Status
  static Future<void> setLoginFormRequiredAndNotFilled(
      bool loginFormRequiredNotFilled) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'loginFormRequiredNotFilled', loginFormRequiredNotFilled);
  }

  static Future<bool> getLoginFormRequiredAndNotFilled() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loginFormRequiredNotFilled') ?? false;
  }
}
