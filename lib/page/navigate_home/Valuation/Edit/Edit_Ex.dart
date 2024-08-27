// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/animation/gf_animation.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_animation_type.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import '../../../../components/L_w_total.dart';
import '../../../../components/colors.dart';
import '../../../../models/executive/Edit_Executive.dart';
import '../../../../models/executive/executive.dart';
import '../LandAppraiser/landbuilding_appraiser.dart';
import '../Model/TableSelcted.dart';
import '../componen/textInput.dart';
import '../google_map/Table.dart';
import '../google_map/google_map.dart';
import '../land_building/LandBuilding.dart';

class Detail_Executive extends StatefulWidget {
  Detail_Executive(
      {super.key, required this.list, required this.index, this.delete});
  List list = [];
  String? index;
  String? delete;
  @override
  State<Detail_Executive> createState() => _New_ExecutiveState();
}

class _New_ExecutiveState extends State<Detail_Executive>
    with SingleTickerProviderStateMixin {
  TextEditingController fromdate = TextEditingController();

  TextEditingController todate = TextEditingController();
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> offsetAnimation;

  TextEditingController? _remark;
  int indexI = 0;

  late TextEditingController customerID;
  late TextEditingController executiveValuationDate;
  late TextEditingController executiveValuationIssueDate;
  late TextEditingController executivePurpose;
  late TextEditingController executivePropertyTypeID;
  late TextEditingController executiveZoneID;
  late TextEditingController executiveLandWidth;
  late TextEditingController executiveLandLengh;
  late TextEditingController executiveLandTotal;
  late TextEditingController executiveLandPrice;
  late TextEditingController executiveLandPricePer;
  late TextEditingController executiveMarketMin;
  late TextEditingController executiveMarketMax;
  late TextEditingController executivePropertyName;
  late TextEditingController executiveObligation;
  late TextEditingController executiveBuilding;
  late TextEditingController executiveFire;
  late TextEditingController executiveFair;
  late TextEditingController executiveForced;
  late TextEditingController executiveProvinceID;
  late TextEditingController executiveDistrictID;
  late TextEditingController executiveCommuneID;
  late TextEditingController executiveRoadTypeID;
  late TextEditingController executiveRemark;
  late TextEditingController executiveapprove1status;
  late TextEditingController executiveComment;
  late TextEditingController executiveLon;
  late TextEditingController executiveLng;
  late TextEditingController executiveBy;
  late TextEditingController executiveUser;
  late TextEditingController executiveApp;
  late TextEditingController rememberToken;
  @override
  void dispose() {
    customerID.dispose();
    executiveValuationDate.dispose();
    executiveValuationIssueDate.dispose();
    executivePurpose.dispose();
    executivePropertyTypeID.dispose();
    executiveZoneID.dispose();
    executiveLandWidth.dispose();
    executiveLandLengh.dispose();
    executiveLandTotal.dispose();
    executiveLandPrice.dispose();
    executiveLandPricePer.dispose();
    executiveMarketMin.dispose();
    executiveMarketMax.dispose();
    executivePropertyName.dispose();
    executiveObligation.dispose();
    executiveBuilding.dispose();
    executiveFire.dispose();
    executiveFair.dispose();
    executiveForced.dispose();
    executiveProvinceID.dispose();
    executiveDistrictID.dispose();
    executiveCommuneID.dispose();
    executiveRoadTypeID.dispose();
    executiveRemark.dispose();
    executiveapprove1status.dispose();
    executiveComment.dispose();
    executiveLon.dispose();
    executiveLng.dispose();
    executiveBy.dispose();
    executiveUser.dispose();
    executiveApp.dispose();
    rememberToken.dispose();

    super.dispose();
  }

  List builDing = [];
  List appraiser = [];
  List conparableMap = [];
  void delete_executive() async {
    final response = await http.delete(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/delete_list_ex/${widget.list[indexI]['executive_id']}'));
    if (response.statusCode == 200) {
      setState(() {
        Navigator.pop(context);
      });
    } else {
      throw Exception('Delete error occured!');
    }
  }

  List listisSelected = [];
  List<Selected> lbTable = [Selected(0, false)];
  void loopBool() {
    setState(() {
      // print('Pov => ${conparableMap.toString()}');
      for (int i = 0; i < conparableMap.length; i++) {
        selectedMain(conparableMap[i]['comparable_id'], true);
      }
    });
  }

  void selectedMain(int comparableId, bool b) {
    listisSelected.add({
      'comparable_id': comparableId,
      'select': b,
    });
    lbTable.add(
      Selected(0, false),
    );
  }

  @override
  void initState() {
    indexI = int.parse(widget.index.toString());
    _Customer_name();
    _hometype();
    zoning();
    customerID = TextEditingController(
        text: widget.list[indexI]['executive_customer_id'].toString());
    executiveValuationDate = TextEditingController(
        text: widget.list[indexI]['executive_valuation_date'].toString());
    executivePurpose = TextEditingController(
        text: widget.list[indexI]['executive_purpose'].toString());
    executivePropertyTypeID = TextEditingController(
        text: widget.list[indexI]['executive_property_type_id'].toString());
    executiveValuationIssueDate = TextEditingController(
        text: widget.list[indexI]['executive_valuation_issue_date'].toString());
    executiveZoneID = TextEditingController(
        text: widget.list[indexI]['executive_zone_id'].toString());
    executiveLandWidth = TextEditingController(
        text: widget.list[indexI]['executive_land_width'].toString());
    executiveLandLengh = TextEditingController(
        text: widget.list[indexI]['executive_land_lengh'].toString());
    executiveLandTotal = TextEditingController(
        text: widget.list[indexI]['executive_land_total'].toString());
    executiveLandPrice = TextEditingController(
        text: widget.list[indexI]['executive_land_price'].toString());
    executiveLandPricePer = TextEditingController(
        text: widget.list[indexI]['executive_land_price_per'].toString());
    executiveMarketMin = TextEditingController(
        text: widget.list[indexI]['executive_market_min'].toString());
    executiveMarketMax = TextEditingController(
        text: widget.list[indexI]['executive_market_max'].toString());
    executivePropertyName = TextEditingController(
        text: widget.list[indexI]['executive_property_name'].toString());
    executiveObligation = TextEditingController(
        text: widget.list[indexI]['executive_obligation'].toString());
    executiveBuilding = TextEditingController(
        text: widget.list[indexI]['executive_building'].toString());
    executiveFire = TextEditingController(
        text: widget.list[indexI]['executive_fire'].toString());
    executiveFair = TextEditingController(
        text: widget.list[indexI]['executive_fair'].toString());
    executiveForced = TextEditingController(
        text: widget.list[indexI]['executive_forced'].toString());
    executiveProvinceID = TextEditingController(
        text: widget.list[indexI]['executive_province_id'].toString());
    executiveDistrictID = TextEditingController(
        text: widget.list[indexI]['executive_district_id'].toString());
    executiveCommuneID = TextEditingController(
        text: widget.list[indexI]['executive_commune_id'].toString());
    executiveRoadTypeID = TextEditingController(
        text: widget.list[indexI]['executive_road_type_id'].toString());
    executiveRemark = TextEditingController(
        text: widget.list[indexI]['executive_remark'].toString());
    executiveLon = TextEditingController(
        text: widget.list[indexI]['executive_lon'].toString());
    executiveLng = TextEditingController(
        text: widget.list[indexI]['executive_lng'].toString());
    executiveBy = TextEditingController(
        text: widget.list[indexI]['executive_by'].toString());
    executiveUser = TextEditingController(
        text: widget.list[indexI]['executive_create_by'].toString());
    _appraiser();
    _building();
    _list_map_table();
    TableMap();
    roadList();
    // agency();
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 645), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.repeat();
    offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.3),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));
  }

  Uint8List? get_bytes;
  late ExecutiveRequestModel requestModelbuildng;
  String? reloard = '1';
  List customer_name = [];
  List raod_name = [];
  String? ds;
  String? Edit_Map = 'Edit_Map';

  String? Raod_id;
  String? land;
  String? total;
  String? _customer_name;
  String? Property;
  String? _zoning;
  String? formattedDate;
  void today_formart() {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(now);
  }

  // Future<void> aWaitImage() async {
  //   setState(() {
  //     remove();
  //     remove();
  //   });
  //   await Future.wait([
  //     _updateImage_Multiple(widget.list[indexI]['executive_id'].toString()),
  //     postApiDatas(),
  //   ]);
  // }

  Future<void> aWait() async {
    setState(() {
      print('======> This');
      remove();
      remove();
    });
    await Future.wait([
      postApiDatas(),
    ]);
  }

  Uint8List? _byesData;
  String? succes;
  String? frist_switch;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height * 0.07;
    double w = MediaQuery.of(context).size.width * 0.2;
    var padingRLT = const EdgeInsets.only(right: 30, left: 30, top: 10);
    var pading_r_l_t_b =
        EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 10);
    var sizeBoxW = const SizedBox(
      width: 10,
    );
