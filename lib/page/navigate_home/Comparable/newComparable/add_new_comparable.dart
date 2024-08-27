// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:web_admin/components/Dateformtest.dart';
import 'package:web_admin/components/L_w_totaltworow.dart';
import 'package:web_admin/components/banktwo.dart';
import 'package:web_admin/components/total_dropdowntwo.dart';
import 'package:web_admin/models/savecomparablemodel.dart';
import '../../../../Profile/contants.dart';
import '../../../../components/L_w_totaltwo.dart';
import '../../../../components/property_typetwo.dart';
import '../../../../components/roadtwo.dart';
import '../../../../components/total_dropdowntwocolumn.dart';
import '../../../../components/total_dropdowntwocondition.dart';
import '../../../../models/autoVerbal.dart';
import '../../../../screen/Property/Map/map_in_addsave.dart';
import '../../Customer/component/Web/simple/dropdown.dart';
import '../../Customer/component/Web/simple/dropdownRowtwo.dart';
import '../../Customer/component/Web/simple/inputdateRowNow .dart';
import '../../Customer/component/Web/simple/inputfiled.dart';
import '../../Customer/component/Web/simple/inputfiledRow.dart';
import '../../Customer/component/Web/simple/inputfiledRowVld.dart';
import '../../Customer/component/title/title.dart';
import 'update_new_comparable.dart';

// ignore: camel_case_types
class AddNewComarable extends StatefulWidget {
  const AddNewComarable({
    super.key,
    required this.device,
    required this.email,
    required this.idUsercontroller,
    required this.myIdcontroller,
    required this.username,
  });
  final String device;
  final String email;
  final String idUsercontroller;
  final String myIdcontroller;
  final String username;
  @override
  State<AddNewComarable> createState() => _AddNewComarableState();
}

var chars = "verbal0123456789compare";

String RandomString(int strlen) {
  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < strlen; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result;
}

class _AddNewComarableState extends State<AddNewComarable> {
  bool waitPosts = false;
  List _list = [];
  late AutoVerbalRequestModel requestModelAuto;
  TextEditingController? _log;
  TextEditingController? _lat;
  String? comparabledate;
  String? com_verbal_id;
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
  String? comparabl_user;
  String addidString = "V";
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
    com_verbal_id = 'V' + RandomString(9);
    savenewcomparableModel = new SavenewcomparableModel(
        bankinfo: '',
        condition: '',
        latittute: '',
        longtittute: '',
        ownerphone: '',
        propertytype: '',
        skc: '',
        surveydate: '');
    setState(() {
      getnewcomparable();
      getNow();
      // log = double.parse(['latlong_log'].toString());
      // lat = double.parse(['latlong_la'].toString());
    });
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

