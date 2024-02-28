import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/message.dart';
import '../provider/firebase_provider.dart';
import 'message_bubble.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({super.key, required this.receiverId, required this.sendId});
  final String receiverId;
  final String sendId;

  final messages = [];

  @override
  Widget build(BuildContext context) => Consumer<FirebaseProvider>(
      builder: (context, value, child) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: double.infinity,
          child: ListView.builder(
            controller: Provider.of<FirebaseProvider>(context, listen: false)
                .scrollController,
            itemCount: value.messages.length,
            itemBuilder: (context, index) {
              final isMe = receiverId != value.messages[index].senderId;

              final isTextmessage =
                  value.messages[index].messageType == MessageType.text;
              return isTextmessage
                  ? MessageBubble(
                      receiverId: receiverId,
                      me: sendId,
                      isMe: isMe,
                      isImage: false,
                      message: value.messages[index])
                  : MessageBubble(
                      receiverId: receiverId,
                      me: sendId,
                      isMe: isMe,
                      isImage: true,
                      message: value.messages[index]);
            },
          )));
}
