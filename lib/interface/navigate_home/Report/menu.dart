// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'Total_amount.dart';
import 'Transetoin/history.dart';

class MenuReport extends StatefulWidget {
  MenuReport({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<MenuReport> createState() => _MenuReportState();
}

class _MenuReportState extends State<MenuReport> {
  List<Text> option = const [
    Text("Costomer",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Verbal", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Comparable",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Valuation",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Property",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Total Amount",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Controller VPoint's User",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.home_repair_service),
    Icon(Icons.home_repair_service),
    Icon(Icons.home_repair_service),
    Icon(Icons.home_repair_service),
    Icon(Icons.home_repair_service),
    Icon(Icons.payment_outlined),
    Icon(Icons.admin_panel_settings_outlined),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        centerTitle: true,
        title: const Text(
          "Report",
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
                  setState(() {
                    if (i == 5) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const Total_Amount();
                        },
                      ));
                    }
                    if (i == 6) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const Trastoin_Payment();
                        },
                      ));
                    }
                  });
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
