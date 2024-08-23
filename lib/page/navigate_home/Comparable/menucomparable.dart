// ignore_for_file: unnecessary_import, implementation_imports, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'comparable4/list_comparable_filter.dart';
import 'comparable3/search_screen.dart/comparable_search.dart';
import 'newComparable/listnewcomparable.dart';
import 'newComparable/responsivenewcomparableadd.dart';

class MenuComparable extends StatefulWidget {
  MenuComparable({super.key, required this.name});
  String? name;

  @override
  State<MenuComparable> createState() => _MenuComparableState();
}

class _MenuComparableState extends State<MenuComparable> {
  List<Text> option = const [
    Text("New Comparable",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Comparable List",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Comparable Search",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Comparable Map List",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.data_saver_on),
    Icon(Icons.list_alt_outlined),
    Icon(Icons.search),
    Icon(Icons.map),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple[900],
        title: const Text(
          "Comparable",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        alignment: Alignment.center,
        decoration: BoxDecoration(
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
                  if (i == 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => List_newcomparable(
                              name: widget.name.toString(),
                            )));
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ResponsivenewcomparableAdd(
                          name: widget.name,
                        );
                      },
                    ));
                  }
                  if (i == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => List_newcomparable(
                              name: widget.name.toString(),
                            )));
                  }
                  if (i == 2) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => comparable_search()));
                  }
                  if (i == 3) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => List_comparable_filter()));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
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
