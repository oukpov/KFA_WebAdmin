// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unused_field, unused_element
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Province_dropdown extends StatefulWidget {
  Province_dropdown(
      {Key? key,
      required this.provicne_id,
      required this.cummone_id,
      required this.district_id,
      required this.cummone_id0,
      required this.district_id0,
      required this.province_id0})
      : super(key: key);
  String? province_id0;
  String? district_id0;
  String? cummone_id0;
  final OnChangeCallback provicne_id;
  final OnChangeCallback district_id;
  final OnChangeCallback cummone_id;

  @override
  State<Province_dropdown> createState() => _PropertyDropdownState();
}

class _PropertyDropdownState extends State<Province_dropdown> {
  @override
  void initState() {
    super.initState();

    _list = [];
    _list_d = [];
    // ignore: unnecessary_new
    Load();
  }

  bool _isLoading = false;
  Future<void> _district() async {
    _isLoading = true;
    await Future.wait([
      dristrict_first(),
    ]);

    setState(() {
      _isLoading = false;
    });
  }

  bool _isLoading_c = false;
  Future<void> _cummune() async {
    _isLoading_c = true;
    await Future.wait([
      cummone_value(),
    ]);

    setState(() {
      _isLoading_c = false;
    });
  }

  String? cummone_id;
  String? district_id;
  List _list = [];
  String? province;
  String? province_id;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55,
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            //value: genderValue,
            onChanged: (newValue) {
              setState(() {
                widget.provicne_id(newValue);
                province_id = newValue.toString();
                _district();
              });
            },
            value: province,
            items: _list
                .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                    value: value["provinces_id"].toString(),
                    child: Text(
                      value["provinces_name"],
                      style: TextStyle(
                          fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                          height: 0.1),
                    ),
                  ),
                )
                .toList(),
            // add extra sugar..
            icon: Icon(
              Icons.arrow_drop_down,
              color: kImageColor,
            ),

            decoration: InputDecoration(
              fillColor: kwhite,
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              labelText: (widget.province_id0 != null)
                  ? widget.province_id0.toString()
                  : 'Province*',
              hintText: 'Select one',
              prefixIcon: Icon(
                Icons.business_outlined,
                color: kImageColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
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
        _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: 55,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  //value: genderValue,
                  onChanged: (newValue) {
                    setState(() {
                      widget.district_id(newValue);
                      district_id = newValue;
                      _cummune();
                    });
                  },
                  value: province,
                  items: _list_d
                      .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                          value: value["district_id"].toString(),
                          child: Text(
                            value["district_name"],
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) * 13,
                                height: 0.1),
                          ),
                        ),
                      )
                      .toList(),
                  // add extra sugar..
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: kImageColor,
                  ),

                  decoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    labelText: (widget.district_id0 != null)
                        ? widget.district_id0.toString()
                        : 'District*',
                    hintText: 'Select one',
                    prefixIcon: Icon(
                      Icons.business_outlined,
                      color: kImageColor,
                    ),
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
        _isLoading_c
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: 55,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  //value: genderValue,
                  onChanged: (newValue) {
                    setState(() {
                      widget.cummone_id(newValue);
                      cummone_id = newValue;
                    });
                  },
                  value: province,
                  items: _list_c
                      .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                          value: value["commune_id"].toString(),
                          child: Text(
                            value["commune_name"],
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) * 13,
                                height: 0.1),
                          ),
                        ),
                      )
                      .toList(),
                  // add extra sugar..
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: kImageColor,
                  ),

                  decoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    labelText: (widget.district_id0 != null)
                        ? widget.cummone_id0.toString()
                        : 'Cummune',
                    hintText: 'Select one',
                    prefixIcon: Icon(
                      Icons.business_outlined,
                      color: kImageColor,
                    ),
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
      ],
    );
  }

  void Load() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/province_bank'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        _list = jsonData['data'];
      });
    }
  }

  var _list_d = [];
  Future<void> dristrict_first() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/district_bank/$province_id'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        _list_d = jsonBody;
        setState(() {
          _list_d;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  var _list_c = [];
  Future<void> cummone_value() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/commune_bank/$district_id'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        _list_c = jsonBody;
        setState(() {
          _list_c;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }
}
