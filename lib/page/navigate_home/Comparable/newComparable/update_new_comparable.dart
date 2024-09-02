// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:web_admin/components/L_w_totaltworow.dart';
import 'package:web_admin/components/banktwo.dart';
import 'package:web_admin/models/savecomparablemodel.dart';
import '../../../../components/L_w_totaltwo.dart';
import '../../../../components/bankcolumn.dart';
import '../../../../components/bankrow.dart';
import '../../../../components/colors.dart';
import '../../../../components/property_typetwo.dart';
import '../../../../components/roadtwo.dart';
import '../../../../components/total_dropdowntwocondition.dart';
import '../../../../models/autoVerbal.dart';
import '../../../../screen/Property/Map/map_in_addsave.dart';
import '../../Customer/component/Web/simple/dropdown.dart';
import '../../Customer/component/Web/simple/inputfiledRowdate.dart';
import '../../Customer/component/title/title.dart';

class Update_NewComarable extends StatefulWidget {
  Update_NewComarable(
      {super.key,
      required this.device,
      this.list,
      required this.email,
      required this.idUsercontroller,
      required this.myIdcontroller});
  final String device;
  final String email;
  final String idUsercontroller;
  final String myIdcontroller;
  var list;

  @override
  State<Update_NewComarable> createState() => _Update_NewComarableState();
}

var verbal_id;
late List<dynamic> list_Khan;
int id_khan = 0;

class _Update_NewComarableState extends State<Update_NewComarable> {
  var check;
  var Sqm = "Sqm";
  bool waitPosts = false;
  late SavenewcomparableModel savenewcomparableModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double? asking_price;
  late AutoVerbalRequestModel requestModelAuto;
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

  var totallys = "Totally";
  List totally = [
    {
      'numer_id': 1,
      'type': 'Totally',
    },
    {
      'numer_id': 2,
      'type': 'Sqm',
    }
  ];
  double? log;
  double? lat, lat1, log2;
  String? provice_map;
  String? songkat;
  String? khan;
  String? compare_bank_id;
  TextEditingController? _log, _lat;
  String? com_bank_officer;
  String? com_bankofficer_contact;
  String? zoning_id;
  String? compare_bank_branch_id;
  String? comparable_property_id;
  String? comparable_road;
  String? comparable_land_width;
  String? comparable_land_total;
  String? comparable_sold_length;
  String? comparable_sold_width;
  String? comparable_sold_total;
  String? comparable_adding_price;
  String? comparable_adding_total;
  String? comparableaddprice;
  String? comparableaddpricetotal;
  String? comparableboughtprice;
  String? comparableboughtpricetotal;
  String? comparablesoldprice;
  String? comparable_sold_total_price;
  String? comparableAmount;
  String? comparable_condition_id;
  String? comparable_year;
  String? comparable_address;
  String? province;
  String? district;
  String? commune;
  String? comparableDate;
  String? comparable_remark;
  String? comparable_survey_date;
  String? comparable_phone;
  double? latlong_log;
  double? latlong_la;
  String? w_get;
  String? l_get;
  String? l_total;
  String? total_get;
  @override
  void initState() {
    super.initState();
    // print("\n\n\n\n\n kokok : ${widget.list['latlong_log']}");
    // print("\n\n\n\n\n kokok : ${widget.list['latlong_la']}");
    // ignore: unnecessary_new
    if (l_get == 'new_executive') {
      comparable_land_lengthcontroller =
          TextEditingController(text: l_get.toString());
      comparable_land_widthcontroller =
          TextEditingController(text: w_get.toString());
      _total = int.parse(l_total.toString());
    } else {}
    getNow();
    setState(() {
      // _updateTotal();
      //comparebankid_controller.text = widget.list['comparable_id'].toString();
      ///////
      controllers.text = widget.list['comparable_id'].toString();
      compare_bank_id = //widget.list['compare_bank_id'].toString();
          (widget.list['compare_bank_id'] == null ||
                  widget.list['compare_bank_id'] == "")
              ? null
              : widget.list['compare_bank_id'].toString();
      compare_bank_branch_id = (widget.list['compare_bank_branch_id'] == null ||
              widget.list['compare_bank_branch_id'] == "")
          ? null
          : widget.list['compare_bank_branch_id'].toString();
      com_bankofficer_controller.text = widget.list['com_bankofficer'];

      com_bankcontact_controller.text =
          widget.list['com_bankofficer_contact'].toString();
      comparable_road = (widget.list['comparable_road'] == null ||
              widget.list['comparable_road'] == "")
          ? null
          : widget.list['comparable_road'].toString();
      comparable_land_lengthcontroller.text =
          widget.list['comparable_land_length'].toString();
      comparable_land_widthcontroller.text =
          widget.list['comparable_land_width'].toString();
      comparable_land_total = (widget.list['comparable_land_total'] == null ||
              widget.list['comparable_land_total'] == "")
          ? null
          : widget.list['comparable_land_total'].toString();
      comparable_sold_lengthcontroller.text =
          widget.list['comparable_sold_length'].toString();
      comparable_sold_widthcontroller.text =
          widget.list['comparable_sold_width'].toString();
      comparable_sold_total = (widget.list['comparable_sold_total'] == null ||
              widget.list['comparable_sold_total'] == "")
          ? null
          : widget.list['comparable_sold_total'].toString();
      comparable_property_id = widget.list['comparable_property_id'].toString();
      comparable_adding_total =
          (widget.list['comparable_adding_total'] == null ||
                  widget.list['comparable_adding_total'] == "")
              ? null
              : widget.list['comparable_adding_total'].toString();
      zoning_id = widget.list['zoning_id'].toString();
      comparable_price_per_sqm_controller.text =
          widget.list['comparable_adding_price'].toString();
      comparable_offerred_price_controller.text =
          widget.list['comparableaddprice'].toString();
      comparableaddpricetotal =
          widget.list['comparableaddpricetotal'].toString();
      comparable_offerred_price_controller2.text =
          widget.list['comparableboughtprice'].toString();
      comparableboughtpricetotal =
          widget.list['comparableboughtpricetotal'].toString();
      comparable_sold_out_price_controller.text =
          widget.list['comparable_sold_price'].toString();
      comparable_sold_total_price =
          widget.list['comparable_sold_total_price'].toString();
      comparable_asking_price_controller.text =
          widget.list['comparableAmount'].toString();
      comparable_condition_id =
          widget.list['comparable_condition_id'].toString();
      comparable_year_controller.text =
          (widget.list['comparable_year'].toString() == 'null')
              ? ""
              : widget.list['comparable_year'].toString();
      comparable_address_controller.text =
          widget.list['comparable_address'].toString();
      comparable_province_controller.text = widget.list['province'].toString();
      comparable_district_controller.text = widget.list['district'].toString();
      comparable_commune_controller.text = widget.list['commune'].toString();
      comparable_date_controller.text =
          widget.list['comparableDate'].toString();
      comparable_remark_controller.text =
          widget.list['comparable_remark'].toString();
      comparable_surveydate_controller.text =
          widget.list['comparable_survey_date'].toString();
      comparable_ownerphone_controller.text =
          widget.list['comparable_phone'].toString();
      log = double.parse(widget.list['latlong_log'].toString());
      lat = double.parse(widget.list['latlong_la'].toString());
    });
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
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    super.dispose();
    com_bankofficer_controller.dispose();
    comparebankid_controller.dispose();
    com_bankcontact_controller.dispose();
    comparable_land_lengthcontroller.dispose();
    comparable_land_widthcontroller.dispose();
    comparable_sold_widthcontroller.dispose();
    comparable_sold_lengthcontroller.dispose();
    comparable_price_per_sqm_controller.dispose();
    comparable_offerred_price_controller.dispose();
    comparable_offerred_price_controller2.dispose();
    comparable_sold_out_price_controller.dispose();
    comparable_asking_price_controller.dispose();
    comparable_year_controller.dispose();
    comparable_address_controller.dispose();
    comparable_province_controller.dispose();
    comparable_district_controller.dispose();
    comparable_commune_controller.dispose();
    comparable_date_controller.dispose();
    comparable_remark_controller.dispose();
    comparable_surveydate_controller.dispose();
    comparable_ownerphone_controller.dispose();
  }

