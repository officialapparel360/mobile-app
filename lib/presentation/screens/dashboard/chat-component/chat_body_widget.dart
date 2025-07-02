import 'package:apparel_360/core/app_style/app_callback.dart';
import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      DateTime dateTime = DateFormat("MM/dd/yyyy hh:mm:ss").parse(dateStr);
      return DateFormat("dd MMM yyyy").format(dateTime);
    } catch (e) {
      return '';
    }
  }

  String formatTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      DateTime dateTime = DateFormat("MM/dd/yyyy hh:mm:ss").parse(dateStr);
      return DateFormat("hh:mm a").format(dateTime);
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    String? lastDateHeader;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chat_bg.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(10),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isMe = message["sender"] == senderUserID;
            final messageDate = message["messageDate"] ?? "";
            final formattedDate = formatDate(messageDate);
            final formattedTime = formatTime(messageDate);
            Widget dateHeader = const SizedBox.shrink();
            if (lastDateHeader != formattedDate) {
              lastDateHeader = formattedDate;
              dateHeader = Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    formattedDate,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                dateHeader, // show date header if applicable
                GestureDetector(
                  onLongPress: () {
                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                          MediaQuery.of(context).size.width * 0.5,
                          MediaQuery.of(context).size.height * 0.6,
                          0,
                          0),
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
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isMe ? AppColor.primaryColor : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message["text"]!,
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          formattedTime,
                          style: TextStyle(
                            color: isMe ? Colors.white70 : Colors.black54,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
