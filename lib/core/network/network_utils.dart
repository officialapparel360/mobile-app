import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionUtil {
  ConnectionUtil._privateConstructor();

  static final ConnectionUtil _instance = ConnectionUtil._privateConstructor();

  factory ConnectionUtil() {
    return _instance;
  }

  Future<bool> checkInternetStatus() async {
    return await _isConnectedToInternet();
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<bool> _isConnectedToInternet() async {
    if (await _checkConnectivity()) {
      return await _hasInternetAccess();
    }
    return false;
  }

  Future<bool> _hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}