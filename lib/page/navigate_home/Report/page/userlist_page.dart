import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controller/user_controller.dart';
import 'package:dio/dio.dart';

class UserListPage extends StatefulWidget {
  final String id;
  UserListPage({super.key, required this.id});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final UserController userController = Get.put(UserController());
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  var users = [].obs;
  var searchResults = [].obs;
  var isLoading = false.obs;
  var isSearching = false.obs;
  var isBlockingUser = false.obs;
  var isUnblockingUser = false.obs;
  var blockingUserId = ''.obs;
  var unblockingUserId = ''.obs;
  Timer? _timer;
  bool _isMounted = true;
  bool _isRefreshing = false;
  final _refreshCompleter = Completer<void>();

  // Pagination variables
  var currentPage = 1;
  var lastPage = 1;
  var isLoadingMore = false.obs;
  var perPage = 10;
  var totalItems = 0;

  Future<void> fetchUsers({bool loadMore = false}) async {
    if (!_isMounted || (_isRefreshing && !loadMore)) {
      return;
    }

    if (!loadMore) {
      _isRefreshing = true;
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;

    try {
      if (!loadMore) {
        isLoading(true);
      } else {
        isLoadingMore(true);
      }

      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/getalluser?page=$currentPage&per_page=$perPage',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200 && _isMounted) {
        final data = response.data;
        lastPage = data['last_page'];
        totalItems = data['total'];

        users.value = data['data'];

        // Re-apply search filter after fetching new data
        if (searchController.text.isNotEmpty) {
          searchUsers(searchController.text);
        }
      }
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      if (_isMounted) {
        isLoading(false);
        isLoadingMore(false);
        _isRefreshing = false;
        if (!_refreshCompleter.isCompleted) {
          _refreshCompleter.complete();
        }
      }
    }
  }

  void searchUsers(String query) {
    if (!_isMounted) return;

    isSearching(true);
    if (query.isEmpty) {
      searchResults.clear();
      isSearching(false);
      return;
    }

    searchResults.value = users.where((user) {
      final phoneMatch = user['tel_num']
              ?.toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ??
          false;
      final nameMatch = '${user['first_name']} ${user['last_name']}'
          .toLowerCase()
          .contains(query.toLowerCase());
      return phoneMatch || nameMatch;
    }).toList();
    isSearching(false);
  }

