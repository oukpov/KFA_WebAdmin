// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:web_admin/components/L_w_totaltworow.dart';
import 'package:web_admin/models/savecomparablemodel.dart';
import '../../../../Profile/contants.dart';
import '../../../../components/Dateform.dart';
import '../../../../components/L_w_totaltwo.dart';
import '../../../../components/bankcolumn.dart';
import '../../../../components/property_typetwo.dart';
import '../../../../components/roadtwo.dart';
import '../../../../components/total_dropdowntwo.dart';
import '../../../../components/total_dropdowntwocolumn.dart';
import '../../../../components/total_dropdowntwocondition.dart';
import '../../../../screen/Property/Map/map_in_add_verbal.dart';
import '../../Customer/component/Web/simple/dropdown.dart';
import '../../Customer/component/Web/simple/dropdownRowtwo.dart';
import '../../Customer/component/Web/simple/inputdateRowNow .dart';
import '../../Customer/component/Web/simple/inputfiledRow.dart';
import '../../Customer/component/Web/simple/inputfiledRowVld.dart';
import '../../Customer/component/title/title.dart';

class Get_NewComarable extends StatefulWidget {
  const Get_NewComarable(
      {super.key,
      required this.device,
      required this.email,
      required this.idUsercontroller,
      required this.myIdcontroller});
  final String device;
  final String email;
  final String idUsercontroller;
  final String myIdcontroller;
  @override
  State<Get_NewComarable> createState() => _Get_NewComarableState();
}

class _Get_NewComarableState extends State<Get_NewComarable> {
  var check;
  bool waitPosts = false;
  List _list = [];
  late SavenewcomparableModel savenewcomparableModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var sizebox40h = const SizedBox(height: 40);
  var sizebox10h = const SizedBox(height: 10);
  var sizebox = const SizedBox(width: 10);
  var sizeboxw40 = const SizedBox(width: 40);
  List listbranch = [""];
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_new
    savenewcomparableModel = new SavenewcomparableModel(
        bankinfo: '',
        condition: '',
        latittute: '',
        longtittute: '',
        ownerphone: '',
        propertytype: '',
        skc: '',
        surveydate: '');
    getNow();
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();

