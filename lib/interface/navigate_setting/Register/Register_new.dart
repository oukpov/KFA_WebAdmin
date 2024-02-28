import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:http/http.dart' as http;
import '../../../../../../components/contants.dart';

class New_Register extends StatefulWidget {
  const New_Register({super.key});

  @override
  State<New_Register> createState() => _New_AgencyState();
}

class _New_AgencyState extends State<New_Register> {
  String? name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Register'),
        backgroundColor: Color.fromRGBO(49, 27, 146, 1),
        centerTitle: true,
        actions: [
          GFButton(
            elevation: 10,
            color: Color.fromARGB(255, 53, 113, 10),
            onPressed: () {
              Assign_new();
            },
            text: "Save",
            icon: Icon(
              Icons.download_outlined,
              color: Colors.white,
            ),
            shape: GFButtonShape.pills,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.84,
              child: TextFormField(
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    fontWeight: FontWeight.bold),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.archive_outlined,
                    color: kImageColor,
                  ),
                  fillColor: kwhite,
                  hintText: 'New Register',
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: kPrimaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> Assign_new() async {
    Map<String, dynamic> payload = await {
      'assiigned_name': name.toString(),
    };
    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/new_Register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success new');
      AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: false,
          title: 'Save Successfully',
          autoHide: Duration(seconds: 3),
          onDismissCallback: (type) {
            setState(() {});
            Navigator.pop(context);
          }).show();
    } else {
      print('Error bank new: ${response.reasonPhrase}');
    }
  }
}
