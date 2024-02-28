import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_admin/screen/Property/FirstProperty/MenuPage/My%20Account/ChatUsers/view/search_screen.dart';

import '../UsersChat/chat_screen.dart';
import '../../../../../Chat/provider/firebase_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.uid});
  final String uid;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
        .getAllUsers(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox(),
        backgroundColor: const Color.fromARGB(255, 114, 214, 190),
        title: Text(
          'Chat ${widget.uid}',
          style: const TextStyle(fontSize: 10),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UsersSearchScreen(myuid: widget.uid),
                    ));
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              )),
          // IconButton(
          //     onPressed: () {
          //       FirebaseAuth.instance.signOut();
          //     },
          //     icon: const Icon(
          //       Icons.logout,
          //       color: Colors.black,
          //     ))
        ],
      ),
      body: Consumer<FirebaseProvider>(
        builder: (context, value, child) {
          if (value.users == null || value.users!.groups.isEmpty) {
            return const SizedBox();
          }

          return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: value.users!.groups.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Chat_Message(
                              uid: widget.uid,
                              userId: value.users!.groups[index].toString()),
                        ));
                  },
                  child: Row(
                    children: [
                      const CircleAvatar(
                          radius: 25, backgroundColor: Colors.yellow),
                      const SizedBox(width: 10),
                      Text(value.users!.groups[index].toString()),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
