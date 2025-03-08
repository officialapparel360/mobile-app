import 'dart:convert';

import 'package:apparel_360/data/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<LoadUserData>((event, emit) async {
      String user = await rootBundle.loadString('assets/raw/user.json');
      final jsonResult = jsonDecode(user) as List<dynamic>;
      List<UserDetail> userDetails = jsonResult.map((e) => UserDetail.fromJson(e)).toList();
      emit(LoadedUserChat(userDetails));
    });
  }
}
