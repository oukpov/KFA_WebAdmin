// ignore_for_file: unused_element, unused_local_variable, unused_field, equal_keys_in_map, unnecessary_null_comparison, unused_catch_clause, null_check_always_fails, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import '../../../components/contants.dart';
import '../../../components/first_pay.dart';
import '../../../components/property_type.dart';
import '../../../screen/Profile/components/Drop.dart';
import '../../../screen/Property/Map/map_in_add_verbal.dart';

class new_customer_map extends StatefulWidget {
  const new_customer_map({super.key});

  @override
  State<new_customer_map> createState() => _new_customerState();
}

class _new_customerState extends State<new_customer_map> {
  TextEditingController start_date = TextEditingController();
  TextEditingController end_date = TextEditingController();
  TextEditingController assigndate = TextEditingController();
  TextEditingController todate = TextEditingController();
  TextEditingController Inspecting_date = TextEditingController();
  TextEditingController _controllerA = TextEditingController();
  TextEditingController _controllerB = TextEditingController();
  TextEditingController _controllerC = TextEditingController();
  TextEditingController _controllerD = TextEditingController();
  @override
  void initState() {
    Gender_dropdown();
    todate.text = "";
    _controllerA.dispose();
    _controllerB.dispose();
    _controllerC.dispose();
    ARF_last_ID();
    Registered_By();
    today_formart();
    _name();

    super.initState();
  }

  void _updateTotal() {
    int a = int.tryParse(_controllerA.text) ?? 0;
    int b = int.tryParse(_controllerB.text) ?? 0;
    int c = int.tryParse(_controllerC.text) ?? 0;
    setState(() {
      customerservicecharge = a.toString();
      var total = a - b - c;
      Total_Fee_dok = total.toString();
      first_payment = b.toString();
      second_payment = c.toString();
      customerservicechargeunpaid = Total_Fee_dok;
      _controllerD = TextEditingController(text: '$total');
    });
  }

  String? ARF_code;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TextEditingController? _Account_Receivable;
  List mr = [
    {
      'numer_id': 1,
      'type': 'Dr.',
    },
    {
      'numer_id': 2,
      'type': 'Miss.',
    },
    {
      'numer_id': 3,
      'type': 'Mr.',
    },
    {
      'numer_id': 4,
      'type': 'Mrs.',
    }
  ];

  List cases = [
    {
      'numer_id': '1',
      'type': '',
    },
    {
      'numer_id': '2',
      'type': 'private',
    },
    {
      'numer_id': '3',
      'type': 'Bank',
    },
  ];
  List option = const [
    "Contact By",
    "Property Guide Name",
  ];
  List bank = const [
    "Bank Officer Name",
    "Bank Officer Tell",
  ];
  List Instructor = const [
    "Instructor Name",
    "Instructor",
  ];
  String? formattedDate;
  void today_formart() {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(now);
  }

  void yyy_formart() {
    DateTime now = DateTime.now();
    yyy = DateFormat('yy').format(now);

    ARF_code = 'ARF$yyy';
    ARF_num = ARF_ID_GET;
  }

  String? log;
  String? lat;
  TextEditingController? _log;
  TextEditingController? _lat;

  String? provice_map;
  String? district_map;
  String? cummune_map;
  String? ARF_num;
  String? yyy;

  String? name_customer;
  String? property_type;
  List<Icon> optionIconList = const [
    Icon(
      Icons.contact_emergency,
      color: kImageColor,
    ),
    Icon(
      Icons.near_me,
      color: kImageColor,
    ),
  ];

