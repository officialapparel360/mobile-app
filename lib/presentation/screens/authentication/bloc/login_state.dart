part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class GetOtpLoadingState extends LoginState {}

class GetOtpSuccessState extends LoginState {
  String otp;

  GetOtpSuccessState({required this.otp});
}

class GetOtpFailState extends LoginState {
  String errorMessage;

  GetOtpFailState({required this.errorMessage});
}

class LoginUserSuccessState extends LoginState {}

class LoginUserFailState extends LoginState {}
