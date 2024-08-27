// ignore_for_file: deprecated_member_use, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../components/colors.dart';
import '../../ResponseDevice/responsive_layout.dart';
import '../../component/LinkURL/AboutUS/aboutus.dart';
import '../ListProperty/ListProPerty.dart';

class MyDrawer extends StatefulWidget {
  final String device;
  final String email;
  final String idUseContoller;
  final String myIdController;
  const MyDrawer(
      {super.key,
      required this.device,
      required this.email,
      required this.idUseContoller,
      required this.myIdController});
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<Icon> listIcon = [
    Icon(Icons.home, color: whiteColor),
    Icon(Icons.house_outlined, color: whiteColor),
    Icon(Icons.home_work_outlined, color: whiteColor),
    Icon(Icons.newspaper, color: whiteColor),
    Icon(Icons.person_3, color: whiteColor),
    Icon(Icons.phone, color: whiteColor),
  ];

  @override
  void initState() {
    super.initState();
  }

  List listTitle = [
    {"title": "Home"},
    {"title": "For Sale"},
    {"title": "For Rent"},
    {
      "title": "News",
      "link": "News",
    },
    {"title": "About Us"},
    {"title": "Contact Us"},
  ];

  int selectIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 12, 3, 63),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: [
            const SizedBox(height: 60),
            for (int i = 0; i < listTitle.length; i++)
              InkWell(
                  onHover: (value) {
                    setState(() {
                      selectIndex = (selectIndex == i) ? -1 : i;
                    });
                  },
                  onTap: () {
                    if (i == 0) {
                      print(
                          '==> ${widget.email} && ==> ${widget.idUseContoller}');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResponsiveLayout(
                                  myIdController: widget.myIdController,
                                  email: widget.email,
                                  idController: widget.idUseContoller)));
                    } else if (i == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListProperty(
                                myIdController: widget.myIdController,
                                list: const [],
                                device: 'Mobile',
                                drawerType: 'For Sale',
                                optionDropdown: false,
                                email: widget.email,
                                idUsercontroller: widget.idUseContoller),
                          ));
                    } else if (i == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListProperty(
                                myIdController: widget.myIdController,
                                list: const [],
                                device: 'Mobile',
                                drawerType: 'For Rent',
                                optionDropdown: false,
                                email: widget.email,
                                idUsercontroller: widget.idUseContoller),
                          ));
                    } else {
                      for (int x = 0; x < listLinkURL.length; x++)
                        launch(
                          listLinkURL[x]['url'].toString(),
                          forceSafariVC: false,
                          forceWebView: false,
                        );
                    }
                  },
                  child: buttonInDrawer(listIcon.elementAt(i),
                      listTitle[i]['title'], context, i)),
          ],
        ),
      ),
    );
  }

  Widget buttonInDrawer(Widget icon, text, BuildContext context, i) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                width: 1,
                color: (selectIndex == i) ? whiteColor : Colors.transparent)),
        height: 50,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            icon,
            const SizedBox(width: 2),
            Text(text,
                style: TextStyle(
                    fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                    color: whiteColor,
                    fontWeight: FontWeight.bold)),
            const Spacer(),
            Icon(
              Icons.arrow_circle_left_outlined,
              color: whiteColor,
            )
          ]),
        ),
      ),
    );
  }
}
