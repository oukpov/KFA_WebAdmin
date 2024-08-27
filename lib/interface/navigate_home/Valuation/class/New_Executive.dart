// ignore_for_file: unused_element, unused_local_variable, unused_field, unnecessary_null_comparison, prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:universal_html/html.dart' as html;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/animation/gf_animation.dart';
import 'package:getwidget/types/gf_animation_type.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../components/L_w_total.dart';
import '../../../../components/colors.dart';
import '../../../../models/executive/ComparableMap.dart';
import '../../../../models/executive/buiding_executive.dart';
import '../../../../models/executive/executive.dart';
import '../componen/textInput.dart';

import '../google_map/Table.dart';
import '../google_map/google_map.dart';
import '../land_building/LandBuilding.dart';
import '../LandAppraiser/landbuilding_appraiser.dart';

class New_Executive extends StatefulWidget {
  const New_Executive({super.key});

  @override
  State<New_Executive> createState() => _New_ExecutiveState();
}

class _New_ExecutiveState extends State<New_Executive>
    with SingleTickerProviderStateMixin {
  TextEditingController fromdate = TextEditingController();
  TextEditingController Valuation = TextEditingController();
  TextEditingController Issue = TextEditingController();
  TextEditingController todate = TextEditingController();
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    requestmap = companyMap(
      propertyTypeName: '',
      provincesName: '',
      districtName: '',
      communeName: '',
      comparableId: '',
      comparableSurveyDate: '',
      comparablePropertyId: '',
      comparableLandLength: '',
      comparableLandWidth: '',
      comparableLandTotal: '',
      comparableSoldLength: '',
      comparableSoldWidth: '',
      comparableSoldTotal: '',
      comparableAddingPrice: '',
      comparableAddingTotal: '',
      comparableSoldPrice: '',
      comparablePhone: '',
      comparableSoldTotalPrice: '',
      comparableConditionId: '',
      comparableYear: '',
      comparableAddress: '',
      comparableProvinceId: '',
      comparableDistrictId: '',
      comparableCommuneId: '',
      comparableRemark: '',
      comparableaddprice: '',
      comparableaddpricetotal: '',
      comparableboughtprice: '',
      comparableAmount: '',
      latlongLog: '',
      latlongLa: '',
      comparablUser: '',
      comparableCon: '',
      comparableboughtpricetotal: '',
      compareBankId: '',
      compareBankBranchId: '',
      comBankofficer: '',
      comBankofficerContact: '',
      comparableRoad: '',
      distance: '',
    );
    frist_switch = 'one';
    // switchValues = List<bool>.generate(list_map.length, (index) => false);
    requestModelbuildng = BuildingRequestModel(
        // executive_id: 0,
        executiveStatus: 1,
        executive_address: '',
        executive_app: 0,
        executive_approvel: 0,
        executive_building: '',
        executive_by: 0,
        executive_com: 0,
        executive_comment: '',
        executive_commune_id: 0,
        executive_create_by: 0,
        executive_customer_id: 0,
        executive_district_id: 0,
        executive_fair: '',
        executive_fire: '',
        executive_forced: '',
        executive_land_lengh: '',
        executive_land_price: '',
        executive_land_price_per: '',
        executive_land_total: '',
        executive_land_width: '',
        executive_lng: '',
        executive_lon: '',
        executive_market_max: '',
        executive_market_min: '',
        executive_modify_by: 0,
        executive_modify_date: '',
        executive_name: 0,
        executive_obligation: '',
        executive_property_name: '',
        executive_property_type_id: 0,
        executive_province_id: 0,
        executive_published: 1,
        executive_purpose: '',
        executive_remark: '',
        executive_remarks: '',
        executive_road_type_id: 0,
        executive_user: '',
        executive_valuate_id: 0,
        executive_valuation_date: '',
        executive_valuation_issue_date: '',
        executive_zone_id: 0,
        executiveapprove1status: 0,
        executivestatusid: 1,
        remember_token: '',
        building: [],
        appriaser: [],
        conparable_map: []
        // autoVerbal: [requestModelVerbal],
        // data: requestModelVerbal,
        );
    _Customer_name();
    _hometype();
    lastID();
    zoning();
    _road();
    today_formart();
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 645), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.repeat();
    offsetAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: const Offset(0, -0.3),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));
  }

  late companyMap requestmap;
  late BuildingRequestModel requestModelbuildng;
  String? reloard = '1';
  List customer_name = [];
  List raod_name = [];
  String? ds;
  String? build_size;
  String? build_price;
  String? price_per;
  String? Raod_id;
  String? land;
  String? total;
  String? _customer_name;
  String? _property;
  String? _zoning;
  String? formattedDate;
  String LastID = '';
  void today_formart() {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(now);
  }

  final _formKey = GlobalKey<FormState>();
  Future<void> remove() async {
    for (int d = 0; d < listisSelected.length; d++) {
      if (listisSelected[d]['select'] == false) {
        listTable.removeWhere((item) =>
            item['comparable_id'] == listisSelected[d]['comparable_id']);
        widgetList.removeWhere((item) =>
            item['propertycomparable_com_id'] ==
            listisSelected[d]['comparable_id']);
        listisSelected.removeWhere((item) =>
            item['comparable_id'] == listisSelected[d]['comparable_id']);
      }
    }
  }

  String provinceID = '';
  String DistrictID = '';
  String CummuneID = '';
  void lastID() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/ex_last/id'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        ID_List = jsonData;

        LastID = ID_List[0]['executive_id'].toString();
      });
    }
  }

  bool message = false;
  String? frist_switch;
  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height * 0.07;
    double _w = MediaQuery.of(context).size.width * 0.2;
    var pading_r_l_t = EdgeInsets.only(right: 30, left: 30, top: 10);
    var pading_r_l_t_b =
        EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 10);
    var _Sizebox_w = SizedBox(
      width: 10,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        centerTitle: true,
        title: Text('New Executive ${LastID == "null" ? "" : "($LastID)"}'),
        // title: Text('$id_only'),
        actions: [
          InkWell(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                await remove();
                await remove();
                message = true;
                // await uploadImageMultiple();
                setState(() {
                  remove();
                  requestModelbuildng.conparable_map = widgetList;
                  if (requestModelbuildng.building.toString() != '[]' &&
                      requestModelbuildng.appriaser.toString() != '[]') {
                    Posts();
                    print('Save Successfuly');
                  } else {
                    print('Can not Save');
                  }
                });
              }
            },
            child: Container(
              height: _h,
              width: _w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Save'),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.save_alt_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: pading_r_l_t,
                child: Row(
                  children: [
                    _dropdown('', customer_name, 'Customer *', 'customer_id',
                        'customerengname', _customer_name, true),
                  ],
                ),
              ),

              Padding(
                padding: pading_r_l_t,
                child: Row(
                  children: [
                    _date(Valuation, 'Valuation Date*', 'Valuation Date*'),
                    _Sizebox_w,
                    _date(Issue, 'Issue Date*', ''),
                  ],
                ),
              ),
              Padding(
                padding: pading_r_l_t,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (requestModelbuildng.executive_valuation_date == '' &&
                        message == true)
                      Text(
                        'Valuation Date* is required',
                        style: TextStyle(color: Colors.red),
                      ),
                    _Sizebox_w,
                    if (requestModelbuildng.executive_valuation_issue_date ==
                            '' &&
                        message == true)
                      Text(
                        'Issue Date* is required',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),

              Padding(
                padding: pading_r_l_t,
                child: Row(
                  children: [
                    Input_text(
                      required: false,
                      valueBack: (value) {
                        setState(() {
                          requestModelbuildng.executive_purpose = value;
                        });
                      },
                      typeRead: false,
                      lable: 'Purpose',
                      type: false,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: pading_r_l_t,
                child: Row(
                  children: [
                    _dropdown(
                        '',
                        _list_type,
                        'Property Type *',
                        'property_type_id',
                        'property_type_name',
                        _property,
                        true),
                    _Sizebox_w,
                    _dropdown('Zoning', _list_zoning, 'Zoning', 'zoning_id',
                        'zoning_name', _zoning, false),
                  ],
                ),
              ),
              _Text('Land Size', pading_r_l_t_b),
              Land_building(
                l_get: 'new_executive_no',
                l: (value) {
                  setState(() {
                    requestModelbuildng.executive_land_lengh = value;
                  });
                },
                total: (value) {
                  setState(() {
                    requestModelbuildng.executive_land_total = value;
                  });
                },
                w: (value) {
                  setState(() {
                    requestModelbuildng.executive_land_width = value;
                  });
                },
              ),
              Padding(
                padding: pading_r_l_t,
                child: Row(
                  children: [
                    Input_text(
                      required: false,
                      valueBack: (value) {
                        setState(() {
                          requestModelbuildng.executive_land_price = value;
                        });
                      },
                      typeRead: false,
                      lable: 'Land Price',
                      type: true,
                    ),
                    _Sizebox_w,
                    Input_text(
                      required: false,
                      valueBack: (value) {
                        setState(() {
                          requestModelbuildng.executive_land_price_per = value;
                        });
                      },
                      typeRead: false,
                      lable: 'Total',
                      type: true,
                    ),
                  ],
                ),
              ),

              _Text('Market Price (Per sqr)', pading_r_l_t_b),
              Padding(
                padding: pading_r_l_t,
                child: Row(
                  children: [
                    Input_text(
                      required: false,
                      valueBack: (value) {
                        setState(() {
                          requestModelbuildng.executive_market_min = value;
                        });
                      },
                      typeRead: false,
                      lable: 'Min Price',
                      type: true,
                    ),
                    _Sizebox_w,
                    Input_text(
                      required: false,
                      valueBack: (value) {
                        setState(() {
                          requestModelbuildng.executive_market_max = value;
                        });
                      },
                      typeRead: false,
                      lable: 'Max Price',
                      type: true,
                    ),
                  ],
                ),
              ),
              build_add(),
              (requestModelbuildng.building.length != 0)
                  ? list_view(requestModelbuildng.building, '1')
                  : SizedBox(),
              SizedBox(height: 5),
              if (requestModelbuildng.building.toString() == '[]' &&
                  message == true)
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'land Building* is required',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              Appraiser_add(),
              (requestModelbuildng.appriaser.length != 0)
                  ? list_view(requestModelbuildng.appriaser, '2')
                  : SizedBox(),
              SizedBox(height: 5),
              if (requestModelbuildng.appriaser.toString() == '[]' &&
                  message == true)
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Appraiser* is required',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              Padding(
                padding: pading_r_l_t,
                child: Row(
                  children: [
                    Input_text(
                      required: false,
                      valueBack: (value) {
                        setState(() {
                          requestModelbuildng.executive_property_name = value;
                        });
                      },
                      typeRead: false,
                      lable: 'Property Name',
                      type: false,
                    ),
                    _Sizebox_w,
                    Input_text(
                      required: false,
                      valueBack: (value) {
                        setState(() {
                          requestModelbuildng.executive_obligation = value;
                        });
                      },
                      typeRead: false,
                      lable: 'Obligation Concern',
                      type: false,
                    ),
                  ],
                ),
              ),
              //////sssssssssssss
              Padding(
                padding: pading_r_l_t,
                child: Row(
                  children: [
                    Input_text(
                      required: false,
                      valueBack: (value) {
                        setState(() {
                          requestModelbuildng.executive_building = value;
                        });
                      },
                      typeRead: false,
                      lable: 'Gross Floor Area (GFA)',
                      type: true,
                    ),
                    _Sizebox_w,
                    Input_text(
                      required: false,
                      valueBack: (value) {
                        setState(() {
                          requestModelbuildng.executive_fire = value;
                        });
                      },
                      typeRead: false,
                      lable: 'Fair Market Value',
                      type: true,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: pading_r_l_t,
                child: Row(
                  children: [
                    Input_text(
                      required: false,
                      valueBack: (value) {
                        setState(() {
                          requestModelbuildng.executive_fair = value;
                        });
                      },
                      typeRead: false,
                      lable: 'Forced Sale Value',
                      type: false,
                    ),
                    _Sizebox_w,
                    Input_text(
                      required: false,
                      valueBack: (value) {
                        setState(() {
                          requestModelbuildng.executive_fair = value;
                        });
                      },
                      typeRead: false,
                      lable: 'Fire Insurance Value',
                      type: false,
                    ),
                  ],
                ),
              ),
              skc(
                  'address : ${(address == 'null') ? '' : address}',
                  'Province : ${(province_name == 'null') ? '' : province_name}',
                  'District : ${(district_name == 'null') ? '' : district_name}',
                  'Cummune : ${(cummune_name == 'null') ? '' : cummune_name}'),
              dropdown_(raod_name),
              Remark(),
              // (_images.length != 0) ? mutiple_pic() : SizedBox(),
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

              Mutiple_image_button(),
              //Pov

              Padding(
                padding: pading_r_l_t,
                child: Row(
                  children: [
                    Input_text(
                      required: true,
                      controller: lat,
                      valueBack: (value) {
                        setState(() {
                          requestModelbuildng.executive_lon = value;
                        });
                      },
                      typeRead: false,
                      lable: 'Latitude *',
                      type: true,
                    ),
                    _Sizebox_w,
                    Input_text(
                      required: true,
                      controller: log,
                      valueBack: (value) {
                        setState(() {
                          requestModelbuildng.executive_lng = log!.text;
                        });
                      },
                      typeRead: false,
                      lable: 'Longitude *',
                      type: true,
                    ),
                  ],
                ),
              ),

              google_map(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: ListView(children: [
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: MyDataTable(
                              list: listTable, listBool: listisSelected),
                        )),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List list_comeback_bool = [];
  List listComeback = [];
  TextEditingController? log;
  TextEditingController? lat;
  String? Purpose = '';

  String? executive_lon = '';
  String? executive_lng = '';

  List _list_type = [];
  void _hometype() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/properties_dropdown'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        _list_type = jsonData;
      });
    }
  }

  List _list_zoning = [];
  void zoning() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/zoning/name'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      // print(jsonData);
      // print(jsonData);

      setState(() {
        _list_zoning = jsonData;
      });
    }
  }

  List _list_comparable = [];
  void get_comparable() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_comparable/11.123123132/104.123123?start=2019-2-1&end=2023-1-1'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        _list_comparable = jsonData;
      });
    }
  }

  List ID_List = [];
  List list_comparble = [];
  List<Map<String, dynamic>> list_map = [];
  String? comparablecode = '';
  String? start = '';
  String? end = '';
  List listTable = [];
  List listisSelected = [];
  List widgetList = [];
  Widget google_map() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Map_Search_Comparable_(
                listTableB: listTable,
                listisSelectedB: listisSelected,
                widgetListB: widgetList,
                listTable: (value) {
                  setState(() {
                    listTable = value;
                  });
                },
                listisSelected: (value) {
                  setState(() {
                    listisSelected = value;
                  });
                },
                widgetList: (value) {
                  setState(() {
                    widgetList = value;
                  });
                },
                delect_first_time: (value) {},
                back_f_value: (value) {},
                executive_map_table_comback: [],
                executive_map_table: (value) {},
                list_CP: list_comparble,
                // list_comparable: (value) {
                //   setState(() {
                //     list_comparble = value;
                //     print('Pov ==> ${list_comparble.toString()}');
                //   });
                // },
                list: requestModelbuildng.conparable_map,
                listback: (value) {
                  setState(() {
                    listComeback = value;
                  });
                },
                y_lat: (value) {
                  setState(() {
                    requestModelbuildng.executive_lon = value.toString();
                    lat = TextEditingController(
                        text: '${requestModelbuildng.executive_lon}');
                    requestModelbuildng.executive_lon = lat!.text;
                  });
                },
                y_log: (value) {
                  setState(() {
                    requestModelbuildng.executive_lng = value.toString();
                    log = TextEditingController(
                        text: '${requestModelbuildng.executive_lng}');
                    requestModelbuildng.executive_lng = log!.text;
                  });
                },
                comparablecode: (value) {
                  setState(() {
                    comparablecode = value;
                  });
                },
                id: LastID,

                get_commune: (value) {},
                get_district: (value) {},
                get_lat: (value) {
                  setState(() {
                    // lat = value;
                  });
                },
                get_log: (value) {
                  setState(() {
                    // log = value;
                  });
                },
                get_max1: (value) {},
                get_max2: (value) {},
                get_min1: (value) {},
                get_min2: (value) {},
                get_province: (value) {},
              );
            },
          ));
        },
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                // color: Color.fromARGB(255, 59, 22, 169),
                borderRadius: BorderRadius.circular(10)),
            height: 200,
            child: Image.network(
              'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/Form_Image/google_maps.png',
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  List<building_execuactive> lb = [
    building_execuactive(0, '', '', '', '', 1, '')
  ];

  Widget Mutiple_image_button() {
    var pading_r_l_t = EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: pading_r_l_t,
      child: InkWell(
        onTap: OpenImgae,
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.05,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: kPrimaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: const [
              SizedBox(width: 5),
              Icon(
                Icons.image,
                color: kImageColor,
              ),
              Text(
                'Select Image *',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 23, 22, 22)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Remark() {
    var pading_r_l_t = EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: pading_r_l_t,
      child: Expanded(
        child: TextFormField(
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.015,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (value) {
            setState(() {
              requestModelbuildng.executive_remarks = value;
            });
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            prefixIcon: Icon(
              Icons.feed_outlined,
              color: kImageColor,
            ),
            hintText: 'Remark',
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
              borderSide: BorderSide(
                width: 1,
                color: kPrimaryColor,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
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

  String imageUrl = '';
  Uint8List? _selectedFile;
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

  Widget dropdown_(list) {
    var pading_r_l_t = EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: pading_r_l_t,
      child: Container(
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          onChanged: (newValue) {
            setState(() {
              requestModelbuildng.executive_road_type_id =
                  int.parse(newValue.toString());
            });
          },
          value: Raod_id,
          items: list
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value["road_id"].toString(),
                  child: Text(
                    value["road_name"].toString(),
                    style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                        height: 0.1),
                  ),
                ),
              )
              .toList(),
          icon: Icon(
            Icons.arrow_drop_down,
            color: kImageColor,
          ),
          decoration: InputDecoration(
            fillColor: kwhite,
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            labelText: 'Raod',
            hintText: 'Raod',
            prefixIcon: Icon(
              Icons.app_registration_sharp,
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
    );
  }

  Widget Appraiser_add() {
    var pading_r_l_t = EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: pading_r_l_t,
      child: InkWell(
        onTap: () {
          _asyncInputDialog(context, '');
          ++i;
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Horizon',
                    fontWeight: FontWeight.bold,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('Appraiser *'),
                    ],
                    pause: const Duration(milliseconds: 100),
                    repeatForever: true,
                  ),
                ),
              ),
              GFAnimation(
                controller: controller,
                slidePosition: offsetAnimation,
                type: GFAnimationType.slideTransition,
                child: Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                  size: 30,
                  shadows: const [Shadow(blurRadius: 5, color: Colors.black)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build_add() {
    var pading_r_l_t = EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: pading_r_l_t,
      child: InkWell(
        onTap: () {
          _asyncInputDialog(context, 'building');

          ++i;
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Horizon',
                    fontWeight: FontWeight.bold,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText(
                        'Building*',
                      ),
                    ],
                    pause: const Duration(milliseconds: 100),
                    repeatForever: true,
                  ),
                ),
              ),
              GFAnimation(
                controller: controller,
                slidePosition: offsetAnimation,
                type: GFAnimationType.slideTransition,
                child: Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                  size: 30,
                  shadows: const [Shadow(blurRadius: 5, color: Colors.black)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Posts() async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "executive_customer_id": requestModelbuildng.executive_customer_id,
      "executive_valuation_date": requestModelbuildng.executive_valuation_date,
      "executive_valuation_issue_date":
          requestModelbuildng.executive_valuation_issue_date,
      "executive_purpose": requestModelbuildng.executive_purpose,
      "executive_property_type_id":
          requestModelbuildng.executive_property_type_id,
      "executive_zone_id": requestModelbuildng.executive_zone_id,
      "executive_land_width": requestModelbuildng.executive_land_width,
      "executive_land_lengh": requestModelbuildng.executive_land_lengh,
      "executive_land_total": requestModelbuildng.executive_land_total,
      "executive_land_price": requestModelbuildng.executive_land_price,
      "executive_land_price_per": requestModelbuildng.executive_land_price_per,
      "executive_market_min": requestModelbuildng.executive_market_min,
      "executive_market_max": requestModelbuildng.executive_market_max,
      "executive_property_name": requestModelbuildng.executive_property_name,
      "executive_obligation": requestModelbuildng.executive_obligation,
      "executive_building": requestModelbuildng.executive_building,
      "executive_fire": requestModelbuildng.executive_fire,
      "executive_fair": requestModelbuildng.executive_fair,
      "executive_forced": requestModelbuildng.executive_forced,
      "executive_province_id": requestModelbuildng.executive_province_id,
      "executive_district_id": requestModelbuildng.executive_district_id,
      "executive_commune_id": requestModelbuildng.executive_commune_id,
      "executive_road_type_id": requestModelbuildng.executive_road_type_id,
      "executive_remark": requestModelbuildng.executive_remark,
      "executive_lon": requestModelbuildng.executive_lon,
      "executive_lng": requestModelbuildng.executive_lng,
      "executive_create_by": requestModelbuildng.executive_create_by,
      "building": requestModelbuildng.building,
      "appraiser": requestModelbuildng.appriaser,
      "conparable_map": requestModelbuildng.conparable_map
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/new_add',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: false,
          title: 'Save Successfuly',
          autoHide: Duration(seconds: 2),
          onDismissCallback: (type) {
            Navigator.pop(context);
          }).show();
    } else {
      print(response.statusMessage);
    }
  }

  Widget list_view(List list, lable) {
    var sizef = TextStyle(
        color: Color.fromARGB(255, 14, 64, 106),
        fontSize: MediaQuery.textScaleFactorOf(context) * 13);
    var sizefs = TextStyle(
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 46, 102, 3),
        fontSize: MediaQuery.textScaleFactorOf(context) * 13);
    var _Sizebox_h = SizedBox(
      height: 10,
    );
    var pading_r_l_t = EdgeInsets.only(right: 30, left: 30, top: 10);
    var _font = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.textScaleFactorOf(context) * 12);
    return Padding(
      padding: pading_r_l_t,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.26,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.24,
                  width: 280,
                  decoration: BoxDecoration(
                      // color: Color.fromARGB(255, 255, 254, 252),
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    (lable == '1')
                                        ? requestModelbuildng.building
                                            .removeAt(index)
                                        : requestModelbuildng.appriaser
                                            .removeAt(index);
                                  });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 166, 37, 28),
                                )),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Divider(
                            color: Color.fromARGB(255, 14, 64, 106), height: 1),
                        const SizedBox(height: 15),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (lable == '1')
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Discription',
                                            style: sizef,
                                          ),
                                          _Sizebox_h,
                                          Text(
                                            'Building Size',
                                            style: sizef,
                                          ),
                                          _Sizebox_h,
                                          Text(
                                            'Building Price',
                                            style: sizef,
                                          ),
                                          _Sizebox_h,
                                          Text(
                                            'Price Per Sqm',
                                            style: sizef,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '  :  ${(list[index]['building_des'].toString() != 'null') ? list[index]['building_des'].toString() : ''}',
                                            style: sizefs,
                                          ),
                                          _Sizebox_h,
                                          Text(
                                            '  :  ${(list[index]['building_size'].toString() != 'null') ? list[index]['building_size'].toString() : ''} sqm',
                                            style: sizefs,
                                          ),
                                          _Sizebox_h,
                                          Text(
                                            '  :  ${(list[index]['building_price'].toString() != 'null') ? list[index]['building_price'].toString() : ''} \$',
                                            style: sizefs,
                                          ),
                                          _Sizebox_h,
                                          Text(
                                            '  :  ${(list[index]['building_price_per'].toString() != 'null') ? list[index]['building_price_per'].toString() : ''} \$/sqm',
                                            style: sizefs,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Price',
                                            style: sizef,
                                          ),
                                          _Sizebox_h,
                                          Text(
                                            'Agent Name',
                                            style: sizef,
                                          ),
                                          _Sizebox_h,
                                          Text(
                                            'Remark',
                                            style: sizef,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ': ${(list[index]['appraiser_price'].toString() != 'null') ? list[index]['appraiser_price'].toString() : ''} \$',
                                            style: sizefs,
                                          ),
                                          _Sizebox_h,
                                          Text(
                                            ': ${(list[index]['agenttype_name'].toString() != 'null') ? list[index]['agenttype_name'].toString() : ''}',
                                            style: sizefs,
                                          ),
                                          _Sizebox_h,
                                          Text(
                                            ': ${(list[index]['appraiser_remark'].toString() != 'null') ? list[index]['appraiser_remark'].toString() : ''}',
                                            style: sizefs,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                      ],
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }

  List onchage_list = [];
  List onchage_list_ = [];
  int i = 0;
  Future _asyncInputDialog(BuildContext context, name) async {
    return showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          insetPadding:
              EdgeInsets.only(top: 5, left: 60, right: 60, bottom: 10),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.72,
            width: MediaQuery.of(context).size.height * 0.5,
            child: ((name == 'building'))
                ? LandBuilding_valuaction_new(
                    id: LastID,
                    list: requestModelbuildng.building,
                    listback: (value) {
                      setState(() {
                        // onchage_list = value;
                        requestModelbuildng.building = value;
                      });
                    },
                  )
                : LandBuilding_Appraiser_new(
                    id: LastID,
                    list: requestModelbuildng.appriaser,
                    listback: (value) {
                      setState(() {
                        requestModelbuildng.appriaser = value;
                      });
                    },
                  ),
          ),
        );
      },
    );
  }

  void _road() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/raod/name'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        raod_name = jsonData;
        print(raod_name.toString());
      });
    }
  }

  void _Customer_name() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Name_customer'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        customer_name = jsonData;
      });
    }
  }

  Widget _Text(text, pad) {
    return Padding(
      padding: pad,
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: MediaQuery.textScaleFactorOf(context) * 15),
      ),
    );
  }

  Widget skc(text1, text2, text3, text4) {
    var _Sizebox_h = SizedBox(
      height: 10,
    );
    var pading_r_l_t = EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: pading_r_l_t,
      child: Column(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: Color.fromARGB(255, 238, 233, 233),
          //   ),
          //   height: MediaQuery.of(context).size.height * 0.1,
          //   width: double.infinity,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(text1),
          //   ),
          // ),
          _Sizebox_h,
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.of(context).size.height * 0.06,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text2),
            ),
          ),
          _Sizebox_h,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.06,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text3),
            ),
          ),
          _Sizebox_h,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.06,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _date(contrller, labletext, date) {
    return Expanded(
      child: TextField(
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.015,
        ),
        controller: contrller, //editing controller of this TextField
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_today,
            color: kImageColor,
            size: MediaQuery.of(context).size.height * 0.025,
          ), //icon of text field
          labelText: "${labletext}",
          labelStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.013,
              fontWeight: FontWeight.bold),
          fillColor: kwhite,
          filled: true,
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
          ), //label text of field
        ),

        readOnly: true, //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            (date == 'Valuation Date*')
                ? requestModelbuildng.executive_valuation_date =
                    DateFormat('yyyy-MM-dd').format(pickedDate)
                : requestModelbuildng.executive_valuation_issue_date =
                    DateFormat('yyyy-MM-dd').format(pickedDate);

            setState(() {
              (date == 'Valuation Date*')
                  ? contrller.text =
                      requestModelbuildng.executive_valuation_date
                  : contrller.text =
                      requestModelbuildng.executive_valuation_issue_date;
            });
          } else {
            print("Date is not selected");
          }
        },
      ),
    );
  }

  Uint8List? _byesData;

  Uint8List? get_bytes;
  String? customer_id;
  String? property_id;
  String? province_name = '';
  String? province_id;
  String? district_name = '';
  String? district_id;
  String? cummune_name = '';
  String? cummune_id;
  String? address = '';
  Random random = new Random();
  Future<void> uploadImageMultiple() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/customer_images'));
    request.fields['customerID'] = LastID.toString();
    if (get_bytes != null) {
      request.files.add(await http.MultipartFile.fromBytes('image', get_bytes!,
          filename: '${random.nextInt(99)}.jpg'));
    } else {
      request.files.add(await http.MultipartFile.fromBytes('image', _byesData!,
          filename: '${random.nextInt(99)}.jpg'));
    }

    var res = await request.send();
  }

  String? Zoning;
  Widget _dropdown(
      _value, _list, lable, text_id, text_name, value_get, bool b) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        //value: genderValue,
        onChanged: (newValue) {
          setState(() {
            if (lable == 'Property Type *') {
              // property_id = newValue;
              requestModelbuildng.executive_property_type_id =
                  int.parse(newValue.toString());
            } else if (lable == 'Zoning') {
              requestModelbuildng.executive_zone_id =
                  int.parse(newValue.toString());
            } else if (lable == 'Customer *') {
              requestModelbuildng.executive_customer_id =
                  int.parse(newValue.toString());
              for (int i = 0; i < customer_name.length; i++) {
                if (newValue == customer_name[i]['customer_id'].toString()) {
                  province_name = customer_name[i]['provinces_name'].toString();
                  district_name = customer_name[i]['district_name'].toString();
                  cummune_name = customer_name[i]['commune_name'].toString();
                  requestModelbuildng.executive_address =
                      customer_name[i]['customerpropertyaddress'].toString();
                  print(
                      'provincename = $province_name || ${customer_name[i]['customerpropertyprovince']}');
                  requestModelbuildng.executive_province_id = int.parse(
                      customer_name[i]['customerpropertyprovince'].toString());
                  print(
                      'district_name = $district_name || ${customer_name[i]['customerpropertydistrict']}');
                  requestModelbuildng.executive_district_id = int.parse(
                      customer_name[i]['customerpropertydistrict'].toString());
                  print(
                      'cummune_name = $cummune_name || ${customer_name[i]['customerpropertycommune']}');
                  requestModelbuildng.executive_commune_id = int.parse(
                      customer_name[i]['customerpropertycommune'].toString());
                } else {}
              }
            }
          });
        },
        validator: (value) {
          if ((value == null || value.isEmpty) && b == true) {
            return 'Please select $lable';
          }
          return null;
        },
        value: value_get,
        items: _list
            .map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
                value: value["$text_id"].toString(),
                child: Form(
                    child: Text(
                  // value["customer_name"].toString(),
                  value['$text_name'].toString(),
                  style: TextStyle(
                      fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                      height: 0.1),
                )),
              ),
            )
            .toList(),
        // add extra sugar..
        icon: Icon(
          Icons.arrow_drop_down,
          color: kImageColor,
        ),

        decoration: InputDecoration(
          labelStyle: (lable == 'Property Type *')
              ? TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.012,
                  fontWeight: FontWeight.bold)
              : null,
          fillColor: kwhite,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 8),
          labelText: lable,
          hintText: lable,
          helperStyle: (lable == 'Property Type *')
              ? TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.012,
                  fontWeight: FontWeight.bold)
              : null,
          prefixIcon: Icon(
            Icons.app_registration_sharp,
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
    );
  }
}
