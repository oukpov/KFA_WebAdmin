import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controller/user_controller.dart';

class UserListForAdmin extends StatelessWidget {
  String id;
  UserListForAdmin({super.key, required this.id});
  final UserController userController = Get.put(UserController());
  var approved_name;
  @override
  Widget build(BuildContext context) {
    userController.fetchOneUser(id); // Call fetchOneUser when building

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your User List '),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (userController.adminuser.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.person_off, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text('No users found',
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ],
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue[900]!, Colors.white],
                stops: const [0.0, 0.3],
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue[900],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.people, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              "Total Users: ${userController.adminuser.length}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     InkWell(
                      //       onTap: () {
                      //         Get.to(() => ReportVerbalAllUserForAdminPage(
                      //               id: int.parse(id),
                      //             ));
                      //       },
                      //       child: Row(
                      //         children: const [
                      //           Text(
                      //             'All Verbals',
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           Icon(Icons.all_inbox, color: Colors.white),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: userController.adminuser.length,
                    itemBuilder: (context, index) {
                      final user = userController.adminuser[index];
                      approved_name = user['approved_name'];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: ListTile(
                          onTap: () {
                            // Get.to(() => ReportVerbalUserForAdmin(
                            //       id: user['userId'].toString(),
                            //       tel_num: user['tel_num'],
                            //       agency: approved_name,
                            //     ));
                          },
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue[900],
                            child: Text(
                              (user['first_name']?.toString()?[0] ?? '?')
                                  .toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            '${user['first_name']?.toString() ?? 'N/A'} ${user['last_name']?.toString() ?? ''}',
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
                                      "Approved By : ${user['approved_name']?.toString() ?? 'No one approved'}",
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
                                  Text(user['tel_num']?.toString() ??
                                      'No phone number'),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.email,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text('ID: ${user['email'].toString()}'),
                                ],
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
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
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.power_settings_new,
                                    color: Colors.red),
                                onPressed: () {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.warning,
                                    animType: AnimType.rightSlide,
                                    title: 'Disapprove User',
                                    desc:
                                        'Are you sure you want to disapprove this user?',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {
                                      userController.disApproveUser(
                                          int.parse(user['userId'].toString()));
                                      print(
                                          "tessssssssssss: ${user['userId']}");
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
                                            "User has been disapproved successfully",
                                        btnOkOnPress: () {
                                          Navigator.of(context).pop();
                                        },
                                        btnOkText: "OK",
                                        btnOkColor: Colors.green,
                                      ).show();
                                    },
                                    btnOkColor: Colors.red,
                                    btnOkText: 'Disapprove',
                                  ).show();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 24, color: Colors.blue[800]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
