import 'package:flutter_bloc/flutter_bloc.dart';
import 'signalr_service.dart';

part 'signalr_state.dart';

class SignalRCubit extends Cubit<SignalRState> {
  late final SignalRService _signalRService;

  SignalRCubit() : super(SignalRInitial());

  Future<void> initConnection() async {
    _signalRService = SignalRService(onMessageReceived: (data) {
      emit(SignalRMessageReceived(data));
    });

    final connected = await _signalRService.connect();
    if (connected) {
      emit(SignalRConnected());
    } else {
      emit(SignalRError('Failed to connect'));
    }
  }

  void sendMessage(String receiverId, String senderId, String message) {
    _signalRService.sendMessage(receiverId, senderId, message);
  }

  void disconnect() {
    _signalRService.disconnect();
    emit(SignalRDisconnected());
  }
}
