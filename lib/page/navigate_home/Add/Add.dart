import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
<<<<<<< HEAD:lib/interface/navigate_home/Add/Add.dart
import 'package:http/http.dart' as http;
import '../../../../../models/verbalModel/verbal_model.dart';
import '../../../Customs/formTwinN.dart';
import '../../../components/ApprovebyAndVerifyby.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import '../../../components/bank_dropdown.dart';
import '../../../components/colors.dart';
import '../../../components/raod_type.dart';
import '../../../components/searchProperty.dart';
import '../../../getx/agent_credit/credit_agent.dart';
import '../../../getx/dropdown_local/dropdown.dart';
import '../../../getx/verbal/verbal.dart';
=======
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import '../../../../components/ApprovebyAndVerifyby.dart';
import '../../../../components/LandBuilding.dart';
import '../../../../components/property.dart';
import '../../../../components/slideUp.dart';
import '../../../../customs/form.dart';
import '../../../Customs/formTwinN.dart';
import '../../../api/api_service.dart';
import '../../../api/contants.dart';
import '../../../components/bank.dart';
import '../../../components/comment.dart';
import '../../../components/forceSale.dart';
import '../../../models/autoVerbal.dart';
import '../../../models/land_building.dart';
>>>>>>> 4df899fe5c5b7786128f08f07b8f4c937ba094bc:lib/page/navigate_home/Add/Add.dart

class Add extends StatefulWidget {
  const Add({
    super.key,
    required this.backvalue,
    // required this.id,
    required this.email,
    // required this.password,

    required this.listUser,
    required this.device,
    required this.listLandBuilding,
    required this.hscreen,
    required this.verbalID,
    required this.lat,
    required this.lng,
    required this.addressController,
    required this.checkMap,
    required this.option,
    required this.creditAgent,
  });

  final String device;
  final String verbalID;
  final List listUser;
  final String email;
  final String lat;
  final String lng;
  final OnChangeCallback backvalue;
  final List listLandBuilding;
  final bool checkMap;
  final double hscreen;
  final int option;
  final OnChangeCallback creditAgent;
  final TextEditingController addressController;

  @override
  State<Add> createState() => _Add_with_propertyState();
}

class _Add_with_propertyState extends State<Add> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String fromValue = 'Bank';
  String genderValue = 'Female';
  int? opt;
  String address = '';
  String propertyTypes = '', propertyTypesValue = '';
  var code = 0;
  var from = [
    'Bank',
    'Private',
    'Other',
  ];
  var gender = [
    'Female',
    'Male',
    'Other',
  ];

  final ControllerAPI controllerAPI = Get.put(ControllerAPI());

  String districts = '';

  Future<Uint8List> comporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );
    setState(() {
      base64string = base64.encode(result);
    });

    return result;
  }

