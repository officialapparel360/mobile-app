import 'package:apparel_360/core/network/repository.dart';
import 'package:apparel_360/core/services/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final NetworkRepository _networkRepository = getIt<NetworkRepository>();

  ChatBloc(super.initialState) {
    on<LoadChatEvent>((event, emit) {
      emit(ChatLoadSuccessState());
    });

    on<SendMessageEvent>((event, emit) {
      _sendMessage(
          chatMessage: event.chatMessage,
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

    try {
      final response = await _networkRepository.sendMessage(body);

      if (response.statusCode == 200) {
        print("Message stored successfully");
      } else {
        print("Failed to store message: ${response.body}");
      }
    } catch (e) {
      print("Error storing message: $e");
    }
  }
}
