import 'package:apparel_360/core/network/repository.dart';
import 'package:apparel_360/core/services/service_locator.dart';
import 'package:apparel_360/data/model/chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/model/user_model.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final NetworkRepository _networkRepository = getIt<NetworkRepository>();

  ChatBloc(super.initialState) {
    on<LoadedUserList>((event, emit) async {
      final senderId = event.senderId;
      Map<String, dynamic> userIdMap = {"userId": senderId};
      final data = await _networkRepository.getUserList(userIdMap);
      if (data["type"] == "success") {
        List<UserDetail> userData = (data["data"] as List).map((item) => UserDetail.fromJson(item)).toList();
        emit(ChatLoadSuccessState(userData));
      }
    });


    on<SendMessageEvent>((event, emit) async {
      emit(ChatLoadingState());
      try {
        final data = await _networkRepository.sendMessage({
          "senderUserID": event.senderUserID,
          "receiverUserID": event.receiverUserID,
          "chatMessage": event.chatMessage,
        });

        if (data["type"] == "success") {
          emit(SendMessagesState());
          add(FetchMessagesEvent(
            receiverUserID: event.receiverUserID,
            senderUserID: event.senderUserID,
          ));
        } else {
          emit(ChatLoadFailState());
        }
      } catch (e) {
        emit(ChatLoadFailState());
      }
    });

    on<FetchMessagesEvent>((event, emit) {
      _fetchMessage(
          receiverUserID: event.receiverUserID,
          senderUserID: event.senderUserID);
    });
  }

  Future<void> _sendMessage(
      {required String senderUserID,
      required String receiverUserID,
      required String chatMessage}) async {
    final Map<String, dynamic> body = {
      "senderUserID": senderUserID,
      "receiverUserID": receiverUserID,
      "chatMessage": chatMessage
    };

      final data = await _networkRepository.sendMessage(body);
      emit(SendMessagesState());

  }

  Future<void> _fetchMessage(
      {required String senderUserID,
        required String receiverUserID,
        }) async {
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
        emit(FetchMessagesState(chatData));
      }
    } catch (e) {
      print("Error storing message: $e");
    }
  }
}
