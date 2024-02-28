import 'package:flutter/material.dart';
import 'ProvinceAll.dart';
import '../../component/Colors/colors.dart';

class ViewAllProvince extends StatefulWidget {
  const ViewAllProvince(
      {super.key,
      required this.email,
      required this.idUserController,
      required this.myIdController});
  final String email;
  final String idUserController;
  final String myIdController;
  @override
  State<ViewAllProvince> createState() => _ViewAllProvinceState();
}

class _ViewAllProvinceState extends State<ViewAllProvince> {
  @override
  Widget build(BuildContext context) {
    return deTailAllProvince();
  }

  Widget deTailAllProvince() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Location In Combodia',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: blackColor,
                fontSize: MediaQuery.textScaleFactorOf(context) * 13),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AllProvince(
                      myIdController: widget.myIdController,
                      email: widget.email,
                      idUserController: widget.idUserController,
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
}
