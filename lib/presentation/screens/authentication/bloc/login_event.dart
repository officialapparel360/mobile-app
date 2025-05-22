part of 'login_bloc.dart';

abstract class LoginEvent {}

class GetOtpEvent extends LoginEvent {
  String mobileNumber;

  GetOtpEvent({required this.mobileNumber});
}

class LoginUserEvent extends LoginEvent {
  String mobileNumber;
  String otp;

  LoginUserEvent({required this.mobileNumber, required this.otp});
}
