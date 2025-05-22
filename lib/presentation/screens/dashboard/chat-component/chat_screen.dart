import 'dart:async';

import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/core/utils/app_constant.dart';
import 'package:apparel_360/presentation/screens/dashboard/chat-component/chat_bloc.dart';
import 'package:apparel_360/presentation/screens/dashboard/chat-component/chat_body_widget.dart';
import 'package:apparel_360/presentation/screens/dashboard/chat-component/chat_top_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/signalR_service.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUserID;
  final String senderUserID;
  final String name;
  final String mobileNumber;

  ChatScreen({
    super.key,
    required this.receiverUserID,
    required this.senderUserID,
    required this.mobileNumber,
    required this.name,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ChatBloc bloc;
  SignalRService signalRService = SignalRService();
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    initialiseEvents();
  }

  fetchMessageApi() {
    bloc.add(FetchMessagesEvent(
      receiverUserID: widget.receiverUserID,
      senderUserID: widget.senderUserID,
    ));
  }

  Future<void> initialiseEvents() async {
    bloc = ChatBloc(ChatInitialState());
    fetchMessageApi();
    _startPolling();
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      fetchMessageApi();
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ChatBloc, ChatState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is FetchMessagesSuccessState) {
              _scrollToBottom();
            }
          },
          builder: (context, state) {
            if (state is SendMessagesSuccessState ||
                state is FetchMessagesSuccessState) {
              return buildBody();
            } else if (state is ChatLoadFailState) {
              return const Text('Error');
              //             showCustomToast(context, "Failed to load messages");
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget buildBody() {
    String topDisplayField = '';
    if (widget.name.isNotEmpty) {
      topDisplayField = widget.name;
    } else {
      topDisplayField = widget.mobileNumber;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChatTopViewWidget(
          topDisplayField: topDisplayField,
        ),
        Expanded(
            child: ChatBodyWidget(
          messages: bloc.userMessages,
          scrollController: _scrollController,
          senderUserID: widget.senderUserID,
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.0),
                      border: Border.all(color: AppColor.black500, width: 1.0)),
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: AppConstant.typeAMessage,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: AppColor.white),
                    onPressed: () => _sendMessage(
                        widget.receiverUserID, widget.senderUserID),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _sendMessage(String receiverUserID, String senderUserID) async {
    if (_messageController.text.trim().isNotEmpty) {
      bloc.add(SendMessageEvent(
        chatMessage: _messageController.text,
        receiverUserID: receiverUserID,
        senderUserID: senderUserID,
      ));
    }
    _messageController.clear();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