  Future getnewcomparable() async {
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
      setState(() {
        _list = jsonDecode(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  final List<String> items =
      List<String>.generate(10, (index) => 'Item $index');
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width * 0.35 * 1.35;
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          // title: Text("New Comparable $comparable_survey_date"),
          title: Text("New Comparable ${widget.idUsercontroller}"),
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
                              padding:
                                  const EdgeInsets.only(right: 30, left: 30),
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
                                                autoHide: Duration(seconds: 3),
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
                                              color: Color.fromARGB(
                                                  255, 32, 167, 8)),
                                          child: Text(
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
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        BankDropdowntwo(
                                          bank: (value) {
                                            savenewcomparableModel.bankinfo =
                                                value;
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
                                          flex: 6,
                                          // validator: (val) {
                                          //   // print("\nobject $val\n");
                                          // }
                                        ),
                                        sizebox,
                                        if (listbranch.length > 1)
                                          DropDown(
                                              //validator: true,
                                              flex: 6,
                                              value: (value) {
                                                setState(() {
                                                  com_bank_brand =
                                                      value.toString();
                                                  print(com_bank_brand);
                                                });
                                              },
                                              list: listbranch,
                                              valuedropdown: 'bank_branch_id',
                                              valuetxt: 'bank_branch_name',
                                              filedName: 'Bank Branch'),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  titletexts('Bank Officer', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: InputfiedRow(
                                        //validator: true,
                                        readOnly: false,
                                        value: (value) {
                                          setState(() {
                                            com_bank_officer = value;
                                          });
                                        },
                                        filedName: 'Bank Officer',
                                        flex: 4),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    child: InputfiedRow(
                                        //validator: true,
                                        readOnly: false,
                                        value: (value) {
                                          setState(() {
                                            com_bank_contact = value;
                                          });
                                        },
                                        filedName: 'Bank Contact',
                                        flex: 4),
                                  ),
                                  sizebox10h,
                                  titletexts('Zoning', context),
                                  sizebox10h,
                                  SizedBox(
                                    height: 45,
                                    child: Row(
                                      children: [
                                        DropDown(
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
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  titletexts('Property Type *', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: Row(
                                      children: [
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
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  titletexts('Road', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        RoadDropdowntwo(
                                          Name_road: (value) {},
                                          filedName: 'All',
                                          id_road: (value) {
                                            comparable_road = value;
                                            //print(comparable_road);
                                          },
                                          flex: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  titletexts('Land', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: Land_buildingtwo(
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
                                  ),
                                  // Land_buildingtwo(

                                  //    filedName: 'W', flex: 3,
                                  //    ),

                                  sizebox10h,
                                  titletexts('Building', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: Land_buildingtwo(
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
                                  ),
                                  sizebox10h,
                                  titletexts('Price Per Sqm', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: Total_dropdowncolumn(
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
                                  sizebox10h,
                                  titletexts('Offered Price', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: Total_dropdowncolumn(
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
                                  sizebox10h,
                                  titletexts('Offered Price', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: Total_dropdowncolumn(
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
                                  ),
                                  sizebox10h,

                                  titletexts('Sold Out Price', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: Total_dropdowncolumn(
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
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.015,
                                          fontWeight: FontWeight.bold),
                                      onChanged: (value) {
                                        setState(() {
                                          Amount = value.toString();
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
                                  SizedBox(
                                    child: DropDownRowTwo(
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
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    child: InputfiedRow(
                                        readOnly: false,
                                        value: (value) {
                                          setState(() {
                                            year = value.toString();
                                            year;
                                          });
                                        },
                                        filedName: 'Year',
                                        flex: 4),
                                  ),
                                  sizebox10h,
                                  titletexts('Address', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: InputfiedRow(
                                        readOnly: false,
                                        value: (value) {
                                          setState(() {
                                            address = value.toString();
                                          });
                                        },
                                        filedName: '',
                                        flex: 4),
                                  ),
                                  sizebox10h,
                                  titletexts('SKC *', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: InputfiedRowVld(
                                        validator: true,
                                        readOnly: false,
                                        value: (value) {
                                          setState(() {
                                            province = value;
                                          });
                                        },
                                        filedName: '',
                                        flex: 4),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    child: InputfiedRowVld(
                                        validator: true,
                                        readOnly: false,
                                        value: (value) {
                                          setState(() {
                                            district = value;
                                          });
                                        },
                                        filedName: '',
                                        flex: 4),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    child: InputfiedRowVld(
                                        validator: true,
                                        readOnly: false,
                                        value: (value) {
                                          setState(() {
                                            commune = value;
                                          });
                                        },
                                        filedName: '',
                                        flex: 4),
                                  ),
                                  sizebox10h,
                                  titletexts('Date*', context),
                                  sizebox10h,
                                  //Text(comparabledate.toString()),
                                  SizedBox(
                                      height: 45,
                                      child: Column(
                                        children: [
                                          InputDateNow(
                                            filedName: '',
                                            flex: 6,
                                            value: (value) {
                                              setState(() {
                                                comparabledate = value;
                                                //print('==>New ${comparabledate}');
                                              });
                                            },
                                          ),
                                        ],
                                      )),
                                  sizebox10h,
                                  titletexts('Remark', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: InputfiedRow(
                                        readOnly: false,
                                        value: (value) {
                                          setState(() {
                                            remak = value;
                                          });
                                        },
                                        filedName: '',
                                        flex: 4),
                                  ),
                                  sizebox10h,
                                  titletexts('Survey Date*', context),
                                  sizebox10h,
                                  SizedBox(
                                      height: 45,
                                      child: Column(
                                        children: [
                                          InputDateNow(
                                            filedName: '',
                                            flex: 6,
                                            value: (value) {
                                              comparable_survey_date = value;
                                            },
                                          ),
                                        ],
                                      )),
                                  sizebox10h,
                                  titletexts('Owner Phone*', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: InputfiedRowVld(
                                        validator: true,
                                        readOnly: false,
                                        value: (value) {
                                          setState(() {
                                            comparable_phone = value;
                                          });
                                        },
                                        filedName: '',
                                        flex: 4),
                                  ),
                                  sizebox10h,
                                  titletexts('Latittute*', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: TextFormField(
                                      validator: (input) {
                                        if (input == null || input.isEmpty) {
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
                                          errorBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.red,
                                          ))),
                                    ),
                                  ),
                                  sizebox10h,
                                  titletexts('Longtittute*', context),
                                  sizebox10h,
                                  SizedBox(
                                    child: TextFormField(
                                      validator: (input) {
                                        if (input == null || input.isEmpty) {
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
                                          errorBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.red,
                                          ))),
                                    ),
                                  ),
                                  sizebox10h,
                                  if (lat == null && log == null)
                                    InkWell(
                                      onTap: () async {
                                        await SlideUp(context);
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          height: 400,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          margin: const EdgeInsets.only(
                                              top: 15, right: 13, left: 15),
                                          child: FadeInImage.assetNetwork(
                                            placeholderCacheHeight: 120,
                                            placeholderCacheWidth: 120,
                                            fit: BoxFit.cover,
                                            placeholderFit: BoxFit.contain,
                                            placeholder: 'assets/earth.gif',
                                            image:
                                                'https://maps.googleapis.com/maps/api/staticmap?center=11.552979, 104.941609&zoom=15&size=1080x920&maptype=hybrid&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                          ),
                                        ),
                                      ),
                                    )
                                  else if (lat != null && log != null)
                                    InkWell(
                                      onTap: () async {
                                        await SlideUp(context);
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          height: 400,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          margin: const EdgeInsets.only(
                                              top: 15, right: 13, left: 15),
                                          child: FadeInImage.assetNetwork(
                                            placeholderCacheHeight: 120,
                                            placeholderCacheWidth: 120,
                                            fit: BoxFit.cover,
                                            placeholderFit: BoxFit.contain,
                                            placeholder: 'assets/earth.gif',
                                            image:
                                                // 'https://maps.googleapis.com/maps/api/staticmap?center=11.552979, 104.941609&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C11.552979, 104.941609&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                                'https://maps.googleapis.com/maps/api/staticmap?center=${(double.parse(lat.toString()) < double.parse(log.toString())) ? "$lat,$log" : "$log,$lat"}&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(double.parse(lat.toString()) < double.parse(log.toString())) ? "$lat,$log" : "$log,$lat"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    const SizedBox(),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: SizedBox(
                                  //     height: 500,
                                  //     width: double.infinity,
                                  //     child: Map_verbal_address_Sale(
                                  //       get_province: (value) {
                                  //         setState(() {
                                  //           songkat = value.toString();
                                  //           print(songkat);
                                  //         });
                                  //       },
                                  //       get_district: (value) {
                                  //         setState(() {
                                  //           provice_map = value.toString();
                                  //         });
                                  //       },
                                  //       get_commune: (value) {
                                  //         setState(() {
                                  //           khan = value.toString();
                                  //         });
                                  //       },
                                  //       get_log: (value) {
                                  //         setState(() {
                                  //           log = value.toString();
                                  //           _log = TextEditingController(
                                  //               text: '${log}');
                                  //           log = _log!.text;
                                  //         });
                                  //       },
                                  //       get_lat: (value) {
                                  //         setState(() {
                                  //           lat = value.toString();
                                  //           _lat = TextEditingController(
                                  //               text: '${lat}');
                                  //           lat = _lat!.text;
                                  //         });
                                  //       },
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ))
                        : Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  sizebox10h,
                                  // Text("${widget.idUsercontroller.toString()}"),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              Comparable_new();
                                              print('object');
                                            });
                                            // validateAndSave();
                                            if (
                                                //   com_property_type != null &&
                                                //     compare_bank_id != null &&
                                                lat != null && log != null) {
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
                                                    // await Comparable_new();
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
                                                desc:
                                                    "Please check lattitude and longitude",
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
                                  //sizebox10h,

                                  SizedBox(
                                    width: double.infinity,
                                    height: 35,
                                    child: Row(
                                      children: [
                                        filedtext('Bank Info', '*', context),
                                        BankDropdowntwo(
                                          bank: (value) {
                                            savenewcomparableModel.bankinfo =
                                                value;
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
                                              // validator: false,
                                              flex: 2,
                                              value: (value) {
                                                setState(() {
                                                  com_bank_brand =
                                                      value.toString();
                                                });
                                              },
                                              list: listbranch,
                                              valuedropdown: 'bank_branch_id',
                                              valuetxt: 'bank_branch_name',
                                              filedName: 'Bank Branch'),
                                        sizeboxw40,
                                        SizedBox(
                                          width: w,
                                        )
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Bank Officer', '', context),
                                              Inputfied(
                                                filedName: '',
                                                flex: 2,
                                                readOnly: false,
                                                validator: false,
                                                value: (value) {
                                                  setState(() {
                                                    com_bank_officer = value;
                                                  });
                                                },
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName: 'Bank Contact',
                                                flex: 2,
                                                readOnly: false,
                                                validator: false,
                                                value: (value) {
                                                  setState(() {
                                                    com_bank_contact = value;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35,
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext('Zoning', '', context),
                                              DropDown(
                                                  validator: true,
                                                  flex: 3,
                                                  value: (value) {
                                                    setState(() {
                                                      zoning_id = value;
                                                    });
                                                  },
                                                  list: zoningList,
                                                  valuedropdown: 'zoning_id',
                                                  valuetxt: '',
                                                  filedName: 'All'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 35,
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext('Property Type*', '',
                                                  context),
                                              property_hoemtypetwo(
                                                flex: 3,
                                                hometype: (value) {
                                                  setState(() {
                                                    com_property_type = value;
                                                  });
                                                },
                                                hometype_lable: '',
                                                filedName: '',
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35,
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext('Road', '', context),
                                              RoadDropdowntwo(
                                                Name_road: (value) {},
                                                filedName: 'All',
                                                id_road: (value) {
                                                  comparable_road = value;
                                                  print(comparable_road);
                                                },
                                                flex: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        filedtext('Land', '', context),
                                        SizedBox(
                                          height: 35,
                                          width: w - 100,
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
                                            ltext: 'length',
                                            wtext: 'width',
                                          ),
                                        ),
                                        filedtext('Building', '', context),
                                        SizedBox(
                                          height: 35,
                                          width: w - 100,
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
                                            ltext: 'length',
                                            wtext: 'width',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 35,
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Price Per Sqm', '', context),
                                              SizedBox(
                                                width: w - 100,
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
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Offered Price', '', context),
                                              SizedBox(
                                                height: 35,
                                                width: w - 100,
                                                child: Total_dropdowntwo(
                                                  flex: 3,
                                                  input: (value) {
                                                    setState(() {
                                                      comparable_add_price =
                                                          value;
                                                    });
                                                  },
                                                  total_type: (value) {
                                                    setState(() {
                                                      comparable_addprice_total =
                                                          value;
                                                    });
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        filedtext('Offered Price', '', context),
                                        SizedBox(
                                          height: 35,
                                          width: w - 100,
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
                                        filedtext(
                                            'Sold Out Price', '', context),
                                        SizedBox(
                                          height: 35,
                                          width: w - 100,
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
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            filedtext(
                                                'Asking Price', '', context),
                                            filedtext(
                                                '(TTAmount)', '', context),
                                          ],
                                        ),
                                        SizedBox(
                                          width: w - 100,
                                          height: 35,
                                          child: InputfiedRow(
                                              readOnly: false,
                                              value: (value) {
                                                setState(() {
                                                  Amount = value.toString();
                                                });
                                              },
                                              filedName: '',
                                              flex: 2),
                                        ),
                                        //sizeboxw40,
                                        filedtext('Condition', '*', context),
                                        SizedBox(
                                          height: 35,
                                          width: w - 100,
                                          child: Total_dropdowntwocondition(
                                            flex: 2,
                                            total_type: (value) {
                                              setState(() {
                                                condition = value.toString();
                                              });
                                            },
                                            input: (value) {
                                              setState(() {
                                                year = value.toString();
                                                print(year);
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w * 2,
                                          child: Row(
                                            children: [
                                              filedtext('Address', '', context),
                                              Inputfied(
                                                filedName: '',
                                                flex: 8,
                                                readOnly: false,
                                                validator: false,
                                                value: (value) {
                                                  setState(() {
                                                    address = value.toString();
                                                    //print(address);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w * 2,
                                          child: Row(
                                            children: [
                                              filedtext('SKC', '', context),
                                              Inputfied(
                                                filedName: 'province',
                                                flex: 2,
                                                readOnly: false,
                                                validator: false,
                                                value: (value) {
                                                  setState(() {
                                                    province = value;
                                                  });
                                                },
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName: 'district',
                                                flex: 2,
                                                readOnly: false,
                                                validator: false,
                                                value: (value) {
                                                  setState(() {
                                                    district = value;
                                                  });
                                                },
                                              ),
                                              sizebox,
                                              Inputfied(
                                                filedName: 'commune',
                                                flex: 2,
                                                readOnly: false,
                                                validator: false,
                                                value: (value) {
                                                  setState(() {
                                                    commune = value;
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        filedtext('Date', '', context),
                                        SizedBox(
                                            height: 35,
                                            width: w - 100,
                                            child: Row(
                                              children: [
                                                DateDrop(
                                                  filedname: '$comparabledate',
                                                  value: (value) {
                                                    setState(() {
                                                      comparabledate = value;
                                                      print(comparabledate);
                                                    });
                                                  },
                                                ),
                                              ],
                                            )),
                                        filedtext('Remark', '', context),
                                        SizedBox(
                                          height: 35,
                                          width: w - 100,
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
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Survey Date', '', context),
                                              SizedBox(
                                                  height: 35,
                                                  width: w - 100,
                                                  child: Row(
                                                    children: [
                                                      DateDrop(
                                                        filedname:
                                                            '$comparable_survey_date',
                                                        value: (value) {
                                                          setState(() {
                                                            comparable_survey_date =
                                                                value;
                                                            print(
                                                                comparable_survey_date);
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w,
                                          child: Row(
                                            children: [
                                              filedtext(
                                                  'Owner Phone', '', context),
                                              SizedBox(
                                                height: 35,
                                                width: w - 100,
                                                child: InputfiedRowVld(
                                                    validator: false,
                                                    readOnly: false,
                                                    value: (value) {
                                                      setState(() {
                                                        comparable_phone =
                                                            value;
                                                        print(comparable_phone);
                                                      });
                                                    },
                                                    filedName: '',
                                                    flex: 6),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizebox10h,
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        filedtext('Latittute', '*', context),
                                        SizedBox(
                                          height: 35,
                                          width: w - 100,
                                          child: TextFormField(
                                            // validator: (input) {
                                            //   if (input == null ||
                                            //       input.isEmpty) {
                                            //     return 'require *';
                                            //   }
                                            //   return null;
                                            // },
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
                                                lat = _lat?.text;
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
                                          height: 35,
                                          width: w - 100,
                                          child: TextFormField(
                                            // validator: (input) {
                                            //   if (input == null ||
                                            //       input.isEmpty) {
                                            //     return 'require *';
                                            //   }
                                            //   return null;
                                            // },
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
                                                log = _log?.text;
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
                                  ),
                                  sizebox10h,
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       right: 40, bottom: 10),
                                  //   child: SizedBox(
                                  //     height: 500,
                                  //     width: double.infinity,
                                  //     child: Map_verbal_address_Sale(
                                  //       get_province: (value) {
                                  //         setState(() {
                                  //           songkat = value.toString();
                                  //           print(songkat);
                                  //         });
                                  //       },
                                  //       get_district: (value) {
                                  //         setState(() {
                                  //           provice_map = value.toString();
                                  //         });
                                  //       },
                                  //       get_commune: (value) {
                                  //         setState(() {
                                  //           khan = value.toString();
                                  //         });
                                  //       },
                                  //       get_log: (value) {
                                  //         setState(() {
                                  //           log = value.toString();
                                  //           _log = TextEditingController(
                                  //               text: '${log}');
                                  //           log = _log!.text;
                                  //         });
                                  //       },
                                  //       get_lat: (value) {
                                  //         setState(() {
                                  //           lat = value.toString();
                                  //           _lat = TextEditingController(
                                  //               text: '${lat}');
                                  //           lat = _lat!.text;
                                  //         });
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                  if (lat == null && log == null)
                                    InkWell(
                                      onTap: () async {
                                        await SlideUp(context);
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          height: 400,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          margin: const EdgeInsets.only(
                                              top: 15, right: 13, left: 15),
                                          child: FadeInImage.assetNetwork(
                                            placeholderCacheHeight: 120,
                                            placeholderCacheWidth: 120,
                                            fit: BoxFit.cover,
                                            placeholderFit: BoxFit.contain,
                                            placeholder: 'assets/earth.gif',
                                            image:
                                                'https://maps.googleapis.com/maps/api/staticmap?center=11.552979, 104.941609&zoom=15&size=1080x920&maptype=hybrid&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                          ),
                                        ),
                                      ),
                                    )
                                  else if (lat != null && log != null)
                                    InkWell(
                                      onTap: () async {
                                        await SlideUp(context);
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          height: 400,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          margin: const EdgeInsets.only(
                                              top: 15, right: 13, left: 15),
                                          child: FadeInImage.assetNetwork(
                                            placeholderCacheHeight: 120,
                                            placeholderCacheWidth: 120,
                                            fit: BoxFit.cover,
                                            placeholderFit: BoxFit.contain,
                                            placeholder: 'assets/earth.gif',
                                            image:
                                                // 'https://maps.googleapis.com/maps/api/staticmap?center=11.552979, 104.941609&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C11.552979, 104.941609&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                                'https://maps.googleapis.com/maps/api/staticmap?center=${(double.parse(lat.toString()) < double.parse(log.toString())) ? "$lat,$log" : "$log,$lat"}&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(double.parse(lat.toString()) < double.parse(log.toString())) ? "$lat,$log" : "$log,$lat"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    const SizedBox(),
                                ],
                              ),
                            ),
                          )),
              ));
  }

//MAP
  Future<void> SlideUp(BuildContext context) async {
//=============================================================
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Map_verbal_addsave(
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
              log = double.parse(value.toString()).toString();
              _log = TextEditingController(text: '${log}');
              log = double.parse(_log!.text).toString();
            });
          },
          get_lat: (value) {
            setState(() {
              lat = double.parse(value.toString()).toString();
              _lat = TextEditingController(text: '${lat}');
              lat = double.parse(_lat!.text).toString();
            });
          },
        ),
      ),
    );

    setState(() {
      requestModelAuto.image = verbal_id.toString();
    });
    if (!mounted) return;
  }

  Future<void> Comparable_new() async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "compare_bank_id": (compare_bank_id == null)
          ? null
          : int.parse(compare_bank_id.toString()),
      "comparabl_user": widget.idUsercontroller.toString(),
      "compare_bank_branch_id": (com_bank_brand == null)
          ? null
          : int.parse(com_bank_brand.toString()),
      "com_bankofficer":
          (com_bank_officer == null) ? 'null' : com_bank_officer.toString(),
      "com_bankofficer_contact":
          (com_bank_contact == null) ? 'null' : com_bank_contact.toString(),
      "zoning_id": zoning_id.toString(),
      "comparable_property_id": (com_property_type == null)
          ? null
          : int.parse(com_property_type.toString()),
      //int.parse(com_property_type.toString()),
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
      "latlong_log": ((double.parse(lat.toString()) == null)
          ? 'null'
          : double.parse(lat.toString())),
      //double.parse(lat.toString()),
      "latlong_la": ((double.parse(log.toString()) == null)
          ? 'null'
          : double.parse(log.toString())),
      "com_verbalid": "V",
      //double.parse(log.toString()),
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
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/new_comparabletest',
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