    return DateFormat('yyyy-MM-dd').format(now);
  }

  void getNow() {
    setState(() {
      String today = getCurrentDate();
      // comparabledate = today;
      // comparable_survey_date = today;
      get_new_comparable();
    });
  }

  Future get_new_comparable() async {
    var headers = {
      'Accept': 'application/json',
      'Connection': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable_search',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      _list = jsonDecode(json.encode(response.data));
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    double textstye = 35;
    check = MediaQuery.of(context).size.width;
    var w = MediaQuery.of(context).size.width * 0.35;
    var wt = MediaQuery.of(context).size.width * 0.27;
    var wt2 = MediaQuery.of(context).size.width * 0.69;
    var wsize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // title: Text("New Comparable $comparable_survey_date"),
        title: Text("New Comparable"),
      ),
      body: (waitPosts)
          ? LiquidLinearProgressIndicator(
              value: 0.25,
              valueColor: const AlwaysStoppedAnimation(
                  Color.fromARGB(255, 53, 33, 207)),
              backgroundColor: Colors.white,
              borderColor: Colors.white,
              borderWidth: 5.0,
              borderRadius: 12.0,
              direction: Axis.vertical,
              center: Text(
                "Please waiting...!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 15),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(right: 0, left: 10),
                  child: (widget.device == 'm')
                      ? Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30, left: 30),
                            child: Column(
                              children: [
                                //Text("${device}"),
                                // Row(
                                //   children: [
                                //     const Spacer(),
                                //     InkWell(
                                //       onTap: () {
                                //         // setState(() {
                                //         //   Comparable_new();
                                //         //   print('object');
                                //         // });
                                //         validateAndSave();
                                //         if (com_property_type != null &&
                                //             compare_bank_id != null &&
                                //             lat != null &&
                                //             log != null &&
                                //             comparabledate != null &&
                                //             condition != null &&
                                //             commune != null &&
                                //             province != null &&
                                //             district != null &&
                                //             comparable_phone != null &&
                                //             total_b != null) {
                                //           AwesomeDialog(
                                //               context: context,
                                //               animType: AnimType.leftSlide,
                                //               headerAnimationLoop: false,
                                //               dialogType: DialogType.success,
                                //               showCloseIcon: false,
                                //               title: 'Save Successfully',
                                //               autoHide: Duration(seconds: 3),
                                //               onDismissCallback: (type) async {
                                //                 await Comparable_new();
                                //                 setState(() {
                                //                   print("Save");
                                //                 });
                                //                 // Navigator.pop(context);
                                //                 // onPressed: () {
                                //                 // Navigator.push(
                                //                 //   context,
                                //                 //   MaterialPageRoute(
                                //                 //       builder: (context) =>
                                //                 //           const ResponsiveHomeP()),
                                //                 // );
                                //               }).show();
                                //         } else {
                                //           AwesomeDialog(
                                //             context: context,
                                //             dialogType: DialogType.error,
                                //             animType: AnimType.rightSlide,
                                //             headerAnimationLoop: false,
                                //             title: 'Error',
                                //             desc: "Please check ",
                                //             btnOkOnPress: () {
                                //               print("Error");
                                //             },
                                //             btnOkIcon: Icons.cancel,
                                //             btnOkColor: Colors.red,
                                //           ).show();
                                //         }
                                //       },
                                //       child: Container(
                                //         alignment: Alignment.center,
                                //         height:
                                //             MediaQuery.of(context).size.height *
                                //                 0.05,
                                //         width:
                                //             MediaQuery.of(context).size.width *
                                //                 0.2,
                                //         decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(10),
                                //             color: Color.fromARGB(
                                //                 255, 32, 167, 8)),
                                //         child: Text(
                                //           'Save',
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.bold),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                sizebox10h,
                                titletexts('Bank Info *', context),
                                sizebox10h,
                                BankDropdowncolumn(
                                  bank: (value) {
                                    setState(() {
                                      // compare_bank_id = value.toString();
                                    });
                                  },
                                  bankbranch: (value) {
                                    setState(() {
                                      listbranch = value;
                                      // print(
                                      //     "\nkokoobject${listbranch}");
                                    });
                                  },
                                  validator: (val) {},
                                  filedName: 'Bank',
                                ),
                                sizebox10h,
                                titletexts('Bank Officer', context),
                                sizebox10h,
                                InputfiedRow(
                                    //validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        // com_bank_officer = value;
                                      });
                                    },
                                    filedName: 'Bank Officer',
                                    flex: 4),
                                sizebox10h,
                                InputfiedRow(
                                    //validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        // com_bank_contact = value;
                                      });
                                    },
                                    filedName: 'Bank Contact',
                                    flex: 4),
                                sizebox10h,
                                titletexts('Zoning', context),
                                sizebox10h,
                                Container(
                                  height: 45,
                                  child: DropDown(
                                      validator: true,
                                      flex: 6,
                                      value: (value) {
                                        setState(() {
                                          // zoning_id = value;
                                        });
                                      },
                                      list: zoningList,
                                      valuedropdown: 'zoning_id',
                                      valuetxt: '',
                                      filedName: ''),
                                ),
                                sizebox10h,
                                titletexts('Property Type *', context),
                                sizebox10h,
                                property_hoemtypetwo(
                                  flex: 3,
                                  hometype: (value) {
                                    setState(() {
                                      // com_property_type = value;
                                    });
                                  },
                                  // hometype_lable: com_property_type,
                                  filedName: 'Property Type',
                                ),
                                sizebox10h,
                                titletexts('Road', context),
                                sizebox10h,
                                RoadDropdowntwo(
                                  Name_road: (value) {},
                                  filedName: 'All',
                                  id_road: (value) {
                                    // comparable_road = value;
                                    //print(comparable_road);
                                  },
                                  flex: 3,
                                ),
                                sizebox10h,
                                titletexts('Land', context),
                                sizebox10h,
                                Land_buildingtwo(
                                  filedName: '',
                                  //flex: 3,
                                  l: (value) {
                                    setState(() {
                                      //  lproperty = value;
                                    });
                                  },
                                  total: (value) {
                                    setState(() {
                                      //ltotal = value;
                                    });
                                  },
                                  w: (value) {
                                    setState(() {
                                      // lwproperty = value;
                                    });
                                  },
                                ),
                                // Land_buildingtwo(

                                //    filedName: 'W', flex: 3,
                                //    ),

                                sizebox10h,
                                titletexts('Building', context),
                                sizebox10h,
                                Land_buildingtwo(
                                  filedName: '',
                                  //flex: 3,
                                  l: (value) {
                                    setState(() {
                                      // lb = value;
                                    });
                                  },
                                  total: (value) {
                                    setState(() {
                                      // total_b = value;
                                    });
                                  },
                                  w: (value) {
                                    setState(() {
                                      // wb = value;
                                    });
                                  },
                                ),
                                sizebox10h,
                                titletexts('Price Per Sqm', context),
                                sizebox10h,
                                Total_dropdowncolumn(
                                  input: (value) {
                                    setState(() {
                                      // askingprice = value;
                                    });
                                  },
                                  total_type: (value) {
                                    setState(() {
                                      // sqm_total = value;
                                    });
                                  },
                                ),
                                sizebox10h,
                                titletexts('Offered Price', context),
                                sizebox10h,
                                Total_dropdowncolumn(
                                  input: (value) {
                                    setState(() {
                                      //comparable_add_price = value;
                                    });
                                  },
                                  total_type: (value) {
                                    setState(() {
                                      //comparable_addprice_total = value;
                                    });
                                  },
                                ),
                                sizebox10h,
                                titletexts('Offered Price', context),
                                sizebox10h,
                                Total_dropdowncolumn(
                                  input: (value) {
                                    setState(() {
                                      // comparable_bought_price =
                                      //     value.toString();
                                    });
                                  },
                                  total_type: (value) {
                                    setState(() {
                                      //comparable_bought_price_total = value;
                                    });
                                  },
                                ),
                                sizebox10h,

                                titletexts('Sold Out Price', context),
                                sizebox10h,
                                Total_dropdowncolumn(
                                  input: (value) {
                                    setState(() {
                                      // comparable_sold_price = value.toString();
                                    });
                                  },
                                  total_type: (value) {
                                    setState(() {
                                      // comparable_sold_total_price =
                                      //     value.toString();
                                    });
                                  },
                                ),
                                sizebox10h,
                                titletexts('Asking Price(TTAmount)', context),
                                SizedBox(
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.015,
                                        fontWeight: FontWeight.bold),
                                    onChanged: (value) {
                                      setState(() {
                                        // Amount = value.toString();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      // prefixIcon: Icon(
                                      //   Icons.width_full_outlined,
                                      //   color: kImageColor,
                                      // ),
                                      fillColor: kwhite,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: kPrimaryColor, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        // borderSide: BorderSide(
                                        //   width: 1,
                                        //   color: (!hasError && widget.validator == true)
                                        //       ? Colors.red
                                        //       : bordertxt,
                                        // ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      labelText: '',
                                    ),
                                  ),
                                ),
                                sizebox10h,
                                titletexts('Condition*', context),
                                sizebox10h,
                                DropDownRowTwo(
                                    validator: true,
                                    flex: 4,
                                    value: (value) {
                                      setState(() {
                                        //condition = value.toString();
                                        //print('====>${condition}');
                                      });
                                    },
                                    list: [],
                                    valuedropdown: '',
                                    valuetxt: '',
                                    filedName: ''),
                                sizebox10h,
                                InputfiedRow(
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        // year = value.toString();
                                        // year;
                                      });
                                    },
                                    filedName: 'Year',
                                    flex: 4),
                                sizebox10h,
                                titletexts('Address', context),
                                sizebox10h,
                                InputfiedRow(
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        // address = value.toString();
                                      });
                                    },
                                    filedName: '',
                                    flex: 4),
                                sizebox10h,
                                titletexts('SKC *', context),
                                sizebox10h,
                                InputfiedRowVld(
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        //  province = value;
                                      });
                                    },
                                    filedName: '',
                                    flex: 4),
                                sizebox10h,
                                InputfiedRowVld(
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        // district = value;
                                      });
                                    },
                                    filedName: '',
                                    flex: 4),
                                sizebox10h,
                                InputfiedRowVld(
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        //  commune = value;
                                      });
                                    },
                                    filedName: '',
                                    flex: 4),
                                sizebox10h,
                                titletexts('Date*', context),
                                sizebox10h,
                                //Text(comparabledate.toString()),
                                SizedBox(
                                    height: 45,
                                    child: InputDateNow(
                                      filedName: '',
                                      flex: 6,
                                      value: (value) {
                                        setState(() {
                                          // comparabledate = value;
                                          //print('==>New ${comparabledate}');
                                        });
                                      },
                                    )),
                                sizebox10h,
                                titletexts('Remark', context),
                                sizebox10h,
                                InputfiedRow(
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        //  remak = value;
                                      });
                                    },
                                    filedName: '',
                                    flex: 4),
                                sizebox10h,
                                titletexts('Survey Date*', context),
                                sizebox10h,
                                SizedBox(
                                    height: 45,
                                    child: InputDateNow(
                                      filedName: '',
                                      flex: 6,
                                      value: (value) {
                                        // comparable_survey_date = value;
                                      },
                                    )),
                                sizebox10h,
                                titletexts('Owner Phone*', context),
                                sizebox10h,
                                InputfiedRowVld(
                                    validator: true,
                                    readOnly: false,
                                    value: (value) {
                                      setState(() {
                                        //  comparable_phone = value;
                                      });
                                    },
                                    filedName: '',
                                    flex: 4),
                                sizebox10h,
                                titletexts('Latittute*', context),
                                sizebox10h,
                                TextFormField(
                                  validator: (input) {
                                    if (input == null || input.isEmpty) {
                                      return 'require *';
                                    }
                                    return null;
                                  },
                                  //controller: ,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (value) {
                                    setState(() {
                                      // bankcontact = value;
                                      //lat = _lat!.text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8),
                                      prefixIcon: Icon(
                                        Icons.numbers_outlined,
                                        color: kImageColor,
                                      ),
                                      hintText: 'Lat',
                                      fillColor: kwhite,
                                      //labelText: widget.filedName,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: kPrimaryColor, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.red,
                                      ))),
                                ),
                                sizebox10h,
                                titletexts('Longtittute*', context),
                                sizebox10h,
                                TextFormField(
                                  validator: (input) {
                                    if (input == null || input.isEmpty) {
                                      return 'require *';
                                    }
                                    return null;
                                  },
                                  //controller: _log,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (value) {
                                    setState(() {
                                      // bankcontact = value;
                                      // log = _log!.text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8),
                                      prefixIcon: Icon(
                                        Icons.numbers_outlined,
                                        color: kImageColor,
                                      ),
                                      hintText: 'Lag',
                                      fillColor: kwhite,
                                      //labelText: widget.filedName,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: kPrimaryColor, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.red,
                                      ))),
                                ),
                                sizebox10h,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 500,
                                    width: double.infinity,
                                    child: Map_verbal_address_Sale(
                                      get_province: (value) {
                                        setState(() {
                                          // songkat = value.toString();
                                          // print(songkat);
                                        });
                                      },
                                      get_district: (value) {
                                        setState(() {
                                          // provice_map = value.toString();
                                        });
                                      },
                                      get_commune: (value) {
                                        setState(() {
                                          // khan = value.toString();
                                        });
                                      },
                                      get_log: (value) {
                                        setState(() {
                                          // log = value.toString();
                                          // _log = TextEditingController(
                                          //     text: '${log}');
                                          // log = _log!.text;
                                        });
                                      },
                                      get_lat: (value) {
                                        setState(() {
                                          // lat = value.toString();
                                          // _lat = TextEditingController(
                                          //     text: '${lat}');
                                          // lat = _lat!.text;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ))
                      : Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: SizedBox(
                              // width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  //Text(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        //const Spacer(),
                                        // InkWell(
                                        //   onTap: () {
                                        //     // setState(() {
                                        //     //   Comparable_new();
                                        //     //   print('object');
                                        //     // });
                                        //     validateAndSave();
                                        //     if (com_property_type != null &&
                                        //         compare_bank_id != null &&
                                        //         lat != null &&
                                        //         log != null &&
                                        //         comparabledate != null &&
                                        //         condition != null &&
                                        //         commune != null &&
                                        //         province != null &&
                                        //         district != null &&
                                        //         comparable_phone != null &&
                                        //         total_b != null) {
                                        //       AwesomeDialog(
                                        //           context: context,
                                        //           animType: AnimType.leftSlide,
                                        //           headerAnimationLoop: false,
                                        //           dialogType:
                                        //               DialogType.success,
                                        //           showCloseIcon: false,
                                        //           title: 'Save Successfully',
                                        //           autoHide:
                                        //               Duration(seconds: 3),
                                        //           onDismissCallback:
                                        //               (type) async {
                                        //             await Comparable_new();
                                        //             setState(() {
                                        //               print("Save");
                                        //             });
                                        //             // Navigator.pop(context);
                                        //             // onPressed: () {
                                        //             // Navigator.push(
                                        //             //   context,
                                        //             //   MaterialPageRoute(
                                        //             //       builder: (context) =>
                                        //             //           const ResponsiveHomeP()),
                                        //             // );
                                        //           }).show();
                                        //     } else {
                                        //       AwesomeDialog(
                                        //         context: context,
                                        //         dialogType: DialogType.error,
                                        //         animType: AnimType.rightSlide,
                                        //         headerAnimationLoop: false,
                                        //         title: 'Error',
                                        //         desc: "Please check ",
                                        //         btnOkOnPress: () {
                                        //           print("Error");
                                        //         },
                                        //         btnOkIcon: Icons.cancel,
                                        //         btnOkColor: Colors.red,
                                        //       ).show();
                                        //     }
                                        //   },
                                        //   child: Container(
                                        //     alignment: Alignment.center,
                                        //     height: MediaQuery.of(context)
                                        //             .size
                                        //             .height *
                                        //         0.05,
                                        //     width: MediaQuery.of(context)
                                        //             .size
                                        //             .width *
                                        //         0.2,
                                        //     decoration: BoxDecoration(
                                        //         borderRadius:
                                        //             BorderRadius.circular(10),
                                        //         color: Color.fromARGB(
                                        //             255, 32, 167, 8)),
                                        //     child: Text(
                                        //       'Save',
                                        //       style: TextStyle(
                                        //           fontWeight: FontWeight.bold),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  Row(
                                    children: [
                                      filedtext('Bank Info', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: TextFormField(
                                                style: TextStyle(
                                                    fontSize: MediaQuery
                                                            .textScaleFactorOf(
                                                                context) *
                                                        12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                onChanged: (value) {
                                                  setState(() {
                                                    // com_bank_officer = value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  // labelStyle: ,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 0),
                                                  fillColor: kwhite,
                                                  filled: true,
                                                  //labelText: widget.filedName,
                                                  // hintText: widget.filedName,
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: MediaQuery
                                                              .textScaleFactorOf(
                                                                  context) *
                                                          12),
                                                  helperStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: MediaQuery
                                                              .textScaleFactorOf(
                                                                  context) *
                                                          12),
                                                  prefixIcon:
                                                      const SizedBox(width: 7),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                kPrimaryColor,
                                                            width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 249, 0, 0),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 249, 0, 0),
                                                    ),
                                                    //  borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            sizebox,
                                            Expanded(
                                              flex: 2,
                                              child: TextFormField(
                                                style: TextStyle(
                                                    fontSize: MediaQuery
                                                            .textScaleFactorOf(
                                                                context) *
                                                        12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                onChanged: (value) {
                                                  setState(() {
                                                    //  com_bank_contact = value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  // labelStyle: ,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 0),
                                                  fillColor: kwhite,
                                                  filled: true,
                                                  labelText: 'Bank Contact',
                                                  // hintText: widget.filedName,
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: MediaQuery
                                                              .textScaleFactorOf(
                                                                  context) *
                                                          12),
                                                  helperStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: MediaQuery
                                                              .textScaleFactorOf(
                                                                  context) *
                                                          12),
                                                  prefixIcon:
                                                      const SizedBox(width: 7),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                kPrimaryColor,
                                                            width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 249, 0, 0),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 249, 0, 0),
                                                    ),
                                                    //  borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            )
                                            // InputfiedRowtwo(
                                            //     validator: false,
                                            //     readOnly: false,
                                            //     value: (value) {
                                            //       setState(() {
                                            //         com_bank_contact = value;
                                            //       });
                                            //     },
                                            //     filedName: 'Bank Contact',
                                            //     flex: 2),
                                          ],
                                        ),
                                      ),
                                      // sizeboxw40,
                                      //filedtext('Zoning', '', context),
                                      SizedBox(
                                        width: w,
                                        // child: DropDown(
                                        //     validator: true,
                                        //     flex: 2,
                                        //     value: (value) {
                                        //       setState(() {
                                        //         // zoning_id = value;
                                        //       });
                                        //     },
                                        //     list: zoningList,
                                        //     valuedropdown: 'zoning_id',
                                        //     valuetxt: '',
                                        //     filedName: 'All'),
                                      ),
                                    ],
                                  ),
                                  sizebox10h,
                                  //Contact by
                                  Row(
                                    children: [
                                      filedtext('Bank Officer', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            // InputfiedRowtwo(
                                            //     validator: false,
                                            //     readOnly: false,
                                            //     value: (value) {
                                            //       setState(() {
                                            //         com_bank_officer = value;
                                            //       });
                                            //     },
                                            //     filedName: '',
                                            //     flex: 2),
                                            Expanded(
                                              flex: 2,
                                              child: TextFormField(
                                                style: TextStyle(
                                                    fontSize: MediaQuery
                                                            .textScaleFactorOf(
                                                                context) *
                                                        12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                onChanged: (value) {
                                                  setState(() {
                                                    // com_bank_officer = value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  // labelStyle: ,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 0),
                                                  fillColor: kwhite,
                                                  filled: true,
                                                  //labelText: widget.filedName,
                                                  // hintText: widget.filedName,
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: MediaQuery
                                                              .textScaleFactorOf(
                                                                  context) *
                                                          12),
                                                  helperStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: MediaQuery
                                                              .textScaleFactorOf(
                                                                  context) *
                                                          12),
                                                  prefixIcon:
                                                      const SizedBox(width: 7),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                kPrimaryColor,
                                                            width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 249, 0, 0),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 249, 0, 0),
                                                    ),
                                                    //  borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            sizebox,
                                            Expanded(
                                              flex: 2,
                                              child: TextFormField(
                                                style: TextStyle(
                                                    fontSize: MediaQuery
                                                            .textScaleFactorOf(
                                                                context) *
                                                        12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                onChanged: (value) {
                                                  setState(() {
                                                    //  com_bank_contact = value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  // labelStyle: ,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 0),
                                                  fillColor: kwhite,
                                                  filled: true,
                                                  labelText: 'Bank Contact',
                                                  // hintText: widget.filedName,
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: MediaQuery
                                                              .textScaleFactorOf(
                                                                  context) *
                                                          12),
                                                  helperStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: MediaQuery
                                                              .textScaleFactorOf(
                                                                  context) *
                                                          12),
                                                  prefixIcon:
                                                      const SizedBox(width: 7),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                kPrimaryColor,
                                                            width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 249, 0, 0),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 249, 0, 0),
                                                    ),
                                                    //  borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            )
                                            // InputfiedRowtwo(
                                            //     validator: false,
                                            //     readOnly: false,
                                            //     value: (value) {
                                            //       setState(() {
                                            //         com_bank_contact = value;
                                            //       });
                                            //     },
                                            //     filedName: 'Bank Contact',
                                            //     flex: 2),
                                          ],
                                        ),
                                      ),
                                      // sizeboxw40,
                                      filedtext('Zoning', '', context),
                                      SizedBox(
                                        width: w,
                                        child: DropDown(
                                            validator: true,
                                            flex: 2,
                                            value: (value) {
                                              setState(() {
                                                // zoning_id = value;
                                              });
                                            },
                                            list: zoningList,
                                            valuedropdown: 'zoning_id',
                                            valuetxt: '',
                                            filedName: 'All'),
                                      ),
                                    ],
                                  ),
                                  sizebox10h,
                                  //Property Guider Name
                                  Row(
                                    children: [
                                      filedtext('Property Type*', '', context),
                                      SizedBox(
                                        width: w,
                                        child: property_hoemtypetwo(
                                          flex: 3,
                                          hometype: (value) {
                                            setState(() {
                                              // com_property_type = value;
                                            });
                                          },
                                          // hometype_lable: com_property_type,
                                          filedName: 'Property Type',
                                        ),
                                      ),
                                      // sizeboxw40,
                                      filedtext('Road', '', context),
                                      SizedBox(
                                        width: w,
                                        child: RoadDropdowntwo(
                                          Name_road: (value) {},
                                          filedName: 'All',
                                          id_road: (value) {
                                            // comparable_road = value;
                                            //print(comparable_road);
                                          },
                                          flex: 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizebox10h,
                                  //Property Type
                                  Row(
                                    children: [
                                      filedtext('Land', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Land_buildingtwoRow(
                                          filedName: '',
                                          flex: 3,
                                          l: (value) {
                                            setState(() {
                                              // lproperty = value;
                                            });
                                          },
                                          total: (value) {
                                            setState(() {
                                              //  ltotal = value;
                                            });
                                          },
                                          w: (value) {
                                            setState(() {
                                              // lwproperty = value;
                                            });
                                          },
                                          ltext: '',
                                          wtext: '',
                                        ),
                                      ),
                                      //sizeboxw40,
                                      filedtext('Building', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Land_buildingtwoRow(
                                          filedName: '',
                                          flex: 3,
                                          l: (value) {
                                            setState(() {
                                              //  lb = value;
                                            });
                                          },
                                          total: (value) {
                                            setState(() {
                                              //  total_b = value;
                                            });
                                          },
                                          w: (value) {
                                            setState(() {
                                              // wb = value;
                                            });
                                          },
                                          ltext: '',
                                          wtext: '',
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizebox10h,
                                  //Property Location
                                  Row(
                                    children: [
                                      filedtext('Price Per Sqm', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Total_dropdowntwo(
                                          flex: 3,
                                          input: (value) {
                                            setState(() {
                                              //  askingprice = value;
                                            });
                                          },
                                          total_type: (value) {
                                            setState(() {
                                              // sqm_total = value;
                                            });
                                          },
                                        ),
                                      ),
                                      //sizeboxw40,
                                      filedtext('Offered Price', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Total_dropdowntwo(
                                          flex: 3,
                                          input: (value) {
                                            setState(() {
                                              // comparable_add_price = value;
                                            });
                                          },
                                          total_type: (value) {
                                            setState(() {
                                              //  comparable_addprice_total = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizebox10h,
                                  Row(
                                    children: [
                                      filedtext('Offered Price', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Total_dropdowntwo(
                                          flex: 3,
                                          input: (value) {
                                            setState(() {
                                              // comparable_bought_price =
                                              //     value.toString();
                                            });
                                          },
                                          total_type: (value) {
                                            setState(() {
                                              // comparable_bought_price_total =
                                              //     value;
                                            });
                                          },
                                        ),
                                      ),
                                      //sizeboxw40,
                                      filedtext('Sold Out Price', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Total_dropdowntwo(
                                          flex: 3,
                                          input: (value) {
                                            setState(() {
                                              // comparable_sold_price =
                                              //     value.toString();
                                            });
                                          },
                                          total_type: (value) {
                                            setState(() {
                                              // comparable_sold_total_price =
                                              //     value.toString();
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  sizebox10h,
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          filedtext(
                                              'Asking Price', '', context),
                                          filedtext('(TTAmount)', '', context),
                                        ],
                                      ),
                                      SizedBox(
                                        width: w,
                                        child: InputfiedRow(
                                            readOnly: false,
                                            value: (value) {
                                              setState(() {
                                                //  Amount = value.toString();
                                              });
                                            },
                                            filedName: '',
                                            flex: 6),
                                      ),
                                      //sizeboxw40,
                                      filedtext('Condition', '*', context),
                                      SizedBox(
                                        width: w,
                                        child: Total_dropdowntwocondition(
                                          flex: 3,
                                          total_type: (value) {
                                            setState(() {
                                              // condition = value.toString();
                                            });
                                          },
                                          input: (value) {
                                            setState(() {
                                              //  year = value.toString();
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  sizebox10h,
                                  //Total Fee Charge
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          filedtext('Address', '', context),
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.77,
                                        child: InputfiedRow(
                                            // validator: false,
                                            readOnly: false,
                                            value: (value) {
                                              setState(() {
                                                //  address = value.toString();
                                                // print(address);
                                              });
                                            },
                                            filedName: '',
                                            flex: 5),
                                      ),
                                    ],
                                  ),
                                  sizebox10h,
                                  Row(
                                    children: [
                                      filedtext('SKC', '*', context),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.77,
                                            child: Row(
                                              children: [
                                                sizebox,
                                                // InputfiedRowtwo(
                                                //     validator: false,
                                                //     readOnly: false,
                                                //     value: (value) {
                                                //       setState(() {
                                                //         //  province = value;
                                                //       });
                                                //     },
                                                //     filedName: '',
                                                //     flex: 2),
                                                // sizebox,
                                                // InputfiedRowtwo(
                                                //     validator: false,
                                                //     readOnly: false,
                                                //     value: (value) {
                                                //       setState(() {
                                                //         //  district = value;
                                                //       });
                                                //     },
                                                //     filedName: '',
                                                //     flex: 2),
                                                // sizebox,
                                                // InputfiedRowtwo(
                                                //     validator: false,
                                                //     readOnly: false,
                                                //     value: (value) {
                                                //       setState(() {
                                                //         //  commune = value;
                                                //       });
                                                //     },
                                                //     filedName: '',
                                                //     flex: 2),
                                              ],
                                            ),
                                          ),
                                          //sizeboxw40,
                                        ],
                                      )
                                    ],
                                  ),
                                  sizebox10h,
                                  Row(
                                    children: [
                                      filedtext('Date', '*', context),
                                      SizedBox(
                                          width: w,
                                          child: Dateform(
                                            flex: 2,
                                            //fromDate: (value) {},
                                            Date: (value) {
                                              setState(() {
                                                // comparabledate = value;
                                                // print(comparabledate);
                                              });
                                            },
                                          )),
                                      //sizeboxw40,
                                      filedtext('Remark', '', context),
                                      SizedBox(
                                        width: w,
                                        child: InputfiedRow(
                                            // validator: false,
                                            readOnly: false,
                                            value: (value) {
                                              setState(() {
                                                // remak = value;
                                                // print(remak);
                                              });
                                            },
                                            filedName: '',
                                            flex: 6),
                                      )
                                    ],
                                  ),
                                  sizebox10h,
                                  Row(
                                    children: [
                                      filedtext('Survey Date', '*', context),
                                      SizedBox(
                                        width: w,
                                        child: Dateform(
                                          flex: 2,
                                          //fromDate: (value) {},
                                          Date: (value) {
                                            // comparable_survey_date = value;
                                            // print(comparable_survey_date);
                                          },
                                        ),
                                      ),
                                      //sizeboxw40,
                                      filedtext('Owner Phone', '*', context),
                                      SizedBox(
                                        width: w,
                                        child: InputfiedRowVld(
                                            validator: false,
                                            readOnly: false,
                                            value: (value) {
                                              setState(() {
                                                // comparable_phone = value;
                                                // print(comparable_phone);
                                              });
                                            },
                                            filedName: '',
                                            flex: 6),
                                      )
                                    ],
                                  ),
                                  sizebox10h,
                                  Row(
                                    children: [
                                      filedtext('Latittute', '*', context),
                                      SizedBox(
                                        // height: 45,
                                        width: w,
                                        child: TextFormField(
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return 'require *';
                                            }
                                            return null;
                                          },
                                          // controller: _lat,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.015,
                                              fontWeight: FontWeight.bold),
                                          onChanged: (value) {
                                            setState(() {
                                              // bankcontact = value;
                                              // lat = _lat!.text;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8),
                                            prefixIcon: Icon(
                                              Icons.numbers_outlined,
                                              color: kImageColor,
                                            ),
                                            hintText: 'Lat',
                                            fillColor: kwhite,
                                            //labelText: widget.filedName,
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 249, 0, 0),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 249, 0, 0),
                                              ),
                                              //  borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      //sizeboxw40,
                                      filedtext('Longtittute', '*', context),
                                      SizedBox(
                                        // height: 45,
                                        width: w,
                                        child: TextFormField(
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return 'require *';
                                            }
                                            return null;
                                          },
                                          // controller: _log,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.015,
                                              fontWeight: FontWeight.bold),
                                          onChanged: (value) {
                                            setState(() {
                                              // bankcontact = value;
                                              // log = _log!.text;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8),
                                            prefixIcon: Icon(
                                              Icons.numbers_outlined,
                                              color: kImageColor,
                                            ),
                                            hintText: 'Lag',
                                            fillColor: kwhite,
                                            //labelText: widget.filedName,
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 249, 0, 0),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 249, 0, 0),
                                              ),
                                              //  borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizebox10h,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 40, bottom: 10),
                                    child: SizedBox(
                                      height: 500,
                                      width: double.infinity,
                                      child: Map_verbal_address_Sale(
                                        get_province: (value) {
                                          setState(() {
                                            // songkat = value.toString();
                                            // print(songkat);
                                          });
                                        },
                                        get_district: (value) {
                                          setState(() {
                                            // provice_map = value.toString();
                                          });
                                        },
                                        get_commune: (value) {
                                          setState(() {
                                            //  khan = value.toString();
                                          });
                                        },
                                        get_log: (value) {
                                          setState(() {
                                            // log = value.toString();
                                            // _log = TextEditingController(
                                            //     text: '${log}');
                                            // log = _log!.text;
                                          });
                                        },
                                        get_lat: (value) {
                                          setState(() {
                                            // lat = value.toString();
                                            // _lat = TextEditingController(
                                            //     text: '${lat}');
                                            // lat = _lat!.text;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
            ),
    );
  }

  List zoningList = [];
  Future<void> genderModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Gender_model'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          // genderList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }
}