//comparable_id

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        centerTitle: true,
        title: Text('${widget.list[indexI]['executive_id']}'),
        actions: [
          InkWell(
            onTap: () async {
              setState(() {
                postApiDatas();
                // if (widget.list[indexI]['url1'].toString() == 'null' &&
                //     _images.length != 0) {
                //   aWaitImage();
                // } else if (widget.list[indexI]['url1'].toString() != 'null') {
                //   aWaitImage();
                // } else {
                //   aWait();
                // }
              });
            },
            child: Container(
              height: h,
              width: w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Edit'),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.edit),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (widget.delete == 'No_Delete')
                ? dropdown_approvals()
                : Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: GFButton(
                          elevation: 10,
                          color: const Color.fromARGB(255, 137, 10, 35),
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              title: 'Confirmation',
                              desc:
                                  'Are you sure you want to delete this item?',
                              btnOkText: 'Yes',
                              btnOkColor:
                                  const Color.fromARGB(255, 72, 157, 11),
                              btnCancelText: 'No',
                              btnCancelColor:
                                  const Color.fromARGB(255, 133, 8, 8),
                              btnOkOnPress: () {
                                setState(() {
                                  delete_executive();
                                });
                              },
                              btnCancelOnPress: () {},
                            ).show();
                          },
                          text: "Delete",
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          shape: GFButtonShape.pills,
                        ),
                      ),
                    ],
                  ),

            Text('1/customerID => ${customerID.text}'),

            Text('2/executiveValuationDate => ${executiveValuationDate.text}'),
            Text(
                'executiveValuationIssueDate => ${executiveValuationIssueDate.text}'),
            Text('3/executivePurpose => ${executivePurpose.text}'),
            Text(
                '4/executivePropertyTypeID => ${executivePropertyTypeID.text}'),
            Text('5/executiveZoneID => ${executiveZoneID.text}'),
            Text('6/executiveLandWidth => ${executiveLandWidth.text}'),
            Text('7/executiveLandLengh => ${executiveLandLengh.text}'),
            Text('8/executiveLandTotal => ${executiveLandTotal.text}'),
            Text('9/executiveLandPrice => ${executiveLandPrice.text}'),
            Text('10/executiveLandPricePer => ${executiveLandPricePer.text}'),
            Text('11/executiveMarketMin => ${executiveMarketMin.text}'),
            Text('12/executiveMarketMax => ${executiveMarketMax.text}'),
            Text('13/executivePropertyName => ${executivePropertyName.text}'),
            Text('14/executiveObligation => ${executiveObligation.text}'),
            Text('15/executiveBuilding => ${executiveBuilding.text}'),
            Text('16/executiveFire => ${executiveFire.text}'),
            Text('17/executiveFair => ${executiveFair.text}'),
            Text('18/executiveForced => ${executiveForced.text}'),
            Text('19/executiveProvinceID => ${executiveProvinceID.text}'),
            Text('20/executiveDistrictID => ${executiveDistrictID.text}'),
            Text('21/executiveCommuneID => ${executiveCommuneID.text}'),
            Text('22/executiveRoadTypeID => ${executiveRoadTypeID.text}'),
            Text('23/executiveRemark => ${executiveRemark.text}'),
            Text('24/executiveLon => ${executiveLon.text}'),
            Text('25/executiveLng => ${executiveLng.text}'),
            Text('26executiveUser => ${executiveUser.text}'),
            Text('builDing => ${builDing}'),
            Text('appraiser => ${appraiser}'),
            Text('conparableMap => ${conparableMap}'),

            Padding(
              padding: padingRLT,
              child: Row(
                children: [
                  dropDown(
                      '',
                      customer_name,
                      widget.list[indexI]['customerengname'].toString(),
                      'customer_id',
                      'customerengname',
                      _customer_name,
                      'Customer*'),
                ],
              ),
            ),

            Padding(
              padding: padingRLT,
              child: Row(
                children: [
                  _date(executiveValuationDate, executiveValuationDate.text,
                      'Valuation Date*'),
                  sizeBoxW,
                  _date(executiveValuationIssueDate,
                      executiveValuationIssueDate.text, ''),
                ],
              ),
            ),
            Padding(
              padding: padingRLT,
              child: Row(
                children: [
                  dropDown(
                      '',
                      _list_type,
                      widget.list[indexI]['property_type_name'].toString(),
                      'property_type_id',
                      'property_type_name',
                      Property,
                      'Property Type*'),
                  sizeBoxW,
                  dropDown(
                      'Zoning',
                      _list_zoning,
                      widget.list[indexI]['zoning_name'].toString(),
                      'zoning_id',
                      'zoning_name',
                      _zoning,
                      'Zoning'),
                ],
              ),
            ),
            _Text('Land Size', pading_r_l_t_b),
            Land_building(
              l_get: executiveLandLengh.text,
              l: (value) {
                setState(() {
                  executiveLandLengh.text = value;
                });
              },
              total_get: executiveLandTotal.text,
              total: (value) {
                setState(() {
                  executiveLandTotal.text = value;
                });
              },
              w_get: executiveLandWidth.text,
              w: (value) {
                setState(() {
                  executiveLandWidth.text = value;
                });
              },
            ),
            Padding(
              padding: padingRLT,
              child: Row(
                children: [
                  Input_text(
                    required: false,
                    valueBack: (value) {
                      setState(() {
                        executiveLandPrice.text = value;
                      });
                    },
                    typeRead: false,
                    lable: 'Land Price',
                    type: true,
                  ),
                  sizeBoxW,
                  Input_text(
                    required: false,
                    valueBack: (value) {
                      setState(() {
                        executiveLandPricePer.text = value;
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
              padding: padingRLT,
              child: Row(
                children: [
                  Input_text(
                    required: false,
                    valueBack: (value) {
                      setState(() {
                        executiveMarketMin.text = value;
                      });
                    },
                    typeRead: false,
                    lable: 'Min Price',
                    type: true,
                  ),
                  sizeBoxW,
                  Input_text(
                    required: false,
                    valueBack: (value) {
                      setState(() {
                        executiveMarketMax.text = value;
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
            (builDing.length != 0)
                ? list_view(builDing, '1')
                : const SizedBox(),
            Appraiser_add(),
            (appraiser.length != 0)
                ? list_view(appraiser, '2')
                : const SizedBox(),
            Padding(
              padding: padingRLT,
              child: Row(
                children: [
                  Input_text(
                    required: false,
                    valueBack: (value) {
                      setState(() {
                        executivePropertyName.text = value;
                      });
                    },
                    typeRead: false,
                    lable: 'Property Name',
                    type: false,
                  ),
                  sizeBoxW,
                  Input_text(
                    required: false,
                    valueBack: (value) {
                      setState(() {
                        executiveObligation.text = value;
                      });
                    },
                    typeRead: false,
                    lable: 'Obligation Concern',
                    type: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: padingRLT,
              child: Row(
                children: [
                  Input_text(
                    required: false,
                    valueBack: (value) {
                      setState(() {
                        executiveBuilding.text = value;
                      });
                    },
                    typeRead: false,
                    lable: 'Gross Floor Area (GFA)',
                    type: true,
                  ),
                  sizeBoxW,
                  Input_text(
                    required: false,
                    valueBack: (value) {
                      setState(() {
                        executiveFire.text = value;
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
              padding: padingRLT,
              child: Row(
                children: [
                  Input_text(
                    required: false,
                    valueBack: (value) {
                      setState(() {
                        executiveFair.text = value;
                      });
                    },
                    typeRead: false,
                    lable: 'Forced Sale Value',
                    type: false,
                  ),
                  sizeBoxW,
                  Input_text(
                    required: false,
                    valueBack: (value) {
                      setState(() {
                        executiveForced.text = value;
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
                'address : ${(widget.list[indexI]['executive_address'].toString() == 'null') ? '' : widget.list[indexI]['executive_address'].toString()}',
                'Province : ${(widget.list[indexI]['provinces_name'].toString() == 'null') ? '' : widget.list[indexI]['provinces_name'].toString()}',
                'District : ${(widget.list[indexI]['district_name'].toString() == 'null') ? '' : widget.list[indexI]['district_name'].toString()}',
                'Cummune : ${(widget.list[indexI]['commune_name'].toString() == 'null') ? '' : widget.list[indexI]['commune_name'].toString()}'),
            dropdown_(raod_name),
            Remark(),
            // if (_byesData != null)
            //   Column(
            //     children: [
            //       if (get_bytes == null)
            //         Image.memory(
            //           _byesData!,
            //           height: 250,
            //           width: double.infinity,
            //         )
            //       else
            //         Image.memory(
            //           get_bytes!,
            //           height: 250,
            //           width: double.infinity,
            //         ),
            //       IconButton(
            //           onPressed: () {
            //             _cropImage();
            //           },
            //           icon: const Icon(
            //             Icons.crop,
            //             size: 35,
            //             color: Colors.grey,
            //           )),
            //     ],
            //   ),
            // Mutiple_image_button(),
            Padding(
              padding: padingRLT,
              child: Row(
                children: [
                  Input_text(
                    required: true,
                    controller: executiveLon,
                    valueBack: (value) {
                      setState(() {
                        executiveLon.text = value;
                      });
                    },
                    typeRead: false,
                    lable: 'Latitude *',
                    type: true,
                  ),
                  sizeBoxW,
                  Input_text(
                    required: true,
                    controller: executiveLng,
                    valueBack: (value) {
                      setState(() {
                        executiveLng.text = value;
                      });
                    },
                    typeRead: false,
                    lable: 'Longitude *',
                    type: true,
                  ),
                ],
              ),
            ),
            // SizedBox(height: 15),
            // Text('Building => ${requestModelbuildng.building}'),
            // SizedBox(height: 15),
            // Text('Appraiser => ${requestModelbuildng.appriaser}'),
            // SizedBox(height: 15),
            // Text('Comparable Map => ${requestModelbuildng.conparable_map}'),
            const SizedBox(height: 10),
            googleMap(),
            const SizedBox(height: 10),
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
                            list: conparableMap, listBool: listisSelected),
                      )),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Future<void> _uploadImage_Multiple(id) async {
  //   final url = Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/executive/image');

  //   final request = http.MultipartRequest('POST', url);
  //   request.fields['executive_file_id'] = id.toString();

  //   if (_images != null) {
  //     final tempDir = await getTemporaryDirectory();
  //     final path = tempDir.path;

  //     List<File> compressedImages = [];

  //     for (int i = 0; i < _images.length; i++) {
  //       var compressedImageFile = await FlutterImageCompress.compressAndGetFile(
  //         _images[i].absolute.path,
  //         '$path/${DateTime.now().millisecondsSinceEpoch}_$i.jpg',
  //         quality: 70,
  //       );

  //       if (compressedImageFile != null) {
  //         compressedImages.add(compressedImageFile);
  //       }
  //     }

  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'image1',
  //         compressedImages[0].path,
  //       ),
  //     );
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'image2',
  //         compressedImages[1].path,
  //       ),
  //     );
  //     if (_images.length < 3) {
  //     } else {
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           'image3',
  //           compressedImages[2].path,
  //         ),
  //       );
  //     }

  //     if (_images.length < 4) {
  //     } else {
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           'image4',
  //           compressedImages[3].path,
  //         ),
  //       );
  //     }
  //   }

  //   final response = await request.send();

  //   if (response.statusCode == 200) {
  //     print('Images uploaded successfully!');
  //   } else {
  //     print('Error uploading images: ${response.reasonPhrase}');
  //   }
  // }

  // Future<void> _updateImage_Multiple(id) async {
  //   final url = Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update_ex/image/${id}');

  //   final request = http.MultipartRequest('POST', url);
  //   request.fields['executive_file_id'] = id.toString();

  //   if (_images != null) {
  //     final tempDir = await getTemporaryDirectory();
  //     final path = tempDir.path;

  //     List<File> compressedImages = [];

  //     for (int i = 0; i < _images.length; i++) {
  //       var compressedImageFile = await FlutterImageCompress.compressAndGetFile(
  //         _images[i].absolute.path,
  //         '$path/${DateTime.now().millisecondsSinceEpoch}_$i.jpg',
  //         quality: 70,
  //       );

  //       if (compressedImageFile != null) {
  //         compressedImages.add(compressedImageFile);
  //       }
  //     }

  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'image1',
  //         compressedImages[0].path,
  //       ),
  //     );
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'image2',
  //         compressedImages[1].path,
  //       ),
  //     );
  //     if (_images.length < 3) {
  //     } else {
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           'image3',
  //           compressedImages[2].path,
  //         ),
  //       );
  //     }

  //     if (_images.length < 4) {
  //     } else {
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           'image4',
  //           compressedImages[3].path,
  //         ),
  //       );
  //     }
  //   }

  //   final response = await request.send();

  //   if (response.statusCode == 200) {
  //     print('Images update successfully!');
  //   } else {
  //     print('Error uploading images: ${response.reasonPhrase}');
  //   }
  // }

  TextEditingController? _log;
  TextEditingController? _lat;
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

  void _approvals() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/executive_approvel'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        approvals_list = jsonData;
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

  String? id_only;

  List list_comparble = [];
  List<Map<String, dynamic>> list_map = [];
  String? comparablecode = '';
  String? start = '';
  String? end = '';

  Widget googleMap() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Map_Search_Comparable_(
                listTableB: conparableMap,
                listisSelectedB: listisSelected,
                widgetListB: [],
                listTable: (value) {
                  setState(() {
                    conparableMap = value;
                  });
                },
                listisSelected: (value) {
                  setState(() {
                    listisSelected = value;
                  });
                },
                widgetList: (value) {
                  setState(() {});
                },
                delect_first_time: (value) {
                  setState(() {
                    delete_first = value;
                  });
                },
                back_f_value: (value) {
                  setState(() {
                    f = value;
                  });
                },
                executive_map_table: (value) {
                  setState(() {
                    conparableMap = value;
                  });
                },

                executive_map_table_comback: conparableMap,
                list_CP: conparableMap,

                list: conparableMap,
                // list: [],
                listback: (value) {
                  setState(() {
                    conparableMap = value;
                  });
                },
                y_lat: (value) {
                  setState(() {
                    executiveLon.text = value;
                  });
                },
                y_log: (value) {
                  setState(() {
                    executiveLng.text = value;
                  });
                },
                comparablecode: (value) {
                  setState(() {
                    comparablecode = value;
                  });
                },
                id: (Edit_Map == 'Edit_Map')
                    ? widget.list[indexI]['executive_id'].toString()
                    : id_only,
                get_commune: (value) {},
                get_district: (value) {},
                get_lat: (value) {},
                get_log: (value) {},
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
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(10)),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 1,
            child: Image.network(
              'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/Form_Image/google_maps.png',
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Future<void> remove() async {
    setState(() {
      for (int d = 0; d < listisSelected.length; d++) {
        if (listisSelected[d]['select'] == false) {
          print('if');
          conparableMap.removeWhere((item) =>
              item['comparable_id'] = listisSelected[d]['comparable_id']);
        } else {
          print('else');
        }
      }
    });
  }

  List<building_execuactive> lb = [
    building_execuactive(0, '', '', '', '', 1, '')
  ];
  void deleteItemToList(int Id) {
    setState(() {
      // print(requestModelbuildng.building.length.toString());
      // requestModelbuildng.building != list;
      // requestModelbuildng.building.removeAt(Id);
      lb.removeAt(int.parse(Id.toString()));
    });
  }

  Future<void> postApiDatas2() async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "executive_customer_id": "977",
      "executive_valuation_date": "2021-12-23",
      "executive_valuation_issue_date": "2021-12-24",
      "executive_purpose": "Secure Lending",
      "executive_property_type_id": "36",
      "executive_zone_id": "0",
      "executive_land_width": null,
      "executive_land_lengh": null,
      "executive_land_total": "138",
      "executive_land_price": "386400",
      "executive_land_price_per": "2800",
      "executive_market_min": null,
      "executive_market_max": null,
      "executive_property_name": null,
      "executive_obligation": null,
      "executive_building": "424.50",
      "executive_fire": "106606",
      "executive_fair": "345104",
      "executive_forced": "345104",
      "executive_province_id": null,
      "executive_district_id": null,
      "executive_commune_id": null,
      "executive_road_type_id": "0",
      "executive_remark": null,
      "executive_lon": "11.5501",
      "executive_lng": "104.9123123",
      "executive_create_by": null,
      "building": [
        {
          "building_executive_id": "587",
          "building_size": "66.75",
          "building_price": "150.00",
          "building_price_per": "10012.50",
          "building_des": "1"
        }
      ],
      "appraiser": [
        {
          "appraiser_executiveid": "587",
          "appraiser_agent_id": "1",
          "appraiser_position": "1",
          "appraiser_price": "1",
          "appraiser_remark": "1"
        }
      ],
      "conparable_map": [
        {
          "propertycomparable_executive_id": "587",
          "propertycomparable_com_id": "1444",
          "propertycomparable_status": "1"
        }
      ]
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update_executive/587',
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

  Future<void> postApiDatas() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update_executive/${widget.list[indexI]['executive_id']}'));
    request.body = json.encode({
      "executive_customer_id": "977",
      "executive_valuation_date": "2021-12-23",
      "executive_valuation_issue_date": "2021-12-24",
      "executive_purpose": "Secure Lending",
      "executive_property_type_id": "36",
      "executive_zone_id": "0",
      "executive_land_width": "0",
      "executive_land_lengh": "0",
      "executive_land_total": "138",
      "executive_land_price": "386400",
      "executive_land_price_per": "2800",
      "executive_market_min": "0",
      "executive_market_max": "0",
      "executive_property_name": "0",
      "executive_obligation": "0",
      "executive_building": "424.50",
      "executive_fire": "106606",
      "executive_fair": "345104",
      "executive_forced": "345104",
      "executive_province_id": "0",
      "executive_district_id": "0",
      "executive_commune_id": "0",
      "executive_road_type_id": "0",
      "executive_remark": "0",
      "executive_lon": "11.5501",
      "executive_lng": "104.9123123",
      "executive_create_by": "0",
      // "executive_customer_id": customerID.text,
      // "executive_valuation_date": executiveValuationDate.text,
      // "executive_valuation_issue_date": executiveValuationIssueDate.text,
      // "executive_purpose": executivePurpose.text,
      // "executive_property_type_id": executivePropertyTypeID.text,
      // "executive_zone_id": executiveZoneID.text,
      // "executive_land_width": executiveLandWidth.text,
      // "executive_land_lengh": executiveLandLengh.text,
      // "executive_land_total": executiveLandTotal.text,
      // "executive_land_price": executiveLandPrice.text,
      // "executive_land_price_per": executiveLandPricePer.text,
      // "executive_market_min": executiveMarketMin.text,
      // "executive_market_max": executiveMarketMax.text,
      // "executive_property_name": executivePropertyName.text,
      // "executive_obligation": executiveObligation.text,
      // "executive_building": executiveBuilding.text,
      // "executive_fire": executiveFire.text,
      // "executive_fair": executiveFair.text,
      // "executive_forced": executiveForced.text,
      // "executive_province_id": executiveProvinceID.text,
      // "executive_district_id": executiveDistrictID.text,
      // "executive_commune_id": executiveCommuneID.text,
      // "executive_road_type_id": executiveRoadTypeID.text,
      // "executive_remark": executiveRemark.text,
      // "executive_lon": executiveLon.text,
      // "executive_lng": executiveLng.text,
      // "executive_create_by": executiveUser.text,
      "building": [],
      "appraiser": [],
      "conparable_map": []
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: false,
          title: 'Save Successfuly',
          autoHide: const Duration(seconds: 2),
          onDismissCallback: (type) {
            Navigator.pop(context);
          }).show();
    } else {
      print(response.reasonPhrase);
    }
  }

  List data = [];
  List<String> _imageUrls = [];
  bool _isLoading = true;
  Future<void> fetchImageUrls() async {
    final response = await http.get(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/image_executive_by/${widget.list[indexI]['executive_id'].toString()}'),
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);

      final Map<String, dynamic> imageData = data.first;

      setState(() {
        _imageUrls = [
          imageData['url1'],
          imageData['url2'],
          imageData['url3'],
          imageData['url4'],
        ];
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to fetch image URLs');
    }
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

  List<File> _images = [];
  Widget mutiple_pic() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 2)),
        height: MediaQuery.of(context).size.height * 0.43,
        width: double.infinity,
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(_images.length, (index) {
            return Image.file(
              _images[index],
              fit: BoxFit.cover,
            );
          }),
        ),
      ),
    );
  }

  Widget mutiple_pic_get() {
    return (_images.length != 0)
        ? Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Container(
              decoration: BoxDecoration(border: Border.all(width: 2)),
              height: MediaQuery.of(context).size.height * 0.43,
              width: double.infinity,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(_images.length, (index) {
                  return Image.file(
                    _images[index],
                    fit: BoxFit.cover,
                  );
                }),
              ),
            ),
          )
        : (data.length == 0 && _images.length == 0)
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.44,
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                    children: _imageUrls.map((imageUrl) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Container(
                                  child: FadeInImage.assetNetwork(
                                    placeholderCacheHeight: 120,
                                    placeholderCacheWidth: 120,
                                    placeholderFit: BoxFit.contain,
                                    placeholder: 'assets/earth.gif',
                                    image: imageUrl,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: FadeInImage.assetNetwork(
                          placeholderCacheHeight: 120,
                          placeholderCacheWidth: 120,
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.contain,
                          placeholder: 'assets/earth.gif',
                          image: imageUrl,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
  }

  Widget Mutiple_image_button() {
    var padingRLT = const EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: padingRLT,
      child: InkWell(
        onTap: pickImages,
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.07,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromARGB(255, 47, 22, 157)),
          child: const Text(
            'Mutiple Image *',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> pickImages() async {
    List<Asset> resultList = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
      );
    } on Exception catch (e) {
      // Handle exception
    }
    // setState(() {
    //   _images;
    // });

    List<File> files = [];
    for (var asset in resultList) {
      ByteData byteData = await asset.getByteData();
      final tempDir = await getTemporaryDirectory();

      final file = File('${tempDir.path}/${asset.name}');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      files.add(file);
    }

    setState(() {
      _images = files;
    });
  }

  Widget Remark() {
    var padingRLT = const EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: padingRLT,
      child: Expanded(
        child: TextFormField(
          controller: executiveRemark,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.015,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (value) {
            setState(() {
              executiveRemark.text = value;
              executiveRemark.text = _remark!.text;
            });
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            prefixIcon: const Icon(
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
              borderSide: const BorderSide(
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

  List approvals_list = [];
  String? approvals;
  Widget dropdown_approvals() {
    var padingRLT = EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: padingRLT,
      child: Container(
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          //value: genderValue,
          onChanged: (newValue) {
            setState(() {
              requestModelbuildng.executive_app =
                  int.parse(newValue.toString());
              print(newValue.toString());
            });
          },
          value: approvals,
          items: approvals_list
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value["appstatus_id"].toString(),
                  child: Text(
                    value["appstatus_name"].toString(),
                    style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * 13,
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
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            labelText: 'Approvals',
            // hintText: '${requestModelbuildng.executive_road_type_id}',
            prefixIcon: const Icon(
              Icons.app_registration_sharp,
              color: kImageColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
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
    );
  }

  Widget dropdown_(list) {
    var padingRLT = const EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: padingRLT,
      child: Container(
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          //value: genderValue,
          onChanged: (newValue) {
            setState(() {
              executiveRoadTypeID.text = newValue!;
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
          // add extra sugar..
          icon: const Icon(
            Icons.arrow_drop_down,
            color: kImageColor,
          ),

          decoration: InputDecoration(
            fillColor: kwhite,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            labelText: '${widget.list[indexI]['road_name'].toString()}',
            // hintText: '${requestModelbuildng.executive_road_type_id}',
            prefixIcon: const Icon(
              Icons.app_registration_sharp,
              color: kImageColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
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
    );
  }

  Widget Appraiser_add() {
    var padingRLT = const EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: padingRLT,
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
              // Text("land~Building"),
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
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                  size: 30,
                  shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                ),
              ),
            ],
          ),
        ),
        // icon: Icon(
        //   Icons.add_circle_outline,
        //   color: Colors.white,
        // ),
      ),
    );
  }

  Widget build_add() {
    var padingRLT = const EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: padingRLT,
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
                      RotateAnimatedText('Building*'),
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
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                  size: 30,
                  shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                ),
              ),
            ],
          ),
        ),
        // icon: Icon(
        //   Icons.add_circle_outline,
        //   color: Colors.white,
        // ),
      ),
    );
  }

  void add_id() async {
    try {
      Map<String, dynamic> payload = {
        'executive_id': int.parse(id_only.toString()),
      };

      final url = Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/ex_last_id');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
      } else {}
    } catch (error) {}
  }

  Widget list_view(List list, lable) {
    var _Sizebox_h = SizedBox(
      height: 10,
    );
    var sizef = TextStyle(
        color: const Color.fromARGB(255, 14, 64, 106),
        fontSize: MediaQuery.textScaleFactorOf(context) * 13);
    var sizefs = TextStyle(
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 46, 102, 3),
        fontSize: MediaQuery.textScaleFactorOf(context) * 13);
    var padingRLT = const EdgeInsets.only(right: 30, left: 30, top: 10);
    var _font = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.height * 0.02);
    return Padding(
      padding: padingRLT,
      child: Container(
        // decoration: BoxDecoration(border: Border.all(width: 0.7)),
        height: MediaQuery.of(context).size.height * 0.26,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    // requestModelbuildng.building.removeAt(index);
                                    (lable == '1')
                                        ? requestModelbuildng.building
                                            .removeAt(index)
                                        : requestModelbuildng.appriaser
                                            .removeAt(index);
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

  int i = 0;
  Future _asyncInputDialog(BuildContext context, name) async {
    return showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 10),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.height * 0.8,
            child: ((name == 'building'))
                ? LandBuilding_valuaction_new(
                    id: widget.list[indexI]['executive_id'].toString(),
                    list: builDing,
                    // list: [],
                    listback: (value) {
                      setState(() {
                        // onchage_list = value;
                        builDing = value;
                      });
                    },
                  )
                : LandBuilding_Appraiser_new(
                    id: widget.list[indexI]['executive_id'].toString(),
                    list: appraiser,
                    // list: [],
                    listback: (value) {
                      setState(() {
                        appraiser = value;
                      });
                    },
                  ),
            // child: (name == 'building')
            //     ? Building(context)
            //     : Appraisering(context),
          ),
        );
      },
    );
  }

  void _building() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/list_building/${widget.list[indexI]['executive_id'].toString()}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        builDing = jsonData;

        // print(list_building.toString());
      });
    }
  }

  List _agency_list = [];

  Widget container(text, color) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.height * 0.12,
        decoration: (color == 'no_color')
            ? null
            : BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 31, 6, 158),
              ),
        child: Text(
          '$text',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height * 0.016,
              color: Colors.white),
        ),
      ),
    );
  }

  String? delete_first = 'delect_first';
  List<bool> switchValues = [];
  String? f = 'one';
  String? delete = 'delect';
  Widget _switch(index) {
    f == 'one'
        ? switchValues = List<bool>.generate(
            requestModelbuildng.conparable_map.length, (index) => true)
        : null;

    return Switch(
      value: switchValues[index],
      onChanged: (value) {
        setState(() {
          switchValues[index] = value;
          f = 'two';
        });
      },
    );
  }

  void _appraiser() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/list_Appraiser/${widget.list[indexI]['executive_id'].toString()}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        appraiser = jsonData;
      });
    }
  }

  void roadList() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/raod/name'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        raod_name = jsonData;
      });
    }
  }

  // List list_table = [];
  void TableMap() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/excutive/list_map/${widget.list[indexI]['executive_id'].toString()}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        conparableMap = jsonData;
        loopBool();
        if (conparableMap.toString() == '[]' ||
            requestModelbuildng.conparable_map.toString() == '[]') {
          conparableMap.removeAt(0);
          requestModelbuildng.conparable_map.removeAt(0);
        } else {
          print('No []');
        }
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

  bool table_bool = false;
  Future<void> _comparable_search_Table() async {
    table_bool = true;
    await Future.wait([
      _list_map_table(),
    ]);
    setState(() {
      table_bool = false;
    });
  }

  Future<void> _list_map_table() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/excutive/list_Table/${widget.list[indexI]['executive_id'].toString()}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        conparableMap = jsonData;
        for (int i = 0; i < conparableMap.length; i++) {
          if (conparableMap[i]['propertycomparable_com_id'].toString() ==
              'null') {
            print(conparableMap[i]['propertycomparable_com_id'].toString());
            conparableMap.removeAt(i);
          }
        }
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
    var padingRLT = EdgeInsets.only(right: 30, left: 30, top: 10);
    return Padding(
      padding: padingRLT,
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
          // _Sizebox_h,
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
              border: Border.all(width: 1, color: Colors.grey),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
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
              border: Border.all(width: 1, color: Colors.grey),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
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
        controller: contrller,
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
            borderSide: const BorderSide(
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
                ? executiveValuationDate.text =
                    DateFormat('yyyy-MM-dd').format(pickedDate)
                : executiveValuationIssueDate.text =
                    DateFormat('yyyy-MM-dd').format(pickedDate);

            setState(() {
              (date == 'Valuation Date*')
                  ? contrller.text = executiveValuationDate.text
                  : contrller.text = executiveValuationIssueDate.text;
            });
          } else {
            print("Date is not selected");
          }
        },
      ),
    );
  }

  Widget dropDown(value, list, lable, textID, textName, valueGet, onChanged) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        isExpanded: true,

        //value: genderValue,
        onChanged: (newValue) {
          setState(() {
            if (onChanged == 'Customer*') {
              customerID.text = newValue.toString();
            }
            if (onChanged == 'Property Type *') {
              // property_id = newValue;
              executivePropertyTypeID.text = newValue!;
            } else if (onChanged == 'Zoning') {
              executiveZoneID.text = newValue!;
            } else if (onChanged == 'Customer*') {
              customerID.text = newValue!;
              for (int i = 0; i < customer_name.length; i++) {
                if (newValue == customer_name[i]['customer_id'].toString()) {
                  executiveProvinceID.text =
                      customer_name[i]['customerpropertyprovince'].toString();
                  executiveDistrictID.text =
                      customer_name[i]['customerpropertydistrict'].toString();
                  executiveCommuneID.text =
                      customer_name[i]['customerpropertycommune'].toString();
                }
              }
            }
          });
        },

        value: valueGet,
        items: list
            .map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
                value: value["$textID"].toString(),
                child: Form(
                    child: Text(
                  // value["customer_name"].toString(),
                  value['$textName'].toString(),
                  style: TextStyle(
                      fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                      height: 0.1),
                )),
              ),
            )
            .toList(),
        // add extra sugar..
        icon: const Icon(
          Icons.arrow_drop_down,
          color: kImageColor,
        ),

        decoration: InputDecoration(
          labelStyle: (lable == 'Property Type *')
              ? TextStyle(
                  fontSize: MediaQuery.textScaleFactorOf(context) * 14,
                  fontWeight: FontWeight.bold)
              : null,
          fillColor: kwhite,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          labelText: lable,
          hintText: lable,
          helperStyle: (lable == 'Property Type *')
              ? TextStyle(
                  fontSize: MediaQuery.textScaleFactorOf(context) * 14,
                  fontWeight: FontWeight.bold)
              : null,
          prefixIcon: const Icon(
            Icons.app_registration_sharp,
            color: kImageColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
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

  var isSelected;
  Widget data_table(context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      padding: EdgeInsets.all(5),
      child: PaginatedDataTable(
        horizontalMargin: 5.0,
        arrowHeadColor: Colors.blueAccent[300],
        columns: const [
          DataColumn(
              label: Text(
            'No',
            style: TextStyle(color: Colors.green),
          )),
          DataColumn(
              label: Text(
            'ID',
            style: TextStyle(color: Colors.green),
          )),
          DataColumn(
              label: Text(
            'Action',
            style: TextStyle(color: Colors.green),
          )),
        ],
        dataRowHeight: 50,
        rowsPerPage: on_row,
        onRowsPerPageChanged: (value) {
          setState(() {
            on_row = value!;
          });
        },
        source: new _DataSource([], 1, context, list_comparble),
        // source: new _DataSource(requestModelbuildng.conparable_map,
        //     requestModelbuildng.conparable_map.length, context, list_comparble),
      ),
    );
  }

  int on_row = 10;
  //For List
  String? building_executive_id;
  String? building_size;
  String? building_price;
  String? building_price_per;
  String? building_des;
  List list = [];
  void addItemToList() {
    setState(() {
      list.add({
        "building_executive_id": id_only,
        "building_size": '',
        "building_price": '',
        "building_price_per": '',
        "building_des": '',
      });
      lb.add(
        building_execuactive(int.parse(id_only.toString()), building_size,
            building_price, building_price_per, '', 1, ''),
      );
    });
    //  print(id);
  }
}

