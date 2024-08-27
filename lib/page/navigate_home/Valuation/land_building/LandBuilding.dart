// ignore_for_file: unused_import, must_call_super, unused_local_variable, must_be_immutable, unused_field

import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../components/colors.dart';
import '../../../../models/executive/executive.dart';

typedef OnChangeCallback = void Function(dynamic value);

class LandBuilding_valuaction_new extends StatefulWidget {
  LandBuilding_valuaction_new(
      {super.key, required this.listback, required this.list, this.id});
  final OnChangeCallback listback;
  final List list;
  String? id;
  @override
  State<LandBuilding_valuaction_new> createState() => _LandBuildingState();
}

class _LandBuildingState extends State<LandBuilding_valuaction_new> {
  final _formKey = GlobalKey<FormState>();

  List list = [];
  var formatter = NumberFormat("##,###,###,##0.00", "en_US");

  List<String> option = [
    'Residencial',
    'Commercial',
    'Agricultural',
  ];
  String? building_executive_id;
  String? building_size;
  String? building_price;
  String? building_price_per;
  String? building_des;
  List<building_execuactive> lb = [
    building_execuactive(0, '', '', '', '', 1, '')
  ];
  void addItemToList() {
    setState(() {
      if (widget.list == []) {
        list.add({
          "building_executive_id": int.parse(widget.id.toString()),
          "building_size": '$building_size',
          "building_price": '$building_price',
          "building_price_per": '$building_price_per',
          "building_des": '$building_des',
          "building_published": 1,
          "remember_token": ""
        });
        lb.add(
          building_execuactive(0, building_size, building_price,
              building_price_per, building_des, 1, ''),
        );
      } else {
        widget.list.add({
          "building_executive_id": int.parse(widget.id.toString()),
          "building_size": '$building_size',
          "building_price": '$building_price',
          "building_price_per": '$building_price_per',
          "building_des": '$building_des',
          "building_published": 1,
          "remember_token": ""
        });
        lb.add(
          building_execuactive(0, building_size, building_price,
              building_price_per, building_des, 1, ''),
        );
      }
    });
    //  print(id);
  }

  // ignore: non_constant_identifier_names
  double? Minimum, Maximun;

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
  }

  String? ds;
  String? _purpose;
  String? build_size;
  String? build_price;
  String? price_per;
  @override
  Widget build(BuildContext context) {
    var sizebox_ = SizedBox(
      height: 10,
    );
    var sizef = TextStyle(
        color: Color.fromARGB(255, 14, 64, 106),
        fontSize: MediaQuery.textScaleFactorOf(context) * 13);
    var sizefs = TextStyle(
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 46, 102, 3),
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
                  'Buliding*',
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
          const SizedBox(height: 8),
          Padding(
            padding: Size_h,
            child: Row(
              children: [
                _TextFiled_Input('no_number', 'Description', ds),
              ],
            ),
          ),
          Padding(
            padding: Size_h,
            child: Row(
              children: [
                _TextFiled_Input('number', 'Building Size', build_size),
              ],
            ),
          ),
          Padding(
            padding: Size_h,
            child: Row(
              children: [
                _TextFiled_Input('number', 'Building Price', build_price),
              ],
            ),
          ),
          Padding(
            padding: Size_h,
            child: Row(
              children: [
                _TextFiled_Input('number', 'Price Per sqm', price_per),
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
                    alignment: Alignment.center,
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
                                    'Discription',
                                    style: sizef,
                                  ),
                                  sizebox_,
                                  Text(
                                    'Building Size',
                                    style: sizef,
                                  ),
                                  sizebox_,
                                  Text(
                                    'Building Price',
                                    style: sizef,
                                  ),
                                  sizebox_,
                                  Text(
                                    'Price Per Sqm',
                                    style: sizef,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '  :  ${(widget.list[index]['building_des'].toString() != 'null') ? widget.list[index]['building_des'].toString() : ''}',
                                    style: sizefs,
                                  ),
                                  sizebox_,
                                  Text(
                                    '  :  ${(widget.list[index]['building_size'].toString() != 'null') ? widget.list[index]['building_size'].toString() : ''} sqm',
                                    style: sizefs,
                                  ),
                                  sizebox_,
                                  Text(
                                    '  :  ${(widget.list[index]['building_price'].toString() != 'null') ? widget.list[index]['building_price'].toString() : ''} \$',
                                    style: sizefs,
                                  ),
                                  sizebox_,
                                  Text(
                                    '  :  ${(widget.list[index]['building_price_per'].toString() != 'null') ? widget.list[index]['building_price_per'].toString() : ''} \$/sqm',
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
            if (lable == 'Description') {
              building_des = value;
            } else if (lable == 'Building Size') {
              building_size = value;
            } else if (lable == 'Building Price') {
              building_price = value;
            } else if (lable == 'Price Per sqm') {
              building_price_per = value;
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
