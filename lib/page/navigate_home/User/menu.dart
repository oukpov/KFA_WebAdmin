// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/page/navigate_home/User/use_vpoint.dart';
import 'control_user.dart';
import 'list_notivigation.dart';

class MenuUser extends StatefulWidget {
  MenuUser({Key? key, required this.id, required this.controller_user})
      : super(key: key);
  final String id;
  final String? controller_user;

  @override
  State<MenuUser> createState() => _MenuUserState();
}

class _MenuUserState extends State<MenuUser> {
  List<Text> option = const [
    Text("New User",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("New Role",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Control User",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("List Notivagation",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("VPoint User",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.add_circle, color: Colors.white),
    Icon(Icons.add_task, color: Colors.white),
    Icon(Icons.person_search_outlined, color: Colors.white),
    Icon(Icons.notifications_active_outlined, color: Colors.white),
    Icon(Icons.library_add_check_outlined, color: Colors.white),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        centerTitle: true,
        title: const Text(
          "User",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage('assets/images/New_KFA_Logo.png'),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < option.length; i++)
              InkWell(
                onTap: () {
                  if (i == 2) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CTL_User()));
                  } else if (i == 3) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Notivigation_day(),
                        ));
                  } else if (i == 4) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => User_Vpoint(
                            controller_user: widget.controller_user,
                          ),
                        ));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.cyan,
                          Colors.indigo,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            spreadRadius: 3,
                            blurRadius: 2,
                            color: Colors.black,
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: optionIconList.elementAt(i),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: option.elementAt(i),
                      ),
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
