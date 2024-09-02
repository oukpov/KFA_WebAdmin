import 'package:flutter/material.dart';

import '../Auto_verbal/Add/Add.dart';
import 'AutoVerbal.dart';

class MenuAutoVerbal extends StatefulWidget {
  MenuAutoVerbal({Key? key, required this.id, required this.id_control_user})
      : super(key: key);
  final String id;
  final String id_control_user;
  @override
  State<MenuAutoVerbal> createState() => _MenuAutoVerbalState();
}

class _MenuAutoVerbalState extends State<MenuAutoVerbal> {
  List<Text> option = const [
    Text("New Auto Verbal",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 36, 0, 156),
            fontSize: 20)),
    Text(" Auto Verbal List",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 36, 0, 156),
            fontSize: 20)),
  ];
  List<Image> optionIconList = const [
    Image(image: AssetImage('assets/New_AutoVerbal.png')),
    Image(image: AssetImage('assets/List_Autoverbal.png')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        title: const Text(
          " Auto Verbal",
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
                  if (i == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Show_autoVerbals()));
                  }
                  if (i == 0) {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => Add(
                    //           id_control_user: widget.id_control_user,
                    //           id: widget.id,
                    //         )));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  margin: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 218, 72),
                          Color.fromARGB(255, 50, 151, 60),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: optionIconList.elementAt(i),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: option.elementAt(i),
                      ),
                      const SizedBox(width: 20),
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
