// ignore_for_file: unused_import, must_call_super, unused_local_variable, unused_field, must_be_immutable

import 'dart:convert';

import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../components/contants.dart';
import '../../../../models/executive/Appriaser.dart';

typedef OnChangeCallback = void Function(dynamic value);

class LandBuilding_Appraiser_new extends StatefulWidget {
  LandBuilding_Appraiser_new(
      {super.key,
      required this.listback,
      required this.list,
      required this.id});
  final OnChangeCallback listback;
  final List list;
  String? id;
  @override
  State<LandBuilding_Appraiser_new> createState() => _LandBuildingState();
}

class _LandBuildingState extends State<LandBuilding_Appraiser_new> {
  final _formKey = GlobalKey<FormState>();

  List list = [];

  String? appraiser_id;
  String? appraiser_agent_id;
  String? appraiser_executiveid;
  String? appraiser_price;
  String? appraiser_remark;
  String? agenttype_name;

  List<building_appraiser> lb = [
    building_appraiser(0, '', 0, '', '', '', 0, '', 0)
  ];
  void addItemToList() {
    setState(() {
      if (widget.list == []) {
        list.add({
          // "appraiser_id": 0,
          "appraiser_executiveid": int.parse(widget.id.toString()),
          'agenttype_name': agenttype_name,
          "appraiser_agent_id": int.parse(appraiser_agent_id.toString()),
          "appraiser_position": '',
          "appraiser_price": '$appraiser_price',
          "appraiser_remark": '$appraiser_remark',
          "appraiser_published": 0,
          "appraiser_modify_date": null,
          "appraiser_modify_by": 0,
        });
        lb.add(
          building_appraiser(
            int.parse(widget.id.toString()),
            agenttype_name,
            int.parse(appraiser_agent_id.toString()),
            null,
            appraiser_price,
            appraiser_remark,
            0,
            null,
            0,
          ),
        );
      } else {
        widget.list.add({
          // "appraiser_id": 0,
          "appraiser_executiveid": int.parse(widget.id.toString()),
          'agenttype_name': agenttype_name,
          "appraiser_agent_id": int.parse(appraiser_agent_id.toString()),
          "appraiser_position": '',
          "appraiser_price": '$appraiser_price',
          "appraiser_remark": '$appraiser_remark',
          "appraiser_published": 0,
          "appraiser_modify_date": null,
          "appraiser_modify_by": 0,
        });
        lb.add(
          building_appraiser(
            int.parse(widget.id.toString()),
            agenttype_name,
            int.parse(appraiser_agent_id.toString()),
            null,
            appraiser_price,
            appraiser_remark,
            0,
            null,
            0,
          ),
        );
      }
    });
    //  print(id);
  }

  void deleteItemToList(index) {
    setState(() {
      widget.listback(widget.list);
      widget.list.removeAt(index);
    });
  }

  int i = 1;
  @override
  void initState() {
    widget.list != list;
    agency();
  }

  @override
  Widget build(BuildContext context) {
    var sizebox_ = const SizedBox(
      height: 10,
    );
    var sizef = TextStyle(
        color: const Color.fromARGB(255, 14, 64, 106),
        fontSize: MediaQuery.textScaleFactorOf(context) * 13);
    var sizefs = TextStyle(
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 46, 102, 3),
        fontSize: MediaQuery.textScaleFactorOf(context) * 13);
    var Size_h = EdgeInsets.only(right: 30, left: 30, top: 10);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Size_h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Appraiser*',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.remove_circle_outline_sharp,
                          color: Colors.red,
                          size: MediaQuery.of(context).size.height * 0.05,
                        )),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 7),
          Padding(
            padding: Size_h,
            child: Row(
              children: [
                _TextFiled_Input('number', 'Price', ''),
              ],
            ),
          ),
          Padding(
            padding: Size_h,
            child: Row(
              children: [
                _dropdown(),
              ],
            ),
          ),
          Padding(
            padding: Size_h,
            child: Row(
              children: [
                _TextFiled_Input('no_number', 'Remark', ''),
              ],
            ),
          ),
          Padding(
            padding: Size_h,
            child: Center(
              child: GFButton(
                elevation: 10,
                onPressed: () {
                  setState(() {
                    addItemToList();
                    if (widget.list == []) {
                    } else {
                      widget.listback(widget.list);
                    }
                  });
                },
                text: "Save",
                textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 18),
                color: Colors.grey,
                icon: const Icon(Icons.save),
                type: GFButtonType.outline2x,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.26,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.24,
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      deleteItemToList(index);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 166, 37, 28),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Divider(
                              color: Color.fromARGB(255, 14, 64, 106),
                              height: 1),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price',
                                    style: sizef,
                                  ),
                                  sizebox_,
                                  Text(
                                    'Agent Name',
                                    style: sizef,
                                  ),
                                  sizebox_,
                                  Text(
                                    'Remark',
                                    style: sizef,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '  :  ${(widget.list[index]['appraiser_price'].toString() != 'null') ? widget.list[index]['appraiser_price'].toString() : ''} \$',
                                    style: sizefs,
                                  ),
                                  sizebox_,
                                  Text(
                                    '  :  ${(widget.list[index]['agenttype_name'].toString() != 'null') ? widget.list[index]['agenttype_name'].toString() : ''}',
                                    style: sizefs,
                                  ),
                                  sizebox_,
                                  Text(
                                    '  :  ${(widget.list[index]['appraiser_remark'].toString() != 'null') ? widget.list[index]['appraiser_remark'].toString() : ''}',
                                    style: sizefs,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  List _agency_list = [];
  void agency() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_agency'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      // print(jsonData);
      // print(jsonData);

      setState(() {
        _agency_list = jsonData;

        print(_agency_list.toString());
      });
    }
  }

  String? name_agency;
  Widget _dropdown() {
    return Expanded(
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        onChanged: (newValue) {
          setState(() {
            print(newValue);
            appraiser_agent_id = newValue;
            for (int i = 0; i < _agency_list.length; i++) {
              if (_agency_list[i]['agenttype_id'].toString() == newValue) {
                agenttype_name = _agency_list[i]['agenttype_name'].toString();
              }
            }
          });
        },
        value: name_agency,
        items: _agency_list
            .map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
                  value: value['agenttype_id'].toString(),
                  child: Text(
                    value["agenttype_name"].toString(),
                    style: TextStyle(
                      fontSize: MediaQuery.textScaleFactorOf(context) * 12,
                    ),
                  )),
            )
            .toList(),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: kImageColor,
        ),
        decoration: InputDecoration(
          fillColor: kwhite,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          labelText: 'Agency Name*',
          hintText: 'Agency Name*',
          prefixIcon: const Icon(
            Icons.app_registration_sharp,
            color: kImageColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _TextFiled_Input(type, lable, _value) {
    return Expanded(
      child: TextFormField(
        keyboardType: (type == 'number') ? TextInputType.number : null,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.015,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (value) {
          setState(() {
            if (lable == 'Price') {
              appraiser_price = value;
            } else {
              appraiser_remark = value;
            }
          });
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          prefixIcon: const Icon(
            Icons.feed_outlined,
            color: kImageColor,
          ),
          hintText: lable,
          // fillColor: kwhite,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: kPrimaryColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  TextStyle Label() {
    return const TextStyle(color: kPrimaryColor, fontSize: 9);
  }

  TextStyle Name() {
    return const TextStyle(
        color: kImageColor, fontSize: 9, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return const TextStyle(
        color: kImageColor, fontSize: 10, fontWeight: FontWeight.bold);
  }
}
