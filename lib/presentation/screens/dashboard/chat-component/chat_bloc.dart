import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(super.initialState) {
    on<LoadChatEvent>((event, emit) {
      emit(ChatLoadSuccessState());
    });
  }
}
