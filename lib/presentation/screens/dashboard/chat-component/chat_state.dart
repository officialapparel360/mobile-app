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

class FetchMessagesState extends ChatState {
  List<ChatModel> messages;

  FetchMessagesState(this.messages);
}

class SendMessagesState extends ChatState {}

class ChatLoadingState extends ChatState {}

