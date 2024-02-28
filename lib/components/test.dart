// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, avoid_print, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Response response;
  Dio dio = Dio();

  bool error = false; //for error status
  bool loading = false; //for data featching status
  String errmsg = ""; //to assing any error message from API/runtime
  var apidata; //for decoded JSON data

  @override
  void initState() {
    getData(); //fetching data
    super.initState();
  }

  getData() async {
    setState(() {
      loading = true; //make loading true to show progressindicator
    });

    String url =
        "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbal?verbal_published=0";
    //don't use "http://localhost/" use local IP or actual live URL

    Response response = await dio.get(url);
    apidata = response.data; //get JSON decoded data from response

    print(apidata['data'][0]['verbal_id']);
    var code = apidata['data'][0]['verbal_id']; //printing the JSON recieved
    print(code);
    if (response.statusCode == 200) {
      //fetch successful
      if (apidata["error"]) {
        //Check if there is error given on JSON
        error = true;
        errmsg = apidata["msg"]; //error message from JSON
      }
    } else {
      error = true;
      errmsg = "Error while fetching data.";
    }

    loading = false;
    setState(() {}); //refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Data from REST API"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: loading
            ? const CircularProgressIndicator()
            : //if loading == true, show progress indicator
            Text(apidata['data'][0]['verbal_id'].toString()),
      ),
    );
  }
}
