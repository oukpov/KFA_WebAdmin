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
  TextEditingController searchController = TextEditingController();
  var users = [].obs;
  var isLoading = false.obs;

  Future<void> fetchUsers() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    dio.options.connectTimeout = 5000; // Set timeout to 5 seconds
    dio.options.receiveTimeout = 5000; // Set timeout to 5 seconds
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
        if (mounted) {
          setState(() {
            users.value = response.data;
          });
        }
      } else {}
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 500,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: searchController,
                                    decoration: const InputDecoration(
                                      hintText:
                                          'Enter Phone Number or Username',
                                      border: InputBorder.none,
                                      // prefixIcon:
                                      //     Icon(Icons.phone, color: Colors.grey[600]),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    if (searchController.text.isNotEmpty) {
                                      userController
                                          .searchphone(searchController.text);
                                    }
                                  },
                                  icon: const Icon(Icons.search),
                                  label: const Text('Search'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (userController.listsearch.isEmpty)
                    Expanded(
                      // Add Expanded to give ListView a constrained height
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return Card(
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue[900],
                                  child: Text(
                                    (user['first_name']?[0] ?? '?')
                                        .toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Text(
                                  '${user['first_name'] ?? 'N/A'} ${user['last_name'] ?? ''}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
                                        Text(user['tel_num'] ??
                                            'No phone number'),
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
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
