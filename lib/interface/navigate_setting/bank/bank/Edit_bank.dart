// ignore_for_file: override_on_non_overriding_member, unused_field, unused_element, equal_keys_in_map, unnecessary_null_comparison, must_be_immutable, unused_local_variable, dead_code

import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:http/http.dart' as http;
import '../../../../components/colors.dart';
import 'bank_list.dart';

typedef OnChangeCallback = void Function(dynamic value);

class Edit_bank extends StatefulWidget {
  Edit_bank(
      {super.key,
      required this.Refresh_Edit_one,
      required this.list,
      required this.index_E,
      required this.Refresh_Edit});
  List? list;
  OnChangeCallback? Refresh_Edit;
  OnChangeCallback? Refresh_Edit_one;
  String? index_E;

  @override
  State<Edit_bank> createState() => _bank_newState();
}

class _bank_newState extends State<Edit_bank> {
  List? bank_list_get;
  Future<void> bank_list() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/banklist'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        bank_list_get = jsonBody;
        setState(() {
          bank_list_get;
          // print('${bank_list_get.toString()}');
        });
      } else {
        print('Error bank');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  int district_id = 0;
  @override
  void initState() {
    super.initState();
    _province();

    id_cummone = '';
    index_edit = int.parse(widget.index_E.toString());
    _bankcontxt = TextEditingController(
        text: '${widget.list![index_edit]['bankcontact']}');
    bankcontact = _bankcontxt!.text;
    ///////////////////////////
    _bankname =
        TextEditingController(text: '${widget.list![index_edit]['bank_name']}');
    bankname = _bankname!.text;
    ///////////////////////////
    _bankofficer = TextEditingController(
        text: '${widget.list![index_edit]['bankofficer']}');
    bankofficer = _bankofficer!.text;
    /////////////
    _bank_village = TextEditingController(
        text: '${widget.list![index_edit]['bank_village']}');
    bank_village = _bank_village!.text;
    input_bank_village = bank_village;
    /////////////
    _bank_acronym = TextEditingController(
        text: '${widget.list![index_edit]['bank_acronym']}');
    bankacronym = _bank_acronym!.text;
  }

  String? onebankclass;
  String? textFieldValue;
  int index_edit = 0;
  bool _isLoading = false;
  Future<void> _province() async {
    _isLoading = true;
    await Future.wait([
      bank_province(),
    ]);

    setState(() {
      _isLoading = false;
    });
  }

  bool _district_l = false;
  Future<void> _district() async {
    _district_l = true;

    await Future.wait([
      bank_dristrict(),
    ]);

    setState(() {
      _district_l = false;
    });
  }

  bool _cummone = false;
  Future<void> _cummone_r() async {
    _cummone = true;
    await Future.wait([
      bank_cummone(),
    ]);

    setState(() {
      _cummone = false;
    });
  }

  List? back_value;
  int pro_id = 0;
  String? province_bank;
  String? district_bank;
  String? province_name;
  List? province;
  Future<void> bank_province() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/province_bank'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        province = jsonBody;
        setState(() {
          province;

          print(cumm_name.toString());
          pro_id = widget.list![index_edit]['bank_province_id'];
          province_bank = province![pro_id - 1]['provinces_name'];

          province_id = pro_id.toString();
          // print('province pov = $pro_id');
          bank_dristrict_first(pro_id.toString());
        });
      } else {
        print('Error bank');
      }
    } catch (e) {
      print('Error bank_province $e');
    }
  }

  String? detail_district;
