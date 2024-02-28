import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_admin/screen/Property/Chat/provider/firebase_provider.dart';
import 'package:web_admin/screen/Property/Chat/service/firebase_firestore_service.dart';

import '../../../../../Chat/Widgets/chat_messages.dart';
import '../../../../../Chat/Widgets/chat_text_field.dart';

class Chat_Message extends StatefulWidget {
  const Chat_Message({super.key, required this.userId, required this.uid});

  final String userId;
  final String uid;
  @override
  State<Chat_Message> createState() => _Chat_MessageState();
}

class _Chat_MessageState extends State<Chat_Message>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getUserById(widget.userId)
      ..getMessages(widget.userId);
    getUser();
    super.initState();
  }

  String url = '';
  void getUser() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/users/firebase/${widget.userId}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        var list = jsonDecode(json.encode(response.data));
        url = list[0]['url'];
        print(list.toString());
      });
    } else {
      print(response.statusMessage);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        FirebaseFirestoreService.updateUserData({
          'lastActive': DateTime.now(),
          'isOnline': true,
        });
        break;

      case AppLifecycleState.inactive:

      case AppLifecycleState.paused:

      case AppLifecycleState.detached:
        FirebaseFirestoreService.updateUserData({'isOnline': false});
        break;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Consumer<FirebaseProvider>(
            builder: (context, value, child) => (value.messages.isEmpty)
                ? Column(
                    children: [
                      ChatTextField(
                        checkmessage: value.user!.uid,
                        receiverId: widget.userId,
                        uid: widget.uid,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      ChatMessages(
                          receiverId: value.user!.uid, sendId: widget.uid),
                      ChatTextField(
                        checkmessage: value.user!.uid,
                        receiverId: widget.userId,
                        uid: widget.uid,
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> sendText(BuildContext context) async {
    await FirebaseFirestoreService.addTextMessage(
        content: '👋', receiverId: widget.userId, uid: widget.uid);

    FocusScope.of(context).unfocus();
  }

  AppBar buildAppbar() => AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back)),
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,
      title: Consumer<FirebaseProvider>(
          builder: (context, value, child) => value.user != null
              ? Row(
                  children: [
                    (url == '')
                        ? const Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                            ),
                          )
                        : CircleAvatar(
                            // backgroundColor: Colors.red,
                            backgroundImage: NetworkImage(url),
                          ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          value.user!.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Text(
                        //   value.user!.isOnline ? 'Online' : 'Offline',
                        //   style: TextStyle(
                        //     color: value.user!.isOnline
                        //         ? Colors.green
                        //         : Colors.grey,
                        //     fontSize: 14,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                )
              : const SizedBox()));
}
