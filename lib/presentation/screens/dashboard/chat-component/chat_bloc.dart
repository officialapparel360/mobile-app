import 'dart:async';

import 'package:apparel_360/core/network/repository.dart';
import 'package:apparel_360/core/services/service_locator.dart';
import 'package:apparel_360/data/model/chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/model/user_model.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final NetworkRepository _networkRepository = getIt<NetworkRepository>();
  final List<Map<String, String>> userMessages = [];

  final _signalRMessageController = StreamController<dynamic>();

  Stream get messageStream => _signalRMessageController.stream;

  StreamSink get messageSink => _signalRMessageController.sink;

  ChatBloc(super.initialState) {
    on<LoadedUserList>((event, emit) async {
      emit(UserListLoadingState());
      final senderId = event.senderId;
      Map<String, dynamic> userIdMap = {"userId": senderId};
      final data = await _networkRepository.getUserList(userIdMap);
      if (data["type"] == "success") {
        List<UserDetail> userData = (data["data"] as List)
            .map((item) => UserDetail.fromJson(item))
            .toList();
        emit(ChatLoadSuccessState(userData));
      }
    });

    on<SendMessageEvent>((event, emit) async {
      try {
        final data = await _networkRepository.sendMessage({
          "senderUserID": event.senderUserID,
          "receiverUserID": event.receiverUserID,
          "chatMessage": event.chatMessage,
        });

        if (data["type"] == "success") {
          userMessages.add({
            "text": event.chatMessage,
            "sender": event.senderUserID,
          });

          emit(SendMessagesSuccessState());

          emit(FetchMessagesSuccessState(messages: List.from(userMessages)));
        } else {
          emit(ChatLoadFailState());
        }
      } catch (e) {
        print("Error sending message: $e");
        emit(ChatLoadFailState());
      }
    });

    on<FetchMessagesEvent>((event, emit) async {
      await _fetchMessage(
          receiverUserID: event.receiverUserID,
          senderUserID: event.senderUserID,
          emit: emit);
    });

    // on<InitialiseSignalREvent>((event, emit) async {
    //   emit(ChatLoadingState());
    //   bool isConnected = await connectSignalR();
    //   emit(SignalRConnectionSuccess(isSignalRConnected: isConnected));
    // });

    on<UpdateReceiveMessageEvent>((event, emit) {
      emit(SendMessagesSuccessState());
    });
  }

  Future<void> _fetchMessage(
      {required String senderUserID,
      required String receiverUserID,
      required Emitter emit}) async {
    final Map<String, dynamic> body = {
      "senderUserID": senderUserID,
      "receiverUserID": receiverUserID,
    };
    try {
      final data = await _networkRepository.fetchMessages(body);
      if (data["type"] == "success") {
        List<ChatModel> chatData = (data["data"] as List)
            .map((item) => ChatModel.fromJson(item))
            .toList();
        print("Message stored successfullyyyy");
        userMessages.clear();
        userMessages.addAll(chatData.map((chat) => {
              "text": chat.chatMessage ?? "",
              "sender": chat.senderUserID ?? ""
            }));
        emit(FetchMessagesSuccessState(messages: userMessages));
      }
    } catch (e) {
      print("Error storing message: $e");
    }
  }

  onMessageReceived(dynamic messages) {
    // update the userMessagesList
    add(UpdateReceiveMessageEvent());
  }
}
