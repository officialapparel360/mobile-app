import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class SignalRService {
  late HubConnection _hubConnection;


  void receiveMessage({required Function(dynamic) onMessageReceived}) {
    _hubConnection.on("Messages", (message) {
      onMessageReceived(message);
    });
  }

  Future<bool> connect() async {
    try {
      _hubConnection = HubConnectionBuilder()
          .withUrl('http://apparels360.in/chat-hub')
          .build();
      await _hubConnection.start();
      if (_hubConnection.state == HubConnectionState.Connected) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error is coming while connecting ${e.toString()}');
      return false;
    }
  }

  Future<void> sendMessage(
      String receiverId, String senderId, String message) async {
    if (_hubConnection.state == HubConnectionState.Connected) {
      await _hubConnection
          .invoke("SendMessage", args: [receiverId, senderId, message]);
    }
  }

  void disconnect() {
    _hubConnection.stop();
  }
}
