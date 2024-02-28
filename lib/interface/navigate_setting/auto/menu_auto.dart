import 'package:flutter/material.dart';
import 'auto_list.dart';
import 'check_District.dart';
import 'new_auto.dart';

class MenuAuto extends StatefulWidget {
  const MenuAuto({super.key});

  @override
  State<MenuAuto> createState() => _MenuAutoState();
}

List<Text> optionText = const [
  Text(
    "New Auto",
    style: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
  ),
  Text(
    "Auto List",
    style: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
  ),
  Text(
    "Auto in Phnom Penh",
    style: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
  )
];
List<Image> optionIcon = const [
  Image(
    image: AssetImage(
      'assets/S_Add.png',
    ),
  ),
  Image(
    image: AssetImage('assets/S_List.png'),
  ),
  Image(
    image: AssetImage(
      'assets/S_plan.png',
    ),
  ),
];

class _MenuAutoState extends State<MenuAuto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(49, 27, 146, 1),
        centerTitle: true,
        title: const Text(
          "Auto",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage('assets/images/New_KFA_Logo.png'),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter),
        ),
        margin: const EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (int i = 0; i < optionIcon.length; i++)
            InkWell(
              onTap: () {
                setState(() {
                  if (i == 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NewAuto()));
                  }
                  if (i == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AutoList()));
                  }
                  if (i == 2) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const District()));
                  }
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green, Colors.blue],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: Color.fromARGB(157, 103, 94, 91),
                          blurStyle: BlurStyle.outer)
                    ]),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: optionIcon.elementAt(i),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: optionText.elementAt(i),
                    )
                  ],
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
