part of 'chat_bloc.dart';

abstract class ChatState {
  ChatState();
}

class ChatInitialState extends ChatState {}

class ChatLoadSuccessState extends ChatState {}

class ChatLoadFailState extends ChatState {}
