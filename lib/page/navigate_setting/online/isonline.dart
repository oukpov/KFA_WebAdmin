import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';

class IsOnline extends StatefulWidget {
  const IsOnline({super.key});

  @override
  State<IsOnline> createState() => _IsOnlineState();
}

class _IsOnlineState extends State<IsOnline> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> updateUserStatusByAgentId(String agentId, bool block) async {
    final QuerySnapshot result = await _firestore
        .collection('users')
        .where('id_agent', isEqualTo: agentId)
        .limit(1)
        .get();
    final userDocRef = result.docs.first.reference;
    await userDocRef.update({
      'block': block,
    });
  }

  int indexselected = 0;
  bool checkBlock = true;
  bool light = false;
  List listTitle = [
    {"title": "Online"},
    {"title": "Offline"},
    {"title": "Block"},
    {"title": "All"}
  ];
  String title = "isOnline";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
              size: 20,
            )),
        title: const Text('Check Agents'),
        actions: [
          for (int i = 0; i < listTitle.length; i++)
            SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          indexselected = (indexselected == i) ? -1 : i;
                          if (i == 0) {
                            title = "isOnline";
                            checkBlock = true;
                          } else if (i == 1) {
                            title = "isOnline";
                            checkBlock = false;
                          } else if (i == 2) {
                            title = "block";
                            checkBlock = true;
                          }
                        });
                      },
                      icon: Icon(
                        (indexselected == i)
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank_outlined,
                        color: (indexselected == i) ? whiteColor : greyColor,
                      )),
                  Text(
                    listTitle[i]['title'],
                    style: TextStyle(
                        color: (indexselected == i) ? whiteColor : greyColor,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
        ],
        backgroundColor: const Color.fromARGB(255, 7, 96, 185),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (indexselected == 3)
            ? FirebaseFirestore.instance.collection('users').snapshots()
            : (indexselected == 2)
                ? FirebaseFirestore.instance
                    .collection('users')
                    .where(title, isEqualTo: checkBlock)
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection('users')
                    .where(title, isEqualTo: checkBlock)
                    .where("block", isEqualTo: false)
                    .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users found.'));
          }
          final users = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                Timestamp timestamp = user['lastActive'];
                DateTime dateTime = timestamp.toDate();
                final bool isOnline = user['isOnline'] ?? false;
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 5, right: 10, left: 10),
                  child: Card(
                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          color: isOnline
                              ? const Color.fromARGB(255, 222, 244, 203)
                              : const Color.fromARGB(255, 236, 240, 245),
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(width: 0.5, color: greyColorNolots)),
                      height: 70,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: Text(
                                "No.${index + 1}  ",
                                style: TextStyle(
                                    color: greyColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Icon(
                              Icons.circle,
                              color: isOnline ? Colors.green : greyColorNolots,
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 110,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user['fullName'] ?? 'Unknown User',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    isOnline
                                        ? "Agent's Online"
                                        : "Agent's Offline",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color:
                                          isOnline ? Colors.green : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              // This bool value toggles the switch.
                              value: user['block'],
                              activeColor: appback,
                              onChanged: (bool value) async {
                                if (user['block'] == true) {
                                  await updateUserStatusByAgentId(
                                      user['id_agent'], false);
                                } else {
                                  await updateUserStatusByAgentId(
                                      user['id_agent'], true);
                                }
                              },
                            ),
                            const Spacer(),
                            Text(
                              isOnline ? "" : "Last Action  ",
                              style: TextStyle(color: appback, fontSize: 13),
                            ),
                            Text(
                              dateTime.toString(),
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
