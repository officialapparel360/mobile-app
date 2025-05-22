part of 'chat_bloc.dart';

abstract class ChatState {
  ChatState();
}

class ChatInitialState extends ChatState {}

class ChatLoadSuccessState extends ChatState {
  List<UserDetail> userDetail;

  ChatLoadSuccessState(this.userDetail);
}

class ChatLoadFailState extends ChatState {}

class FetchMessagesSuccessState extends ChatState {
  List<Map<String, String>> messages;

  FetchMessagesSuccessState({required this.messages});
}

class SendMessagesSuccessState extends ChatState {}

class ChatLoadingState extends ChatState {}

class UserListLoadingState extends ChatState {}

class SignalRConnectionSuccess extends ChatState {
  bool isSignalRConnected;

  SignalRConnectionSuccess({required this.isSignalRConnected});
}
