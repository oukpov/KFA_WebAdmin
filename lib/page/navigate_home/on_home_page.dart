// ignore_for_file: unused_import, prefer_const_constructors, unnecessary_const

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../../screen/Property/FirstProperty/ResponseDevice/responsive_layout.dart';
import 'Add/menu_list.dart';
import 'AutoVerbal/menu.dart';
import 'Comparable/menucomparable.dart';
import 'Customer/menu.dart';
import 'Report/menu.dart';
import 'User/menu.dart';
import 'Valuation/menu.dart';

class NoBodyHome extends StatefulWidget {
  NoBodyHome(
      {Key? key,
      required this.controller_user,
      required this.id,
      required this.nativigation,
      required this.name,
      required this.email})
      : super(key: key);
  final String id;
  final String name;
  final String? controller_user;
  bool? nativigation;
  final String email;
  @override
  State<NoBodyHome> createState() => _NoBodyHomeState();
}

class _NoBodyHomeState extends State<NoBodyHome> {
  List<Text> option = const [
    Text("Costomer",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Valuation",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Comparable",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Property",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Auto Verbal",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Verbal",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("User",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Report",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.group_rounded, color: Colors.white),
    Icon(Icons.price_change_rounded, color: Colors.white),
    Icon(Icons.compare_rounded, color: Colors.white),
    Icon(Icons.view_cozy_rounded, color: Colors.white),
    Icon(Icons.preview_rounded, color: Colors.white),
    Icon(Icons.visibility_rounded, color: Colors.white),
    Icon(Icons.person_pin_outlined, color: Colors.white),
    Icon(Icons.report_rounded, color: Colors.white),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < 8; i++)
            InkWell(
              hoverColor: Color.fromARGB(161, 255, 249, 87),
              onTap: () {
                if (i == 0) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuCostome(
                            id: widget.id,
                          )));
                }
                if (i == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuValuation(
                            id: widget.id,
                          )));
                }
                if (i == 2) {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => MenuComparable(
                  //           name: widget.name,
                  //         )));
                }
                if (i == 3) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ResponsiveLayout(
                        myIdController: widget.controller_user!,
                        email: widget.email,
                        idController: widget.id),
                  ));
                }
                if (i == 4) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuAutoVerbal(
                            id: widget.id,
                            id_control_user: widget.controller_user!,
                          )));
                }
                if (i == 5) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuVerbal(
                            id_control_user: widget.controller_user!,
                            id: widget.id,
                          )));
                }
                if (i == 6) {
                  print(widget.controller_user);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuUser(
                            controller_user: widget.controller_user,
                            id: widget.id,
                          )));
                }
                if (i == 7) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuReport(
                            id: widget.id,
                          )));
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 8, color: Colors.white),
                  gradient: LinearGradient(
                    colors: const [
                      Colors.cyan,
                      Colors.indigo,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      topRight: Radius.circular(45)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 40,
                      width: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: option.elementAt(i),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: optionIconList.elementAt(i),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