//bankcontact
  TextEditingController? _bankcontxt;
  TextEditingController? _bankname;
  TextEditingController? _bankofficer;
  TextEditingController? _bank_village;
  TextEditingController? _bank_acronym;
  TextEditingController? _province_id;
  String? province_id;
  List district_list = [];
  int? district_function;
  String? id_district;
  String? dr;
  int district = 0;
  Future<void> bank_dristrict_first(String? pro_id) async {
    String? DID;
    if (province_id == null) {
      setState(() {
        DID = pro_id.toString();
      });
    } else {
      setState(() {
        DID = province_id;
      });
    }
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/district_bank/$DID'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        district_list = jsonBody;
        setState(() {
          district_list;
          bank_commune_id = widget.list![0]['bank_commune_id'].toString();

          district_id = widget.list![index_edit]['bank_district_id'];
          for (int i = 0; i < district_list.length; i++) {
            if (district_list[i]['district_id'].toString() ==
                district_id.toString()) {
              dr = district_list[i]['district_name'].toString();
              // bank_district_id = district_list[i]['district_id'];
              district = district_list[i]['district_id'];
              // print('${district_list[i]['district_name'].toString()}');
              print('id = ${district.toString()}');

              break;
            }
          }
          bank_cummone_value(district);
          bank_commune_id;
          id_district = district.toString();
          dr;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  Future<void> bank_dristrict() async {
    String? DID;
    if (province_id == null) {
      setState(() {
        DID = pro_id.toString();
      });
    } else {
      setState(() {
        DID = province_id;
      });
    }
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/district_bank/$province_id'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        district_list = jsonBody;
        setState(() {
          district_list;
          detail_district = 'Show dropdown';

          // print(province_id.toString());
          // print(district_id.toString());
          // print(district_bank.toString());
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  // if (cummone_list![i]['commune_id'].toString() ==
  //               widget.list![i]['bank_commune_id'].toString()) {
  //             print('Yes Yes');
  //           } else {
  //             print('No No');
  //           }
  String? cumm_name;
  String? cumm_name1;
  Future<void> bank_cummone_value(district) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/commune_bank/${district.toString()}'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        cummone_list = jsonBody;
        setState(() {
          cummone_list;
          int? aa = widget.list![index_edit]['bank_commune_id'];
          for (int i = 0; i < widget.list!.length; i++) {
            if (cummone_list![i]['commune_id'] == aa) {
              cumm_name1 = cummone_list![i]['commune_name'].toString();
              print('Id = ${cummone_list![i]['commune_name'].toString()}');
              print(aa.toString());
              cumm_name1;
              break;
            }
          }

          cummone_first;
          id_cummone = bank_commune_id;
          cumm_name1;

          print('Cummone');
        });
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  List? cummone_list = [];
  String? cummone;
  String? cummone_first;
  String? id_cummone;
  Future<void> bank_cummone() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/commune_bank/${id_district.toString()}'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        cummone_list = jsonBody;
        setState(() {
          cummone_list;
        });
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  String? post;
  @override
  String? bankoption;
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 225, 224, 224),
        body: (_isLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.185,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.1),
                                    bottomRight: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.1))),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.16,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 45, 50, 212),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.1),
                                    bottomRight: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.1))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return Bank_list();
                                              },
                                            ));
                                          },
                                          icon: Icon(
                                            Icons.arrow_back_ios_new,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                            color: Colors.white,
                                          )),
                                      Text(
                                        // 'Edit Data Bank List',
                                        'Edit Bank',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Column(
                                        children: [
                                          GFButton(
                                            elevation: 10,
                                            color: Color.fromARGB(
                                                255, 53, 113, 10),
                                            onPressed: () async {
                                              // Edit_new();
                                              // setState(() {
                                              if (widget.list![index_edit]['bank_name'].toString() !=
                                                      bankname ||
                                                  widget.list![index_edit]
                                                              ['bank_acronym']
                                                          .toString() !=
                                                      bankacronym ||
                                                  widget.list![index_edit]['bankofficer']
                                                          .toString() !=
                                                      bankofficer ||
                                                  widget.list![index_edit]
                                                              ['bank_village']
                                                          .toString() !=
                                                      bank_village ||
                                                  widget.list![index_edit]
                                                              ['bankcontact']
                                                          .toString() !=
                                                      bankcontact ||
                                                  widget.list![index_edit]['bank_province_id']
                                                          .toString() !=
                                                      province_id ||
                                                  widget.list![index_edit]
                                                              ['bank_district_id']
                                                          .toString() !=
                                                      bank_district_id) {
                                                await Edit_new();
                                                await bank_list();
                                                print('Edit');
                                                widget.Refresh_Edit!(
                                                    bank_list_get);
                                                widget.Refresh_Edit_one!(
                                                    'one back class');
                                              } else {
                                                print('No Edit');
                                              }
                                            },
                                            text: "Save",
                                            icon: Icon(
                                              Icons.download_outlined,
                                              color: Colors.white,
                                            ),
                                            shape: GFButtonShape.pills,
                                          ),
                                          GFButton(
                                            elevation: 10,
                                            color: Color.fromARGB(
                                                255, 137, 10, 35),
                                            onPressed: () {
                                              AwesomeDialog(
                                                context: context,
                                                title: 'Confirmation',
                                                desc:
                                                    'Are you sure you want to delete this item?',
                                                btnOkText: 'Yes',
                                                btnOkColor: Color.fromARGB(
                                                    255, 72, 157, 11),
                                                btnCancelText: 'No',
                                                btnCancelColor: Color.fromARGB(
                                                    255, 133, 8, 8),
                                                btnOkOnPress: () async {
                                                  delete_bank();
                                                },
                                                btnCancelOnPress: () {},
                                              ).show();
                                            },
                                            text: "Delete",
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                            shape: GFButtonShape.pills,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    MediaQuery.of(context).size.height * 0.1),
                                topRight: Radius.circular(
                                    MediaQuery.of(context).size.height * 0.1))),
                        height: MediaQuery.of(context).size.height * 0.77,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [Bank(context)],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  Stack Bank(BuildContext context) {
    return Stack(children: [
      Container(
          child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.84,
              child: TextFormField(
                controller: _bankname,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    fontWeight: FontWeight.bold),
                onChanged: (value) {
                  setState(() {
                    bankname = _bankname!.text;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.badge_outlined,
                    color: kImageColor,
                  ),
                  fillColor: kwhite,
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
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.84,
              child: TextFormField(
                controller: _bank_acronym,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    fontWeight: FontWeight.bold),
                onChanged: (value) {
                  setState(() {
                    bankacronym = _bank_acronym!.text;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.archive_outlined,
                    color: kImageColor,
                  ),
                  fillColor: kwhite,
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
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.84,
              child: TextFormField(
                controller: _bankofficer,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    fontWeight: FontWeight.bold),
                onChanged: (value) {
                  setState(() {
                    bankofficer = _bankofficer!.text;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.apartment_outlined,
                    color: kImageColor,
                  ),
                  fillColor: kwhite,
                  hintText: (bankofficer == null || bankofficer == '')
                      ? '${widget.list![index_edit]['bankofficer'].toString()}'
                      : bankofficer,
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
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.84,
              child: TextFormField(
                controller: _bankcontxt,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    fontWeight: FontWeight.bold),
                onChanged: (value) {
                  setState(() {
                    // bankcontact = value;
                    bankcontact = _bankcontxt!.text;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: kImageColor,
                  ),
                  fillColor: kwhite,
                  // hintText: (bankcontact == null || bankcontact == '')
                  //     ? '${widget.list![index_edit]['bankcontact'].toString()}'
                  //     : bankcontact,
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  onChanged: (newValue) async {
                    province_id = newValue;
                    if (newValue == null) {
                      setState(() {
                        province_id = pro_id.toString();
                        province_id;
                      });
                    } else {
                      province_id = newValue;
                      province_id;
                      await _district();
                    }
                  },
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please select bank';
                    }
                    return null;
                  },
                  items: province!
                      .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                            value: value["provinces_id"].toString(),
                            child: Text(
                              value["provinces_name"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.textScaleFactorOf(context) *
                                          13,
                                  height: 1),
                            )),
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
                    labelText: '$province_bank',

                    hintText: 'Select',
                    prefixIcon: Icon(
                      Icons.home_work,
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
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kerror,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: kerror,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    //   decoration: InputDecoration(
                    //       labelText: 'From',
                    //       prefixIcon: Icon(Icons.business_outlined)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            _district_l
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        onChanged: (newValue) {
                          id_district = newValue;
                          if (newValue == null) {
                            setState(() {
                              id_district = district.toString();
                              id_district;
                            });
                          } else {
                            setState(() {
                              id_district = newValue;
                              id_district;

                              _cummone_r();
                            });
                          }
                        },
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please select bank';
                          }
                          return null;
                        },
                        items: district_list
                            .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                                value: value["district_id"].toString(),
                                child: Text(
                                  value["district_name"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: MediaQuery.textScaleFactorOf(
                                              context) *
                                          13,
                                      height: 1),
                                ),
                              ),
                            )
                            .toList(),
                        // add extra sugar..
                        //  detail_district='Show dropdown';
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: kImageColor,
                        ),
                        //property_type_id
                        decoration: InputDecoration(
                          fillColor: kwhite,
                          filled: true,
                          labelText: (detail_district != 'Show dropdown')
                              ? '${dr.toString()}'
                              : 'Select',
                          hintText: 'Select',
                          prefixIcon: Icon(
                            Icons.home_work,
                            color: kImageColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: kPrimaryColor, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kerror,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: kerror,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          //   decoration: InputDecoration(
                          //       labelText: 'From',
                          //       prefixIcon: Icon(Icons.business_outlined)),
                        ),
                      ),
                    ),
                  ),
            _cummone
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            if (newValue == null) {
                              id_cummone = bank_commune_id;
                              id_cummone;
                            } else {
                              id_cummone = newValue;
                              id_cummone;
                            }
                            print('nanan = ${id_cummone}');
                          });
                        },
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please select bank';
                          }
                          return null;
                        },
                        items: cummone_list!
                            .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                                value: value["commune_id"].toString(),
                                child: Text(
                                  value["commune_name"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: MediaQuery.textScaleFactorOf(
                                              context) *
                                          13,
                                      height: 1),
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
                          labelText: '$cumm_name1',

                          hintText: 'Select',
                          prefixIcon: Icon(
                            Icons.home_work,
                            color: kImageColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: kPrimaryColor, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kerror,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: kerror,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          //   decoration: InputDecoration(
                          //       labelText: 'From',
                          //       prefixIcon: Icon(Icons.business_outlined)),
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: _bank_village,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold),
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        input_bank_village = bank_village;
                      } else {
                        input_bank_village = value;
                      }
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.apartment_outlined,
                      color: kImageColor,
                    ),
                    fillColor: kwhite,
                    hintText: 'Village',
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
      )),
    ]);
  }

  String? address;
  String? songkat;
  String? provice_map;
  String? khan;
  String? province_dropdown;
  //////Bank New
  String? bankname;
  String? bankacronym;
  String? bankofficer;
  String? bankcontact;
  String? bank_province_id;
  String? bank_district_id;
  String? bank_village;
  String? input_bank_village;
  String? bank_commune_id;
  String? bank_published;
  String? bank_created_by;
  String? bank_modify_by;

  Future<void> Edit_new() async {
    Map<String, dynamic> payload = await {
      'bank_name': bankname.toString(),
      'bank_acronym': bankacronym.toString(),
      'bankofficer': bankofficer.toString(),
      'bankcontact': bankcontact.toString(),
      'bank_province_id': int.parse(province_id.toString()),
      'bank_district_id': int.parse(id_district.toString()),
      'bank_village': (bank_village != null)
          ? input_bank_village.toString()
          : input_bank_village,
      'bank_commune_id': int.parse(id_cummone.toString()),
      'bank_published': 0,
    };
    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update_bank/${widget.list![index_edit]['bank_id'].toString()}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success bank new');
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
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Bank_list();
              },
            ));
          }).show();
    } else {
      print('Error bank new: ${response.reasonPhrase}');
    }
  }

  void delete_bank() async {
    final response = await http.delete(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/delete_bank/${widget.list![index_edit]['bank_id'].toString()}'));
    if (response.statusCode == 200) {
      setState(() {});
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Bank_list();
        },
      ));
    } else {
      throw Exception('Delete error occured!');
    }
  }
}
