import 'package:flutter/material.dart';
import '../../../../Auth/login.dart';
import '../../../../components/colors.dart';
import '../MenuPage/AddProperty/Verbal_add.dart';
import '../MenuPage/ListProperty/ListProPerty.dart';

Widget buttonDrawer(var icon, text, BuildContext context) {
  return Row(children: [
    Icon(
      icon,
      color: blackColor,
    ),
    const SizedBox(width: 2),
    Text(text,
        style: TextStyle(
            fontSize: MediaQuery.textScaleFactorOf(context) * 12,
            color: blackColor))
  ]);
}

var size7 = const SizedBox(height: 7);
var diVider = Divider(height: 1, color: whiteColor);

var imageBackGround = Image.asset(
  'assets/images/KFA_CRM.png',
  width: 60,
);

Widget headerTitle(BuildContext context) {
  return Text(
    'Khmer Foundation Appraisal',
    style: TextStyle(
        color: blackColor,
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.textScaleFactorOf(context) * 17),
  );
}

Widget headerTitleOption(BuildContext context, fontsize) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Find Your New Home',
        style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.textScaleFactorOf(context) * fontsize),
      ),
    ],
  );
}

Widget optionHeader(text, int index, w, context, email, idUserController,
    bool member, idUserpersonal, myIdController) {
  return InkWell(
    onTap: () {
      if (index == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListProperty(
                      myIdController: myIdController,
                      email: email,
                      idUsercontroller: idUserController,
                      optionDropdown: false,
                      device: 'Mobile',
                      drawerType: 'For Rent',
                      list: const [],
                    )));
      } else if (index == 2) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListProperty(
                      myIdController: myIdController,
                      email: email,
                      idUsercontroller: idUserController,
                      device: 'Mobile',
                      optionDropdown: false,
                      drawerType: 'For Sale',
                      list: const [],
                    )));
      } else {
        if (member == true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProperty(
                  idUserController: idUserpersonal,
                ),
              ));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Login(),
              ));
        }
      }
    },
    child: Container(
      alignment: Alignment.center,
      height: 35,
      width: w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromARGB(255, 4, 8, 83),
          border: Border.all(width: 1, color: Colors.white)),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.textScaleFactorOf(context) * 12),
      ),
    ),
  );
}
