// ignore_for_file: unused_field, unused_local_variable

import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:web_admin/page/navigate_home/User/search.dart';

import '../../../components/colors.dart';

class User_Vpoint extends StatefulWidget {
  User_Vpoint({super.key, required this.controller_user});
  final String? controller_user;

  @override
  State<User_Vpoint> createState() => _Uer_VpointState();
}

class _Uer_VpointState extends State<User_Vpoint> {
  @override
  void initState() {
    _get();
    super.initState();
  }

  List list_back = [];
  int index_back = 0;
  bool callback = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            )),
        backgroundColor: const Color.fromARGB(255, 23, 17, 124),
        title: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: TextFormField(
                onTap: () async {
                  final selected = await showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                      list,
                      (value) {
                        setState(() {
                          callback = true;
                          index_back = int.parse(value.toString());
                          print(index_back.toString());
                        });
                      },
                      false,
                      'id_user_control',
                      (value) {
                        setState(() {
                          list_back = value;
                        });
                      },
                    ),
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
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Search listing here...',
                ),
              ),
            ),
          ),
        ),
        actions: [
          GFButton(
            textStyle: const TextStyle(color: Colors.white),
            onPressed: () async {
              setState(() {
                callback = false;
              });
            },
            text: "All",
            icon: const Icon(Icons.menu_open),
            color: Colors.white,
            type: GFButtonType.outline,
          ),
          const SizedBox(width: 10),
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Color.fromARGB(255, 23, 17, 124),
      body: (_await)
          ? Center(
              child: _await_value(),
            )
          : callback == false
              ? body(list, 0)
              : body(list_back, index_back),
      // body: _await_value(),
    );
  }

  Widget body(List list, index_back) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 220, 223, 223),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
        child: ListView.builder(
          itemCount: (callback != false) ? 1 : list.length,
          itemBuilder: (context, index) {
            return (callback != false)
                // ?
                ? Box_value(list, index_back)
                // _Text('sdfsdf')
                : Box_value(list, index);
          },
        ),
      )),
    );
  }

  Widget Box_value(list, index) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
      child: Card(
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.17,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Text(
                        'User ID : ${(list[index]['id_user_control'].toString() == "null") ? "" : list[index]['id_user_control']}'),
                    _Text(
                        'Name : ${list[index]['first_name']} ${list[index]['last_name']}'),
                    _Text('Sex : ${list[index]['gender']}'),
                    _Text('Phone : ${list[index]['tel_num']}'),
                    _Text('Email : ${list[index]['email']}'),
                    V_Image(
                        '${(list[index]['count_autoverbal'].toString() == "null") ? "0" : list[index]['count_autoverbal']}'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GFButton(
                      textStyle:
                          TextStyle(color: Color.fromARGB(255, 148, 146, 146)),
                      onPressed: () {
                        setState(() {
                          _showMyDialog(
                              'User ID : ${(list[index]['id_user_control'].toString() == "null") ? "" : list[index]['id_user_control']}',
                              'Name : ${list[index]['first_name']} ${list[index]['last_name']}',
                              'Sex : ${list[index]['gender']}',
                              'Phone : ${list[index]['tel_num']}',
                              'Email : ${list[index]['email']}',
                              '${(list[index]['count_autoverbal'].toString() == "null") ? "0" : list[index]['count_autoverbal']}',
                              '${(list[index]['id_user_control'].toString() == "null") ? "" : list[index]['id_user_control']}');
                          _v_point = TextEditingController(
                              text:
                                  '${(list[index]['count_autoverbal'].toString() == "null") ? "0" : list[index]['count_autoverbal']}');
                          // _v_point = TextEditingController(
                          //     text:
                          //         '${(list[index]['count_autoverbal'].toString() == "null") ? "0" : list[index]['count_autoverbal']}');
                          // Edit_V_Point('${list[index]['id_user_control']}',
                          //     '${list[index]['count_autoverbal']}');
                        });
                      },
                      text: "Edit",
                      icon: Icon(Icons.edit),
                      color: Color.fromARGB(255, 204, 203, 203),
                      type: GFButtonType.outline,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget V_Image(v_point) {
    return Row(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.02,
          width: MediaQuery.of(context).size.height * 0.02,
          child: Image.network(
              'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/Form_Image/v.png'),
        ),
        Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.02,
            width: MediaQuery.of(context).size.height * 0.08,
            child: _Text('$v_point')),
      ],
    );
  }

  Future<void> Edit_V_Point(id_user_control) async {
    var count_autoverbal;
    // var id = '38K622F38A';
    setState(() {
      // count_autoverbal = _v_point!.text;
      count_autoverbal = v_point;
      print(count_autoverbal.toString());
    });
    var data = '''''';
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updart_History/${id_user_control}/${widget.controller_user}?addDate=$date&Vpoint=$count_autoverbal',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: false,
          title: 'Succesfully',
          autoHide: Duration(seconds: 3),
          onDismissCallback: (type) {
            setState(() {});
            Navigator.pop(context);
          }).show();
    } else {
      print(response.statusMessage);
    }
  }

  Widget _Text(text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.grey[700],
            fontSize: MediaQuery.textScaleFactorOf(context) * 10),
      ),
    );
  }

  Future<void> _showMyDialog(text, name, sex, phone, email, v_point, id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Text(text),
              InkWell(
                onTap: () {
                  setState(() {
                    if (date == null) {
                      AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.question,
                          showCloseIcon: false,
                          title: 'Please Check Date',
                          autoHide: Duration(seconds: 2),
                          onDismissCallback: (type) {
                            setState(() {});
                          }).show();
                    } else {
                      Edit_V_Point(id);
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 2,
                      color: Color.fromARGB(255, 58, 59, 60),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.download),
                      Text(
                        'Save',
                        style: TextStyle(
                            color: Color.fromARGB(255, 56, 55, 55),
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 11),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Text(name),
              _Text(sex),
              _Text(phone),
              _Text(email),
              SizedBox(height: 10),
              Input_V(),
            ],
          )),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Back',
                  style: TextStyle(color: Colors.grey),
                ))
          ],
        );
      },
    );
  }

  String? date;
  TextEditingController controller = TextEditingController();
  TextEditingController? _v_point;
  String? v_point;
  Widget Input_V() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.035,
                width: MediaQuery.of(context).size.height * 0.035,
                child: Image.network(
                    'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/Form_Image/v.png'),
              ),
              SizedBox(width: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.23,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextFormField(
                    // controller: _v_point,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        v_point = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 8),

                      // hintText: '$text',
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.height * 0.15,
            child: TextField(
              style: TextStyle(
                fontSize: MediaQuery.textScaleFactorOf(context) * 10,
                color: Color.fromARGB(255, 43, 41, 41),
              ),
              controller: controller,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Colors.grey,
                  size: MediaQuery.of(context).size.height * 0.025,
                ), //icon of text field
                labelText: "Date",
                labelStyle: TextStyle(
                    fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
                fillColor: kwhite,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ), //label text of field
              ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));
                if (pickedDate != null) {
                  setState(() {
                    date = DateFormat('yyyy-MM-dd').format(pickedDate);
                    controller.text = date!;
                    print(controller.text.toString());
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
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
                          height: MediaQuery.of(context).size.height * 0.13,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _container(),
                                    _container(),
                                    _container(),
                                    _container(),
                                    _container(),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            radius: 10),
                                        SizedBox(width: 10),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color.fromARGB(
                                                255, 190, 14, 14),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5)),
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
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
        height: MediaQuery.of(context).size.height * 0.01,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromARGB(255, 190, 14, 14),
        ),
      ),
    );
  }

  bool _await = true;
  Future<void> _get() async {
    _await = true;
    await Future.wait([
      User_VPoint(),
    ]);
    setState(() {
      _await = false;
    });
  }

  List list = [];
  Future<void> User_VPoint() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user_VPoint'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        list = jsonBody;
        setState(() {
          list;
        });
      } else {
        print('Error');
      }
    } catch (e) {
      print('Error $e');
    }
  }
}
