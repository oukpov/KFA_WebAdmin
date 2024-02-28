import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../Chat/Widgets/custom_text_form_field.dart';

class UsersSearchScreen extends StatefulWidget {
  const UsersSearchScreen({Key? key, required this.myuid}) : super(key: key);
  final String myuid;
  @override
  State<UsersSearchScreen> createState() => _UsersSearchScreenState();
}

class _UsersSearchScreenState extends State<UsersSearchScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List listsearch = [];
  Future<void> search(value) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/users/finding?search=$value',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listsearch = jsonDecode(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  void addGroupToUser(uid) async {
    if (uid != 'null') {
      try {
        DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('users').doc(widget.myuid);
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
    if (uid != 'null' && widget.myuid != uid) {
      try {
        DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('users').doc(uid);
        await userDocRef.update({
          'groups': FieldValue.arrayUnion([widget.myuid])
        });

        print('Group added successfully to user ');
      } catch (e) {
        print('Error adding group to user: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.black,
          title: const Text(
            'Users Search',
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                CustomTextFormField(
                  controller: controller,
                  hintText: 'Search',
                  onChanged: (value) {
                    setState(() {
                      search(value);
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: double.infinity,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: listsearch.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (listsearch[index]['control_user']
                                          .toString() !=
                                      'null' &&
                                  widget.myuid !=
                                      listsearch[index]['control_user']
                                          .toString()) {
                                addGroupToUser(listsearch[index]['control_user']
                                    .toString());
                                usergetYouruid(listsearch[index]['control_user']
                                    .toString());
                              }
                            });
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.07),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.green),
                                  const Spacer(),
                                  Text(listsearch[index]['username'].toString())
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