// https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_comparable/$lat_verbal/$log_verbal?start=${widget.start}&end=${widget.end}
class _DataSource extends DataTableSource {
  final List data;
  final List data1;
  final int count_row;
  final BuildContext context;

  _DataSource(this.data, this.count_row, this.context, this.data1);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    final list_com = data1[index];
    final item = data[index];
    bool isSelected = false;
    return DataRow(
        selected: true,
        color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return index % 2 == 0
                  ? Color.fromARGB(168, 73, 83, 224)
                  : Colors.white;
            }
            return index % 2 == 0
                ? Color.fromARGB(255, 255, 162, 162)
                : Colors.white;
          },
        ),
        cells: [
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '$index',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {},
          ),
          // DataCell(
          //   placeholder: true,
          //   Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Text(
          //         '${item['propertycomparable_com_id'].toString()}',
          //         style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          //       ),
          //     ],
          //   ),
          //   onTap: () {},
          // ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${list_com['property_type_name'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {},
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${list_com['comparable_land_total'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {},
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${list_com['comparable_sold_total'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {},
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${list_com['comparable_adding_price'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {},
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(list_com['comparableaddprice'].toString() == 'null' ? '' : list_com['comparableaddprice'].toString())}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {},
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(list_com['comparableboughtprice'].toString() == 'null' ? '' : list_com['comparableboughtprice'].toString())}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {},
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${list_com['comparable_sold_price'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {},
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(list_com['provinces_name'].toString() == 'null' ? '' : list_com['provinces_name'].toString())} ${(list_com['district_name'].toString() == 'null' ? '' : list_com['district_name'].toString())} ${(list_com['commune_name'].toString() == 'null' ? '' : list_com['commune_name'].toString())}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {},
          ),
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${list_com['comparable_survey_date'].toString()}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {},
          ),
        ]);
  }

  @override
  int get rowCount => count_row;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
