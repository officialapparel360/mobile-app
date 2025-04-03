import 'package:apparel_360/core/app_style/app_callback.dart';
import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:flutter/material.dart';

class ChatBodyWidget extends StatelessWidget {
  ChatBodyWidget({
    super.key,
    this.copyMessage,
    required this.messages,
    required this.scrollController,
    required this.senderUserID,
  });

  StringToVoidCallBack? copyMessage;
  final List<Map<String, String>> messages;
  final ScrollController scrollController;
  final String senderUserID;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: ListView.builder(
        controller: scrollController, // Attach scroll controller
        padding: const EdgeInsets.all(10),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final isMe = messages[index]["sender"] == senderUserID;

          return Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: GestureDetector(
              onLongPress: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    MediaQuery.of(context).size.width * 0.5, // X Position
                    MediaQuery.of(context).size.height * 0.6, // Y Position
                    0,
                    0,
                  ),
                  items: [
                    PopupMenuItem(
                      value: 'copy',
                      child: const Text('Copy'),
                      onTap: () {
                        if (copyMessage != null) {
                          copyMessage!(message["text"]!);
                        }
                      },
                    ),
                  ],
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isMe ? AppColor.primaryColor : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  message["text"]!,
                  style: TextStyle(color: isMe ? Colors.white : Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
