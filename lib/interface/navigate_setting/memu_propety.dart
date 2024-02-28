// ignore_for_file: unnecessary_import, implementation_imports, unused_import, non_constant_identifier_names, camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'Accompany_by/menu_Acompany.dart';
import 'Appraiser/menu_Appraiser.dart';
import 'Approved/menu_Approved.dart';
import 'Inspector/menu_Inspector.dart';
import 'Inspectors/menu_Inspectors.dart';
import 'Register/menu_Register.dart';
import 'agency/menu_Agency.dart';
import 'assign/menu_assign.dart';
import 'auto/menu_auto.dart';
import 'bank/bank/menu_bank.dart';
import 'bank/brand/menu_brand.dart';

class On_property extends StatefulWidget {
  final String username;
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final String from;
  final String tel;
  final String id;
  const On_property({
    Key? key,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.gender,
    required this.from,
    required this.tel,
    required this.id,
  }) : super(key: key);

  @override
  State<On_property> createState() => _On_propertyState();
}

class _On_propertyState extends State<On_property> {
  List<Text> option = const [
    Text("Biulding Type",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Register",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Auto",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Road",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Approved",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Bank",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Brand",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Agency",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Option",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Land",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Assign To",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Inspector Name",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Inspectors Name",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Register Name",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Accomnpany Name",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Approved Name",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Appraiser Name",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Min & Max",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Province",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("District",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Commune",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
  ];
  List<Icon> optionIconList = [
    Icon(Icons.cabin, color: Colors.white),
    Icon(Icons.how_to_reg, color: Colors.white),
    Icon(Icons.auto_fix_high, color: Colors.white),
    Icon(Icons.edit_road, color: Colors.white),
    Icon(Icons.checklist_rtl, color: Colors.white),
    Icon(Icons.account_balance, color: Colors.white),
    Icon(Icons.support_agent, color: Colors.white),
    Icon(Icons.settings_applications, color: Colors.white),
    Icon(Icons.forest, color: Colors.white),
    //Inspector
    Icon(Icons.insert_page_break, color: Colors.white),
    Icon(Icons.insert_page_break, color: Colors.white),
    Icon(Icons.app_registration_rounded, color: Colors.white),
    Icon(Icons.add_comment_sharp, color: Colors.white),
    Icon(Icons.add_comment_sharp, color: Colors.white),
    Icon(Icons.add_comment_sharp, color: Colors.white),

    ///
    Icon(Icons.assignment_ind, color: Colors.white),
    Icon(Icons.hourglass_empty, color: Colors.white),
    Icon(Icons.category, color: Colors.white),
    Icon(Icons.dashboard, color: Colors.white),
    Icon(Icons.calendar_view_month, color: Colors.white),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < optionIconList.length; i++)
            InkWell(
              hoverColor: Color.fromARGB(161, 255, 249, 87),
              onTap: () {
                setState(() {
                  if (i == 2) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MenuAuto()));
                  }
                  if (i == 5) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Menu_bank()));
                  }
                  if (i == 6) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Menu_brand()));
                  }
                  if (i == 7) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Menu_Agency()));
                  }
                  if (i == 10) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Menu_Assign()));
                  }
                  if (i == 11) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Menu_Inspector()));
                  }
                  if (i == 12) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Menu_Inspectors()));
                  }
                  if (i == 13) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Menu_Register()));
                  }
                  if (i == 14) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Menu_Acompany()));
                  }
                  if (i == 15) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Menu_Approved()));
                  }
                  if (i == 16) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Menu_Appraiser()));
                  }
                });
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 8, color: Colors.white),
                    gradient: LinearGradient(
                      colors: const [
                        Color.fromARGB(255, 88, 130, 236),
                        Color.fromARGB(255, 142, 55, 110),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: const [0.8, 0.2],
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomRight: Radius.circular(25)),
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
                  )),
            ),
        ],
      ),
    );
  }
}