  List<Icon> bank_branch = const [
    Icon(
      Icons.account_balance,
      color: kImageColor,
    ),
    Icon(
      Icons.near_me,
      color: kImageColor,
    ),
  ];
  //SELECT * FROM `customer_models` WHERE `customercode`='ARF20-0167';
  String? customergender;
  String? customercode;
  String? customerengname;
  String? customerphones;
  String? customersizeother;
  String? customerBuildSize;
  String? customerprovince_id;
  String? customerdistrict_id;
  String? customercommune_id;
  String? customercontactbys;
  String? customerproperty;
  String? customerpropertyaddress;
  String? customerpropertybankname;
  String? customerpropertybankbranch;
  String? officer_name;
  String? office_tell;
  String? customerservicecharge;
  String? customerservicechargeunpaid;
  String? first_payment;
  String? second_payment;
  String? customerorn;
  String? customerorns;
  String? CustomerInvoice;
  String? CustomerInvoices;
  String? paid_by;
  String? paid_bys;
  String? customerstartdate;
  String? customerenddate;
  String? customerinspectingdate;
  String? customerremark;
  String? customercasefrom;
  String? customerdatetotal;
  String? customervat;
  String? customerassigneddate;
  String? second_date_payment;
  String? date_dayment;
  String? customerregistered;
  String? customerinspectors;
  String? customerinspector;
  String? customerassigned;
  String? customerappraisalname;
  String? accompany;
  String? Instructor_Name;
  String? Instructor_Tel;
  String? customerphoness;
  String? customercontactname;
  String? customerkhmname;
  String? customermarital_id;
  String? customermarital;
  String? customernationallyid;
  String? customeroccupationid;
  String? customerinformationsourceid;
  String? customerinformationsources;
  String? customercontactbyid;
  String? customerbanknameid;
  String? customerbankbranchid;
  String? customerbankaccount;
  String? customerphone;
  String? customeremail;
  String? customeremails;
  String? customeraddress;
  String? customerprovinceid;
  String? customerdistrictid;
  String? customercommuneid;
  String? customerpropertyprovince;
  String? customerpropertydistrict;
  String? customerpropertycommune;
  String? customerchargeFrom;
  String? customerappraisalfor;
  String? customerappraisalfrom;
  String? customerappraisaltel;
  String? customerappraisallandguardname;
  String? customerappraisallandguardtel;
  String? customersendto;
  Future<void> newCustomer() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IllpWW9TR0R1WHRsQ2xsV01QMFlNZUE9PSIsInZhbHVlIjoic0hMbzdGMjdNVmdDeTBKTDMxZEJVcUZqd25UTU4wU3p3VlMxQkI0ZFJOejRicjdZQzlHUnpVUkoyMXIreGNiWWd6dXY0YkZJTWIvN01LTGxTdDJkNld3YU4yWHBSUjBMRzJkaStSWUQ3QUY0VlVPNVZQZ1hkaW03QzM3U0cwKy8iLCJtYWMiOiIxMTNhMzc1MGE3MzlhNTliMjlmODFiMjdkOTI0M2RlM2QyNjc4Y2EyNDkyZGQ0MTI4YmMwZjYyNzUxYzRmOGZkIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IlBCVDdNa2Z1bk93SnZHaklucjM5WEE9PSIsInZhbHVlIjoiNGlndEc2ZFRKUmhjN2d5S3Frd2EyYzlsNUdDaHdEWnE5UUx4UlNhV0ZGa0Y4eTRHSUV6VmVuakgrSU5qTE4xT2VTazNlZFIySzJLYzRSamFReXkyN2ZWYVdOaFBVcmo4TVB1Mlh4SXpHRkw3dDdQblpEalN5TjZEVnZ0YnBNdVAiLCJtYWMiOiI5MjZkOGFiZmM3ODZiNDdkMGExNGUzMzNlYzI1MDY2NTRhZTg4YzUwODY3OGEyOWIxOTlhODA1NjI4ZDBmOWU1IiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/new/customer'));
    request.body = json.encode({
      "customergender": customergender,
      "customercode": ARF_ID_GET.toString(),
      "customer_code_num": ARF_ID_GET.toString(),
      "customerengname": customerengname,
      "customerkhmname": customerkhmname,
      "customerbirthdate": formattedDate,
      "customermarital_id": customermarital_id,
      "customermarital": customermarital,
      "customernationally_id": customernationallyid,
      "customeroccupation_id": customeroccupationid,
      "customerinformationsource_id": customerinformationsourceid,
      "customerinformationsources": customerinformationsources,
      "customercontactby_id": customercontactbyid,
      "customercontactbys": customerphones,
      "customervat": customervat,
      "customerbankname_id": customerbanknameid,
      "customerbankbranch_id": customerbankbranchid,
      "customerbankaccount": customerbankaccount,
      "customerphone": customerphone,
      "customerphones": customerphones,
      "customeremail": customeremail,
      "customeremails": customeremails,
      "customeraddress": customeraddress,
      "customerprovince_id": customerprovinceid,
      "customerdistrict_id": customerdistrictid,
      "customercommune_id": customercommuneid,
      "customercontactname": customercontactname,
      "customerproperty": customerproperty,
      "customersize": customersizeother,
      "customersizeother": null,
      //////////////
      "customerpropertyaddress": customerpropertyaddress,
      "customerpropertyprovince": customerpropertyprovince,
      "customerpropertydistrict": customerpropertydistrict,
      "customerpropertycommune": customerpropertycommune,
      "customerregistered": customerregistered,
      "customerdate": formattedDate,
      "customerservicecharge": customerservicecharge,
      "date_dayment": date_dayment,
      "first_payment": first_payment,
      "paid_by": paid_by,
      "customerservicechargePaid": first_payment,

      ///XMLHttpRequest-----------
      "second_date_payment": second_date_payment,
      "second_payment": second_payment,
      "paid_bys": paid_bys,
      //  "paid_bys": paid_bys,
      "customerservicechargeunpaid": customerservicechargeunpaid,
      "customerchargeFrom": null,
      "customerappraisalfor": null,
      "customerappraisalfrom": null,
      "customerappraisalname": customerappraisalname,

      ///XMLHttpRequest----------
      "customerappraisaltel": customerappraisaltel,
      "customerappraisallandguardname": customerappraisaltel,
      "customerappraisallandguardtel": customerappraisallandguardtel,
      "customerstartdate": customerstartdate,
      "customerenddate": customerenddate,
      "customerdatetotal": customerdatetotal,
      "customersendto": customersendto,
      "customerpropertyowner": null,
      ///////////////
      "customerpropertybankname": customerpropertybankname,
      "customerpropertybankbranch": customerpropertybankbranch,
      "customerinspector": customerinspector,
      "customerinspectors": customerinspectors,
      "customerinspectingdate": customerinspectingdate,
      "customerassigned": customerassigned,
      "customerassigneddate": customerassigneddate,
      "customer_status": 1,
      "customerreference": null,
      "customerreferencename": null,
      "customerreferencephone": null,
      "customerreferred": null,
      "customerremark": customerremark,
      "customerorn": customerorn,
      "customerorns": customerorns,
      "customerBuildSize": customerBuildSize,
      "CustomerInvoice": CustomerInvoice,
      "CustomerInvoices": CustomerInvoices,
      "customerinstructorname": Instructor_Name,
      "customerinstructortel": Instructor_Tel,
      "customercasefrom": customercasefrom,
      "customervaluationbankmame": null,
      "customervaluationbranchname": null,
      "customerreferredtel": null,
      "officer_name": officer_name,
      "office_tell": office_tell,
      "appraiser": null,
      "Unpaid": null,
      "PaidBy": null,
      "accompany": accompany,
      "customer_published": 0,
      "customer_created_by": 1,
      "customer_created_date": "2020-1-1",
      "customer_modify_by": null,
      "customer_modify_date": null,
      "province_map": provice_map,
      "district_map": district_map,
      "cummune_map": cummune_map,
      "lat": lat,
      "log": log,
      // "lat": 2.00,
      // "log": 2.00,
      "image_map":
          "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$log&zoom=20&size=720x720&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Post Succesfuly');
      Navigator.pop(context);
    } else {
      print(response.reasonPhrase);
    }
  }

