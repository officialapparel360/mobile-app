part of 'chat_bloc.dart';

abstract class ChatEvent {
  ChatEvent();
}

class LoadChatEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  String senderUserID;
  String receiverUserID;
  String chatMessage;

  SendMessageEvent(
      {required this.chatMessage,
      required this.receiverUserID,
      required this.senderUserID});
}
