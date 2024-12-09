// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:web_admin/controller/user_controller.dart';

// class UserListPage extends StatefulWidget {
//   final String id;
//   UserListPage({super.key, required this.id});

//   @override
//   State<UserListPage> createState() => _UserListPageState();
// }

// class _UserListPageState extends State<UserListPage> {
//   final UserController userController = Get.put(UserController());

//   @override
//   void initState() {
//     super.initState();
//     userController.fetchUsers(); // Fetch users when page loads
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue[900],
//         title: Text('User List', style: TextStyle(color: Colors.white)),
//         elevation: 0,
//       ),
//       body: Obx(() {
//         if (userController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (userController.users.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Icon(Icons.person_off, size: 80, color: Colors.grey),
//                 SizedBox(height: 16),
//                 Text('No users found',
//                     style: TextStyle(fontSize: 18, color: Colors.grey)),
//               ],
//             ),
//           );
//         } else {
//           return Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Colors.blue[900]!, Colors.white],
//                 stops: [0.0, 0.3],
//               ),
//             ),
//             child: ListView.builder(
//               padding: const EdgeInsets.all(8),
//               itemCount: userController.users.length,
//               itemBuilder: (context, index) {
//                 final user = userController.users[index];
//                 return Card(
//                   elevation: 4,
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.all(16),
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.blue[900],
//                       child: Text(
//                         (user.firstName?[0] ?? '?').toUpperCase(),
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     title: Text(
//                       '${user.firstName ?? 'N/A'} ${user.lastName ?? ''}',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             const Icon(Icons.person,
//                                 size: 16, color: Colors.black),
//                             const SizedBox(width: 8),
//                             Text(
//                                 "Approved By : ${user.approvedName ?? 'No one approved'}",
//                                 style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black)),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: [
//                             const Icon(Icons.phone,
//                                 size: 16, color: Colors.grey),
//                             const SizedBox(width: 8),
//                             Text(user.telNum ?? 'No phone number'),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: [
//                             const Icon(Icons.email,
//                                 size: 16, color: Colors.grey),
//                             const SizedBox(width: 8),
//                             Text(user.email ?? 'No email'),
//                           ],
//                         ),
//                       ],
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         InkWell(
//                           onTap: () async {
//                             if (user.approvalStatus != 'approved') {
//                               await userController.approveUser(
//                                   user.userId!, int.parse(widget.id));
//                               // ignore: use_build_context_synchronously
//                               AwesomeDialog(
//                                 padding: const EdgeInsets.only(
//                                     right: 30, left: 30, bottom: 10, top: 10),
//                                 alignment: Alignment.center,
//                                 width: 350,
//                                 context: context,
//                                 dialogType: DialogType.success,
//                                 animType: AnimType.rightSlide,
//                                 headerAnimationLoop: false,
//                                 title: "Success",
//                                 desc: "User has been approved successfully",
//                                 btnOkOnPress: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 btnOkText: "OK",
//                                 btnOkColor: Colors.green,
//                               ).show();
//                             }
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 6),
//                             decoration: BoxDecoration(
//                               color: user.approvalStatus == 'approved'
//                                   ? Colors.green[100]
//                                   : Colors.orange[100],
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Text(
//                               user.approvalStatus == 'approved'
//                                   ? 'APPROVED'
//                                   : 'PENDING',
//                               style: TextStyle(
//                                 color: user.approvalStatus == 'approved'
//                                     ? Colors.green[900]
//                                     : Colors.orange[900],
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         ElevatedButton(
//                           onPressed: () async {
//                             try {
//                               // Show confirmation dialog first
//                               AwesomeDialog(
//                                 padding: const EdgeInsets.only(
//                                     right: 30, left: 30, bottom: 10, top: 10),
//                                 alignment: Alignment.center,
//                                 width: 350,
//                                 context: context,
//                                 dialogType: DialogType.question,
//                                 animType: AnimType.rightSlide,
//                                 headerAnimationLoop: false,
//                                 title: "Confirm",
//                                 desc:
//                                     "Are you sure you want to block this user?",
//                                 btnOkOnPress: () async {
//                                   // Block user after confirmation
//                                   await userController
//                                       .blockUser(user.controlUser ?? '');

//                                   // Show success message
//                                   // ignore: use_build_context_synchronously
//                                   AwesomeDialog(
//                                     padding: const EdgeInsets.only(
//                                         right: 30,
//                                         left: 30,
//                                         bottom: 10,
//                                         top: 10),
//                                     alignment: Alignment.center,
//                                     width: 350,
//                                     context: context,
//                                     dialogType: DialogType.success,
//                                     animType: AnimType.rightSlide,
//                                     headerAnimationLoop: false,
//                                     title: "Success",
//                                     desc: "User has been blocked successfully",
//                                     btnOkOnPress: () {
//                                       Navigator.of(context).pop();
//                                       setState(() {}); // Refresh UI
//                                     },
//                                     btnOkText: "OK",
//                                     btnOkColor: Colors.green,
//                                   ).show();
//                                 },
//                                 btnOkText: "Yes",
//                                 btnOkColor: Colors.green,
//                                 btnCancelText: "No",
//                                 btnCancelColor: Colors.red,
//                                 btnCancelOnPress: () {},
//                               ).show();
//                             } catch (e) {
//                               print('Error blocking user: $e');
//                               // Show error message
//                               AwesomeDialog(
//                                 padding: const EdgeInsets.only(
//                                     right: 30, left: 30, bottom: 10, top: 10),
//                                 alignment: Alignment.center,
//                                 width: 350,
//                                 context: context,
//                                 dialogType: DialogType.error,
//                                 animType: AnimType.rightSlide,
//                                 headerAnimationLoop: false,
//                                 title: "Error",
//                                 desc: "Failed to block user",
//                                 btnOkOnPress: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 btnOkText: "OK",
//                                 btnOkColor: Colors.red,
//                               ).show();
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 6),
//                           ),
//                           child: const Text(
//                             'BLOCK',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         ElevatedButton(
//                           onPressed: () async {
//                             try {
//                               // Show confirmation dialog first
//                               AwesomeDialog(
//                                 padding: const EdgeInsets.only(
//                                     right: 30, left: 30, bottom: 10, top: 10),
//                                 alignment: Alignment.center,
//                                 width: 350,
//                                 context: context,
//                                 dialogType: DialogType.question,
//                                 animType: AnimType.rightSlide,
//                                 headerAnimationLoop: false,
//                                 title: "Confirm",
//                                 desc:
//                                     "Are you sure you want to unblock this user?",
//                                 btnOkOnPress: () async {
//                                   // Unblock user after confirmation
//                                   await userController
//                                       .unblockUser(user.controlUser ?? '');

//                                   // Show success message
//                                   // ignore: use_build_context_synchronously
//                                   AwesomeDialog(
//                                     padding: const EdgeInsets.only(
//                                         right: 30,
//                                         left: 30,
//                                         bottom: 10,
//                                         top: 10),
//                                     alignment: Alignment.center,
//                                     width: 350,
//                                     context: context,
//                                     dialogType: DialogType.success,
//                                     animType: AnimType.rightSlide,
//                                     headerAnimationLoop: false,
//                                     title: "Success",
//                                     desc:
//                                         "User has been unblocked successfully",
//                                     btnOkOnPress: () {
//                                       Navigator.of(context).pop();
//                                       setState(() {}); // Refresh UI
//                                     },
//                                     btnOkText: "OK",
//                                     btnOkColor: Colors.green,
//                                   ).show();
//                                 },
//                                 btnOkText: "Yes",
//                                 btnOkColor: Colors.green,
//                                 btnCancelText: "No",
//                                 btnCancelColor: Colors.red,
//                                 btnCancelOnPress: () {},
//                               ).show();
//                             } catch (e) {
//                               print('Error unblocking user: $e');
//                               // Show error message
//                               AwesomeDialog(
//                                 padding: const EdgeInsets.only(
//                                     right: 30, left: 30, bottom: 10, top: 10),
//                                 alignment: Alignment.center,
//                                 width: 350,
//                                 context: context,
//                                 dialogType: DialogType.error,
//                                 animType: AnimType.rightSlide,
//                                 headerAnimationLoop: false,
//                                 title: "Error",
//                                 desc: "Failed to unblock user",
//                                 btnOkOnPress: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 btnOkText: "OK",
//                                 btnOkColor: Colors.red,
//                               ).show();
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 6),
//                           ),
//                           child: const Text(
//                             'UNBLOCK',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//       }),
//     );
//   }
// }
