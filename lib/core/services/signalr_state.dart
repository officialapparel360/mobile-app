part of 'signalRCubit.dart';

abstract class SignalRState {}

class SignalRInitial extends SignalRState {}

class SignalRConnected extends SignalRState {}

class SignalRDisconnected extends SignalRState {}

class SignalRError extends SignalRState {
  final String message;
  SignalRError(this.message);
}

class SignalRMessageReceived extends SignalRState {
  final dynamic message;
  SignalRMessageReceived(this.message);
}
