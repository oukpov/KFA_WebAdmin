import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MenuComparableReport extends StatefulWidget {
  const MenuComparableReport({super.key});

  @override
  State<MenuComparableReport> createState() => _MenuComparableReportState();
}

class _MenuComparableReportState extends State<MenuComparableReport> {
  List<Text> option = const [
    Text(
      "Comparable Report Year",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
    Text(
      "Comparable Case",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
    Text(
      'Comparable Case Bar Chart',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    )
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.data_saver_on),
    Icon(Icons.list_alt_outlined),
    Icon(Icons.list_alt_outlined),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        centerTitle: true,
        title: const Text(
          "Comparable Report",
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
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     //return const customerCaseinOut();
                    //   },
                    // ));
                  }
                  if (i == 1) {
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) {
                    //    // return const customercasebar();
                    //   },
                    // ));
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