  void nextPage() {
    if (currentPage < lastPage) {
      currentPage++;
      fetchUsers();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      fetchUsers();
    }
  }

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    fetchUsers();
    _timer = Timer.periodic(Duration(seconds: 30), (timer) async {
      if (_isMounted && !_isRefreshing) {
        await fetchUsers();
      }
    });
  }

  @override
  void dispose() {
    _isMounted = false;
    _timer?.cancel();
    _scrollController.dispose();
    searchController.dispose();
    if (!_refreshCompleter.isCompleted) {
      _refreshCompleter.complete();
    }
    super.dispose();
  }

  Future<void> _refreshData() async {
    if (_isMounted && !_isRefreshing) {
      await fetchUsers();
    }
  }

  Future<void> _handleBlockUnblock(
      Map<String, dynamic> user, bool isBlock) async {
    try {
      if (isBlock) {
        isBlockingUser(true);
        blockingUserId(user['control_user']);
        await userController.blockUser(user['control_user'] ?? '');
      } else {
        isUnblockingUser(true);
        unblockingUserId(user['control_user']);
        await userController.unblockUser(user['control_user'] ?? '');
      }

      await fetchUsers(); // Fetch users for current page instead of resetting to page 1
    } catch (e) {
      print('Error ${isBlock ? "blocking" : "unblocking"} user: $e');
      if (_isMounted) {
        AwesomeDialog(
          padding:
              const EdgeInsets.only(right: 30, left: 30, bottom: 10, top: 10),
          alignment: Alignment.center,
          width: 350,
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: "Error",
          desc: "Failed to ${isBlock ? "block" : "unblock"} user",
          btnOkOnPress: () {
            Navigator.of(context).pop();
          },
          btnOkText: "OK",
          btnOkColor: Colors.red,
        ).show();
      }
    } finally {
      if (_isMounted) {
        if (isBlock) {
          isBlockingUser(false);
          blockingUserId('');
        } else {
          isUnblockingUser(false);
          unblockingUserId('');
        }
      }
    }
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 500,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          hintText: 'Enter Phone Number or Username',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          searchUsers(value);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (searchController.text.isNotEmpty) {
                          searchUsers(searchController.text);
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
            ),
            Expanded(
              child: Obx(() {
                final displayList =
                    searchResults.isEmpty && searchController.text.isEmpty
                        ? users
                        : searchResults;

                if (displayList.isEmpty && isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

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
                      Expanded(
                        child: displayList.isEmpty
                            ? const Center(
                                child: Text('No users found in this page'))
                            : ListView.builder(
                                controller: _scrollController,
                                padding: const EdgeInsets.all(8),
                                itemCount: displayList.length,
                                itemBuilder: (context, index) {
                                  final user = displayList[index];
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
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      title: Text(
                                        '${user['first_name'] ?? 'N/A'} ${user['last_name'] ?? ''}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              const Icon(Icons.person,
                                                  size: 16,
                                                  color: Colors.black),
                                              const SizedBox(width: 8),
                                              Text(
                                                  "Approved By : ${user['approved_name'] ?? 'No one approved'}",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if (user['approval_status'] !=
                                                  'approved') {
                                                await userController
                                                    .approveUser(
                                                        user['user_id'],
                                                        int.parse(widget.id));
                                                if (_isMounted) {
                                                  // ignore: use_build_context_synchronously
                                                  AwesomeDialog(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 30,
                                                            left: 30,
                                                            bottom: 10,
                                                            top: 10),
                                                    alignment: Alignment.center,
                                                    width: 350,
                                                    context: context,
                                                    dialogType:
                                                        DialogType.success,
                                                    animType:
                                                        AnimType.rightSlide,
                                                    headerAnimationLoop: false,
                                                    title: "Success",
                                                    desc:
                                                        "User has been approved successfully",
                                                    btnOkOnPress: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      _refreshData(); // Refresh after approval
                                                    },
                                                    btnOkText: "OK",
                                                    btnOkColor: Colors.green,
                                                  ).show();
                                                }
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                color:
                                                    user['approval_status'] ==
                                                            'approved'
                                                        ? Colors.green[100]
                                                        : Colors.orange[100],
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                user['approval_status'] ==
                                                        'approved'
                                                    ? 'APPROVED'
                                                    : 'PENDING',
                                                style: TextStyle(
                                                  color:
                                                      user['approval_status'] ==
                                                              'approved'
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
                                            Obx(() => ElevatedButton(
                                                  onPressed: isBlockingUser
                                                              .value &&
                                                          blockingUserId
                                                                  .value ==
                                                              user[
                                                                  'control_user']
                                                      ? null
                                                      : () async {
                                                          if (_isMounted) {
                                                            AwesomeDialog(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 30,
                                                                      left: 30,
                                                                      bottom:
                                                                          10,
                                                                      top: 10),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 350,
                                                              context: context,
                                                              dialogType:
                                                                  DialogType
                                                                      .question,
                                                              animType: AnimType
                                                                  .rightSlide,
                                                              headerAnimationLoop:
                                                                  false,
                                                              title: "Confirm",
                                                              desc:
                                                                  "Are you sure you want to block this user?",
                                                              btnOkOnPress:
                                                                  () async {
                                                                await _handleBlockUnblock(
                                                                    user, true);
                                                              },
                                                              btnOkText: "Yes",
                                                              btnOkColor:
                                                                  Colors.green,
                                                              btnCancelText:
                                                                  "No",
                                                              btnCancelColor:
                                                                  Colors.red,
                                                              btnCancelOnPress:
                                                                  () {},
                                                            ).show();
                                                          }
                                                        },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12,
                                                        vertical: 6),
                                                  ),
                                                  child: isBlockingUser.value &&
                                                          blockingUserId
                                                                  .value ==
                                                              user[
                                                                  'control_user']
                                                      ? SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                            strokeWidth: 2,
                                                          ),
                                                        )
                                                      : const Text(
                                                          'BLOCK',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                )),
                                          if (user['is_blocked'] ==
                                              '1') // Show unblock button if blocked
                                            Obx(() => ElevatedButton(
                                                  onPressed: isUnblockingUser
                                                              .value &&
                                                          unblockingUserId
                                                                  .value ==
                                                              user[
                                                                  'control_user']
                                                      ? null
                                                      : () async {
                                                          if (_isMounted) {
                                                            AwesomeDialog(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 30,
                                                                      left: 30,
                                                                      bottom:
                                                                          10,
                                                                      top: 10),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 350,
                                                              context: context,
                                                              dialogType:
                                                                  DialogType
                                                                      .question,
                                                              animType: AnimType
                                                                  .rightSlide,
                                                              headerAnimationLoop:
                                                                  false,
                                                              title: "Confirm",
                                                              desc:
                                                                  "Are you sure you want to unblock this user?",
                                                              btnOkOnPress:
                                                                  () async {
                                                                await _handleBlockUnblock(
                                                                    user,
                                                                    false);
                                                              },
                                                              btnOkText: "Yes",
                                                              btnOkColor:
                                                                  Colors.green,
                                                              btnCancelText:
                                                                  "No",
                                                              btnCancelColor:
                                                                  Colors.red,
                                                              btnCancelOnPress:
                                                                  () {},
                                                            ).show();
                                                          }
                                                        },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12,
                                                        vertical: 6),
                                                  ),
                                                  child: isUnblockingUser
                                                              .value &&
                                                          unblockingUserId
                                                                  .value ==
                                                              user[
                                                                  'control_user']
                                                      ? SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                            strokeWidth: 2,
                                                          ),
                                                        )
                                                      : const Text(
                                                          'UNBLOCK',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                )),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed:
                                  currentPage > 1 ? () => previousPage() : null,
                              child: Icon(Icons.arrow_back),
                            ),
                            SizedBox(width: 16),
                            Text(
                                'Page $currentPage of $lastPage (Total: $totalItems)'),
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: currentPage < lastPage
                                  ? () => nextPage()
                                  : null,
                              child: Icon(Icons.arrow_forward),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
