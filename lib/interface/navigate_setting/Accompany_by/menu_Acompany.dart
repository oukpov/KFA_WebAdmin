import 'package:flutter/material.dart';
import 'Acompany_List.dart';
import 'Acompany_new.dart';

class Menu_Acompany extends StatefulWidget {
  const Menu_Acompany({super.key});

  @override
  State<Menu_Acompany> createState() => _MenuAutoState();
}

List<Text> optionText = const [
  Text(
    "Acompany New",
    style: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
  ),
  Text(
    "Acompany List",
    style: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
  ),
];
List<Image> optionIcon = [
  Image(
    image: AssetImage(
      'assets/S_Add.png',
    ),
  ),
  Image(
    image: AssetImage('assets/S_List.png'),
  ),
];

class _MenuAutoState extends State<Menu_Acompany> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 27, 146, 1),
        centerTitle: true,
        title: Text(
          "Acompany",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage('assets/images/New_KFA_Logo.png'),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter),
        ),
        margin: EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (int i = 0; i < optionIcon.length; i++)
            InkWell(
              onTap: () {
                setState(() {
                  if (i == 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => New_Acompany()));
                  }
                  if (i == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Acompany_List()));
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
                      padding: EdgeInsets.all(5),
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
