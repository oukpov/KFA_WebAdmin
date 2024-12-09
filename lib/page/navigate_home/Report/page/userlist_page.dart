import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controller/user_controller.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class UserListPage extends StatefulWidget {
  final String id;
  UserListPage({super.key, required this.id});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final UserController userController = Get.put(UserController());
  var users = [].obs;
  var isLoading = false.obs;

  Future<void> fetchUsers() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    try {
      isLoading(true);
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/getalluser',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          users.value = response.data;
        });
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers(); // Fetch users when page loads
    Timer.periodic(Duration(seconds: 1), (timer) {
      fetchUsers();
    });
  }

  Future<void> _refreshData() async {
    await fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('User List', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Obx(() {
          if (users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue[900]!, Colors.white],
                  stops: [0.0, 0.3],
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[900],
                        child: Text(
                          (user['first_name']?[0] ?? '?').toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        '${user['first_name'] ?? 'N/A'} ${user['last_name'] ?? ''}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.person,
                                  size: 16, color: Colors.black),
                              const SizedBox(width: 8),
                              Text(
                                  "Approved By : ${user['approved_name'] ?? 'No one approved'}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.phone,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(user['tel_num'] ?? 'No phone number'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.email,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(user['email'] ?? 'No email'),
                            ],
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (user['approval_status'] != 'approved') {
                                await userController.approveUser(
                                    user['user_id'], int.parse(widget.id));
                                // ignore: use_build_context_synchronously
                                AwesomeDialog(
                                  padding: const EdgeInsets.only(
                                      right: 30, left: 30, bottom: 10, top: 10),
                                  alignment: Alignment.center,
                                  width: 350,
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  headerAnimationLoop: false,
                                  title: "Success",
                                  desc: "User has been approved successfully",
                                  btnOkOnPress: () {
                                    Navigator.of(context).pop();
                                    _refreshData(); // Refresh after approval
                                  },
                                  btnOkText: "OK",
                                  btnOkColor: Colors.green,
                                ).show();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: user['approval_status'] == 'approved'
                                    ? Colors.green[100]
                                    : Colors.orange[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                user['approval_status'] == 'approved'
                                    ? 'APPROVED'
                                    : 'PENDING',
                                style: TextStyle(
                                  color: user['approval_status'] == 'approved'
                                      ? Colors.green[900]
                                      : Colors.orange[900],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (user['is_blocked'] ==
                              '0') // Show block button if not blocked
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  // Show confirmation dialog first
                                  AwesomeDialog(
                                    padding: const EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                        bottom: 10,
                                        top: 10),
                                    alignment: Alignment.center,
                                    width: 350,
                                    context: context,
                                    dialogType: DialogType.question,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: "Confirm",
                                    desc:
                                        "Are you sure you want to block this user?",
                                    btnOkOnPress: () async {
                                      // Block user after confirmation
                                      await userController.blockUser(
                                          user['control_user'] ?? '');

                                      // Show success message
                                      // ignore: use_build_context_synchronously
                                      AwesomeDialog(
                                        padding: const EdgeInsets.only(
                                            right: 30,
                                            left: 30,
                                            bottom: 10,
                                            top: 10),
                                        alignment: Alignment.center,
                                        width: 350,
                                        context: context,
                                        dialogType: DialogType.success,
                                        animType: AnimType.rightSlide,
                                        headerAnimationLoop: false,
                                        title: "Success",
                                        desc:
                                            "User has been blocked successfully",
                                        btnOkOnPress: () {
                                          Navigator.of(context).pop();
                                          _refreshData(); // Refresh after blocking
                                        },
                                        btnOkText: "OK",
                                        btnOkColor: Colors.green,
                                      ).show();
                                    },
                                    btnOkText: "Yes",
                                    btnOkColor: Colors.green,
                                    btnCancelText: "No",
                                    btnCancelColor: Colors.red,
                                    btnCancelOnPress: () {},
                                  ).show();
                                } catch (e) {
                                  print('Error blocking user: $e');
                                  // Show error message
                                  AwesomeDialog(
                                    padding: const EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                        bottom: 10,
                                        top: 10),
                                    alignment: Alignment.center,
                                    width: 350,
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: "Error",
                                    desc: "Failed to block user",
                                    btnOkOnPress: () {
                                      Navigator.of(context).pop();
                                    },
                                    btnOkText: "OK",
                                    btnOkColor: Colors.red,
                                  ).show();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                              ),
                              child: const Text(
                                'BLOCK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          if (user['is_blocked'] ==
                              '1') // Show unblock button if blocked
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  // Show confirmation dialog first
                                  AwesomeDialog(
                                    padding: const EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                        bottom: 10,
                                        top: 10),
                                    alignment: Alignment.center,
                                    width: 350,
                                    context: context,
                                    dialogType: DialogType.question,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: "Confirm",
                                    desc:
                                        "Are you sure you want to unblock this user?",
                                    btnOkOnPress: () async {
                                      // Unblock user after confirmation
                                      await userController.unblockUser(
                                          user['control_user'] ?? '');

                                      // Show success message
                                      // ignore: use_build_context_synchronously
                                      AwesomeDialog(
                                        padding: const EdgeInsets.only(
                                            right: 30,
                                            left: 30,
                                            bottom: 10,
                                            top: 10),
                                        alignment: Alignment.center,
                                        width: 350,
                                        context: context,
                                        dialogType: DialogType.success,
                                        animType: AnimType.rightSlide,
                                        headerAnimationLoop: false,
                                        title: "Success",
                                        desc:
                                            "User has been unblocked successfully",
                                        btnOkOnPress: () {
                                          Navigator.of(context).pop();
                                          _refreshData(); // Refresh after unblocking
                                        },
                                        btnOkText: "OK",
                                        btnOkColor: Colors.green,
                                      ).show();
                                    },
                                    btnOkText: "Yes",
                                    btnOkColor: Colors.green,
                                    btnCancelText: "No",
                                    btnCancelColor: Colors.red,
                                    btnCancelOnPress: () {},
                                  ).show();
                                } catch (e) {
                                  print('Error unblocking user: $e');
                                  // Show error message
                                  AwesomeDialog(
                                    padding: const EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                        bottom: 10,
                                        top: 10),
                                    alignment: Alignment.center,
                                    width: 350,
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: "Error",
                                    desc: "Failed to unblock user",
                                    btnOkOnPress: () {
                                      Navigator.of(context).pop();
                                    },
                                    btnOkText: "OK",
                                    btnOkColor: Colors.red,
                                  ).show();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                              ),
                              child: const Text(
                                'UNBLOCK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }),
      ),
    );
  }
}