  Random random = new Random();
  Future<void> uploadImageMultiple() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customer_image'));
    request.fields['customer_code_num'] = ARF_ID_GET.toString();
    if (get_bytes != null) {
      request.files.add(await http.MultipartFile.fromBytes('image1', get_bytes!,
          filename: '${random.nextInt(99)}.jpg'));
    } else {
      request.files.add(await http.MultipartFile.fromBytes('image1', _byesData!,
          filename: '${random.nextInt(99)}.jpg'));
    }

    var res = await request.send();
  }

  String? start_end;
  String? _case;
  String? Property_Guide_Name;
  String? Contact_By;
  String? Total_Fee_;
  String? Total_Fee_dok;
  String? payfirst;

  List _list_Appraiser = [];

  bool waitPosts = false;
  Future<void> posts() async {
    waitPosts = true;
    await Future.wait([
      uploadImageMultiple(),
      newCustomer(),
    ]);
    setState(() {
      waitPosts = false;
    });
  }

  String? _waiting;
  @override
  Widget build(BuildContext context) {
    var sizefont_map = TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.011,
        fontWeight: FontWeight.bold);
    var sizefont = TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.015,
        fontWeight: FontWeight.bold);
    var sizehintext = TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.013,
        fontWeight: FontWeight.bold);
    var pading = EdgeInsets.only(
      left: 30,
      right: 30,
      bottom: 10,
    );
    var pading_t = EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10);
    var pading_bt = EdgeInsets.only(left: 30, right: 30);
    var pading_b = EdgeInsets.only(left: 30, right: 30, top: 10);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[900],
          title: const Text('New Comparable Map'),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () async {
                if (lat != null &&
                    customergender != null &&
                    customerengname != null &&
                    customersizeother != null &&
                    customerBuildSize != null &&
                    _byesData != null &&
                    customerregistered != null &&
                    customerpropertybankname != null &&
                    customerservicechargeunpaid != null &&
                    customerstartdate != null &&
                    customerenddate != null &&
                    customerinspector != null &&
                    customerassigned != null &&
                    customerproperty != null &&
                    customerinspectors != null) {
                  _waiting = 'await';
                  posts();
                  print('Post');
                } else {
                  print('More Option');
                }

                // update_new();
              },
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(255, 32, 167, 8)),
                child: Text(
                  'Save',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.textScaleFactorOf(context) * 17),
                ),
              ),
            ),
          ],
        ),
        // Name(customerengname + customergender = )
        body: (_waiting == 'await')
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
                      fontSize: MediaQuery.of(context).size.height * 0.025),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    (lat != null)
                        ? InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Map_verbal_address_Sale(
                                    get_province: (value) {
                                      setState(() {
                                        provice_map = value.toString();
                                      });
                                    },
                                    get_district: (value) {
                                      setState(() {
                                        district_map = value.toString();
                                      });
                                    },
                                    get_commune: (value) {
                                      setState(() {
                                        cummune_map = value.toString();
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
                                  );
                                },
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 30, left: 30, bottom: 10),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1)),
                                width: double.infinity,
                                child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$log&zoom=20&size=720x720&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                    )),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Map_verbal_address_Sale(
                                    get_province: (value) {
                                      setState(() {
                                        provice_map = value.toString();
                                      });
                                    },
                                    get_district: (value) {
                                      setState(() {
                                        district_map = value.toString();
                                      });
                                    },
                                    get_commune: (value) {
                                      setState(() {
                                        cummune_map = value.toString();
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
                                  );
                                },
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 30, left: 30, bottom: 10),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1)),
                                width: double.infinity,
                                child: const Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      'https://as1.ftcdn.net/v2/jpg/01/82/41/00/1000_F_182410090_u28pNa09PcegnESG1HMabetiQGKrlAOV.jpg',
                                    )),
                              ),
                            ),
                          ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 30, left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _log,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.015,
                                  fontWeight: FontWeight.bold),
                              onChanged: (value) {
                                setState(() {
                                  // bankcontact = value;
                                  log = _log!.text;
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.numbers_outlined,
                                  color: kImageColor,
                                ),
                                hintText: "log",
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),

                                fillColor: kwhite,
                                // hintText: (bankcontact == null || bankcontact == '')
                                //     ? '${widget.list![index_edit]['bankcontact'].toString()}'
                                //     : bankcontact,
                                filled: true,
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
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _lat,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.015,
                                  fontWeight: FontWeight.bold),
                              onChanged: (value) {
                                setState(() {
                                  // bankcontact = value;
                                  lat = _lat!.text;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "lat",
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                prefixIcon: const Icon(
                                  Icons.numbers_outlined,
                                  color: kImageColor,
                                ),
                                fillColor: kwhite,
                                // hintText: (bankcontact == null || bankcontact == '')
                                //     ? '${widget.list![index_edit]['bankcontact'].toString()}'
                                //     : bankcontact,
                                filled: true,
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
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: pading_b,
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              //value: genderValue,
                              isExpanded: true,
                              onChanged: (newValue) {
                                setState(() {
                                  customergender = newValue.toString();
                                });
                              },
                              items: _list_getnder
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value["gender_id"].toString(),
                                      child: Text(value["gendername"]),
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
                                labelStyle: sizefont,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                fillColor: kwhite,
                                filled: true,
                                labelText: 'Gender*',
                                hintText: 'Gender*',
                                prefixIcon: const Icon(
                                  Icons.discount_outlined,
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
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.015,
                                  fontWeight: FontWeight.bold),
                              onChanged: (value) {
                                setState(() {
                                  customerengname = value.toString();
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: kImageColor,
                                ),
                                hintText: 'Customer Name*',
                                fillColor: kwhite,
                                filled: true,
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    payment_first(
                      controller1: null,
                      controller2: null,
                      OR_N: '$ARF_code-$ARF_ID_GET',
                      hintTexts: 'In Khmer',
                      First_Pay: (value) {},
                      hintText: (value) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ////////////tver dol ng tel
                    payment_first(
                      controller1: null,
                      controller2: null,
                      OR_N: 'VAT TIN',
                      hintTexts: 'Tel',
                      First_Pay: (value) {
                        setState(() {
                          customerphones = value.toString();
                        });
                      },
                      hintText: (value) {
                        setState(() {
                          customervat = value.toString();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    payment_first(
                      controller1: null,
                      controller2: null,
                      OR_N: 'Building Size *',
                      hintTexts: 'Size *',
                      First_Pay: (value) {
                        setState(() {
                          customersizeother = value.toString();
                        });
                      },
                      hintText: (value) {
                        setState(() {
                          customerBuildSize = value.toString();
                        });
                      },
                    ),

                    //Image Customer
                    if (_byesData != null)
                      Column(
                        children: [
                          if (get_bytes == null)
                            Image.memory(
                              _byesData!,
                              height: 250,
                              width: double.infinity,
                            )
                          else
                            Image.memory(
                              get_bytes!,
                              height: 250,
                              width: double.infinity,
                            ),
                          IconButton(
                              onPressed: () {
                                _cropImage();
                              },
                              icon: const Icon(
                                Icons.crop,
                                size: 35,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                    InkWell(
                      onTap: () {
                        OpenImgae();
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 30, left: 30, top: 10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 1, color: kPrimaryColor)),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.image,
                                  color: kImageColor,
                                  size: 30,
                                ),
                                Text(
                                  '   Select Image*',
                                  style: TextStyle(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    for (int i = 0; i < option.length; i++)
                      Padding(
                        padding: pading_b,
                        child: Container(
                          child: TextFormField(
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                                fontWeight: FontWeight.bold),
                            onChanged: (value) {
                              setState(() {
                                if (i == 0) {
                                  customerphoness = value.toString();
                                } else if (i == 1) {
                                  customercontactname = value;
                                }
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              prefixIcon: optionIconList.elementAt(i),
                              hintText: option.elementAt(i).toString(),
                              fillColor: kwhite,
                              filled: true,
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
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(
                      height: 10,
                    ),
                    property_hoemtype(
                      hometype: (value) {
                        setState(() {
                          customerproperty = value.toString();
                        });
                      },
                      hometype_lable: property_type,
                    ),
                    Padding(
                      padding: pading,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              customerpropertyaddress = value.toString();
                            });
                          },
                          maxLines: 3,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Property Location *',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    // Province_dropdown(
                    //   cummone_id0: null,
                    //   district_id0: null,
                    //   province_id0: null,
                    //   provicne_id: (value) {
                    //     setState(() {
                    //       customerprovince_id = value.toString();
                    //     });
                    //   },
                    //   cummone_id: (value) {
                    //     setState(() {
                    //       customercommune_id = value.toString();
                    //     });
                    //   },
                    //   district_id: (value) {
                    //     setState(() {
                    //       customerdistrict_id = value.toString();
                    //     });
                    //   },
                    // ),
                    Padding(
                      padding: pading_bt,
                      child: Container(
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          //value: genderValue,
                          onChanged: (newValue) {
                            setState(() {
                              customerregistered = newValue.toString();
                            });
                          },
                          value: name_customer,
                          items: _list_Registered_By
                              .map<DropdownMenuItem<String>>(
                                (value) => DropdownMenuItem<String>(
                                  value: value["person_id"].toString(),
                                  child: Text(
                                    value["assiigned_name"],
                                    style: TextStyle(
                                        fontSize: MediaQuery.textScaleFactorOf(
                                                context) *
                                            13,
                                        height: 0.1),
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
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 8),
                            labelText: 'Registered By *',
                            hintText: 'Registered By ',
                            prefixIcon: const Icon(
                              Icons.app_registration_sharp,
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
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: pading_b,
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              //value: genderValue,
                              onChanged: (newValue) {
                                setState(() {
                                  customercasefrom = newValue.toString();
                                });
                              },
                              value: _case,
                              items: cases
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value["numer_id"].toString(),
                                      child: Text(
                                        value["type"].toString(),
                                        style: TextStyle(
                                            fontSize:
                                                MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    13,
                                            height: 0.1),
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
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                labelText: 'case',
                                hintText: 'case',
                                prefixIcon: const Icon(
                                  Icons.app_registration_sharp,
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
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              controller:
                                  todate, //editing controller of this TextField
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: kImageColor,
                                  size: MediaQuery.of(context).size.height *
                                      0.025,
                                ), //icon of text field
                                labelText: "${formattedDate}",
                                fillColor: kwhite,
                                filled: true,
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
                                  formattedDate = DateFormat('yyyy-MM-dd')
                                      .format(pickedDate);

                                  setState(() {
                                    todate.text = formattedDate!;
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Bank
                    BankDropdown(
                      bank: (value) {
                        setState(() {
                          customerpropertybankname = value.toString();
                        });
                      },
                      bankbranch: (value) {
                        setState(() {
                          customerpropertybankbranch = value.toString();
                        });
                      },
                    ),
                    for (int j = 0; j < bank.length; j++)
                      Padding(
                        padding: pading,
                        child: Container(
                          child: TextFormField(
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                                fontWeight: FontWeight.bold),
                            onChanged: (value) {
                              setState(() {
                                if (j == 0) {
                                  officer_name = value.toString();
                                } else if (j == 1) {
                                  office_tell = value.toString();
                                }
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              prefixIcon: bank_branch.elementAt(j),
                              hintText: bank.elementAt(j).toString(),
                              fillColor: kwhite,
                              filled: true,
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
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: pading_bt,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              // controller: _Account_Receivable,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                                fontWeight: FontWeight.bold,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _controllerA =
                                      TextEditingController(text: '$value');
                                  _updateTotal();
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                prefixIcon: const Icon(
                                  Icons.feed_outlined,
                                  color: kImageColor,
                                ),
                                hintText: "Total Fee Charge *",
                                fillColor: kwhite,
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
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              // controller: _controllerD,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                hintText: (Total_Fee_dok != null)
                                    ? "   $Total_Fee_dok"
                                    : "   Account Receivable (A/R)",
                                fillColor: kwhite,
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
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    payment_first(
                      controller1: null,
                      controller2: null,
                      OR_N: 'OR N',
                      hintTexts: 'First pay',
                      First_Pay: (value) {
                        setState(() {
                          payfirst = value;
                          _controllerB = TextEditingController(text: '$value');

                          // Total_Fee_dok = _controllerC.text;
                          _updateTotal();
                        });
                      },
                      hintText: (value) {
                        setState(() {
                          customerorn = value.toString();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    payment_first(
                      controller1: null,
                      controller2: null,
                      OR_N: 'Pain_by',
                      hintTexts: 'Invoice',
                      First_Pay: (value) {
                        setState(() {
                          CustomerInvoice = value.toString();
                        });
                      },
                      hintText: (value) {
                        setState(() {
                          paid_by = value.toString();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Final Date
                    // Date_click(
                    //   date: (value) {
                    //     setState(() {
                    //       date_dayment = value.toString();
                    //     });
                    //   },
                    // ),
                    payment_first(
                      controller1: null,
                      controller2: null,
                      OR_N: 'OR N',
                      hintTexts: 'Final pay',
                      First_Pay: (value) {
                        setState(() {
                          _controllerC = TextEditingController(text: '$value');
                          _updateTotal();
                        });
                      },
                      hintText: (value) {
                        setState(() {
                          customerorns = value.toString();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    payment_first(
                      controller1: null,
                      controller2: null,
                      OR_N: 'Paid bys',
                      hintTexts: 'Invoice',
                      First_Pay: (value) {
                        setState(() {
                          CustomerInvoices = value.toString();
                        });
                      },
                      hintText: (value) {
                        setState(() {
                          paid_bys = value.toString();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Date_click(
                    //   date: (value) {
                    //     setState(() {
                    //       second_date_payment = value.toString();
                    //     });
                    //   },
                    // ),
                    payment_first(
                      controller1: null,
                      controller2: null,
                      OR_N: 'Instructor Tell',
                      hintTexts: 'Instructor Name',
                      First_Pay: (value) {
                        setState(() {
                          Instructor_Name = value;
                        });
                      },
                      hintText: (value) {
                        setState(() {
                          Instructor_Tel = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            padding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              onChanged: (newValue) {
                                setState(() {
                                  customerappraisalname = newValue.toString();
                                });
                              },
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select bank';
                                }
                                return null;
                              },
                              items: _list_appraiser
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value["person_id"].toString(),
                                      child: Text(
                                        value["Appraiser_name"],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.012,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: kImageColor,
                              ),
                              decoration: InputDecoration(
                                labelStyle: sizefont,
                                fillColor: kwhite,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                labelText: 'Appraiser',
                                hintText: 'Appraiser',
                                prefixIcon: const Icon(
                                  Icons.real_estate_agent_outlined,
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
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 0),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              onChanged: (newValue) {
                                setState(() {
                                  accompany = newValue.toString();
                                });
                              },
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select bank';
                                }
                                return null;
                              },
                              items: _list_Accompany_by
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value["person_id"].toString(),
                                      child: Text(
                                        value["Accompany_by_name"],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.012,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: kImageColor,
                              ),
                              decoration: InputDecoration(
                                labelStyle: sizefont,
                                fillColor: kwhite,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                labelText: 'Accompany by',
                                hintText: 'Accompany by',
                                prefixIcon: const Icon(
                                  Icons.real_estate_agent_outlined,
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
                          ),
                        ),
                      ],
                    ),

                    /// Start day and End day
                    Padding(
                      padding: pading,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('End Date*  -  Start Date*  = ',
                                  style: sizefont),
                              Text(
                                  selectedStartDate != null &&
                                          selectedEndDate != null &&
                                          selectedEndDate!
                                                  .difference(
                                                      selectedStartDate!)
                                                  .inDays >=
                                              0
                                      ? ' (${selectedEndDate!.difference(selectedStartDate!).inDays} days)'
                                      : '( ? )',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      color: Colors.red)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: pading,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              controller:
                                  start_date, //editing controller of this TextField
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: kImageColor,
                                  size: MediaQuery.of(context).size.height *
                                      0.025,
                                ), //icon of text field
                                labelText: 'Start Date *',
                                // labelText: "${formattedDate}",
                                fillColor: kwhite,
                                filled: true,
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
                                ), //label text of field
                              ),
                              readOnly:
                                  true, //set it true, so that user will not able to edit text
                              onTap: () async {
                                selectedStartDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));

                                if (selectedStartDate != null) {
                                  customerstartdate = DateFormat('yyyy-MM-dd')
                                      .format(selectedStartDate!);

                                  setState(() {
                                    start_date.text = customerstartdate!;
                                    customerdatetotal = selectedEndDate!
                                        .difference(selectedStartDate!)
                                        .inDays
                                        .toString();
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                                if (selectedEndDate!
                                        .difference(selectedStartDate!)
                                        .inDays <
                                    0) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: 'Error',
                                    desc: "Please check ",
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: Colors.red,
                                  ).show();
                                } else {}
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              controller:
                                  end_date, //editing controller of this TextField
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: kImageColor,
                                  size: MediaQuery.of(context).size.height *
                                      0.025,
                                ), //icon of text field
                                // labelText: "${formattedDate}",
                                labelText: 'End Date *',
                                fillColor: kwhite,
                                filled: true,
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
                                ), //label text of field
                              ),
                              readOnly:
                                  true, //set it true, so that user will not able to edit text
                              onTap: () async {
                                selectedEndDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));

                                if (selectedEndDate != null) {
                                  customerenddate = DateFormat('yyyy-MM-dd')
                                      .format(selectedEndDate!);

                                  setState(() {
                                    end_date.text = customerenddate!;
                                    customerdatetotal = selectedEndDate!
                                        .difference(selectedStartDate!)
                                        .inDays
                                        .toString();
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                                if (selectedEndDate!
                                        .difference(selectedStartDate!)
                                        .inDays <
                                    0) {
                                  setState(() {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.rightSlide,
                                      headerAnimationLoop: false,
                                      title: 'Please Check',
                                      desc:
                                          "You should Input (Start date < End Date)",
                                      btnOkOnPress: () {},
                                      btnOkIcon: Icons.cancel,
                                      btnOkColor: Colors.red,
                                    ).show();
                                  });
                                } else {}
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              onChanged: (newValue) {
                                setState(() {
                                  customerinspector = newValue.toString();
                                });
                              },
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select';
                                }
                                return null;
                              },
                              items: _list_Inspector
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value["person_id"].toString(),
                                      child: Text(
                                        value["Inspector_name"],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.012,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: kImageColor,
                              ),
                              decoration: InputDecoration(
                                labelStyle: sizehintext,
                                fillColor: kwhite,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                labelText: 'Inspector Name *',
                                hintText: 'Inspector Name *',
                                prefixIcon: const Icon(
                                  Icons.real_estate_agent_outlined,
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
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 0),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              onChanged: (newValue) {
                                setState(() {
                                  customerinspectors = newValue.toString();
                                });
                              },
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select';
                                }
                                return null;
                              },
                              items: _list_Inspectors
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value["person_id"].toString(),
                                      child: Text(
                                        value["Inspectors_name"],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.012,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: kImageColor,
                              ),
                              decoration: InputDecoration(
                                labelStyle: sizehintext,
                                fillColor: kwhite,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                labelText: 'Inspectors Name *',
                                hintText: 'Inspectors Name *',
                                prefixIcon: const Icon(
                                  Icons.real_estate_agent_outlined,
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
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: pading_t,
                      child: Container(
                        child: TextField(
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.015,
                          ),
                          controller:
                              Inspecting_date, //editing controller of this TextField
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: kImageColor,
                              size: MediaQuery.of(context).size.height * 0.025,
                            ), //icon of text field
                            labelText: 'Inspecting Date',
                            // labelText: "${formattedDate}",
                            fillColor: kwhite,
                            filled: true,
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
                              customerinspectingdate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                Inspecting_date.text = customerinspectingdate!;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: pading_bt,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    customerassigned = newValue.toString();
                                  });
                                },
                                validator: (String? value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Please select';
                                  }
                                  return null;
                                },
                                items: _list_assigned_By
                                    .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem<String>(
                                        value: value["person_id"].toString(),
                                        child: Text(
                                          value["assiigned_name"],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.012,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: kImageColor,
                                ),
                                decoration: InputDecoration(
                                  labelStyle: sizehintext,
                                  fillColor: kwhite,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 8),
                                  labelText: 'Assigned By*',
                                  hintText: 'Assigned By*',
                                  prefixIcon: Icon(
                                    Icons.real_estate_agent_outlined,
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
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              controller:
                                  assigndate, //editing controller of this TextField
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: kImageColor,
                                  size: MediaQuery.of(context).size.height *
                                      0.025,
                                ), //icon of text field
                                // labelText: "${formattedDate}",
                                labelText: 'Assigned Date',
                                fillColor: kwhite,
                                filled: true,
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
                                  customerassigneddate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);

                                  setState(() {
                                    assigndate.text = customerassigneddate!;
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: pading_t,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              customerremark = value.toString();
                            });
                          },
                          maxLines: 3,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Remark',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }

  // Image select file
  File? _imageFile;
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        print(_imageFile);
      });
    }
  }

  String ARF_ID_GET = '';
  List _ARF_List = [];

  void ARF_last_ID() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/AFR_ID_Get'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        _ARF_List = jsonData;
        var _ARF_ID_GET = int.parse(_ARF_List[0]['arf_id'].toString()) + 1;
        ARF_ID_GET = _ARF_ID_GET.toString();
        yyy_formart();
      });
    }
  }

  List _list_getnder = [];
  void Gender_dropdown() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Gender_model'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body)['data'];
      setState(() {
        _list_getnder = jsonData;
      });
    }
  }

  void ARF_ID() async {
    Map<String, dynamic> payload = await {
      'arf_id': ARF_ID_GET,
      'customer_status': 1,
    };

    final url = await Uri.parse(
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

  XFile? _file;
  Uint8List? imagebytes;
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  Uint8List? _selectedFile;
  Uint8List? _byesData;

  String imageUrl = '';
  Uint8List? get_bytes;

  late File croppedFile;
  OpenImgae() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files!.elementAt(0);
      final reader = html.FileReader();
      WebUiSettings settings;
      reader.onLoadEnd.listen((event) {
        setState(() {
          _byesData =
              Base64Decoder().convert(reader.result.toString().split(',').last);
          _selectedFile = _byesData;
          croppedFile = File.fromRawPath(_byesData!);
          imageUrl = html.Url.createObjectUrlFromBlob(file.slice());
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  final completer = Completer<Uint8List>();
  html.File? cropimage_file;
  String? _uploadedBlobUrl;
  String? _croppedBlobUrl;
  Future<void> _cropImage() async {
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
      cropimage_file = html.File([blob], 'cropped-image.png');
      get_bytes = Uint8List.fromList(bytes);
      // await
      setState(() {
        _croppedBlobUrl = croppedFile.path;
        saveBlobToFile(_croppedBlobUrl!, croppedFile.path);
      });

      if (cropimage_file != null) {}
    }
  }

  Future<void> saveBlobToFile(String blobUrl, String filename) async {
    final response = await http.get(Uri.parse(blobUrl));
    final bytes = response.bodyBytes;

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/$filename";
  }

  Future<void> _name() async {
    await Future.wait([
      Registered_By(),
      appraiser(),
      Inspector(),
      Inspectors(),
      assigned_By(),
      Accompany_by()
    ]);
  }

  List _list_Registered_By = [];
  Future<void> Registered_By() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Registered_By/name'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        _list_Registered_By = jsonBody;
        setState(() {
          _list_Registered_By;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  List _list_appraiser = [];
  Future<void> appraiser() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/appraiser/name'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        _list_appraiser = jsonBody;
        setState(() {
          _list_appraiser;
        });
      } else {
        print('Error appraiser');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  List _list_Inspector = [];
  Future<void> Inspector() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Inspector/name'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        _list_Inspector = jsonBody;
        setState(() {
          _list_Inspector;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  List _list_Inspectors = [];
  Future<void> Inspectors() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Inspectors/name'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        _list_Inspectors = jsonBody;
        setState(() {
          _list_Inspectors;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  List _list_assigned_By = [];
  Future<void> assigned_By() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/assigned_By/name'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        _list_assigned_By = jsonBody;
        setState(() {
          _list_assigned_By;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }

  List _list_Accompany_by = [];
  Future<void> Accompany_by() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Accompany_by/name'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body)['data'];
        _list_Accompany_by = jsonBody;
        setState(() {
          _list_Accompany_by;
        });
      } else {
        print('Error bank_dristrict');
      }
    } catch (e) {
      print('Error bank_dristrict $e');
    }
  }
}
