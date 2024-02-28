import 'dart:convert';
import 'package:flutter/material.dart';
import '../../component/Colors/appbar.dart';
import '../../component/Colors/colors.dart';
import 'ChatUsers/Chats/chats_screen.dart';
import 'MyFavorites/MyFavorites.dart';
import 'package:http/http.dart' as http;

class MyAccountProperty extends StatefulWidget {
  MyAccountProperty(
      {super.key,
      required this.idUsercontroller,
      required this.email,
      required this.myIdController});
  String idUsercontroller;
  String email;
  final String myIdController;
  @override
  State<MyAccountProperty> createState() => _MyAccountPropertyState();
}

class _MyAccountPropertyState extends State<MyAccountProperty> {
  List<Icon> listIcon = [
    Icon(Icons.house_outlined, color: appback),
    const Icon(
      Icons.favorite,
      color: Color.fromARGB(255, 149, 12, 2),
    ),
    Icon(Icons.search_outlined, color: appback),
    Icon(Icons.message_outlined, color: appback),
    const Icon(
      Icons.radio_button_on_sharp,
      color: Color.fromARGB(255, 149, 12, 2),
    ),
  ];
  String user = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String gender = '';
  String from = '';
  String tel = '';
  String idUserController = '';
  @override
  void initState() {
    getControlUser();
    super.initState();
  }

  Future getControlUser() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/${widget.idUsercontroller}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        user = jsonData[0]['username'].toString();
        firstName = jsonData[0]['first_name'].toString();
        lastName = jsonData[0]['last_name'].toString();
        email = jsonData[0]['email'].toString();
        gender = jsonData[0]['gender'].toString();
        from = jsonData[0]['known_from'].toString();
        tel = jsonData[0]['tel_num'].toString();
        idUserController = jsonData[0]['control_user'].toString();
      });
    }
  }

  List listTitle = [
    {'title': 'My Listings'},
    {'title': 'My Favorites'},
    {'title': 'Search Listings'},
    {'title': 'Clients Chats'},
    {'title': 'Log Out'},
  ];
  int selectIndex = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: $user'),
                            const SizedBox(height: 10),
                            const Text('My Account'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(height: 5, color: Colors.grey),
                    const SizedBox(height: 10),
                    for (int i = 0; i < listIcon.length; i++)
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            selectIndex = (selectIndex == i) ? -1 : i;
                          });
                        },
                        onTap: () {
                          setState(() {
                            if (i == 0) {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => const MyListings(),
                              //     ));
                            } else if (i == 1) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return MyFavories(
                                      myIdController: widget.myIdController,
                                      email: widget.email,
                                      idUsercontroller: idUserController);
                                },
                              ));
                            } else if (i == 2) {
                            } else if (i == 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChatScreen(uid: widget.myIdController),
                                  ));
                            } else {}
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 0.4,
                                  color: (selectIndex == i)
                                      ? greyColor
                                      : Colors.transparent)),
                          height: 55,
                          width: double.infinity,
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              listIcon[i],
                              const SizedBox(width: 10),
                              Text(listTitle[i]['title'].toString())
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