  int _total = 0;
  TextEditingController comparebankid_controller = TextEditingController();
  TextEditingController com_bankofficer_controller = TextEditingController();
  TextEditingController com_bankcontact_controller = TextEditingController();
  TextEditingController comparable_land_lengthcontroller =
      TextEditingController();
  TextEditingController comparable_land_widthcontroller =
      TextEditingController();
  TextEditingController comparable_price_per_sqm_controller =
      TextEditingController();
  TextEditingController comparable_offerred_price_controller =
      TextEditingController();
  TextEditingController comparable_offerred_price_controller2 =
      TextEditingController();
  TextEditingController comparable_sold_out_price_controller =
      TextEditingController();
  TextEditingController comparable_asking_price_controller =
      TextEditingController();
  TextEditingController comparable_year_controller = TextEditingController();
  TextEditingController comparable_address_controller = TextEditingController();
  TextEditingController comparable_province_controller =
      TextEditingController();
  TextEditingController comparable_district_controller =
      TextEditingController();
  TextEditingController comparable_commune_controller = TextEditingController();
  TextEditingController comparable_date_controller = TextEditingController();
  TextEditingController comparable_remark_controller = TextEditingController();
  TextEditingController comparable_surveydate_controller =
      TextEditingController();
  TextEditingController comparable_ownerphone_controller =
      TextEditingController();
  TextEditingController comparable_sold_lengthcontroller =
      TextEditingController();
  TextEditingController comparable_sold_widthcontroller =
      TextEditingController();
  TextEditingController controllers = TextEditingController();
  Future<void> updateComparable() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update_Comparable'));
    request.body = json.encode({
      "comparable_id": widget.list['comparable_id'],
      "compare_bank_id": compare_bank_id.toString(),
      "compare_bank_branch_id": compare_bank_branch_id,
      "com_bankofficer": (com_bankofficer_controller.text == null)
          ? 'null'
          : com_bankofficer_controller.text.toString(),
      "com_bankofficer_contact": com_bankcontact_controller.text,
      "zoning_id": zoning_id,
      "comparable_property_id": comparable_property_id,
      "comparable_road": comparable_road,
      "comparable_land_length": comparable_land_lengthcontroller.text,
      "comparable_land_width": comparable_land_widthcontroller.text,
      "comparable_land_total": comparable_land_total,
      "comparable_sold_length": comparable_sold_lengthcontroller.text,
      "comparable_sold_width": comparable_sold_widthcontroller.text,
      "comparable_sold_total": comparable_sold_total,
      "comparable_adding_price": comparable_price_per_sqm_controller.text,
      "comparable_adding_total": comparable_adding_total,
      "comparableaddprice": comparable_offerred_price_controller.text,
      "comparableaddpricetotal": comparableaddpricetotal,
      "comparableboughtprice": comparable_offerred_price_controller2.text,
      "comparableboughtpricetotal": comparableboughtpricetotal,
      "comparable_sold_price": comparable_sold_out_price_controller.text,
      "comparable_sold_total_price": comparable_sold_total_price,
      "comparableAmount": comparable_asking_price_controller.text,
      "comparable_condition_id": comparable_condition_id,
      "comparable_year": (comparable_year_controller.text == 'null')
          ? ''
          : comparable_year_controller.text,
      "comparable_address": comparable_address_controller.text,
      "province": comparable_province_controller.text,
      "district": comparable_district_controller.text,
      "commune": comparable_commune_controller.text,
      "comparableDate": comparable_date_controller.text,
      "comparable_remark": comparable_remark_controller.text,
      "comparable_survey_date": comparable_surveydate_controller.text,
      "comparable_phone": comparable_ownerphone_controller.text,
      "latlong_log": log,
      "latlong_la": lat
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      update = false;
    } else {
      print(response.reasonPhrase);
    }
  }

