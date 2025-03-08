part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class UserChatList extends ChatEvent{}

class LoadUserData extends ChatEvent {
}
class UserDataLoaded extends ChatEvent {
}
