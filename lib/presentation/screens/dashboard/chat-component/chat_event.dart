part of 'chat_bloc.dart';

abstract class ChatEvent {
  ChatEvent();
}

class LoadChatEvent extends ChatEvent {}

class LoadedUserList extends ChatEvent {
  String senderId;

  LoadedUserList({required this.senderId});
}

class SendMessageEvent extends ChatEvent {
  String senderUserID;
  String receiverUserID;
  String chatMessage;

  SendMessageEvent(
      {required this.chatMessage,
      required this.receiverUserID,
      required this.senderUserID});
}

class FetchMessagesEvent extends ChatEvent {
  String senderUserID;
  String receiverUserID;

  FetchMessagesEvent(
      {required this.receiverUserID,
        required this.senderUserID});
}