  bool update = false;
  Future _updateNewverbal() async {
    update = true;
    await Future.wait([updateComparable()]);
    // await Future.wait([(updateComparable)]);
    setState(() {
      update = false;
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
        title: const Text(
          'Update ',
          style: TextStyle(color: Colors.amber, fontSize: 22),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 10,
              width: 100,
              child: GFButton(
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    updateComparable();
                    _updateNewverbal();
                  });
                },
                text: "Update",
                shape: GFButtonShape.pills,
                fullWidthButton: true,
              ),
            ),
          )
        ],
      ),
      body: (update)
          ? const Center(
              child: CircularProgressIndicator(),
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
                                sizebox10h,
                                titletexts('Bank Info *', context),
                                sizebox10h,
                                SizedBox(
                                  child: BankDropdowncolumn(
                                      bank: (value) {
                                        setState(() {
                                          compare_bank_id = value.toString();
                                        });
                                      },
                                      bankbranch: (value) {
                                        setState(() {
                                          compare_bank_branch_id = value;
                                          // print(
                                          //     "\nkokoobject${listbranch}");
                                        });
                                      },
                                      validator: (val) {},
                                      filedName:
                                          widget.list['bank_name'].toString(),
                                      brandfiledName: ((widget
                                                  .list['bank_branch_name']
                                                  .toString()) ==
                                              'null')
                                          ? ''
                                          : (widget.list['bank_branch_name']
                                              .toString())),
                                ),
                                sizebox10h,
                                titletexts('Bank Officer', context),
                                sizebox10h,
                                SizedBox(
                                  child: Row(
                                    children: [
                                      inputController(2, false, 'Bank Officer',
                                          com_bankofficer_controller),
                                    ],
                                  ),
                                ),
                                titletexts('Bank Contact', context),
                                sizebox10h,
                                SizedBox(
                                  child: Row(
                                    children: [
                                      inputController(2, false, 'Bank Contact',
                                          com_bankcontact_controller),
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                titletexts('Zoning', context),
                                sizebox10h,
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Row(
                                    children: [
                                      DropDown(
                                          validator: true,
                                          flex: 2,
                                          value: (value) {
                                            setState(() {
                                              widget.list['zoning_id']
                                                  .toString();
                                            });
                                          },
                                          list: zoningList,
                                          valuedropdown: 'zoning_id',
                                          valuetxt: '',
                                          filedName: 'All'),
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
                                            // com_property_type = value;
                                            comparable_property_id =
                                                value.toString();
                                            // print(value);
                                          });
                                        },
                                        // hometype_lable: com_property_type,
                                        filedName: widget
                                            .list['property_type_name']
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                titletexts('Road', context),
                                sizebox10h,
                                SizedBox(
                                  //width: w,
                                  child: Row(
                                    children: [
                                      RoadDropdowntwo(
                                        Name_road: (value) {
                                          setState(() {
                                            widget.list['road_name'].toString();
                                          });
                                        },
                                        filedName:
                                            widget.list['road_name'].toString(),
                                        id_road: (value) {
                                          setState(() {
                                            comparable_road = value.toString();
                                          });
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
                                        comparable_land_lengthcontroller.text =
                                            value;
                                      });
                                    },
                                    total: (value) {
                                      setState(() {
                                        comparable_land_total = value;
                                      });
                                    },
                                    w: (value) {
                                      setState(() {
                                        comparable_land_widthcontroller.text =
                                            value;
                                      });
                                    },
                                    ltext: widget.list['comparable_land_length']
                                        .toString(),
                                    wtext: widget.list['comparable_land_width']
                                        .toString(),
                                    l_total: widget
                                        .list['comparable_land_total']
                                        .toString(),
                                  ),
                                ),
                                sizebox10h,
                                titletexts('Building', context),
                                sizebox10h,
                                SizedBox(
                                  child: Land_buildingtwo(
                                    filedName: '',
                                    //flex: 3,
                                    l: (value) {
                                      setState(() {
                                        comparable_sold_lengthcontroller.text =
                                            value;
                                      });
                                    },
                                    total: (value) {
                                      setState(() {
                                        comparable_sold_total = value;
                                      });
                                    },
                                    w: (value) {
                                      setState(() {
                                        comparable_sold_widthcontroller.text =
                                            value;
                                      });
                                    },
                                    ltext: widget.list['comparable_sold_length']
                                        .toString(),
                                    wtext: widget.list['comparable_sold_width']
                                        .toString(),
                                    l_total: widget
                                        .list['comparable_sold_total']
                                        .toString(),
                                  ),
                                ),
                                sizebox10h,
                                titletexts('Price Per Sqm', context),
                                sizebox10h,
                                SizedBox(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            inputController(3, false, '',
                                                comparable_price_per_sqm_controller),
                                          ],
                                        ),
                                      ),
                                      sizebox10h,
                                      SizedBox(
                                        child: DropdownButtonFormField<String>(
                                          //value: genderValue,
                                          isExpanded: true,
                                          onChanged: (newValue) {
                                            setState(() {
                                              comparable_adding_total =
                                                  newValue;
                                            });
                                          },
                                          items: totally
                                              .map<DropdownMenuItem<String>>(
                                                (value) =>
                                                    DropdownMenuItem<String>(
                                                  value: value["numer_id"]
                                                      .toString(),
                                                  child: Text(value["type"]),
                                                  onTap: () {
                                                    setState(() {});
                                                  },
                                                ),
                                              )
                                              .toList(),
                                          // add extra sugar..
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: kImageColor,
                                          ),
                                          decoration: InputDecoration(
                                            // labelStyle: ,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 0),
                                            fillColor: kwhite,
                                            filled: true,
                                            label: (int.parse(widget.list[
                                                            'comparable_adding_total'] ??
                                                        ''.toString()) ==
                                                    1)
                                                ? const Text('Totally')
                                                : (int.parse(widget.list[
                                                                'comparable_adding_total'] ??
                                                            ''.toString()) ==
                                                        2)
                                                    ? const Text('Sqm')
                                                    : const Text('Select'),
                                            // labelText: (int.parse(widget
                                            //             .list[
                                            //                 'comparable_adding_total']
                                            //             .toString()) ==
                                            //         1)
                                            //     .toString(),
                                            // ? Text("Totally")
                                            // : Text("Sqm"),
                                            //.toString(),
                                            //hintText: widget.filedName,
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery
                                                        .textScaleFactorOf(
                                                            context) *
                                                    12),
                                            helperStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery
                                                        .textScaleFactorOf(
                                                            context) *
                                                    12),
                                            prefixIcon:
                                                const SizedBox(width: 7),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 1.0),
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
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                sizebox10h,
                                titletexts('Offered Price', context),
                                sizebox10h,
                                SizedBox(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            inputController(3, false, '',
                                                comparable_offerred_price_controller),
                                          ],
                                        ),
                                      ),
                                      sizebox10h,
                                      SizedBox(
                                        child: DropdownButtonFormField<String>(
                                          //value: genderValue,
                                          isExpanded: true,
                                          onChanged: (newValue) {
                                            setState(() {
                                              print(newValue);
                                              comparableaddpricetotal =
                                                  newValue;
                                              // widget
                                              //     .total_type(newValue);
                                            });
                                          },
                                          items: totally
                                              .map<DropdownMenuItem<String>>(
                                                (value) =>
                                                    DropdownMenuItem<String>(
                                                  value: value["numer_id"]
                                                      .toString(),
                                                  child: Text(value["type"]),
                                                  onTap: () {
                                                    setState(() {});
                                                  },
                                                ),
                                              )
                                              .toList(),
                                          // add extra sugar..
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: kImageColor,
                                          ),
                                          decoration: InputDecoration(
                                            // labelStyle: ,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 0),
                                            fillColor: kwhite,
                                            filled: true,
                                            label: (int.parse(widget.list[
                                                            'comparableaddpricetotal'] ??
                                                        ''.toString()) ==
                                                    1)
                                                ? Text('Totally')
                                                : (int.parse(widget.list[
                                                                'comparableaddpricetotal'] ??
                                                            ''.toString()) ==
                                                        2)
                                                    ? Text('Sqm')
                                                    : Text('Select'),

                                            //hintText: widget.filedName,
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery
                                                        .textScaleFactorOf(
                                                            context) *
                                                    12),
                                            helperStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery
                                                        .textScaleFactorOf(
                                                            context) *
                                                    12),
                                            prefixIcon:
                                                const SizedBox(width: 7),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 1.0),
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
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                sizebox10h,
                                titletexts('Offered Price', context),
                                sizebox10h,
                                SizedBox(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            inputController(3, false, '',
                                                comparable_offerred_price_controller2),
                                          ],
                                        ),
                                      ),
                                      sizebox10h,
                                      SizedBox(
                                        child: DropdownButtonFormField<String>(
                                          //value: genderValue,
                                          isExpanded: true,
                                          onChanged: (newValue) {
                                            setState(() {
                                              print(newValue);
                                              comparableboughtpricetotal =
                                                  newValue;
                                            });
                                          },
                                          items: totally
                                              .map<DropdownMenuItem<String>>(
                                                (value) =>
                                                    DropdownMenuItem<String>(
                                                  value: value["numer_id"]
                                                      .toString(),
                                                  child: Text(value["type"]),
                                                  onTap: () {
                                                    setState(() {});
                                                  },
                                                ),
                                              )
                                              .toList(),
                                          // add extra sugar..
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: kImageColor,
                                          ),
                                          decoration: InputDecoration(
                                            // labelStyle: ,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 0),
                                            fillColor: kwhite,
                                            filled: true,
                                            label: (int.parse(widget.list[
                                                            'comparableboughtpricetotal']
                                                        .toString()) ==
                                                    1)
                                                ? Text("Totally")
                                                : (int.parse(widget.list[
                                                                'comparableboughtpricetotal']
                                                            .toString()) ==
                                                        2)
                                                    ? Text("Sqm")
                                                    : Text("Select"),
                                            //hintText: widget.filedName,
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery
                                                        .textScaleFactorOf(
                                                            context) *
                                                    12),
                                            helperStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery
                                                        .textScaleFactorOf(
                                                            context) *
                                                    12),
                                            prefixIcon:
                                                const SizedBox(width: 7),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 1.0),
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
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                sizebox10h,

                                titletexts('Sold Out Price', context),
                                sizebox10h,
                                SizedBox(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            inputController(3, false, '',
                                                comparable_sold_out_price_controller),
                                          ],
                                        ),
                                      ),
                                      sizebox10h,
                                      SizedBox(
                                        child: DropdownButtonFormField<String>(
                                          //value: genderValue,
                                          isExpanded: true,
                                          onChanged: (newValue) {
                                            setState(() {
                                              print(newValue);
                                              comparable_sold_total_price =
                                                  newValue;
                                            });
                                          },
                                          items: totally
                                              .map<DropdownMenuItem<String>>(
                                                (value) =>
                                                    DropdownMenuItem<String>(
                                                  value: value["numer_id"]
                                                      .toString(),
                                                  child: Text(value["type"]),
                                                  onTap: () {
                                                    setState(() {});
                                                  },
                                                ),
                                              )
                                              .toList(),
                                          // add extra sugar..
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: kImageColor,
                                          ),
                                          decoration: InputDecoration(
                                            // labelStyle: ,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 0),
                                            fillColor: kwhite,
                                            filled: true,
                                            label: (int.parse(
                                                      widget.list[
                                                              'comparable_sold_total_price']
                                                          .toString(),
                                                    ) ==
                                                    1)
                                                ? Text('Totally')
                                                : (int.parse(
                                                          widget.list[
                                                                  'comparable_sold_total_price']
                                                              .toString(),
                                                        ) ==
                                                        2)
                                                    ? Text('Sqm')
                                                    : Text("Select"),
                                            //labelText:
                                            //hintText: widget.filedName,
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery
                                                        .textScaleFactorOf(
                                                            context) *
                                                    12),
                                            helperStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery
                                                        .textScaleFactorOf(
                                                            context) *
                                                    12),
                                            prefixIcon:
                                                const SizedBox(width: 7),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 1.0),
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
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                sizebox10h,
                                titletexts('Asking Price(TTAmount)', context),
                                sizebox10h,
                                SizedBox(
                                  // width: w,
                                  child: Row(
                                    children: [
                                      inputController(3, false, '',
                                          comparable_asking_price_controller),
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                titletexts('Condition*', context),
                                sizebox10h,
                                SizedBox(
                                  // width: w,
                                  child: Total_dropdowntwocondition(
                                      conditiontext: (int.parse(widget.list[
                                                      'comparable_condition_id']
                                                  .toString()) ==
                                              1)
                                          ? const Text("Condition 1")
                                          : (int.parse(widget.list[
                                                          'comparable_condition_id']
                                                      .toString()) ==
                                                  2)
                                              ? const Text("Condition 2")
                                              : const Text("Select"),
                                      conditionyear: ((widget
                                                  .list['comparable_year']
                                                  .toString()) ==
                                              'null')
                                          ? ''
                                          : (widget.list['comparable_year']
                                              .toString()),
                                      flex: 3,
                                      total_type: (value) {
                                        setState(() {
                                          comparable_condition_id =
                                              value.toString();
                                        });
                                      },
                                      input: (value) {
                                        setState(() {});
                                      },
                                      filedName: '',
                                      readOnly: true,
                                      controllers: comparable_year_controller),
                                ),

                                sizebox10h,
                                titletexts('Address', context),
                                sizebox10h,
                                SizedBox(
                                  // width: w * 2 + 100,
                                  child: Row(
                                    children: [
                                      inputController(3, false, '',
                                          comparable_address_controller),
                                    ],
                                  ),
                                ),
                                // InputfiedRow(
                                //     readOnly: false,
                                //     value: (value) {
                                //       setState(() {
                                //         address = value.toString();
                                //       });
                                //     },
                                //     filedName: '',
                                //     flex: 4),
                                sizebox10h,
                                titletexts('SKC *', context),
                                sizebox10h,
                                SizedBox(
                                  child: Row(
                                    children: [
                                      inputController(3, false, '',
                                          comparable_province_controller),
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                SizedBox(
                                  child: Row(
                                    children: [
                                      inputController(3, false, '',
                                          comparable_district_controller),
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                SizedBox(
                                  child: Row(
                                    children: [
                                      inputController(3, false, '',
                                          comparable_commune_controller),
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                titletexts('Date*', context),
                                sizebox10h,
                                SizedBox(
                                  child: Row(
                                    children: [
                                      InputfiedRowDate(
                                          // validator: false,
                                          controller:
                                              comparable_date_controller,
                                          readOnly: false,
                                          value: (value) {
                                            setState(() {});
                                          },
                                          filedName: '',
                                          flex: 6),
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                titletexts('Remark', context),
                                sizebox10h,
                                SizedBox(
                                  child: Row(
                                    children: [
                                      inputController(3, false, '',
                                          comparable_remark_controller),
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                titletexts('Survey Date*', context),
                                sizebox10h,
                                SizedBox(
                                  child: Row(
                                    children: [
                                      InputfiedRowDate(
                                          controller:
                                              comparable_surveydate_controller,
                                          readOnly: false,
                                          value: (value) {},
                                          filedName: '',
                                          flex: 6),
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                titletexts('Owner Phone*', context),
                                sizebox10h,
                                SizedBox(
                                  child: Row(
                                    children: [
                                      inputController(3, false, '',
                                          comparable_ownerphone_controller),
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                titletexts('Latittute*', context),
                                sizebox10h,
                                SizedBox(
                                  // height: 45,
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
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.015,
                                        fontWeight: FontWeight.bold),
                                    onChanged: (value) {
                                      setState(() {
                                        // bankcontact = value;
                                        lat = double.parse(_lat!.text);
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
                                      hintText:
                                          widget.list['latlong_la'].toString(),
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
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 249, 0, 0),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedErrorBorder:
                                          const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 249, 0, 0),
                                        ),
                                        //  borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                                sizebox10h,
                                titletexts('Longtittute*', context),
                                sizebox10h,
                                SizedBox(
                                  // height: 45,

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
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.015,
                                        fontWeight: FontWeight.bold),
                                    onChanged: (value) {
                                      setState(() {
                                        // bankcontact = value;
                                        log = double.parse(_log!.text);
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
                                      hintText:
                                          widget.list['latlong_log'].toString(),
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
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 249, 0, 0),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedErrorBorder:
                                          const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 249, 0, 0),
                                        ),
                                        //  borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                                sizebox10h,
                                sizebox10h,
                                if (lat != null && lat1 == null)
                                  InkWell(
                                    onTap: () async {
                                      await SlideUp(context);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        height: 400,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                              'https://maps.googleapis.com/maps/api/staticmap?center=${(double.parse(lat.toString()) < double.parse(log.toString())) ? "$lat,$log" : "$log,$lat"}&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(double.parse(lat.toString()) < double.parse(log.toString())) ? "$lat,$log" : "$log,$lat"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                        ),
                                      ),
                                    ),
                                  )
                                else if (lat1 != null)
                                  InkWell(
                                    onTap: () async {
                                      await SlideUp(context);
                                    },
                                    child: Container(
                                      height: 180,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      margin: const EdgeInsets.only(
                                          top: 15, right: 13, left: 15),
                                      child: FadeInImage.assetNetwork(
                                        placeholderCacheHeight: 50,
                                        placeholderCacheWidth: 50,
                                        fit: BoxFit.cover,
                                        placeholderFit: BoxFit.fill,
                                        placeholder: 'assets/earth.gif',
                                        image:
                                            'https://maps.googleapis.com/maps/api/staticmap?center=${(double.parse(lat.toString()) < double.parse(log.toString())) ? "$lat,$log" : "$log,$lat"}&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C? ${(double.parse(lat.toString()) < double.parse(log.toString())) ? "$lat,$log" : "$log,$lat"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                      ),
                                    ),
                                  )
                                else
                                  const SizedBox(),
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
                                SizedBox(
                                  width: double.infinity,
                                  height: 35,
                                  child: Row(
                                    children: [
                                      filedtext('Bank Info', '*', context),
                                      SizedBox(
                                        width: w,
                                        child: BankDropdownrow(
                                            bank: (value) {
                                              setState(() {
                                                compare_bank_id =
                                                    value.toString();
                                              });
                                            },
                                            bankbranch: (value) {
                                              setState(() {
                                                compare_bank_branch_id = value;
                                                // print(
                                                //     "\nkokoobject${listbranch}");
                                              });
                                            },
                                            validator: (val) {},
                                            filedName: widget.list['bank_name']
                                                .toString(),
                                            brandfiledName: ((widget.list[
                                                            'bank_branch_name']
                                                        .toString()) ==
                                                    'null')
                                                ? ''
                                                : (widget
                                                    .list['bank_branch_name']
                                                    .toString())),
                                      ),
                                      sizeboxw40,
                                      SizedBox(
                                        width: w,
                                      )
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                //Contact by
                                SizedBox(
                                  width: double.infinity,
                                  height: 35,
                                  child: Row(
                                    children: [
                                      filedtext('Bank Officer', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            inputController(
                                                2,
                                                false,
                                                'Bank Officer',
                                                com_bankofficer_controller),
                                            sizebox,
                                            inputController(
                                                3,
                                                false,
                                                'Bank Contact',
                                                com_bankcontact_controller)
                                          ],
                                        ),
                                      ),
                                      // sizeboxw40,
                                      filedtext('Zoning', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            DropDown(
                                                validator: true,
                                                flex: 2,
                                                value: (value) {
                                                  setState(() {
                                                    widget.list['zoning_id']
                                                        .toString();
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
                                //Property Guider Name
                                SizedBox(
                                  height: 35,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      filedtext('Property Type*', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            property_hoemtypetwo(
                                              flex: 3,
                                              hometype: (value) {
                                                setState(() {
                                                  // com_property_type = value;
                                                  comparable_property_id =
                                                      value.toString();
                                                  // print(value);
                                                });
                                              },
                                              // hometype_lable: com_property_type,
                                              filedName: widget
                                                  .list['property_type_name']
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // sizeboxw40,
                                      filedtext('Road', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            RoadDropdowntwo(
                                              Name_road: (value) {
                                                setState(() {
                                                  widget.list['road_name']
                                                      .toString();
                                                });
                                              },
                                              filedName: widget
                                                  .list['road_name']
                                                  .toString(),
                                              id_road: (value) {
                                                setState(() {
                                                  comparable_road =
                                                      value.toString();
                                                });
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
                                  height: 35,
                                  child: Row(
                                    children: [
                                      filedtext('Land', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Land_buildingtwoRow(
                                          filedName: '',
                                          flex: 3,
                                          l: (value) {
                                            setState(() {
                                              comparable_land_lengthcontroller
                                                  .text = value;
                                            });
                                          },
                                          total: (value) {
                                            setState(() {
                                              comparable_land_total = value;
                                            });
                                          },
                                          w: (value) {
                                            setState(() {
                                              comparable_land_widthcontroller
                                                  .text = value;
                                            });
                                          },
                                          ltext: widget
                                              .list['comparable_land_length']
                                              .toString(),
                                          wtext: widget
                                              .list['comparable_land_width']
                                              .toString(),
                                          l_total: widget
                                              .list['comparable_land_total']
                                              .toString(),
                                        ),
                                      ),
                                      //ទុកកែពេលក្រោយហាមលុប!!!!!!!
                                      // SizedBox(
                                      //   width: w,
                                      //   child: Row(children: [
                                      //     inputController(3, false, '',
                                      //         comparable_land_lengthcontroller),
                                      //     inputController(3, false, '',
                                      //         comparable_land_widthcontroller),
                                      //     Expanded(
                                      //       flex: 3,
                                      //       child: Container(
                                      //         alignment: Alignment.centerLeft,
                                      //         decoration: BoxDecoration(
                                      //             color: const Color.fromARGB(
                                      //                 2, 19, 20, 20),
                                      //             border: Border.all(
                                      //               width: 1,
                                      //               color: Colors.black,
                                      //             ),
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     5.0)),
                                      //         width: MediaQuery.of(context)
                                      //                 .size
                                      //                 .width *
                                      //             0.09,
                                      //         height: 46,
                                      //         child: (_total != 0)
                                      //             ? Text('$_total')
                                      //             : Padding(
                                      //                 padding:
                                      //                     const EdgeInsets.only(
                                      //                         left: 18.0),
                                      //                 child: Text(
                                      //                   '${l_total}',
                                      //                   style: TextStyle(
                                      //                     fontSize: MediaQuery
                                      //                             .textScaleFactorOf(
                                      //                                 context) *
                                      //                         12,
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //       ),
                                      //     )
                                      //   ]),
                                      // ),
                                      filedtext('Building', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Land_buildingtwoRow(
                                          filedName: '',
                                          flex: 3,
                                          l: (value) {
                                            setState(() {
                                              comparable_sold_lengthcontroller
                                                  .text = value;
                                              print(
                                                  comparable_sold_lengthcontroller
                                                      .text);
                                              //  lb = value;
                                            });
                                          },
                                          total: (value) {
                                            setState(() {
                                              comparable_sold_total = value;
                                              // print(total_b);
                                            });
                                          },
                                          w: (value) {
                                            setState(() {
                                              comparable_sold_widthcontroller
                                                  .text = value;
                                              print(
                                                  comparable_sold_widthcontroller
                                                      .text);
                                              // wb = value;
                                            });
                                          },
                                          ltext: widget
                                              .list['comparable_sold_length']
                                              .toString(),
                                          wtext: widget
                                              .list['comparable_sold_width']
                                              .toString(),
                                          l_total: widget
                                              .list['comparable_sold_total']
                                              .toString(),
                                        ),
                                      )
                                      //ទុកកែពេលក្រោយហាមលុប!!!!!!!
                                      // SizedBox(
                                      //   width: w,
                                      //   child: Row(children: [
                                      //     inputController(3, false, '',
                                      //         comparable_sold_lengthcontroller),
                                      //     inputController(3, false, '',
                                      //         comparable_sold_widthcontroller),
                                      //     Expanded(
                                      //       flex: 3,
                                      //       child: Container(
                                      //         alignment: Alignment.centerLeft,
                                      //         decoration: BoxDecoration(
                                      //             color: const Color.fromARGB(
                                      //                 2, 19, 20, 20),
                                      //             border: Border.all(
                                      //               width: 1,
                                      //               color: Colors.black,
                                      //             ),
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     5.0)),
                                      //         width: MediaQuery.of(context)
                                      //                 .size
                                      //                 .width *
                                      //             0.09,
                                      //         height: 46,
                                      //         child: (_total != 0)
                                      //             ? Text('$_total')
                                      //             : Padding(
                                      //                 padding:
                                      //                     const EdgeInsets.only(
                                      //                         left: 18.0),
                                      //                 child: Text(
                                      //                   '${comparable_sold_total}',
                                      //                   style: TextStyle(
                                      //                     fontSize: MediaQuery
                                      //                             .textScaleFactorOf(
                                      //                                 context) *
                                      //                         12,
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //       ),
                                      //     )
                                      //   ]),
                                      // ),
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                //Property Location
                                SizedBox(
                                  width: double.infinity,
                                  height: 35,
                                  child: Row(
                                    children: [
                                      filedtext('Price Per Sqm', '', context),
                                      SizedBox(
                                          width: w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              inputController(3, false, '',
                                                  comparable_price_per_sqm_controller),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  //value: genderValue,
                                                  isExpanded: true,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      comparable_adding_total =
                                                          newValue;
                                                    });
                                                  },
                                                  items: totally
                                                      .map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                        (value) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                          value:
                                                              value["numer_id"]
                                                                  .toString(),
                                                          child: Text(
                                                              value["type"]),
                                                          onTap: () {
                                                            setState(() {});
                                                          },
                                                        ),
                                                      )
                                                      .toList(),
                                                  // add extra sugar..
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: kImageColor,
                                                  ),
                                                  decoration: InputDecoration(
                                                    // labelStyle: ,
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 8,
                                                            horizontal: 0),
                                                    fillColor: kwhite,
                                                    filled: true,
                                                    label: (int.parse(widget
                                                                        .list[
                                                                    'comparable_adding_total'] ??
                                                                ''
                                                                    .toString()) ==
                                                            1)
                                                        ? Text('Totally')
                                                        : (int.parse(widget.list[
                                                                        'comparable_adding_total'] ??
                                                                    ''.toString()) ==
                                                                2)
                                                            ? Text('Sqm')
                                                            : Text('Select'),

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
                                                    prefixIcon: const SizedBox(
                                                        width: 7),
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
                                                      // borderSide: BorderSide(
                                                      //   width: 1,
                                                      //   color: (!hasError && widget.validator == true)
                                                      //       ? Colors.red
                                                      //       : bordertxt,
                                                      // ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      //sizeboxw40,
                                      filedtext('Offered Price', '', context),
                                      SizedBox(
                                          width: w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              inputController(3, false, '',
                                                  comparable_offerred_price_controller),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  //value: genderValue,
                                                  isExpanded: true,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      print(newValue);
                                                      comparableaddpricetotal =
                                                          newValue;
                                                      // widget
                                                      //     .total_type(newValue);
                                                    });
                                                  },
                                                  items: totally
                                                      .map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                        (value) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                          value:
                                                              value["numer_id"]
                                                                  .toString(),
                                                          child: Text(
                                                              value["type"]),
                                                          onTap: () {
                                                            setState(() {});
                                                          },
                                                        ),
                                                      )
                                                      .toList(),
                                                  // add extra sugar..
                                                  icon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: kImageColor,
                                                  ),
                                                  decoration: InputDecoration(
                                                    // labelStyle: ,
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 8,
                                                            horizontal: 0),
                                                    fillColor: kwhite,
                                                    filled: true,
                                                    label: (int.parse(widget
                                                                        .list[
                                                                    'comparableaddpricetotal'] ??
                                                                ''
                                                                    .toString()) ==
                                                            1)
                                                        ? Text('Totally')
                                                        : (int.parse(widget.list[
                                                                        'comparableaddpricetotal'] ??
                                                                    ''.toString()) ==
                                                                2)
                                                            ? Text('Sqm')
                                                            : Text('Select'),

                                                    //hintText: widget.filedName,
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
                                                    prefixIcon: const SizedBox(
                                                        width: 7),
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
                                                      // borderSide: BorderSide(
                                                      //   width: 1,
                                                      //   color: (!hasError && widget.validator == true)
                                                      //       ? Colors.red
                                                      //       : bordertxt,
                                                      // ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                SizedBox(
                                  width: double.infinity,
                                  height: 35,
                                  child: Row(
                                    children: [
                                      filedtext('Offered Price', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            inputController(3, false, '',
                                                comparable_offerred_price_controller2),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                //value: genderValue,
                                                isExpanded: true,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    print(newValue);
                                                    comparableboughtpricetotal =
                                                        newValue;
                                                  });
                                                },
                                                items: totally
                                                    .map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                      (value) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: value["numer_id"]
                                                            .toString(),
                                                        child:
                                                            Text(value["type"]),
                                                        onTap: () {
                                                          setState(() {});
                                                        },
                                                      ),
                                                    )
                                                    .toList(),
                                                // add extra sugar..
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: kImageColor,
                                                ),
                                                decoration: InputDecoration(
                                                  // labelStyle: ,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 0),
                                                  fillColor: kwhite,
                                                  filled: true,
                                                  label: (int.parse(widget.list[
                                                                  'comparableboughtpricetotal']
                                                              .toString()) ==
                                                          1)
                                                      ? Text("Totally")
                                                      : (int.parse(widget.list[
                                                                      'comparableboughtpricetotal']
                                                                  .toString()) ==
                                                              2)
                                                          ? Text("Sqm")
                                                          : Text("Select"),
                                                  //hintText: widget.filedName,
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
                                                    // borderSide: BorderSide(
                                                    //   width: 1,
                                                    //   color: (!hasError && widget.validator == true)
                                                    //       ? Colors.red
                                                    //       : bordertxt,
                                                    // ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //sizeboxw40,
                                      filedtext('Sold Out Price', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            inputController(3, false, '',
                                                comparable_sold_out_price_controller),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                //value: genderValue,
                                                isExpanded: true,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    print(newValue);
                                                    comparable_sold_total_price =
                                                        newValue;
                                                  });
                                                },
                                                items: totally
                                                    .map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                      (value) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: value["numer_id"]
                                                            .toString(),
                                                        child:
                                                            Text(value["type"]),
                                                        onTap: () {
                                                          setState(() {});
                                                        },
                                                      ),
                                                    )
                                                    .toList(),
                                                // add extra sugar..
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: kImageColor,
                                                ),
                                                decoration: InputDecoration(
                                                  // labelStyle: ,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 0),
                                                  fillColor: kwhite,
                                                  filled: true,
                                                  label: (int.parse(
                                                            widget.list[
                                                                    'comparable_sold_total_price']
                                                                .toString(),
                                                          ) ==
                                                          1)
                                                      ? const Text('Totally')
                                                      : (int.parse(
                                                                widget.list[
                                                                        'comparable_sold_total_price']
                                                                    .toString(),
                                                              ) ==
                                                              2)
                                                          ? const Text('Sqm')
                                                          : const Text(
                                                              "Select"),
                                                  //labelText:
                                                  //hintText: widget.filedName,
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
                                                    // borderSide: BorderSide(
                                                    //   width: 1,
                                                    //   color: (!hasError && widget.validator == true)
                                                    //       ? Colors.red
                                                    //       : bordertxt,
                                                    // ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                SizedBox(
                                  width: double.infinity,
                                  height: 35,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        child: Column(
                                          children: [
                                            filedtext(
                                                'Asking Price', '', context),
                                            filedtext(
                                                '(TTAmount)', '', context),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            inputController(3, false, '',
                                                comparable_asking_price_controller),
                                          ],
                                        ),
                                      ),
                                      //sizeboxw40,
                                      filedtext('Condition', '*', context),
                                      SizedBox(
                                        width: w,
                                        child: Total_dropdowntwocondition(
                                          conditiontext: (int.parse(widget.list[
                                                          'comparable_condition_id']
                                                      .toString()) ==
                                                  1)
                                              ? const Text("Condition 1")
                                              : (int.parse(widget.list[
                                                              'comparable_condition_id']
                                                          .toString()) ==
                                                      2)
                                                  ? const Text("Condition 2")
                                                  : const Text("Select"),
                                          conditionyear: widget
                                              .list['comparable_year']
                                              .toString(),
                                          flex: 3,
                                          total_type: (value) {
                                            setState(() {
                                              comparable_condition_id =
                                                  value.toString();
                                            });
                                          },
                                          input: (value) {
                                            setState(() {
                                              // comparable_year =
                                              //     value.toString();
                                            });
                                          },
                                          filedName: '',
                                          readOnly: true,
                                          controllers:
                                              comparable_year_controller,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                //Total Fee Charge
                                SizedBox(
                                  width: double.infinity,
                                  height: 35,
                                  child: Row(
                                    children: [
                                      filedtext('Address', '', context),
                                      SizedBox(
                                        width: w * 2 + 100,
                                        child: Row(
                                          children: [
                                            inputController(3, false, '',
                                                comparable_address_controller),
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
                                      filedtext('SKC', '*', context),
                                      SizedBox(
                                        height: 35,
                                        width: w * 2 + 100,
                                        child: Row(
                                          children: [
                                            inputController(3, false, '',
                                                comparable_province_controller),
                                            sizebox,
                                            inputController(3, false, '',
                                                comparable_district_controller),
                                            sizebox,
                                            inputController(3, false, '',
                                                comparable_commune_controller)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                SizedBox(
                                  width: double.infinity,
                                  height: 35,
                                  child: Row(
                                    children: [
                                      filedtext('Date', '*', context),
                                      SizedBox(
                                        width: w,
                                        // child: inputController(3, false, '',
                                        //     comparable_date_controller),
                                        child: Row(
                                          children: [
                                            InputfiedRowDate(
                                                // validator: false,
                                                controller:
                                                    comparable_date_controller,
                                                readOnly: false,
                                                value: (value) {
                                                  setState(() {
                                                    // comparable_date_controller
                                                    //     .text = value;
                                                    // // print(remak);
                                                  });
                                                },
                                                filedName: '',
                                                flex: 6),
                                          ],
                                        ),
                                      ),
                                      //sizeboxw40,
                                      filedtext('Remark', '', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            inputController(3, false, '',
                                                comparable_remark_controller),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                SizedBox(
                                  width: double.infinity,
                                  height: 35,
                                  child: Row(
                                    children: [
                                      filedtext('Survey Date', '*', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            InputfiedRowDate(
                                                controller:
                                                    comparable_surveydate_controller,
                                                readOnly: false,
                                                value: (value) {},
                                                filedName: '',
                                                flex: 6),
                                          ],
                                        ),
                                      ),
                                      filedtext('Owner Phone', '*', context),
                                      SizedBox(
                                        width: w,
                                        child: Row(
                                          children: [
                                            inputController(3, false, '',
                                                comparable_ownerphone_controller),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                sizebox10h,
                                SizedBox(
                                  width: double.infinity,
                                  height: 35,
                                  child: Row(
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
                                              lat = double.parse(_lat!.text);
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
                                            hintText: widget.list['latlong_la']
                                                .toString(),
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
                                              log = double.parse(_log!.text);
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
                                            hintText: widget.list['latlong_log']
                                                .toString(),
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
                                if (lat != null && lat1 == null)
                                  InkWell(
                                    onTap: () async {
                                      await SlideUp(context);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        height: 400,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                              'https://maps.googleapis.com/maps/api/staticmap?center=${(double.parse(lat.toString()) < double.parse(log.toString())) ? "$lat,$log" : "$log,$lat"}&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(double.parse(lat.toString()) < double.parse(log.toString())) ? "$lat,$log" : "$log,$lat"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                        ),
                                      ),
                                    ),
                                  )
                                else if (lat1 != null)
                                  InkWell(
                                    onTap: () async {
                                      await SlideUp(context);
                                    },
                                    child: Container(
                                      height: 180,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      margin: const EdgeInsets.only(
                                          top: 15, right: 13, left: 15),
                                      child: FadeInImage.assetNetwork(
                                        placeholderCacheHeight: 50,
                                        placeholderCacheWidth: 50,
                                        fit: BoxFit.cover,
                                        placeholderFit: BoxFit.fill,
                                        placeholder: 'assets/earth.gif',
                                        image:
                                            'https://maps.googleapis.com/maps/api/staticmap?center=${(double.parse(lat.toString()) < double.parse(log.toString())) ? "$lat,$log" : "$log,$lat"}&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C? ${(double.parse(lat.toString()) < double.parse(log.toString())) ? "$lat,$log" : "$log,$lat"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                      ),
                                    ),
                                  )
                                else
                                  const SizedBox(),
                              ],
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
              log = double.parse(value.toString());
              _log = TextEditingController(text: '${log}');
              log = double.parse(_log!.text);
            });
          },
          get_lat: (value) {
            setState(() {
              lat = double.parse(value.toString());
              _lat = TextEditingController(text: '${lat}');
              lat = double.parse(_lat!.text);
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
          // genderList = jsonBody;
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

  Widget inputController(
    int flex,
    bool readOnly,
    String filedName,
    controllers,
  ) {
    return Expanded(
      flex: flex,
      child: TextFormField(
        // onChanged:
        controller: controllers,
        validator: (input) {
          if (input == null || input.isEmpty) {
            return 'require *';
          }
          return null;
        },
        readOnly: readOnly,
        style: TextStyle(
            fontSize: MediaQuery.textScaleFactorOf(context) * 12,
            fontWeight: FontWeight.bold),
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          // labelStyle: ,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          fillColor: kwhite,
          filled: true,
          labelText: filedName,
          //hintText: widget.filedName,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.textScaleFactorOf(context) * 12),
          helperStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.textScaleFactorOf(context) * 12),
          prefixIcon: const SizedBox(width: 7),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 249, 0, 0),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 249, 0, 0),
            ),
            //  borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
