import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/components/colors.dart';

class IsOnline extends StatefulWidget {
  const IsOnline({super.key});

  @override
  State<IsOnline> createState() => _IsOnlineState();
}

class _IsOnlineState extends State<IsOnline> {
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
        backgroundColor: const Color.fromARGB(255, 7, 96, 185),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
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

          // List of users
          final users = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
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
                            Column(
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
                                    color: isOnline ? Colors.green : Colors.red,
                                  ),
                                ),
                              ],
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
