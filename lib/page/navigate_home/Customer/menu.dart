// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:web_admin/page/navigate_home/Customer/responsiveDevice.dart/addnew.dart';

import 'AddNew/new_customer.dart';
import 'List/customer_list.dart';
import 'List/customer_list_map.dart';

import 'AddNewMap/new_customer_map.dart';

class MenuCostome extends StatefulWidget {
  MenuCostome({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<MenuCostome> createState() => _MenuCostomeState();
}

class _MenuCostomeState extends State<MenuCostome> {
  List<Text> option = const [
    Text("New Customer",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    // Text("New Customer Map",
    //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Costomer List",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

    // Text("Costomer List Map",
    //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.data_saver_on),
    // Icon(Icons.data_usage),
    Icon(Icons.list_alt_outlined),
    // Icon(Icons.map_outlined),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        centerTitle: true,
        title: const Text(
          "Customer",
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
                  if (i == 0) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ResponsiveCustomer(
                          email: '',
                          idController: '96',
                          myIdController: '',
                        );
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
    );
  }
}
