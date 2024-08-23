// ignore_for_file: unused_field, must_be_immutable

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:http/http.dart' as http;
import '../../../../../../components/contants.dart';

class Edit_Agency extends StatefulWidget {
  Edit_Agency({super.key, required this.list, required this.index});
  List list = [];
  String? index;

  @override
  State<Edit_Agency> createState() => _New_AgencyState();
}

class _New_AgencyState extends State<Edit_Agency> {
  TextEditingController? _update_new;
  TextEditingController? _email;
  TextEditingController? _phone;
  int index_p = 0;
  @override
  void initState() {
    index_p = int.parse(widget.index.toString());
    _update_new = TextEditingController(
        text: '${widget.list[index_p]['agenttype_name']}');
    name = _update_new!.text;

    _email = TextEditingController(
        text: '${widget.list[index_p]['agent_type_email']}');
    email = _email!.text;

    _phone = TextEditingController(
        text: '${widget.list[index_p]['agent_type_phone']}');
    phone = _phone!.text;
    super.initState();
  }

  String? name;
  String? phone;
  String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Approved'),
        backgroundColor: Color.fromRGBO(49, 27, 146, 1),
        centerTitle: true,
        actions: [
          GFButton(
            elevation: 10,
            color: Color.fromARGB(255, 53, 113, 10),
            onPressed: () {
              Assign_new();
            },
            text: "Edit",
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
                controller: _update_new,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    fontWeight: FontWeight.bold),
                onChanged: (value) {
                  setState(() {
                    name = _update_new!.text;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.archive_outlined,
                    color: kImageColor,
                  ),
                  fillColor: kwhite,
                  hintText: 'Update Name Edit_Inspector',
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
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.84,
              child: TextFormField(
                controller: _phone,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    fontWeight: FontWeight.bold),
                onChanged: (value) {
                  setState(() {
                    phone = _phone!.text;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.archive_outlined,
                    color: kImageColor,
                  ),
                  fillColor: kwhite,
                  hintText: 'Phone',
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
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.84,
              child: TextFormField(
                controller: _email,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    fontWeight: FontWeight.bold),
                onChanged: (value) {
                  setState(() {
                    email = _email!.text;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.archive_outlined,
                    color: kImageColor,
                  ),
                  fillColor: kwhite,
                  hintText: 'Email',
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
      'agenttype_name': name.toString(),
      'agent_type_phone': phone.toString(),
      'agent_type_email': email.toString(),
      'agenttype_published': 1,
    };
    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update_agency/${widget.list[index_p]['agenttype_id']}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success Edit');
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