<<<<<<< HEAD:lib/interface/navigate_home/Add/Add.dart
  VerbalModels verbalModels = VerbalModels(data: []);
  Data datamodel = Data();
  String lable = '';
  final CreditAgent creditAgent = Get.put(CreditAgent());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? file;
  Uint8List? get_bytes;
  @override
  void initState() {
    pdfimage();
    provinceModel();
    super.initState();
    listOptin = listRaodNBorey;
    verbalUser = int.parse(widget.verbalID);
    creditAgent.creditAgent(83);
  }

  int verbalUser = 0;
  String base64string = 'No';

  void saveToLocal() {
    // setState(() {
    //   final person = Person(
    //     verbal_id: "209K105F209Acrwedbunj",
    //     verbal_image: 'No',
    //     verbal_property_id: '0',
    //     verbal_bank_id: '0',
    //     verbal_bank_branch_id: "null",
    //     verbal_bank_contact: "null",
    //     verbal_owner: "null",
    //     verbal_contact: "null",
    //     verbal_date: '2024-05-27',
    //     verbal_bank_officer: "null",
    //     verbal_address: 'Phnom Penh, Khan Russey Keo, Tuol Sangke',

    //   );
    //   listModel.put(person.verbal_id, person);
    // });
  }

  // int? id_route;
  String bankName = '';
  String branchName = '';
  void saveAutoLocal() {
    // setState(() {
    //   final person = Person(
    //       verbal_id: widget.verbalID,
    //       verbal_khan: widget.addressController.text,
    //       verbal_property_id: propertyTypesId,
    //       verbal_bank_id: bankId,
    //       verbal_bank_branch_id: bankBranchId,
    //       verbal_bank_contact: bankContact,
    //       verbal_owner: owner,
    //       verbal_contact: contact,
    //       verbal_date: date,
    //       verbal_bank_officer: bankOfficer,
    //       verbal_address: widget.addressController.text,
    //       verbal_approve_id: approveId,
    //       VerifyAgent: agent,
    //       verbal_comment: comment,
    //       latlong_log: widget.lng,
    //       latlong_la: widget.lat,
    //       verbal_image: base64string,
    //       verbal_com: verbalCom,
    //       verbal_con: verbalCon,
    //       verbal_property_code: code.toString(),
    //       verbal_user: user,
    //       verbal_province_id: verbalProvinceID.toString(),
    //       // "verbal_district_id":null,
    //       // "verbal_commune_id":null,
    //       verbal_option: option.toString(),
    //       VerbalType: widget.listLandBuilding,
    //       property_type_name: propertyTypes,
    //       bank_branch_name: branchName,
    //       bank_name: bankName);
    //   listModel.put(person.verbal_id, person);
    // });
  }

  String base64Image = '';

  List listdata = [];

  bool checkboreyTP = false;
  int countwaiting = 0;
  List listOptin = [];
  List listTitle = [
    {"title": "Cancle"},
    {"title": "OK"},
  ];
  // bool checkrequest = false;
  Uint8List? getbytesMID;
  bool districtbool = false;
  bool check = false;
  List listRaodNBorey = [
    {"road_id": 1, "road_name": "Main Roads"},
    {"road_id": 2, "road_name": "Sub Road"},
  ];
  List listRaodBorey = [
    {"road_id": 38, "road_name": "Borey Residential"},
    {"road_id": 39, "road_name": "Borey Commercial"},
  ];
  VerbalAdd verbalAdd = VerbalAdd();
  int count = 0;
  late Timer _timer;
  bool waitingCheck = false;
  @override
  Widget build(BuildContext context) {
    return (widget.listLandBuilding.isEmpty && check == false)
        ? const SizedBox()
        : Obx(
            () => Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  alignment: Alignment.center,
                  height: (_byesData != null || get_bytes != null)
                      ? widget.hscreen + 200
                      : widget.hscreen,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: waiting
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Center(child: CircularProgressIndicator()),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(creditAgent.credit.value.toString()),
                              Row(
                                children: [
                                  const SizedBox(width: 30),
                                  const Icon(Icons.qr_code,
                                      color: kImageColor, size: 25),
                                  const SizedBox(width: 10),
                                  Text(verbalUser.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor)),
                                  const SizedBox(width: 10),
                                  const Spacer(),
                                  if (verbalAdd.iswaiting.value &&
                                      verbalAdd.isverbal.value)
                                    const Center(
                                        child: CircularProgressIndicator())
                                  else
                                    InkWell(
                                      onTap: () async {
                                        verbalAdd.iswaiting.value = true;
                                        await verbalAdd.timewating();
                                        setState(() {
                                          datamodel.verbalAddress =
                                              widget.addressController.text;
                                          datamodel.latlongLa =
                                              double.parse(widget.lat);
                                          datamodel.latlongLog =
                                              double.parse(widget.lng);
                                          datamodel.verbalOption =
                                              widget.option;
                                          datamodel.verbalUser = int.parse(
                                              widget.listUser[0]['id']
                                                  .toString());
                                        });
                                        if (formKey.currentState!.validate() &&
                                            datamodel.road != null) {
                                          if (widget
                                              .listLandBuilding.isNotEmpty) {
                                            await verbalAdd.saveAuto(
                                                datamodel,
                                                widget.verbalID,
                                                widget.listLandBuilding,
                                                base64string,
                                                widget.listUser[0]['id'],
                                                creditAgent.credit.value);
                                            setState(() {
                                              widget.listLandBuilding.clear();
                                              widget.addressController.clear();
                                              checkboreyTP = false;
                                              verbalUser = int.parse(
                                                  verbalAdd.verbalID.value);

                                              widget.creditAgent(
                                                  "${creditAgent.credit.value + 1}");
                                            });
                                          } else {
                                            getxsnackbar(
                                                "Please add Land/Building at least 1!",
                                                "");
                                          }
                                        } else {
                                          getxsnackbar(
                                              "Please Your Requestment", "");
                                        }
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: greyColor),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: whiteColor),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Save  ',
                                                style: TextStyle(
                                                    color: greyColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Icon(Icons.save_alt,
                                                color: greyColor)
                                          ],
                                        ),
                                      ),
                                    ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, left: 30),
                                child: Row(
                                  children: [
                                    Text(
                                      'Borey  ',
                                      style: TextStyle(
                                          color: greyColor, fontSize: 15),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            waitingCheck = true;
                                            checkboreyTP = !checkboreyTP;
                                            if (!checkboreyTP) {
                                              datamodel.borey = 0;
                                              listOptin = listRaodNBorey;
                                            } else {
                                              datamodel.borey = 1;
                                              listOptin = listRaodBorey;
                                            }
                                            _timer = Timer.periodic(
                                                const Duration(seconds: 1),
                                                (Timer timer) async {
                                              setState(() {
                                                countwaiting++;
                                              });

                                              if (countwaiting >= 1) {
                                                _timer.cancel();
                                                waitingCheck = false;
                                              }
                                            });
                                          });
                                        },
                                        icon: Icon(
                                            !checkboreyTP
                                                ? Icons
                                                    .check_box_outline_blank_outlined
                                                : Icons.check_box_outlined,
                                            size: 25,
                                            color: greyColor),
                                        color: whiteColor),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              if (widget.lat != null)
                                InkWell(
                                  onTap: () async {},
                                  child: Container(
                                    height: 250,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    margin: const EdgeInsets.only(
                                        top: 15, right: 30, left: 30),
                                    child: FadeInImage.assetNetwork(
                                      placeholderCacheHeight: 50,
                                      placeholderCacheWidth: 50,
                                      fit: BoxFit.cover,
                                      placeholderFit: BoxFit.fill,
                                      placeholder: 'assets/earth.gif',
                                      image:
                                          'https://maps.googleapis.com/maps/api/staticmap?center=${widget.lat},${widget.lng}&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${widget.lat},${widget.lng}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                    ),
                                  ),
                                ),

                              const SizedBox(height: 10),
                              // CommentAndOption(
                              //   value: (value) {
                              //     setState(() {
                              //       opt = int.parse(value);
                              //       print("opt => $opt");
                              //     });
                              //   },
                              //   comment1: (opt != null) ? opt.toString() : null,
                              //   id: (value) {
                              //     setState(() {
                              //       option = int.parse(value.toString());
                              //       print("option => $option");
                              //     });
                              //   },
                              //   comment: (newValue) {
                              //     setState(() {
                              //       comment = newValue!.toString();
                              //     });
                              //   },
                              //   opt_type_id: (value) {
                              //     setState(() {
                              //       opt_type_id = value.toString();
                              //       print("opt_type_id => $opt_type_id");
                              //     });
                              //   },
                              // ),

                              if (widget.listLandBuilding.isNotEmpty)
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 280,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  widget
                                                      .listLandBuilding.length;
                                              i++)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 10, 10),
                                              child: Container(
                                                width: 270,
                                                //height: 210,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: kPrimaryColor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15)),
                                                ),

                                                child: Column(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                '${widget.listLandBuilding[i]['verbal_landid']}',
                                                                style:
                                                                    NameProperty(),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child:
                                                                    IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 30,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      check =
                                                                          true;
                                                                      widget
                                                                          .listLandBuilding
                                                                          .removeAt(
                                                                              i);
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      '${widget.listLandBuilding[i]['address'] ?? ""} ',
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 3.0),
                                                    const Divider(
                                                        height: 1,
                                                        thickness: 1,
                                                        color: kPrimaryColor),
                                                    const SizedBox(height: 3.0),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Depreciation",
                                                              style: Label(),
                                                            ),
                                                            const SizedBox(
                                                                height: 3),
                                                            if (widget.listLandBuilding[
                                                                        i][
                                                                    'verbal_land_des'] !=
                                                                "Land")
                                                              Text(
                                                                "Floor",
                                                                style: Label(),
                                                              ),
                                                            const SizedBox(
                                                                height: 3),
                                                            Text(
                                                              "Area",
                                                              style: Label(),
                                                            ),
                                                            const SizedBox(
                                                                height: 3),
                                                            Text(
                                                              'Max Value/Sqm',
                                                              style: Label(),
                                                            ),
                                                            const SizedBox(
                                                                height: 3),
                                                            Text(
                                                              'Min Value/Sqm',
                                                              style: Label(),
                                                            ),
                                                            const SizedBox(
                                                                height: 3),
                                                            Text(
                                                              'Max Value',
                                                              style: Label(),
                                                            ),
                                                            const SizedBox(
                                                                height: 3),
                                                            Text(
                                                              'Min Value',
                                                              style: Label(),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            width: 15),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                                height: 4),
                                                            Text(
                                                              ' : ${widget.listLandBuilding[i]['verbal_land_des'] ?? ""}',
                                                              style: Name(),
                                                            ),
                                                            const SizedBox(
                                                                height: 2),
                                                            if (widget.listLandBuilding[
                                                                        i][
                                                                    'verbal_land_des'] !=
                                                                "land")
                                                              Text(
                                                                ' : ${widget.listLandBuilding[i]['verbal_land_dp'] ?? ""}',
                                                                style: Name(),
                                                              ),
                                                            const SizedBox(
                                                                height: 2),
                                                            Text(
                                                              // ':   ' +
                                                              //     (formatter.format(lb[i]
                                                              //             .verbal_land_area
                                                              //             .toInt()))
                                                              //         .toString() +
                                                              ' : ${widget.listLandBuilding[i]['verbal_land_area'] ?? ""}m\u00B2',
                                                              // area + 'm' + '\u00B2',
                                                              style: Name(),
                                                            ),
                                                            const SizedBox(
                                                                height: 2),
                                                            Text(
                                                              ' : ${widget.listLandBuilding[i]['verbal_land_minsqm'] ?? ""}\$',
                                                              style: Name(),
                                                            ),
                                                            const SizedBox(
                                                                height: 2),
                                                            Text(
                                                              ' : ${widget.listLandBuilding[i]['verbal_land_maxsqm'] ?? ""}\$',
                                                              style: Name(),
                                                            ),
                                                            const SizedBox(
                                                                height: 2),
                                                            Text(
                                                              ' : ${widget.listLandBuilding[i]['verbal_land_minvalue'] ?? ""}\$',
                                                              style: Name(),
                                                            ),
                                                            const SizedBox(
                                                                height: 2),
                                                            Text(
                                                              ' : ${widget.listLandBuilding[i]['verbal_land_maxvalue'] ?? ""}\$',
                                                              style: Name(),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 10),
                              if (_byesData != null)
                                Column(
                                  children: [
                                    if (_byesData != null &&
                                        cropORopen == false)
                                      SizedBox(
                                        height: 150,
                                        child: Image.memory(
                                          _byesData!,
                                        ),
                                      )
                                    else if (get_bytes != null &&
                                        cropORopen == true)
                                      SizedBox(
                                          height: 150,
                                          child: Image.memory(get_bytes!)),
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
                              const SizedBox(height: 10.0),
                              if (datamodel.road == null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 30),
                                    Text("Road",
                                        style: TextStyle(
                                            color: (datamodel.road == null)
                                                ? Colors.red
                                                : whiteColor,
                                            fontSize: 14)),
                                  ],
                                ),
                              const SizedBox(height: 5),
                              waitingCheck
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          right: 30, left: 30),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: OptionRoadNew(
                                          pwidth: 250,
                                          hight: 45,
                                          list: listOptin,
                                          valueId: "road_id",
                                          valueName: "road_name",
                                          lable: "Road",
                                          onbackValue: (value) {
                                            setState(() {
                                              List<String> parts =
                                                  value!.split(',');

                                              lable = parts[1];
                                              datamodel.road = int.parse(
                                                  parts[0].toString());
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(right: 30, left: 30),
                              //   child: SizedBox(
                              //     height: 45,
                              //     width: double.infinity,
                              //     child: DropdownButtonFormField<String>(
                              //       isExpanded: true,
                              //       onChanged: (newValue) {
                              //         setState(() {
                              //           datamodel.borey = int.parse(newValue!);
                              //         });
                              //       },
                              //       items: roadList
                              //           .map<DropdownMenuItem<String>>(
                              //             (value) => DropdownMenuItem<String>(
                              //               value: value["road_id"].toString(),
                              //               child: Text(
                              //                   value["road_name"].toString()),
                              //             ),
                              //           )
                              //           .toList(),
                              //       icon: const Icon(
                              //         Icons.arrow_drop_down,
                              //         color: kImageColor,
                              //       ),
                              //       decoration: InputDecoration(
                              //         contentPadding: const EdgeInsets.symmetric(
                              //             vertical: 8, horizontal: 10),
                              //         fillColor: kwhite,
                              //         filled: true,
                              //         labelText: "Raod",
                              //         hintText: 'Select one',
                              //         prefixIcon: const Icon(
                              //           Icons.edit_road_outlined,
                              //           color: kImageColor,
                              //         ),
                              //         focusedBorder: OutlineInputBorder(
                              //           borderSide: const BorderSide(
                              //               color: kPrimaryColor, width: 2.0),
                              //           borderRadius: BorderRadius.circular(10),
                              //         ),
                              //         enabledBorder: OutlineInputBorder(
                              //           borderSide: const BorderSide(
                              //             width: 1,
                              //             color: kPrimaryColor,
                              //           ),
                              //           borderRadius: BorderRadius.circular(10),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(height: 10.0),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, left: 30),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        openImgae();
                                      },
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: kPrimaryColor,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        // padding: EdgeInsets.only(left: 30, right: 30),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                const SizedBox(width: 10),
                                                const Icon(
                                                  Icons.map_sharp,
                                                  color: kImageColor,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  (_byesData == null)
                                                      ? 'Choose Photo'
                                                      : 'choosed Photo',
                                                  style: const TextStyle(
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            )),
                                      ),
                                    )),
                                    const SizedBox(width: 10),
                                    // OKOKOKOK
                                    // Expanded(
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(8.0),
                                    //     child: DropdownOptionX(
                                    //       icon: Icons.real_estate_agent_outlined,
                                    //       dataid: "property_type_id",
                                    //       dataname: "property_type_name",
                                    //       lable: "PropertyType",
                                    //       value: (value) {
                                    //         setState(() {
                                    //           // propertyID = int.parse(value);
                                    //         });
                                    //       },
                                    //       valuenameback: (value) {},
                                    //     ),
                                    //   ),
                                    // ),
                                    Expanded(
                                      child: propertyType(
                                        lable: "propertyTypes *",
                                        value: (value) {
                                          setState(() {
                                            datamodel.propertyTypeId =
                                                int.parse(value);
                                          });
                                        },
                                        valueName: "propertyTypes *",
                                        valuenameback: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              BankDropdownSearch(
                                bankbranchback: (value) {
                                  setState(() {
                                    branchName = value;
                                    // print('==> $branchName');
                                  });
                                },
                                banknameback: (value) {
                                  setState(() {
                                    bankName = value;
                                  });
                                },
                                bankName: 'Bank',
                                branchName: 'Branch',
                                bank: (value) {
                                  setState(() {
                                    datamodel.verbalBankId = int.parse(value);
                                  });
                                },
                                bankbranch: (value) {
                                  setState(() {
                                    datamodel.verbalBankBranchId =
                                        int.parse(value);
                                  });
                                },
                              ),

                              FormTwinN(
                                Label1: 'Owner',
                                Label2: 'Contact',
                                onSaved1: (input) {
                                  setState(() {
                                    datamodel.verbalOwner = input!;
                                  });
                                },
                                onSaved2: (input) {
                                  setState(() {
                                    datamodel.verbalContact = input!;
                                  });
                                },
                                icon1: const Icon(
                                  Icons.person,
                                  color: kImageColor,
                                ),
                                icon2: const Icon(
                                  Icons.phone,
                                  color: kImageColor,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              // DateComponents(
                              //   date: (value) {
                              //     date = value;
                              //   },
                              // ),

                              FormTwinN(
                                Label1: 'Bank Officer',
                                Label2: 'Contact',
                                onSaved1: (input) {
                                  setState(() {
                                    datamodel.verbalBankOfficer = input!;
                                  });
                                },
                                onSaved2: (input) {
                                  setState(() {
                                    datamodel.verbalBankContact = input!;
                                  });
                                },
                                icon1:
                                    const Icon(Icons.work, color: kImageColor),
                                icon2:
                                    const Icon(Icons.phone, color: kImageColor),
                              ),

                              const SizedBox(height: 5),
                              // ForceSaleAndValuation(
                              //   value: (value) {
                              //     verbal_con = value;
                              //   },
                              //   // fsl: list[0]['verbal_con'],
                              // ),

                              // ApprovebyAndVerifyby(
                              //   approve: (value) {
                              //     setState(() {
                              //       approve_id = value.toString();
                              //     });
                              //   },
                              //   verify: (value) {
                              //     setState(() {
                              //       agent = value.toString();
                              //     });
                              //   },
                              //   // appro: list[0]['approve_name'],
                              //   // vfy: list[0]['VerifyAgent'],
                              // ),

                              // FormController(
                              //   value: address,
                              //   label: 'Phum optional',
                              //   valueback: (value) {},
                              //   // onSaved: (input) {
                              //   //   setState(() {
                              //   //     address = input!.toString();
                              //   //   });
                              //   // },
                              //   iconname: const Icon(Icons.location_on_rounded,
                              //       color: kImageColor),
                              // ),

                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: TextFormField(
                                  controller: widget.addressController,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.addressController.text = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    fillColor: kwhite,
                                    filled: true,
                                    labelText: "Phum optional",
                                    labelStyle:
                                        const TextStyle(color: kTextLightColor),
                                    prefixIcon: const Icon(
                                        Icons.location_on_rounded,
                                        color: kImageColor),
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: kPrimaryColor),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              // const SizedBox(height: 10),
                              // SizedBox(
                              //   height: 50,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(right: 30, left: 30),
                              //     child: Row(
                              //       children: [
                              //         DropdownProvince(
                              //             types: '',
                              //             list: listprovinceModel,
                              //             valuedropdown: 'provinces_id',
                              //             valuetxt: 'provinces_name',
                              //             value: (value) {
                              //               setState(() {
                              //                 verbalProvinceID = value;
                              //                 districtWaiting();
                              //               });
                              //             },
                              //             validator: false,
                              //             txtvalue: (searchResults.isNotEmpty)
                              //                 ? searchResults[0]['provinces_name']
                              //                     .toString()
                              //                 : "Provinces"),
                              //         const SizedBox(width: 10),
                              //         districtbool
                              //             ? const Center(
                              //                 child: CircularProgressIndicator())
                              //             : Dropdown_District(
                              //                 types: '',
                              //                 list: listdistrictModel,
                              //                 valuedropdown: 'district_id',
                              //                 valuetxt: 'district_name',
                              //                 value: (value) {
                              //                   setState(() {
                              //                     verbalDistrictID = value;
                              //                     communetWaiting();
                              //                   });
                              //                 },
                              //                 validator: false,
                              //                 txtvalue: "District"),
                              //         const SizedBox(width: 10),
                              //         communebool
                              //             ? const Center(
                              //                 child: CircularProgressIndicator())
                              //             : Dropdown_District(
                              //                 types: '',
                              //                 list: listcommuneModel,
                              //                 valuedropdown: 'commune_id',
                              //                 valuetxt: 'commune_name',
                              //                 value: (value) {
                              //                   setState(() {
                              //                     verbalCommuneID = value;
                              //                   });
                              //                 },
                              //                 validator: false,
                              //                 txtvalue: "Commune"),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          );
  }

  bool waiting = false;
  String? options;
  String commune = '';
  Widget request(title) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 30),
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 14)),
=======
  Widget addVerbal(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 40),
              Icon(
                Icons.qr_code,
                color: kImageColor,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                verbal_id,
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              )
            ],
          ),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (lat != null && lat1 == null)
                InkWell(
                  onTap: () async {
                    await SlideUp(context);
                  },
                  child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width * 0.45,
                    // margin: EdgeInsets.only(top: 15, right: 13, left: 15),
                    child: FadeInImage.assetNetwork(
                      placeholderCacheHeight: 120,
                      placeholderCacheWidth: 120,
                      fit: BoxFit.cover,
                      placeholderFit: BoxFit.fill,
                      placeholder: 'assets/earth.gif',
                      image:
                          'https://maps.googleapis.com/maps/api/staticmap?center=${lat},${log}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
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
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: FadeInImage.assetNetwork(
                      placeholderCacheHeight: 50,
                      placeholderCacheWidth: 50,
                      placeholderFit: BoxFit.cover,
                      placeholder: 'assets/earth.gif',
                      image:
                          'https://maps.googleapis.com/maps/api/staticmap?center=${lat1},${log2}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat1},${log2}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                    ),
                  ),
                )
              else
                SizedBox(),
              SizedBox(width: 20),
              if (_byesData != null)
                InkWell(
                  onTap: () {
                    OpenImgae();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 180,
                    child: (get_bytes == null)
                        ? Image.memory(
                            _byesData!,
                          )
                        : Image.memory(get_bytes!),
                  ),
                )
              else
                InkWell(
                    onTap: () {
                      OpenImgae();
                    },
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        child: Stack(children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/Form_Image/image_select.jpg',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 180,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ]),
                      ),
                    ))
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(right: 120),
            child: Row(
              children: [
                Spacer(),
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
          ),
          InkWell(
              onTap: () async {
                testComporessList();
              },
              child: Text('Compress Image')),
          SizedBox(height: 10),
          CommentAndOption(
            value: (value) {
              setState(() {
                opt = int.parse(value);
              });
            },
            comment1: (opt != null) ? opt.toString() : null,
            id: (value) {
              setState(() {
                requestModelAuto.option = value;
              });
            },
            comment: (newValue) {
              setState(() {
                requestModelAuto.comment = newValue!.toString();
              });
            },
            opt_type_id: (value) {
              setState(() {
                opt_type_id = value.toString();
              });
            },
          ),

          if (id_khan != 0)
            InkWell(
              onTap: () {
                _asyncInputDialog(context);
                ++i;
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent[700],
                    borderRadius: BorderRadius.circular(30)),
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
                            RotateAnimatedText('land'),
                            RotateAnimatedText('Building'),
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
                        shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (i >= 0)
            Container(
              width: 500,
              height: (lb.length > 1) ? 280 : 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 1; i < lb.length; i++)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Container(
                          width: 290,
                          //height: 210,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: kPrimaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '${lb[i].verbal_land_type} ',
                                          style: NameProperty(),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                deleteItemToList(i);
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: kPrimaryColor,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${lb[i].address} ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Depreciation",
                                        style: Label(),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        "Floor",
                                        style: Label(),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        "Area",
                                        style: Label(),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        'Min Value/Sqm',
                                        style: Label(),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        'Max Value/Sqm',
                                        style: Label(),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        'Min Value',
                                        style: Label(),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        'Min Value',
                                        style: Label(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 4),
                                      Text(
                                        ':   ' + lb[i].verbal_land_dp,
                                        style: Name(),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        ':   ' + lb[i].verbal_land_des,
                                        style: Name(),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        ':   ' +
                                            (formatter.format(lb[i]
                                                    .verbal_land_area
                                                    .toInt()))
                                                .toString() +
                                            'm' +
                                            '\u00B2',
                                        style: Name(),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        ':   ' +
                                            (lb[i].verbal_land_minsqm)
                                                .toString() +
                                            '\$',
                                        style: Name(),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        ':   ' +
                                            (lb[i].verbal_land_maxsqm)
                                                .toString() +
                                            '\$',
                                        style: Name(),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        ':   ' +
                                            (formatter.format(
                                                    lb[i].verbal_land_minvalue))
                                                .toString() +
                                            '\$',
                                        style: Name(),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        ':   ' +
                                            (formatter
                                                    .format(lb[i]
                                                        .verbal_land_maxvalue)
                                                    .toString() +
                                                '\$'),
                                        style: Name(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          SizedBox(
            height: 10.0,
          ),
          PropertyDropdown(
            name: (value) {
              propertyType = value;
            },
            id: (value) {
              requestModelAuto.property_type_id = value;
            },
          ),
          SizedBox(
            height: 5.0,
          ),
          BankDropdown(
            bank: (value) {
              requestModelAuto.bank_id = value;
            },
            bankbranch: (value) {
              requestModelAuto.bank_branch_id = value;
            },
          ),
          SizedBox(
            height: 5.0,
          ),
          FormTwinN(
            Label1: 'Owner',
            Label2: 'Contact',
            onSaved1: (input) {
              requestModelAuto.owner = input!;
            },
            onSaved2: (input) {
              requestModelAuto.contact = input!;
            },
            icon1: Icon(
              Icons.person,
              color: kImageColor,
            ),
            icon2: Icon(
              Icons.phone,
              color: kImageColor,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          // DateComponents(
          //   date: (value) {
          //     requestModelAuto.date = value;
          //   },
          // ),
          SizedBox(
            height: 5.0,
          ),
          FormTwinN(
            Label1: 'Bank Officer',
            Label2: 'Contact',
            onSaved1: (input) {
              requestModelAuto.bank_officer = input!;
            },
            onSaved2: (input) {
              requestModelAuto.bank_contact = input!;
            },
            icon1: Icon(
              Icons.work,
              color: kImageColor,
            ),
            icon2: Icon(
              Icons.phone,
              color: kImageColor,
            ),
          ),

          SizedBox(
            height: 5,
          ),
          ForceSaleAndValuation(
            value: (value) {
              requestModelAuto.verbal_con = value;
            },
          ),

          SizedBox(
            height: 10,
          ),
          ApprovebyAndVerifyby(
            approve: (value) {
              requestModelAuto.approve_id = value;
            },
            verify: (value) {
              requestModelAuto.agent = value;
            },
          ),

          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
            child: FormS(
              label: 'Phum optional',
              onSaved: (input) {
                requestModelAuto.address = input!;
              },
              iconname: Icon(
                Icons.location_on_rounded,
                color: kImageColor,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
>>>>>>> 4df899fe5c5b7786128f08f07b8f4c937ba094bc:lib/page/navigate_home/Add/Add.dart
        ],
      ),
    );
  }

  Future<void> getxsnackbar(title, subtitle) async {
    Get.snackbar(
      title,
      subtitle,
      colorText: Colors.black,
      padding: const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
      borderColor: const Color.fromARGB(255, 48, 47, 47),
      borderWidth: 1.0,
      borderRadius: 5,
      backgroundColor: const Color.fromARGB(255, 235, 242, 246),
      icon: const Icon(Icons.add_alert),
    );
  }

  String province = '';
  String area = '';
  //MAP
  List<dynamic> searchResults = [];
  Future<void> searchProperties(String query) async {
    setState(() {
      searchResults = listprovinceModel.where((property) {
        final provincemap = property['province_map'].toString().toLowerCase();

        final lowerCaseQuery = query.toLowerCase();

        return provincemap.contains(lowerCaseQuery);
      }).toList();
    });
  }

//===================== Upload Image to MySql Server
  final picker = ImagePicker();
  Uint8List? imagebytes;
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  var imagelogo;
  List listPDF = [];
  Future<void> pdfimage() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/pdf/15'));

    if (rs.statusCode == 200) {
      setState(() {
        listPDF = jsonDecode(rs.body);

        if (listPDF.isNotEmpty) {
          imagelogo = listPDF[0]['image'].toString();
        }
      });
    }
  }

  Uint8List? _selectedFile;
  Uint8List? _byesData;
  String imageUrl = '';
  late File croppedFile;
  Future<File> convertImageByteToFile(
      Uint8List imageBytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    File file = File('$path/$fileName');
    await file.writeAsBytes(imageBytes);
    return file;
  }

  void openImgae() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files!.elementAt(0);
      final reader = html.FileReader();

      // Check size of the file
      int fileSizeInBytes = file.size;
      print('File size: $fileSizeInBytes bytes');

      reader.onLoadEnd.listen((event) {
        setState(() {
          _byesData = const Base64Decoder()
              .convert(reader.result.toString().split(',').last);
          _selectedFile = _byesData;
          // croppedFile = File.fromRawPath(_byesData!);
          imageUrl = html.Url.createObjectUrlFromBlob(file.slice());
          comporessList(_byesData!);
          cropORopen = false;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  Random random = Random();
  final completer = Completer<Uint8List>();
  html.File? cropimageFile;
  String? _croppedBlobUrl;
  bool cropORopen = false;
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
      cropimageFile = html.File([blob], 'cropped-image.png');
      get_bytes = Uint8List.fromList(bytes);
      setState(() {
        cropORopen = true;
        comporessList(get_bytes!);
        _croppedBlobUrl = croppedFile.path;
        if (!kIsWeb) {
          saveBlobToFile(_croppedBlobUrl!, croppedFile.path);
        }
      });
    }
  }

  Future<void> saveBlobToFile(String blobUrl, String filename) async {
    final response = await http.get(Uri.parse(blobUrl));
    final bytes = response.bodyBytes;

    if (!kIsWeb) {
      final directory = await getApplicationDocumentsDirectory();
      final path = "${directory.path}/$filename";
      final file = io.File(path);
      await file.writeAsBytes(bytes);
    }
  }

  List listprovinceModel = [];
  Future<void> provinceModel() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/provinceModel',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listprovinceModel = jsonDecode(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 12);
  }

  TextStyle Name() {
    return TextStyle(
        color: kImageColor, fontSize: 13, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return TextStyle(
        color: kImageColor, fontSize: 13, fontWeight: FontWeight.bold);
  }
}
