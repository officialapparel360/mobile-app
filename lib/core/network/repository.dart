import 'package:apparel_360/core/network/network_call_interface.dart';

class NetworkRepository {
  final NetworkCallInterface networkCallInterface;

  NetworkRepository(this.networkCallInterface);

  Future<dynamic> login(String mobile, String password) async {
    final body = {"mobileNo": mobile, "password": password};
    return await networkCallInterface.post('Account/Login', body);
  }

  Future<dynamic> otpVerify(Map<String, dynamic> otpData) async {
    return await networkCallInterface.post('Account/VerifyOTP', otpData);
  }

  Future<dynamic> sendMessage(Map<String, dynamic> sendMessageRequest) async {
    return await networkCallInterface.post(
        'Chats/SendMessage', sendMessageRequest);
  }

  Future<dynamic> getUserList(Map<String, dynamic> userId) async {
    return await networkCallInterface.get('Account/GetUsers', data: userId);
  }

  Future<dynamic> fetchMessages(
      Map<String, dynamic> fetchMessagesRequest) async {
    return await networkCallInterface.get('Chats/GetChats',
        data: fetchMessagesRequest);
  }

  Future<dynamic> getProductList() async {
    return await networkCallInterface.get('Product/GetProductList');
  }
}
