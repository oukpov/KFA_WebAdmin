// ignore_for_file: use_build_context_synchronously
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../service/firebase_firestore_service.dart';
import '../service/media_service.dart';
import 'constants.dart';
import 'custom_text_form_field.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField(
      {super.key,
      required this.receiverId,
      required this.uid,
      this.checkmessage});
  final String receiverId;
  final String uid;
  final checkmessage;
  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: controller,
            hintText: 'Add Message...',
          ),
        ),
        const SizedBox(width: 5),
        CircleAvatar(
          backgroundColor: mainColor,
          radius: 20,
          child: IconButton(
              onPressed: () {
                sendText(context);
                // print(widget.receiverId);
                // print(widget.uid);
              },
              icon: const Icon(Icons.send)),
        ),
        const SizedBox(width: 5),
        CircleAvatar(
          backgroundColor: mainColor,
          radius: 20,
          child: IconButton(
              onPressed: () {
                if (widget.checkmessage != null) {
                  sendImage();
                } else {
                  addGroupToUser(widget.receiverId);
                  usergetYouruid(widget.receiverId);
                }
              },
              icon: const Icon(Icons.camera_alt_outlined)),
        ),
      ],
    );
  }

  void addGroupToUser(uid) async {
    if (uid != 'null') {
      try {
        DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('users').doc(widget.uid);
        await userDocRef.update({
          'groups': FieldValue.arrayUnion(['$uid'])
        });

        print('Group added successfully to user ');
      } catch (e) {
        print('Error adding group to user: $e');
      }
    }
  }

  void usergetYouruid(uid) async {
    if (uid != 'null' && widget.uid != uid) {
      try {
        DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('users').doc(uid);
        await userDocRef.update({
          'groups': FieldValue.arrayUnion([widget.uid])
        });

        print('Group added successfully to user ');
      } catch (e) {
        print('Error adding group to user: $e');
      }
    }
  }

  Future<void> sendText(BuildContext context) async {
    if (controller.text.isNotEmpty) {
      await FirebaseFirestoreService.addTextMessage(
          content: controller.text,
          receiverId: widget.receiverId,
          uid: widget.uid);
      controller.clear();
      FocusScope.of(context).unfocus();
    }
    FocusScope.of(context).unfocus();
  }

  Uint8List? file;
  Future<void> sendImage() async {
    final pickImage = await MediaService.pickImage();
    setState(() {
      file = pickImage;
    });
    if (file != null) {
      await FirebaseFirestoreService.addImageMessage(
          receiverId: widget.receiverId, file: file!, uid: widget.uid);
    }
  }
}
