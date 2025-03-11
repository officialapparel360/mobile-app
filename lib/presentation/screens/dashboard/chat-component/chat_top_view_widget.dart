import 'package:flutter/material.dart';

class ChatTopViewWidget extends StatelessWidget {
  const ChatTopViewWidget({super.key});

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
    );
  }
}
