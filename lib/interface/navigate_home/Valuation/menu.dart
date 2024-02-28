// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'class/Executive_approvel.dart';
import 'class/New_Executive.dart';
import 'class/list_Executive.dart';

class MenuValuation extends StatefulWidget {
  MenuValuation({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<MenuValuation> createState() => _MenuValuationState();
}

class _MenuValuationState extends State<MenuValuation> {
  List<Text> option = const [
    Text("New Executive",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Executive List",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Executive Approvals",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.add_circle),
    Icon(Icons.list_alt_outlined),
    Icon(Icons.app_registration),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        centerTitle: true,
        title: const Text(
          "Valuation",
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
        child: Padding(
          padding: const EdgeInsets.only(right: 120, left: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < option.length; i++)
                InkWell(
                  onTap: () {
                    if (i == 0) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const New_Executive();
                        },
                      ));
                    }
                    if (i == 1) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Executive_List();
                        },
                      ));
                    }
                    if (i == 2) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Executive_approvals();
                        },
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
      ),
    );
  }
}
