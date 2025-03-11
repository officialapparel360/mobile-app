import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/core/utils/app_constant.dart';
import 'package:apparel_360/presentation/screens/dashboard/chat-component/chat_bloc.dart';
import 'package:apparel_360/presentation/screens/dashboard/chat-component/chat_body_widget.dart';
import 'package:apparel_360/presentation/screens/dashboard/chat-component/chat_top_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ChatTopViewWidget(),
            Expanded(
                child: ChatBodyWidget(
              messages: _messages,
              scrollController: _scrollController,
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28.0),
                          border:
                              Border.all(color: AppColor.black500, width: 1.0)),
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
                        onPressed: _sendMessage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    // bloc.add(SendMessageEvent(
    //     chatMessage: _messageController.text,
    //     receiverUserID: 'receiverUserID',
    //     senderUserID: 'senderUserID'));
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({"text": _messageController.text, "sender": "me"});
        _messageController.clear();
      });
      _scrollToBottom();
    }
  }

  void _receiveMessage(String message) {
    setState(() {
      _messages.add({"text": message, "sender": "other"});
    });
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
}
