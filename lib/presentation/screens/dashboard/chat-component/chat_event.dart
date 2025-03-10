part of 'chat_bloc.dart';

abstract class ChatEvent {
  ChatEvent();
}

class LoadChatEvent extends ChatEvent {}
