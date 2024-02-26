import 'package:flutter/material.dart';
import 'package:waterbuddy/Features/Chat/data/massege.dart';

class BotChatBubble extends StatelessWidget {
  const BotChatBubble({
    super.key,
    required this.massege,
  });
  final Massege massege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: const BoxDecoration(
            color: Color(0xffEEEEEE),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        padding: const EdgeInsets.all(16),
        child: Text(
          massege.massege,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.massege,
  });
  final Massege massege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: const BoxDecoration(
            color: Color(0xff13A9EB),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40))),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        padding: const EdgeInsets.all(16),
        child: Text(
          massege.massege,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
