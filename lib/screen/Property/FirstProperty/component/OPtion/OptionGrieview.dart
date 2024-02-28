import 'package:flutter/material.dart';
import '../../MenuPage/ListProperty/ListProPerty.dart';

Widget optionProperty(context, List list, text, add, type, device, email,
    idUserController, myIdController) {
  return Padding(
    padding: const EdgeInsets.only(right: 30, left: 30),
    child: Row(
      children: [
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.textScaleFactorOf(context) * 19),
        ),
        const Spacer(),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ListProperty(
                    myIdController: myIdController,
                    email: email,
                    idUsercontroller: idUserController,
                    optionDropdown: false,
                    drawerType: 'For $type',
                    device: device,
                    list: list,
                  );
                },
              ));
            },
            child: Text(
              'View All',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.textScaleFactorOf(context) * 12,
                  color: const Color.fromARGB(255, 62, 60, 60)),
            )),
      ],
    ),
  );
}
