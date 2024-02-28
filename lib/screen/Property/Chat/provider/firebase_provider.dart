import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/User_Model.dart.dart';
import '../Model/Users_Model.dart';
import '../Model/Users_SearchModel.dart';
import '../Model/message.dart';

class FirebaseProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();
  UserModel? user;
  UsersModel? users;
  List<Message> messages = [];
  List<UserSearchModel> searchlist = [];
  UsersModel? getAllUsers(uid) {
    FirebaseFirestore.instance
        .collection('users')
        // .orderBy('lastActive', descending: true)
        .doc(uid)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.users = UsersModel.fromJson(user.data()!);
      notifyListeners();
    });
    return users;
  }

  UserModel? getUserById(String userId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.user = UserModel.fromJson(user.data()!);
      notifyListeners();
    });
    return user;
  }

  Future<UserModel?> getUsersByIds(List<dynamic> userIds) async {
    try {
      for (String userId in userIds) {
        var snapshot = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(includeMetadataChanges: true)
            .listen((user) {
          this.user = UserModel.fromJson(user.data()!);
          notifyListeners();
        });
      }
    } catch (e) {
      print('Error getting users by IDs: $e');
    }
    return user;
  }

  List<Message> getMessages(String receiverId) {
    FirebaseFirestore.instance
        // .collection('users')
        // .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .orderBy('sentTime', descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((messages) {
      this.messages =
          messages.docs.map((doc) => Message.fromJson(doc.data())).toList();
      notifyListeners();

      scrollDown();
    });
    return messages;
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
  List<UserSearchModel> searchUser(String fullName) {
    FirebaseFirestore.instance
        .collection('users')
        .where("fullName", isGreaterThanOrEqualTo: fullName)
        .snapshots(includeMetadataChanges: true)
        .listen((event) {
      this.searchlist = event.docs
          .map((doc) => UserSearchModel.fromJson(doc.data()))
          .toList();
      notifyListeners();
    });
    return searchlist;
  }
}
