import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class SignalRService {
  late HubConnection _hubConnection;

  SignalRService() {
    _hubConnection = HubConnectionBuilder()
        .withUrl('http://apparels360.in/chat-hub')
        .build();

    _hubConnection.onclose(
      ({error}) => print('error while closing signalR'),
    );

    _hubConnection.on("ReceiveMessage", (message) {
      print("New message received: ${message?[0]}");
    });

    _hubConnection.on("Users", (message) {
 //     onUsersUpdate(message);
    });

    _hubConnection.on("Messages", (message) {
 //     onMessageReceived(message);
    });
  }

  Future<bool> connect() async {
    try {
      await _hubConnection.start();
      if (_hubConnection.state == HubConnectionState.Connected) {
        return true;
      } else {
        return false;
      }
      print('SignalR connected');
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
