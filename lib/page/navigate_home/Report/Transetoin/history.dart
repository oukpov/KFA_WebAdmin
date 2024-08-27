// ignore_for_file: unused_element, unused_field

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:web_admin/page/navigate_home/Report/Transetoin/personal_user.dart';
import '../../User/search.dart';

class Trastoin_Payment extends StatefulWidget {
  const Trastoin_Payment({super.key});

  @override
  State<Trastoin_Payment> createState() => _Trastoin_PaymentState();
}

class _Trastoin_PaymentState extends State<Trastoin_Payment> {
  @override
  void initState() {
    super.initState();
    _get();
  }

  bool _await = true;
  Future<void> _get() async {
    _await = true;
    await Future.wait([
      Get_User(),
    ]);
    setState(() {
      _await = false;
    });
  }

  bool callback = false;
  String? query;
  int index_back = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 23, 17, 124),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.04,
              )),
          actions: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TextFormField(
                      onTap: () async {
                        final selected = await showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(list, (value) {
                            setState(() {
                              callback = true;
                              index_back = int.parse(value.toString());
                              print(index_back.toString());
                            });
                          }, true, 'control_user', (value) {}),
                        );
                        if (selected != null) {
                          // Handle the selected item here.
                          print('Selected: $selected');
                        }
                      },
                      readOnly: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: 'Search listing here...',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GFButton(
                  textStyle: TextStyle(color: Colors.white),
                  onPressed: () async {
                    setState(() {
                      callback = false;
                    });
                  },
                  text: "All",
                  icon: Icon(Icons.menu_open),
                  color: Colors.white,
                  type: GFButtonType.outline,
                ),
                SizedBox(width: 10)
              ],
            ),
          ],
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 23, 17, 124),
        ),
        body: (_await)
            ? _await_value()
            : (callback != false)
                // ?
                ? _body(list, 0)
                : _body(list, index_back));
  }

  Widget _body(List list, index) {
    return Container(
        height: MediaQuery.of(context).size.height * 9,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 254, 251, 251),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: ListView.builder(
          itemCount: (callback != false) ? 1 : list.length,
          itemBuilder: (context, index) {
            return (callback != false)
                // ?
                ? Box_value(list, index_back)
                : Box_value(list, index);
          },
        ));
  }

  Widget Box_value(List list, index) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return persoin_User(
                list_get: list,
                index: index.toString(),
                id_controller: '${list[index]['control_user']}',
              );
            },
          ));
        },
        child: Card(
          elevation: 15,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: Color.fromARGB(255, 227, 224, 224),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: '${list[index]['url']}',
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 25,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(), // Placeholder while loading
                      errorWidget: (context, url, error) => Icon(
                          Icons.error), // Widget to show in case of an error
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _text('USER ID : ${list[index]['control_user']}', 9,
                            true),
                        _text('Name : ${list[index]['username']}', 9, false),
                        _text('Phone : ${list[index]['tel_num']}', 9, false),
                        _text('Email : ${list[index]['email']}', 9, false)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _text(text, f, bool b) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        text,
        style: TextStyle(
            color: Color.fromARGB(255, 88, 88, 88),
            fontSize: MediaQuery.textScaleFactorOf(context) * f,
            fontWeight: (b == false) ? null : FontWeight.bold),
      ),
    );
  }

  List list = [];
  Future<List> Get_User() async {
    final rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/User_all_payment'));

    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list = jsonData;
      });
    }
    return list;
  }

  Widget _await_value() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Shimmer.fromColors(
            baseColor: Color.fromARGB(255, 151, 150, 150),
            highlightColor: Color.fromARGB(255, 221, 221, 219),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 10),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _container(),
                                    _container(),
                                    _container(),
                                    _container()
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            )),
      ),
    );
  }

  Widget _container() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.008,
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromARGB(255, 190, 14, 14),
        ),
      ),
    );
  }
}
