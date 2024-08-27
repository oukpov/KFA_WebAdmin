import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OneSignal extends StatefulWidget {
  const OneSignal({super.key});

  @override
  State<OneSignal> createState() => _OneSignalState();
}

class _OneSignalState extends State<OneSignal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  mainOnesignal();
                },
                child: const Text('Push Notification'))
          ],
        ),
      ),
    );
  }

  Future<void> mainOnesignal() async {
    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Basic NjUxOTVjMTEtOWI2MS00OGFiLThiOTYtYWFmMDhhNTEwZWFl'
    };
    var data =
        '''{"app_id": "d3025f03-32f5-444a-8100-7f7637a7f631",\r\n"contents": {"en": "English Message"},\r\n"headings": {"en": "English Title"},\r\n"target_channel": "push",\r\n"include_aliases": { "external_id": ["54K182F54A"]}}''';
    var dio = Dio();
    var response = await dio.request(
      'https://onesignal.com/api/v1/notifications',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }
}
