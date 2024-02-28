import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Model/User_Model.dart.dart';
import '../Model/message.dart';
import 'firebase_storage_service.dart';

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;

  static Future<void> createUser({
    required String fullName,
    required String image,
    required String email,
    required String uid,
    required List groups,
    // required String token
  }) async {
    final user = UsersModel(
      uid: uid,
      email: email,
      fullName: fullName,
      image: image,
      isOnline: true,
      lastActive: DateTime.now(),
      groups: groups,
      // token: token,
    );

    await firestore.collection('users').doc(uid).set(user.toJson());
  }

  static Future<void> addTextMessage({
    required String content,
    required String receiverId,
    required String uid,
  }) async {
    final message = Message(
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.text,
      senderId: uid,
    );

    await _addMessageToChat(receiverId, message, uid);
  }

  static Future<void> _addMessageToChat(
      String receiverId, Message message, String uid) async {
    await firestore
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add(message.toJson());

    await firestore
        .collection('chat')
        .doc(uid)
        .collection('messages')
        .add(message.toJson());
  }

  static Future<void> addImageMessage(
      {required String receiverId,
      required Uint8List file,
      required String uid}) async {
    final image = await FirebaseStorageService.uploadImage(
        file, 'image/chat/${DateTime.now()}');

    final message = Message(
      content: image,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.image,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    // await _addMessageToChat(receiverId, message, uid);
  }

  static Future<void> updateUserData(Map<String, dynamic> data) async =>
      await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data);

  // static Future<List<UserSearchModel>> searchUser(String fullName) async {
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .where("fullName", isGreaterThanOrEqualTo: fullName)
  //       .get();
  //   return snapshot.docs
  //       .map((doc) => UserSearchModel.fromJson(doc.data()))
  //       .toList();
  // }
}
      // content: content,
      // sentTime: DateTime.now(),
      // receiverId: receiverId,
      // messageType: MessageType.text,
      // senderId: FirebaseAuth.instance.currentUser!.uid,