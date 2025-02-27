import 'package:apparel_360/core/network/network_call_interface.dart';

class NetworkRepository {
  final NetworkCallInterface networkCallInterface;

  NetworkRepository(this.networkCallInterface);

  Future<dynamic> login(String mobile, String password) async {
    final body ={
      "mobileNo" : mobile,
      "password" : password
    };
    return await networkCallInterface.post('/Login', body);
  }

  Future<dynamic> otpVerify(Map<String, dynamic> otpData) async {
    return await networkCallInterface.post('/VerifyOTP', otpData);
  }
}
