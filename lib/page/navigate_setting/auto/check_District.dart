import 'package:flutter/material.dart';
import 'GoogleMap.dart';

class District extends StatefulWidget {
  const District({super.key});

  @override
  State<District> createState() => _DistrictState();
}

class _DistrictState extends State<District> {
  late List _list;
  int num_index = 0;
  List<String> Title = [
    "Khan Chamkar Mon",
    "Khan Daun Penh",
    "Khan 7 Makara",
    "Khan Tuol Kouk",
    "Khan Mean Chey",
    "Khan Chbar Ampov",
    "Khan Chroy Changvar",
    "Khan Sensok",
    "Khan Russey Keo",
    "Khan Dangkor",
    "Khan Pou Senchey",
    "Khan Preaek Pnov",
    "======> Show All <======",
  ];
  TextStyle title = const TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  @override
  void initState() {
    _list = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("District in Phnom Penh"),
      ),
      body: ListView.builder(
          itemCount: Title.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              height: 50,
              alignment: Alignment.center,
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
              child: InkWell(
                onTap: () {
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Check_map(
                              name: Title[index].toString(),
                              get_cid: index,
                            )));
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Image(
                      image: AssetImage(
                        'assets/S_place.png',
                      ),
                    ),
                    Text(
                      Title.elementAt(index),
                      style: title,
                    ),
                    const Image(
                      image: AssetImage(
                        'assets/poin.png',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
