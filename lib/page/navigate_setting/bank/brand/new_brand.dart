// ignore_for_file: override_on_non_overriding_member, unused_field, unused_element, equal_keys_in_map, unnecessary_null_comparison

import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:http/http.dart' as http;

import '../../../../components/contants.dart';

class new_Brand extends StatefulWidget {
  const new_Brand({super.key});

  @override
  State<new_Brand> createState() => _bank_newState();
}

class _bank_newState extends State<new_Brand> {
  @override
  void initState() {
    super.initState();
    _province();
    id_district = '';
    brand_commune_id = '';
  }

  bool _isLoading = false;
  Future<void> _province() async {
    _isLoading = true;
    await Future.wait([
      brand_province(),
      bank_name(),
      brand_detail_id(),
    ]);

    setState(() {
      _isLoading = false;
    });
  }

  bool _district_l = false;
  Future<void> _district() async {
    _district_l = true;
    await Future.wait([
      brand_dristrict(),
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

  List? province;
  Future<void> brand_province() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/province_bank'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        province = jsonBody;
        setState(() {
          province;
        });
      } else {
        print('Error bank');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  String? last_detail_brand;
  List? last_id;
  Future<void> brand_detail_id() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Last_bankID'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        last_id = jsonBody;
        setState(() {
          last_id;
          last_detail_brand = last_id![0]['bank_id'].toString();
          print(last_detail_brand);
        });
      } else {
        print('Error bank');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  List? bank_name_list;
  Future<void> bank_name() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bank_dropdown'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['banks'];
        bank_name_list = jsonBody;
        setState(() {
          bank_name_list;
        });
      } else {
        print('Error bank');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  String? province_id;
  String? bank_name_d;
  List district_list = [];
  String? id_district;
  Future<void> brand_dristrict() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/district_bank/${province_id}'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];
        district_list = jsonBody;
        setState(() {
          district_list;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  List? cummone_list = [];
  String? cummone;
  String? id_cummone;
  Future<void> bank_cummone() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/commune_bank/${brand_district_id}'));
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
        backgroundColor: const Color.fromARGB(255, 225, 224, 224),
        body: (_isLoading)
            ? const Center(
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
                                color: const Color.fromARGB(255, 255, 255, 255),
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
                                color: const Color.fromARGB(255, 45, 50, 212),
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
                                        'Brand New',
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
                                            color: const Color.fromARGB(
                                                255, 57, 132, 4),
                                            onPressed: () {
                                              setState(() {
                                                if (brandofficer != null &&
                                                    brandcontact != null &&
                                                    bank_name_d != null &&
                                                    brandname != null &&
                                                    province_id != null &&
                                                    brand_district_id != null &&
                                                    brand_commune_id != null) {
                                                  brand_new();
                                                } else {
                                                  AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.error,
                                                    animType:
                                                        AnimType.rightSlide,
                                                    headerAnimationLoop: false,
                                                    title: 'Error',
                                                    desc: "Please check ",
                                                    btnOkOnPress: () {},
                                                    btnOkIcon: Icons.cancel,
                                                    btnOkColor: Colors.red,
                                                  ).show();
                                                }
                                              });
                                            },
                                            text: "Save",
                                            icon: const Icon(
                                              Icons.download_outlined,
                                              color: Colors.white,
                                            ),
                                            shape: GFButtonShape.pills,
                                          ),
                                          GFButton(
                                            elevation: 10,
                                            color: const Color.fromARGB(
                                                255, 137, 10, 35),
                                            onPressed: () {},
                                            text: "Edit",
                                            icon: const Icon(
                                              Icons.edit,
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
                      const SizedBox(height: 10),
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
                          children: [Brank_new(context)],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  Stack Brank_new(BuildContext context) {
    return Stack(children: [
      Container(
          child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30, top: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 10),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      setState(() {
                        brandofficer = value;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.badge_outlined,
                        color: kImageColor,
                      ),
                      fillColor: kwhite,
                      hintText: 'Brand Officer',
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * 14,
                        fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      setState(() {
                        brandcontact = value;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: kImageColor,
                      ),
                      fillColor: kwhite,
                      hintText: 'brand Contact',
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
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
                ),
              ),
              Container(
                height: 45,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  onChanged: (newValue) {
                    setState(() {
                      bank_name_d = newValue;
                    });
                  },
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please select bank';
                    }
                    return null;
                  },
                  items: bank_name_list!
                      .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                          value: value["bank_name"].toString(),
                          child: Text(
                            value["bank_name"],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.textScaleFactorOf(context) * 13,
                                height: 1),
                          ),
                        ),
                      )
                      .toList(),
                  // add extra sugar..
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: kImageColor,
                  ),
                  decoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    labelText: 'Bank Name',

                    hintText: 'Select',
                    prefixIcon: const Icon(
                      Icons.home_work,
                      color: kImageColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: kerror,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.07,
                  width: double.infinity,
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      setState(() {
                        brandname = value;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.apartment_outlined,
                        color: kImageColor,
                      ),
                      fillColor: kwhite,
                      hintText: 'brand Name',
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  onChanged: (newValue) {
                    setState(() {
                      province_id = newValue;
                      if (province_id != null) {
                        _district();
                      } else {}
                    });
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
                                    MediaQuery.textScaleFactorOf(context) * 13,
                                height: 1),
                          ),
                        ),
                      )
                      .toList(),
                  // add extra sugar..
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: kImageColor,
                  ),
                  decoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    labelText: 'Province',

                    hintText: 'Select',
                    prefixIcon: const Icon(
                      Icons.home_work,
                      color: kImageColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: kerror,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
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
              const SizedBox(height: 10),
              _district_l
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      height: 45,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              onChanged: (newValue) {
                                setState(() {
                                  id_district = newValue;
                                  _cummone_r();
                                });
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
                                      child: Text(value["district_name"],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize:
                                                  MediaQuery.textScaleFactorOf(
                                                          context) *
                                                      13)),
                                    ),
                                  )
                                  .toList(),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: kImageColor,
                              ),
                              decoration: InputDecoration(
                                fillColor: kwhite,
                                filled: true,
                                labelText: 'Khan/District',
                                hintText: 'Select',
                                prefixIcon: const Icon(
                                  Icons.home_work,
                                  color: kImageColor,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: kPrimaryColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: kPrimaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: kerror,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: kerror,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
              const SizedBox(height: 10),
              _cummone
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      height: 45,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            id_cummone = newValue;
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
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: kImageColor,
                        ),
                        decoration: InputDecoration(
                          fillColor: kwhite,
                          filled: true,
                          labelText: 'Sangkat/Commune',

                          hintText: 'Select',
                          prefixIcon: const Icon(
                            Icons.home_work,
                            color: kImageColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: kPrimaryColor, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: kerror,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
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
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      setState(() {
                        brand_village = value.toString();
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
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
                        borderSide: const BorderSide(
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
  String? brandname;
  String? brandacronym;
  String? brandofficer;
  String? brandcontact;
  String? brand_province_id;
  String? brand_district_id;
  String? brand_village;
  String? brand_commune_id;

  void brand_new() async {
    Map<String, dynamic> payload = await {
      'bank_branch_details_id': int.parse(last_detail_brand.toString()),
      'bank_branch_published': 0,
      'bank_branch_name': bank_name_d.toString(),
      'bank_brand_officer': brandofficer.toString(),
      'bank_brand_contact': brandcontact.toString(),
      'bank_branch_province_id': int.parse(province_id.toString()),
      'bank_branch_district_id': int.parse(brand_district_id.toString()),
      'bank_branch_village':
          (brand_village != null) ? brand_village.toString() : 'N/A',
      'bank_branch_commune_id': int.parse(brand_commune_id.toString()),
    };
    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/brand_new');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success brand new');
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
