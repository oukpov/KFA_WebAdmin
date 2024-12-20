import 'package:flutter/material.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';

class UIAPP extends StatefulWidget {
  const UIAPP({super.key});

  @override
  State<UIAPP> createState() => _UIAPPState();
}

class _UIAPPState extends State<UIAPP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appback,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "USER INTERFACE APPLICATION",
                style: TextStyle(
                  color: blackColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: greyColor)),
                height: 600,
                padding: const EdgeInsets.all(30),
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(right: 30),
                    decoration: BoxDecoration(
                        color: greenColors,
                        border: Border.all(width: 1, color: blackColor)),
                    height: 550,
                    width: 300,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
