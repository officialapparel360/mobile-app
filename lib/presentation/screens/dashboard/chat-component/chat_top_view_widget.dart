import 'package:flutter/material.dart';

class ChatTopViewWidget extends StatelessWidget {
  const ChatTopViewWidget({super.key, required this.topDisplayField});

  final String topDisplayField;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(topDisplayField),
                  ],
                ),
              ),
            ],
          ),
          const Icon(Icons.settings),
        ],
      ),
    );
  }
}
