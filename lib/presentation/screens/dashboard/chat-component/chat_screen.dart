import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/core/utils/app_constant.dart';
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

  void _sendMessage() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios_new),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: CircleAvatar(),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Vishu'),
                            Text('last seen today at 11:45pm'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.settings),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: AppColor.primaryColor
                    .withValues(alpha: 0.4, blue: 1, green: 0.8, red: 0.9),
                child: ListView.builder(
                  controller: _scrollController, // Attach scroll controller
                  padding: const EdgeInsets.all(10),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isMe = message["sender"] == "me";

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: GestureDetector(
                        onLongPress: () {
                          showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                              MediaQuery.of(context).size.width *
                                  0.5, // X Position
                              MediaQuery.of(context).size.height *
                                  0.6, // Y Position
                              0,
                              0,
                            ),
                            items: [
                              PopupMenuItem(
                                value: 'copy',
                                child: const Text('Copy'),
                                onTap: () => _copyToClipboard(message["text"]!),
                              ),
                            ],
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe
                                ? AppColor.primaryColor.withValues(alpha: 0.7)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            message["text"]!,
                            style: TextStyle(
                                color: isMe ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
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
}
