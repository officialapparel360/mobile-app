import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/core/utils/app_constant.dart';
import 'package:apparel_360/presentation/screens/dashboard/chat-component/chat_bloc.dart';
import 'package:apparel_360/presentation/screens/dashboard/chat-component/chat_body_widget.dart';
import 'package:apparel_360/presentation/screens/dashboard/chat-component/chat_top_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/signalR_service.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUserID;
  final String senderUserID;

  ChatScreen(
      {super.key, required this.receiverUserID, required this.senderUserID});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  late ChatBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ChatBloc(ChatInitialState());
    _receiveMessage(widget.receiverUserID, widget.senderUserID);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(ChatInitialState())
        ..add(
          FetchMessagesEvent(
            receiverUserID: widget.receiverUserID,
            senderUserID: widget.senderUserID,
          ),
        ),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is FetchMessagesState) {
                _messages.clear();
              } else if (state is SendMessagesState) {
                _messageController.clear();
                _receiveMessage(widget.receiverUserID, widget.senderUserID);
              } else if (state is ChatLoadFailState) {
                //             showCustomToast(context, "Failed to load messages");
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ChatTopViewWidget(),
                  Expanded(
                      child: _buildChatBody(context, state)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28.0),
                                border: Border.all(
                                    color: AppColor.black500, width: 1.0)),
                            child: TextField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppConstant.typeAMessage,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15)),
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
            },
          ),
        ),
      ),
    );
  }


  void _sendMessage(String receiverUserID, String senderUserID) async{
    if (_messageController.text.trim().isNotEmpty) {
      SignalRService signalRService = SignalRService();
      bool isConnected = await signalRService.connect();
      if(isConnected){
        context.read<ChatBloc>().add(
          SendMessageEvent(
            chatMessage: _messageController.text,
            receiverUserID: receiverUserID,
            senderUserID: senderUserID,
          ),
        );
      }
    }
    _messageController.clear();
  }

  void _receiveMessage(String receiverUserID, String senderUserID) {
    context.read<ChatBloc>().add(
      FetchMessagesEvent(
        receiverUserID: receiverUserID,
        senderUserID: senderUserID,
      ),
    );
    _scrollToBottom();
  }

  void _copyToClipboard(String message) {
    FocusScope.of(context).unfocus(); // Close keyboard
    Clipboard.setData(ClipboardData(text: message));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Message copied!")),
    );
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildChatBody(BuildContext context, ChatState state) {
    if (state is FetchMessagesState) {
      _messages.clear(); // Clear previous messages
      _messages.addAll(state.messages.map((chat) => {
        "text": chat.chatMessage ?? "",
        "sender": chat.senderUserID??""
      }));
    } else if (state is SendMessagesState) {
      _messageController.clear();
      context.read<ChatBloc>().add(
        FetchMessagesEvent(
          receiverUserID: widget.receiverUserID,
          senderUserID: widget.senderUserID,
        ),
      );
    } else if (state is ChatLoadFailState) {
      return Center(child: Text("Failed to load messages"));
    }
    return ChatBodyWidget(
      messages: _messages,
      scrollController: _scrollController,
      senderUserID: widget.senderUserID,
    );
  }

}


