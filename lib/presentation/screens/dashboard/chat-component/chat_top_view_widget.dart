import 'package:apparel_360/core/app_style/app_text_style.dart';
import 'package:apparel_360/presentation/screens/dashboard/chat-component/chat_profile_page.dart';
import 'package:flutter/material.dart';

class ChatTopViewWidget extends StatelessWidget {
  const ChatTopViewWidget(
      {super.key, required this.topDisplayField, required this.chatUserId});

  final String topDisplayField;
  final String chatUserId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xfff3e9d4),
            Color(0xffefe4dc),
            Color(0xffececdc),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) =>
                            ChatProfilePage(userId: chatUserId)));
              },
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: CircleAvatar(),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          topDisplayField,
                          style: AppTextStyle.getFont17Style(),
                        ),
                      ],
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
