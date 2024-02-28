// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

typedef OnChangeCallback = void Function(dynamic value);

class Code extends StatefulWidget {
  final OnChangeCallback code;
  const Code({
    Key? key,
    required this.code,
  }) : super(key: key);

  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {
  late List<dynamic> code;
  bool loading = false;
  late int codedisplay;
  late int check_num;
  @override
  void initState() {
    Load();
    code = [];
    codedisplay = 0;
    super.initState();
  }

  void Load() async {
    setState(() {
      loading = true; //make loading true to show progressindicator
    });
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbal'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        loading = false;
        code = jsonData['data'];
        check_num = int.parse(code[0]['verbal_id']);

        // print(_list);
      });
      // print(list.length);
    }
    // print(code.length);
    for (int i = 1; i < code.length; i++) {
      if (check_num < int.parse(code[i]['verbal_id'])) {
        check_num = int.parse(code[i]['verbal_id']);
      }
    }
    codedisplay = check_num + 1;
    widget.code(codedisplay);
    print(codedisplay);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: loading
          ? Center(child: CircularProgressIndicator())
          : Row(
              children: [
                SizedBox(width: 40),
                Icon(
                  Icons.qr_code,
                  color: Colors.black,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  codedisplay.toString(),
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
    );
  }
}
