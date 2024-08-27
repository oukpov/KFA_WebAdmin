// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:web_admin/components/L_w_totaltworow.dart';
import 'package:web_admin/models/savecomparablemodel.dart';
import '../../../../Profile/contants.dart';
import '../../../../components/Dateform.dart';
import '../../../../components/L_w_totaltwo.dart';
import '../../../../components/bankcolumn.dart';
import '../../../../components/banktwo.dart';
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

class CloneNewComparable extends StatefulWidget {
  const CloneNewComparable(
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
  State<CloneNewComparable> createState() => _CloneNewComparableState();
}

TextEditingController? _log;
TextEditingController? _lat;
String? comparabledate;
String? genderList;
String? provnce_id;
String? songkat;
String? compare_bank_id;
String? com_bank_brand;
String? zoning_id;
String? provice_map;
String? khan;
String? log;
String? lat;
String? value_d;
String? com_property_type;
String? total_b;
String? lproperty;
String? w;
String? wb;
String? ltotal;
String? lb;
String? lwproperty;
String? officer_price_total;
String? comparable_add_price;
String? comparable_addprice_total;
String? askingprice;
String? comparable_phone;
String? remak;
String? officer_price;
String? sqm_total;
String? Amount;
String? condtion;
String? condition;
String? year;
String? comparable_bought_price;
String? comparable_bought_price_total;
String? comparable_sold_price;
String? comparable_sold_total_price;
String? address;
String? district_id;
String? cummune_id;
String? com_bank_officer = '';
String? com_bank_contact;
String? comparable_road;
String? province;
String provinceName = '';
String? district;
String? commune;
String? comparable_survey_date;
TextEditingController _controllerL = TextEditingController();
TextEditingController _controllerW = TextEditingController();
int _total = 0;
List _condition = [
  {
    'id': 1,
    'Condition': 'Condition 1',
  },
  {
    'id': 2,
    'Condition': 'Condition 2',
  }
];

class _CloneNewComparableState extends State<CloneNewComparable> {
  var check;
  bool waitPosts = false;
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
      comparabledate = today;
      comparable_survey_date = today;
    });
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
        title: const Text("New Comparable"),
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
                                Row(
                                  children: [
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   Comparable_new();
                                        //   print('object');
                                        // });
                                        validateAndSave();
                                        if (com_property_type != null &&
                                            compare_bank_id != null &&
                                            lat != null &&
                                            log != null &&
                                            comparabledate != null &&
                                            condition != null &&
                                            commune != null &&
                                            province != null &&
                                            district != null &&
                                            comparable_phone != null &&
                                            total_b != null) {
                                          AwesomeDialog(
                                              context: context,
                                              animType: AnimType.leftSlide,
                                              headerAnimationLoop: false,
                                              dialogType: DialogType.success,
                                              showCloseIcon: false,
                                              title: 'Save Successfully',
                                              autoHide:
                                                  const Duration(seconds: 3),
                                              onDismissCallback: (type) async {
                                                await Comparable_new();
                                                setState(() {
                                                  print("Save");
                                                });
                                                // Navigator.pop(context);
                                                // onPressed: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           const ResponsiveHomeP()),
                                                // );
                                              }).show();
                                        } else {
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.error,
                                            animType: AnimType.rightSlide,
                                            headerAnimationLoop: false,
                                            title: 'Error',
                                            desc: "Please check ",
                                            btnOkOnPress: () {
                                              print("Error");
                                            },
                                            btnOkIcon: Icons.cancel,
                                            btnOkColor: Colors.red,
                                          ).show();
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color.fromARGB(
                                                255, 32, 167, 8)),
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                sizebox10h,
                                titletexts('Bank Info *', context),
                                sizebox10h,
                                BankDropdowncolumn(
                                  bank: (value) {
                                    setState(() {
                                      compare_bank_id = value.toString();
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
                                        com_bank_officer = value;
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
                                        com_bank_contact = value;
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
                                          zoning_id = value;
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
                                      com_property_type = value;
                                    });
                                  },
                                  hometype_lable: com_property_type,
                                  filedName: 'Property Type',
                                ),
                                sizebox10h,
                                titletexts('Road', context),
                                sizebox10h,
                                RoadDropdowntwo(
                                  Name_road: (value) {},
                                  filedName: 'All',
                                  id_road: (value) {
                                    comparable_road = value;
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
                                      lproperty = value;
                                    });
                                  },
                                  total: (value) {
                                    setState(() {
                                      ltotal = value;
                                    });
                                  },
                                  w: (value) {
                                    setState(() {
                                      lwproperty = value;
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
                                      lb = value;
                                    });
                                  },
                                  total: (value) {
                                    setState(() {
                                      total_b = value;
                                    });
                                  },
                                  w: (value) {
                                    setState(() {
                                      wb = value;
                                    });
                                  },
                                ),
                                sizebox10h,
                                titletexts('Price Per Sqm', context),
                                sizebox10h,
                                Total_dropdowncolumn(
                                  input: (value) {
                                    setState(() {
                                      askingprice = value;
                                    });
                                  },
                                  total_type: (value) {
                                    setState(() {
                                      sqm_total = value;
                                    });
                                  },
                                ),
                                sizebox10h,
                                titletexts('Offered Price', context),
                                sizebox10h,
                                Total_dropdowncolumn(
                                  input: (value) {
                                    setState(() {
                                      comparable_add_price = value;
                                    });
                                  },
                                  total_type: (value) {
                                    setState(() {
                                      comparable_addprice_total = value;
                                    });
                                  },
                                ),
                                sizebox10h,
                                titletexts('Offered Price', context),
                                sizebox10h,
                                Total_dropdowncolumn(
                                  input: (value) {
                                    setState(() {
                                      comparable_bought_price =
                                          value.toString();
                                    });
                                  },
                                  total_type: (value) {
                                    setState(() {
                                      comparable_bought_price_total = value;
                                    });
                                  },
                                ),
                                sizebox10h,

                                titletexts('Sold Out Price', context),
                                sizebox10h,
                                Total_dropdowncolumn(
                                  input: (value) {
                                    setState(() {
                                      comparable_sold_price = value.toString();
                                    });
                                  },
                                  total_type: (value) {
                                    setState(() {
                                      comparable_sold_total_price =
                                          value.toString();
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
                                        Amount = value.toString();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8),
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
                                        condition = value.toString();
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
                                        year = value.toString();
                                        year;
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
                                        address = value.toString();
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
                                        province = value;
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
                                        district = value;
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
                                        commune = value;
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
                                          comparabledate = value;
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
                                        remak = value;
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
                                        comparable_survey_date = value;
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
                                        comparable_phone = value;
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
                                  controller: _lat,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (value) {
                                    setState(() {
                                      // bankcontact = value;
                                      lat = _lat!.text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8),
                                      prefixIcon: const Icon(
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
                                  controller: _log,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (value) {
                                    setState(() {
                                      // bankcontact = value;
                                      log = _log!.text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8),
                                      prefixIcon: const Icon(
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
                                          songkat = value.toString();
                                          print(songkat);
                                        });
                                      },
                                      get_district: (value) {
                                        setState(() {
                                          provice_map = value.toString();
                                        });
                                      },
                                      get_commune: (value) {
                                        setState(() {
                                          khan = value.toString();
                                        });
                                      },
                                      get_log: (value) {
                                        setState(() {
                                          log = value.toString();
                                          _log = TextEditingController(
                                              text: '${log}');
                                          log = _log!.text;
                                        });
                                      },
                                      get_lat: (value) {
                                        setState(() {
                                          lat = value.toString();
                                          _lat = TextEditingController(
                                              text: '${lat}');
                                          lat = _lat!.text;
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
                                        InkWell(
                                          onTap: () {
                                            // setState(() {
                                            //   Comparable_new();
                                            //   print('object');
                                            // });
                                            validateAndSave();
                                            if (com_property_type != null &&
                                                compare_bank_id != null &&
                                                lat != null &&
                                                log != null &&
                                                comparabledate != null &&
                                                condition != null &&
                                                commune != null &&
                                                province != null &&
                                                district != null &&
                                                comparable_phone != null &&
                                                total_b != null) {
                                              AwesomeDialog(
                                                  context: context,
                                                  animType: AnimType.leftSlide,
                                                  headerAnimationLoop: false,
                                                  dialogType:
                                                      DialogType.success,
                                                  showCloseIcon: false,
                                                  title: 'Save Successfully',
                                                  autoHide:
                                                      Duration(seconds: 3),
                                                  onDismissCallback:
                                                      (type) async {
                                                    await Comparable_new();
                                                    setState(() {
                                                      print("Save");
                                                    });
                                                    // Navigator.pop(context);
                                                    // onPressed: () {
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //       builder: (context) =>
                                                    //           const ResponsiveHomeP()),
                                                    // );
                                                  }).show();
                                            } else {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.error,
                                                animType: AnimType.rightSlide,
                                                headerAnimationLoop: false,
                                                title: 'Error',
                                                desc: "Please check ",
                                                btnOkOnPress: () {
                                                  print("Error");
                                                },
                                                btnOkIcon: Icons.cancel,
                                                btnOkColor: Colors.red,
                                              ).show();
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color.fromARGB(
                                                    255, 32, 167, 8)),
                                            child: const Text(
                                              'Save',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,

                                  Row(
                                    children: [
                                      filedtext('Bank Info', '*', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            BankDropdowntwo(
                                              bank: (value) {
                                                savenewcomparableModel
                                                    .bankinfo = value;
                                                setState(() {
                                                  compare_bank_id =
                                                      value.toString();
                                                });
                                              },
                                              bankbranch: (value) {
                                                setState(() {
                                                  listbranch = value;
                                                  // print(
                                                  //     "\nkokoobject${listbranch}");
                                                });
                                              },
                                              filedName: 'bank',
                                              flex: 2,
                                              // validator: (val) {
                                              //   // print("\nobject $val\n");
                                              // }
                                            ),
                                            sizebox,
                                            if (listbranch.length > 1)
                                              DropDown(
                                                  validator: true,
                                                  flex: 2,
                                                  value: (value) {
                                                    setState(() {
                                                      com_bank_brand =
                                                          value.toString();
                                                    });
                                                  },
                                                  list: listbranch,
                                                  valuedropdown:
                                                      'bank_branch_id',
                                                  valuetxt: 'bank_branch_name',
                                                  filedName: 'Bank Branch'),
                                          ],
                                        ),
                                      ),
                                      sizeboxw40,
                                      SizedBox(
                                        width: w,
                                      )
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
                                                    com_bank_officer = value;
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
                                                    com_bank_contact = value;
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
                                      filedtext('Zoning', '', context),
                                      SizedBox(
                                        width: w,
                                        child: DropDown(
                                            validator: true,
                                            flex: 2,
                                            value: (value) {
                                              setState(() {
                                                zoning_id = value;
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
                                              com_property_type = value;
                                            });
                                          },
                                          hometype_lable: com_property_type,
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
                                            comparable_road = value;
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
                                              lproperty = value;
                                            });
                                          },
                                          total: (value) {
                                            setState(() {
                                              ltotal = value;
                                            });
                                          },
                                          w: (value) {
                                            setState(() {
                                              lwproperty = value;
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
                                              lb = value;
                                            });
                                          },
                                          total: (value) {
                                            setState(() {
                                              total_b = value;
                                            });
                                          },
                                          w: (value) {
                                            setState(() {
                                              wb = value;
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
                                              askingprice = value;
                                            });
                                          },
                                          total_type: (value) {
                                            setState(() {
                                              sqm_total = value;
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
                                              comparable_add_price = value;
                                            });
                                          },
                                          total_type: (value) {
                                            setState(() {
                                              comparable_addprice_total = value;
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
                                              comparable_bought_price =
                                                  value.toString();
                                            });
                                          },
                                          total_type: (value) {
                                            setState(() {
                                              comparable_bought_price_total =
                                                  value;
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
                                              comparable_sold_price =
                                                  value.toString();
                                            });
                                          },
                                          total_type: (value) {
                                            setState(() {
                                              comparable_sold_total_price =
                                                  value.toString();
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
                                                Amount = value.toString();
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
                                              condition = value.toString();
                                            });
                                          },
                                          input: (value) {
                                            setState(() {
                                              year = value.toString();
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
                                                address = value.toString();
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
                                                //         province = value;
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
                                                //         district = value;
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
                                                //         commune = value;
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
                                                comparabledate = value;
                                                print(comparabledate);
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
                                                remak = value;
                                                print(remak);
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
                                            comparable_survey_date = value;
                                            print(comparable_survey_date);
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
                                                comparable_phone = value;
                                                print(comparable_phone);
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
                                          controller: _lat,
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
                                              lat = _lat!.text;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8),
                                            prefixIcon: const Icon(
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
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 249, 0, 0),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
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
                                          controller: _log,
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
                                              log = _log!.text;
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
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 249, 0, 0),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
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
                                            songkat = value.toString();
                                            print(songkat);
                                          });
                                        },
                                        get_district: (value) {
                                          setState(() {
                                            provice_map = value.toString();
                                          });
                                        },
                                        get_commune: (value) {
                                          setState(() {
                                            khan = value.toString();
                                          });
                                        },
                                        get_log: (value) {
                                          setState(() {
                                            log = value.toString();
                                            _log = TextEditingController(
                                                text: '${log}');
                                            log = _log!.text;
                                          });
                                        },
                                        get_lat: (value) {
                                          setState(() {
                                            lat = value.toString();
                                            _lat = TextEditingController(
                                                text: '${lat}');
                                            lat = _lat!.text;
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

  String? customerimage1;
  String? customerimage2;
  String? customerimage3;
  String? customerimage4;
  String? customerimage5;
  String? customerimage6;
  String? customerimage7;

  List<Uint8List> compressedImage = [];
  Future<List<Uint8List>> compressImages(List<Uint8List> imageList) async {
    List<Uint8List> compressedImages = [];
    for (var image in imageList) {
      Uint8List compressedImage = await testCompressList(image);
      compressedImages.add(compressedImage);
    }
    return compressedImages;
  }

  Future<Uint8List> testCompressList(Uint8List image) async {
    var result = await FlutterImageCompress.compressWithList(
      image,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );
    print('Original size: ${image.length}');
    print('Compressed size: ${result.length}');
    return result;
  }

  List valutionList = [];
  Future<void> valutionTypeModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_valutiontype'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body);
          valutionList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List appraiserList = [];
  Future<void> appraiserModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/appraiser/name'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          appraiserList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List accompanyList = [];
  Future<void> accompanyModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Accompany_by/name'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          accompanyList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List inspectorList = [];
  Future<void> inspectorModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Inspector/name'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          inspectorList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List inspectorsList = [];
  Future<void> inspectorsModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Inspectors/name'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          inspectorsList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List bankList = [];
  Future<void> bankModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/banks'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        bankList = jsonBody;
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List branchList = [];
  Future<void> branchModel(value) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bankbranch?bank_branch_details_id=$value'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['bank_branches'];
          branchList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List hometypeList = [];
  Future<void> homeModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/properties_dropdown'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body);
          hometypeList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List zoningList = [];
  Future<void> genderModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Gender_model'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          genderList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List assiignedList = [];
  Future<void> assiignedModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Registered_By/name'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          assiignedList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  List provinceList = [];
  Future<void> provinceModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/province_bank'));
      if (response.statusCode == 200) {
        setState(() {
          var jsonBody = jsonDecode(response.body)['data'];
          provinceList = jsonBody;
        });
      } else {
        print('Error ');
      }
    } catch (e) {
      print('Error  $e');
    }
  }

  // Image select file
  File? imageFile;
  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print(imageFile);
      });
    }
  }

  String aRFIDGETs = '';
  List aRFList = [];

  void aRFlastID() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/AFR_ID_Get'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        aRFList = jsonData;
        var aRFIDGET = int.parse(aRFList[0]['aRFID'].toString()) + 1;
        aRFIDGETs = aRFIDGET.toString();
      });
    }
  }

  void aRFID() async {
    Map<String, dynamic> payload = {
      'aRFID': aRFIDGETs,
      'customer_status': 1,
    };

    final url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/AFR_ID');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success ARF ID POST');
    } else {
      print('Error Latlog: ${response.reasonPhrase}');
    }
  }

  XFile? file;
  Uint8List? imagebytes;
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  Uint8List? selectedFile;
  Uint8List? _byesData;

  String imageUrl = '';
  Uint8List? get_bytes;
  List<Uint8List> selectedImages = [];

  late File croppedFile;
  void openImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files != null) {
        for (var file in files) {
          final reader = html.FileReader();
          reader.onLoadEnd.listen((event) {
            setState(() {
              selectedImages
                  .add(Uint8List.fromList(reader.result as List<int>));
            });
          });
          reader.readAsArrayBuffer(file);
        }
      }
    });
  }

  final completer = Completer<Uint8List>();
  html.File? cropimagefile;
  String? uploadedBlobUrl;
  String? _croppedBlobUrl;
  Future<void> cropImage() async {
    WebUiSettings settings;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    settings = WebUiSettings(
      context: context,
      presentStyle: CropperPresentStyle.dialog,
      boundary: CroppieBoundary(
        width: (screenWidth * 0.4).round(),
        height: (screenHeight * 0.4).round(),
      ),
      viewPort: const CroppieViewPort(
        width: 300,
        height: 300,
      ),
      enableExif: true,
      enableZoom: true,
      showZoomer: true,
    );
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageUrl,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [settings],
    );
    if (croppedFile != null) {
      final bytes = await croppedFile.readAsBytes();
      final blob = html.Blob([bytes]);
      cropimagefile = html.File([blob], 'cropped-image.png');
      get_bytes = Uint8List.fromList(bytes);
      // await
      setState(() {
        _croppedBlobUrl = croppedFile.path;
        saveBlobToFile(_croppedBlobUrl!, croppedFile.path);
      });

      if (cropimagefile != null) {}
    }
  }

  Future<void> saveBlobToFile(String blobUrl, String filename) async {
    final response = await http.get(Uri.parse(blobUrl));
    final bytes = response.bodyBytes;

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/$filename";
  }

  Future<void> Comparable_new() async {
    // setState(() {
    //   address = '$khan / $songkat';
    // });
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "compare_bank_id": int.parse(compare_bank_id.toString()),
      "compare_bank_branch_id": (com_bank_brand == null)
          ? null
          : int.parse(com_bank_brand.toString()),
      "com_bankofficer":
          (com_bank_officer == null) ? 'null' : com_bank_officer.toString(),
      "com_bankofficer_contact":
          (com_bank_contact == null) ? 'null' : com_bank_contact.toString(),
      "zoning_id": zoning_id.toString(),
      "comparable_property_id": int.parse(com_property_type.toString()),
      "comparable_road": (comparable_road == null)
          ? null
          : int.parse(comparable_road.toString()),
      "comparable_land_length": lproperty.toString(),
      "comparable_land_width": lwproperty.toString(),
      "comparable_land_total": ltotal.toString(),
      "comparable_sold_length": (lb == null) ? 'null' : lb.toString(),
      "comparable_sold_width": wb.toString(),
      "comparable_sold_total": total_b.toString(),
      "comparable_adding_price":
          (askingprice == null) ? 'null' : askingprice.toString(),
      "comparable_adding_total":
          (sqm_total == null) ? 'null' : sqm_total.toString(),
      "comparableaddprice": (comparable_add_price == null)
          ? 'null'
          : comparable_add_price.toString(),
      "comparableaddpricetotal": (comparable_addprice_total == null)
          ? 'null'
          : comparable_addprice_total.toString(),
      "comparableboughtprice": (comparable_bought_price == null)
          ? 'null'
          : comparable_bought_price.toString(),
      "comparableboughtpricetotal": (comparable_bought_price_total == null)
          ? null
          : comparable_bought_price_total.toString(),
      "comparable_sold_price": (comparable_sold_price == null)
          ? null
          : comparable_sold_price.toString(),
      "comparable_sold_total_price": (comparable_sold_total_price == null)
          ? null
          : comparable_sold_total_price.toString(),
      "comparableAmount": (Amount == null) ? 'null' : Amount.toString(),
      "comparable_condition_id":
          (condition == null) ? null : condition.toString(),
      "comparable_year": (year == null) ? 'null' : year.toString(),
      "comparable_address": (address == null) ? 'null' : address.toString(),
      "province": province.toString(),
      "district": district.toString(),
      "commune": commune.toString(),
      "comparableDate": comparabledate.toString(),
      "comparable_remark": (remak == null) ? 'null' : remak.toString(),
      "comparable_survey_date": (comparable_survey_date == null)
          ? 'null'
          : comparable_survey_date.toString(),
      "comparable_phone":
          (comparable_phone == null) ? null : comparable_phone.toString(),
      "latlong_log": double.parse(lat.toString()),
      "latlong_la": double.parse(log.toString()),
      // "compare_bank_id": "7",
      // "compare_bank_branch_id": "0",
      // "com_bankofficer": "btb",
      // "com_bankofficer_contact": "simeng",
      // "zoning_id": "7",
      // "comparable_property_id": "1",
      // "comparable_road": "7",
      // "comparable_land_length": "7777",
      // "comparable_land_width": "7777",
      // "comparable_land_total": "7777",
      // "comparable_sold_length": "7777",
      // "comparable_sold_width": "7777",
      // "comparable_sold_total": "7777",
      // "comparable_adding_price": "7777",
      // "comparable_adding_total": "7777",
      // "comparableaddprice": "7777",
      // "comparableaddpricetotal": "7777",
      // "comparableboughtprice": "7777",
      // "comparableboughtpricetotal": "7777",
      // "comparable_sold_price": "7777",
      //"comparable_sold_total_price": "7777",
      // "comparableAmount": "7777",
      // "comparable_condition_id": "7777",
      // "comparable_year": "2024",
      // "comparable_address": "pp",
      // "province": "pp",
      // "district": "pp",
      // "commune": "pp",
      // "comparableDate": "2024",
      // "comparable_remark": "simeng",
      // "comparable_survey_date": "2024-01-10",
      // "comparable_phone": "0966705117",
      // "latlong_log": "13.3551",
      // "latlong_la": "103.8226"
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/new_comparable',
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

  // void Comparable_new2() async {
  //   String? address;
  //   setState(() {
  //     address = '$khan / $songkat';
  //   });
  //   try {
  //     Map<String, dynamic> payload = {
  //       'comparable_property_id': int.parse(com_property_type.toString()),
  //       'comparable_land_length': lproperty.toString(),
  //       'comparable_land_width': wproperty.toString(),
  //       'comparable_land_total': total.toString(),
  //       'comparable_sold_length':
  //           (lproperty == null) ? 'null' : lproperty.toString(),
  //       'comparable_sold_width': wproperty.toString(),
  //       'comparable_sold_total': total_b.toString(),
  //       'comparable_adding_price':
  //           (askingprice == null) ? 'null' : askingprice.toString(),
  //       'comparable_adding_total':
  //           (sqm_total == null) ? 'null' : sqm_total.toString(),
  //       'comparable_sold_price':
  //           (officer_price == null) ? 'null' : officer_price.toString(),
  //       'comparable_sold_total_price': (officer_price_total == null)
  //           ? 'null'
  //           : officer_price_total.toString(),
  //       'comparable_condition_id':
  //           (condition == null) ? 'null' : condition.toString(),
  //       'comparable_year': (year == null) ? 'null' : year.toString(),
  //       'comparable_address': address.toString(),
  //       'comparable_province_id': provnce_id.toString(),
  //       'comparable_district_id': district_id.toString(),
  //       'comparable_commune_id': cummune_id.toString(),
  //       'comparable_remark': (remak == null) ? 'null' : remak.toString(),
  //       'comparable_con': 0,
  //       'comparable_distance': 0,
  //       'comparable_status_id': 0,
  //       'comparableaddprice': (comparable_add_price == null)
  //           ? 'null'
  //           : comparable_add_price.toString(),
  //       'comparableaddpricetotal': (comparable_addprice_total == null)
  //           ? 'null'
  //           : comparable_addprice_total.toString(),
  //       'comparableboughtprice': '0',
  //       'comparableAmount': (Amount == null) ? 'null' : Amount.toString(),
  //       'latlong_log': double.parse(log.toString()),
  //       'latlong_la': double.parse(lat.toString()),
  //       'comparabl_user': 0,
  //       // 'comparable_phone':
  //       //     (con_user == null) ? null : int.parse(con_user.toString()),
  //       'comparable_phone':
  //           (comparable_phone == null) ? null : comparable_phone.toString(),
  //       'comparableboughtpricetotal': '0',
  //       'compare_bank_id': int.parse(compare_bank_id.toString()),
  //       'compare_bank_branch_id': (com_bank_brand == null)
  //           ? null
  //           : int.parse(com_bank_brand.toString()),
  //       'com_bankofficer':
  //           (com_bank_officer == null) ? 'null' : com_bank_officer.toString(),
  //       'com_bankofficer_contact':
  //           (com_bank_contact == null) ? 'null' : com_bank_contact.toString(),
  //       'comparable_road':
  //           (id_road == null) ? null : int.parse(id_road.toString()),
  //     };
  //     final url = Uri.parse(
  //         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/new_comparable');
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(payload),
  //     );
  //     if (response.statusCode == 200) {
  //       print('Success Comparable');
  //     } else {
  //       print('Error 1: ${response.reasonPhrase}');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }
}
