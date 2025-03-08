part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class LoadUserChat extends ChatState {}

class LoadedUserChat extends ChatState {
  List<UserDetail> userDetail;

  LoadedUserChat(this.userDetail);
}