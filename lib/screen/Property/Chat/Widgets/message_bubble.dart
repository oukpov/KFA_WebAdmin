// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import '../Model/message.dart';
import 'constants.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble(
      {super.key,
      required this.isMe,
      required this.isImage,
      required this.message,
      required this.me,
      required this.receiverId});

  final bool isMe;
  final bool isImage;
  final Message message;
  final String me;
  final String receiverId;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) => Align(
        alignment: widget.isMe ? Alignment.topRight : Alignment.topLeft,
        child: (widget.me == widget.message.receiverId ||
                widget.me == widget.message.senderId)
            ? Container(
                decoration: BoxDecoration(
                    color: widget.isMe
                        ? mainColor
                        : const Color.fromARGB(255, 111, 109, 109),
                    borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: widget.isMe
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    // isImage
                    // ? Container(
                    //     height: 200,
                    //     width: 200,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       image: DecorationImage(
                    //         image: NetworkImage(message.content),
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //   )
                    InkWell(
                      onTap: () {
                        setState(() {
                          checkUrlType(widget.message.content);
                        });
                      },
                      child: Text(widget.message.content,
                          style: const TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      timeago.format(widget.message.sentTime),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ))
            : const SizedBox(),
      );

  void checkUrlType(String url) {
    RegExp httpRegex = RegExp(r'^http://');
    RegExp httpsRegex = RegExp(r'^https://');

    if (httpRegex.hasMatch(url)) {
      link(url);
    } else if (httpsRegex.hasMatch(url)) {
      link(url);
    } else {}
  }

  void link(url) async {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  }
}
