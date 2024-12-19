import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../../../../components/bank_dropdown.dart';
import '../../../../../../models/verbalModel/verbal_model.dart';
import '../../../../../components/raod_type.dart';
import '../../../../Customs/formTwinN_Controller.dart';
import '../../../../Widgets/searchProperty.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import '../../../../components/colors.dart';
import '../../../../components/input_controller.dart';
import '../../../../getx/dropdown_local/dropdown.dart';
import '../../../../getx/verbal/verbal.dart';
import '../../../../getx/verbal/verbal_list.dart';
import '../../../../models/LandBuilding/landbuilding_Model.dart';

class EditAutoVerbal extends StatefulWidget {
  const EditAutoVerbal({
    super.key,
    required this.listUser,
    required this.device,
    required this.hscreen,
    required this.listData,
    required this.index,
    required this.addressController,
    required this.listLandBuilding,
    // required this.listLandBuildingModel,
  });

  final String device;

  final List listUser;
  final List listData;
  final int index;
  final TextEditingController addressController;
  final double hscreen;
  final List<LandbuildingModels> listLandBuilding;
  // final List<LandbuildingModel> listLandBuildingModel;

  @override
  State<EditAutoVerbal> createState() => _Add_with_propertyState();
}

class _Add_with_propertyState extends State<EditAutoVerbal> {
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

  VerbalData verbalData = VerbalData();
  VerbalModels verbalModels = VerbalModels(data: []);
  String lable = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? file;
  Uint8List? get_bytes;
  @override
  void initState() {
    // pdfimage();
    // provinceModel();
    super.initState();

    mainData();
  }

  String lableroad = '';
  void mainData() async {
    setState(() {
      titleNumber.text = widget.listData[widget.index]['title_number'] ?? "";
      if (widget.listData[widget.index]['borey'] == 1) {
        checkboreyTP = true;
        listOptin = listRaodBorey;
      } else {
        listOptin = listRaodNBorey;
      }
    });
    if (widget.listData[widget.index]["type_value"].toString() == "T") {
      await verbalData.imagebase64(widget.listData[widget.index]["verbal_id"]);
    }
  }

  String base64string = 'No';

  // int? id_route;
  String bankName = '';
  String branchName = '';

  String base64Image = '';

  List listdata = [];

  bool checkboreyTP = false;
  int countwaiting = 0;
  int countPost = 0;
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
  List listlandbuilding = [];
  VerbalAdd verbalAdd = VerbalAdd();
  int count = 0;
  late Timer _timer;
  bool waitingCheck = false;
  TextEditingController titleNumber = TextEditingController();
  LandbuildingModels landbuildingModel = LandbuildingModels();
  void updateLandbuilding(int index) async {
    if (index < 0 || index >= widget.listLandBuilding.length) {
      return;
    }

    setState(() {
      widget.listLandBuilding[index].verbalLandId =
          landbuildingModel.verbalLandId;
      widget.listLandBuilding[index].verbalLandDes =
          landbuildingModel.verbalLandDes;
      widget.listLandBuilding[index].verbalLandArea =
          landbuildingModel.verbalLandArea;
      widget.listLandBuilding[index].verbalLandMinsqm =
          landbuildingModel.verbalLandMinsqm;
      widget.listLandBuilding[index].verbalLandMaxsqm =
          landbuildingModel.verbalLandMaxsqm;
      widget.listLandBuilding[index].verbalLandMinvalue =
          landbuildingModel.verbalLandMinvalue;
      widget.listLandBuilding[index].verbalLandMaxvalue =
          landbuildingModel.verbalLandMaxvalue;

      indexselect = -1;
    });
  }

  List list = [];
  int indexselect = -1;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          alignment: Alignment.center,
          height: (_byesData != null || get_bytes != null)
              ? widget.hscreen + 200
              : widget.hscreen,
          width: 450,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      const Icon(Icons.qr_code, color: kImageColor, size: 25),
                      const SizedBox(width: 10),
                      Text(
                          widget.listData[widget.index]['verbal_id'].toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor)),
                      const SizedBox(width: 10),
                      const Spacer(),
                      if (verbalAdd.iswaiting.value && verbalAdd.isverbal.value)
                        const Center(child: CircularProgressIndicator())
                      else
                        InkWell(
                          onTap: () async {
                            verbalAdd.iswaiting.value = true;
                            await verbalAdd.timewating();
                            setState(() {
                              list = [];

                              list = widget.listLandBuilding
                                  .where((item) => item.typeValue == 'N')
                                  .map((item) {
                                return item.toJson();
                              }).toList();
                            });
                            await verbalAdd.updateAuto(
                                widget.listData[widget.index],
                                widget.listData[widget.index]['verbal_id'],
                                list,
                                base64string,
                                listlandbuilding);
                            setState(() {
                              // widget.listLandBuilding.clear();
                              checkboreyTP = false;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: greyColor),
                                borderRadius: BorderRadius.circular(5),
                                color: whiteColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Save  ',
                                    style: TextStyle(
                                        color: greyColor,
                                        fontWeight: FontWeight.bold)),
                                Icon(Icons.save_alt, color: greyColor)
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, left: 30),
                    child: Row(
                      children: [
                        Text(
                          'Borey  ',
                          style: TextStyle(color: greyColor, fontSize: 15),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                waitingCheck = true;
                                checkboreyTP = !checkboreyTP;
                                if (!checkboreyTP) {
                                  widget.listData[widget.index]['borey'] = 0;
                                  listOptin = listRaodNBorey;
                                } else {
                                  widget.listData[widget.index]['borey'] = 1;
                                  listOptin = listRaodBorey;
                                }
                                _timer =
                                    Timer.periodic(const Duration(seconds: 1),
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
                                    ? Icons.check_box_outline_blank_outlined
                                    : Icons.check_box_outlined,
                                size: 25,
                                color: greyColor),
                            color: whiteColor),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  if (widget.listData[widget.index]['latlong_log'] != 0)
                    InkWell(
                      onTap: () async {},
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width * 1,
                        margin:
                            const EdgeInsets.only(top: 15, right: 30, left: 30),
                        child: FadeInImage.assetNetwork(
                          placeholderCacheHeight: 50,
                          placeholderCacheWidth: 50,
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.fill,
                          placeholder: 'assets/earth.gif',
                          image:
                              'https://maps.googleapis.com/maps/api/staticmap?center=${(widget.listData[widget.index]['latlong_la'] < widget.listData[widget.index]['latlong_log']) ? "${widget.listData[widget.index]['latlong_la']},${widget.listData[widget.index]['latlong_log']}" : "${widget.listData[widget.index]['latlong_log']},${widget.listData[widget.index]['latlong_la']}"}&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(widget.listData[widget.index]['latlong_la'] < widget.listData[widget.index]['latlong_log']) ? "${widget.listData[widget.index]['latlong_la']},${widget.listData[widget.index]['latlong_log']}" : "${widget.listData[widget.index]['latlong_log']},${widget.listData[widget.index]['latlong_la']}"}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8',
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 1,
                          color: blueColor,
                        )),
                    width: 350,
                    height: 320,
                    child: Obx(() {
                      if (widget.listLandBuilding.isEmpty) {
                        return const Text('No Data');
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: widget.listLandBuilding.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              setState(() {
                                indexselect =
                                    (indexselect == index) ? -1 : index;
                                landbuildingModel.typeValue =
                                    widget.listLandBuilding[index].typeValue;
                                landbuildingModel.verbalLandDes = widget
                                    .listLandBuilding[index].verbalLandDes;
                                landbuildingModel.verbalLandId =
                                    widget.listLandBuilding[index].verbalLandId;

                                landbuildingModel.verbalLandArea = widget
                                    .listLandBuilding[index].verbalLandArea;
                                landbuildingModel.verbalLandMinsqm = widget
                                    .listLandBuilding[index].verbalLandMinsqm;
                                landbuildingModel.verbalLandMaxsqm = widget
                                    .listLandBuilding[index].verbalLandMaxsqm;
                                landbuildingModel.verbalLandMinvalue = widget
                                    .listLandBuilding[index].verbalLandMinvalue;
                                landbuildingModel.verbalLandMaxvalue = widget
                                    .listLandBuilding[index].verbalLandMaxvalue;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Container(
                                width: 270,
                                //height: 210,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: (indexselect != index) ? 1 : 2,
                                      color: (indexselect != index)
                                          ? kPrimaryColor
                                          : greenColors),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                ),

                                child: Column(
                                  children: [
                                    Stack(
                                      //widget.listLandBuilding[index].typeValue ?? ""
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${widget.listLandBuilding[index].verbalLandid}',
                                              style: NameProperty(),
                                            ),
                                            Text(
                                              '${widget.listLandBuilding[index].typeValue}',
                                              style: NameProperty(),
                                            ),
                                            const Spacer(),

                                            (indexselect != index)
                                                ? Icon(Icons.edit,
                                                    color: greyColor, size: 25)
                                                : IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        AwesomeDialog(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          width: 450,
                                                          context: context,
                                                          dialogType: DialogType
                                                              .success,
                                                          animType: AnimType
                                                              .rightSlide,
                                                          headerAnimationLoop:
                                                              false,
                                                          title: 'Done',
                                                          desc:
                                                              "Do you want to update!",
                                                          btnOkOnPress:
                                                              () async {
                                                            if (landbuildingModel
                                                                    .typeValue !=
                                                                'N') {
                                                              await verbalAdd
                                                                  .updatelandbuilding(
                                                                      landbuildingModel);
                                                            }
                                                            updateLandbuilding(
                                                                index);
                                                          },
                                                          btnCancelOnPress:
                                                              () {},
                                                        ).show();
                                                      });
                                                    },
                                                    icon: Icon(Icons.edit,
                                                        color: greenColors,
                                                        size: 25)),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  check = true;

                                                  listlandbuilding.add({
                                                    "verbal_land_id": widget
                                                        .listLandBuilding[index]
                                                        .verbalLandId
                                                  });
                                                  widget.listLandBuilding
                                                      .removeAt(index);
                                                });
                                              },
                                            ),
                                            // )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${widget.listLandBuilding[index].address ?? ""} ',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 3.0),
                                    const Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: kPrimaryColor),
                                    const SizedBox(height: 3.0),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            textTitle("Depreciation", index,
                                                indexselect),
                                            const SizedBox(height: 3),
                                            if (widget.listLandBuilding[index]
                                                    .verbalLandDes !=
                                                "LS")
                                              textTitle(
                                                  "Floor", index, indexselect),
                                            const SizedBox(height: 3),
                                            textTitle(
                                                "Area", index, indexselect),
                                            const SizedBox(height: 3),
                                            textTitle("Max Value/Sqm", index,
                                                indexselect),
                                            const SizedBox(height: 3),
                                            textTitle("Min Value/Sqm", index,
                                                indexselect),
                                            const SizedBox(height: 3),
                                            textTitle("Max Value", index,
                                                indexselect),
                                            const SizedBox(height: 3),
                                            textTitle("Min Value", index,
                                                indexselect),
                                          ],
                                        ),
                                        const SizedBox(width: 15),
                                        // Column(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.start,
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     if (indexselect == index)
                                        //       InputController(
                                        //           controllerback: (value) {
                                        //             setState(() {
                                        //               if (value != "" ||
                                        //                   value != null) {
                                        //                 landbuildingModel
                                        //                         .verbalLandDes =
                                        //                     value;
                                        //               }
                                        //             });
                                        //           },
                                        //           value: widget
                                        //                   .listLandBuilding[
                                        //                       index]
                                        //                   .verbalLandDes ??
                                        //               "")
                                        //     else
                                        //       textName(
                                        //         " : ${widget.listLandBuilding[index].verbalLandDes ?? ""}",
                                        //       ),
                                        //     if (widget.listLandBuilding[index]
                                        //             .verbalLandDes !=
                                        //         "LS")
                                        //       if (indexselect == index)
                                        //         InputController(
                                        //             controllerback: (value) {
                                        //               setState(() {
                                        //                 if (value != "" ||
                                        //                     value != null) {
                                        //                   landbuildingModel
                                        //                           .verbalLandDes =
                                        //                       value;
                                        //                 }
                                        //               });
                                        //             },
                                        //             value: widget
                                        //                     .listLandBuilding[
                                        //                         index]
                                        //                     .verbalLandDes ??
                                        //                 "")
                                        //       else
                                        //         textName(
                                        //           " : ${widget.listLandBuilding[index].verbalLandDes ?? ""}",
                                        //         ),
                                        //     const SizedBox(height: 2),
                                        //     if (indexselect == index)
                                        //       InputController(
                                        //           controllerback: (value) {
                                        //             setState(() {
                                        //               if (value != "" ||
                                        //                   value != null) {
                                        //                 landbuildingModel
                                        //                         .verbalLandArea =
                                        //                     double.parse(value);
                                        //               }
                                        //             });
                                        //           },
                                        //           value:
                                        //               "${widget.listLandBuilding[index].verbalLandArea ?? ""}")
                                        //     else
                                        //       textName(
                                        //         " : ${widget.listLandBuilding[index].verbalLandArea ?? ""}m\u00B2",
                                        //       ),
                                        //     const SizedBox(height: 2),
                                        //     if (indexselect == index)
                                        //       InputController(
                                        //           controllerback: (value) {
                                        //             setState(() {
                                        //               if (value != "" ||
                                        //                   value != null) {
                                        //                 landbuildingModel
                                        //                         .verbalLandMinsqm =
                                        //                     double.parse(value);
                                        //               }
                                        //             });
                                        //           },
                                        //           value:
                                        //               "${widget.listLandBuilding[index].verbalLandMinsqm ?? ""}")
                                        //     else
                                        //       textName(
                                        //         " : ${widget.listLandBuilding[index].verbalLandMinsqm ?? ""}",
                                        //       ),
                                        //     const SizedBox(height: 2),
                                        //     if (indexselect == index)
                                        //       InputController(
                                        //           controllerback: (value) {
                                        //             setState(() {
                                        //               if (value != "" ||
                                        //                   value != null) {
                                        //                 landbuildingModel
                                        //                         .verbalLandMaxsqm =
                                        //                     double.parse(value);
                                        //               }
                                        //             });
                                        //           },
                                        //           value:
                                        //               "${widget.listLandBuilding[index].verbalLandMaxsqm ?? ""}")
                                        //     else
                                        //       textName(
                                        //         " : ${widget.listLandBuilding[index].verbalLandMaxsqm ?? ""}",
                                        //       ),
                                        //     const SizedBox(height: 2),
                                        //     if (indexselect == index)
                                        //       InputController(
                                        //           controllerback: (value) {
                                        //             setState(() {
                                        //               if (value != "" ||
                                        //                   value != null) {
                                        //                 landbuildingModel
                                        //                         .verbalLandMinsqm =
                                        //                     double.parse(value);
                                        //               }
                                        //             });
                                        //           },
                                        //           value:
                                        //               "${widget.listLandBuilding[index].verbalLandMinvalue ?? ""}")
                                        //     else
                                        //       textName(
                                        //         " : ${widget.listLandBuilding[index].verbalLandMinsqm ?? ""}\$",
                                        //       ),
                                        //     const SizedBox(height: 2),
                                        //     if (indexselect == index)
                                        //       InputController(
                                        //           controllerback: (value) {
                                        //             setState(() {
                                        //               if (value != "" ||
                                        //                   value != null) {
                                        //                 landbuildingModel
                                        //                         .verbalLandMaxvalue =
                                        //                     double.parse(value);
                                        //               }
                                        //             });
                                        //           },
                                        //           value:
                                        //               "${widget.listLandBuilding[index].verbalLandMaxvalue ?? ""}")
                                        //     else
                                        //       textName(
                                        //         " : ${widget.listLandBuilding[index].verbalLandMaxvalue ?? ""}\$",
                                        //       ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Text(verbalData
                          //     .listlandbuilding[index].verbalLandId
                          //     .toString()),
                        );
                      }
                    }),
                  ),
                  // if (widget.listLandBuilding.isNotEmpty)
                  //   SizedBox(
                  //     width: MediaQuery.of(context).size.width * 0.7,
                  //     height: 280,
                  //     child: SingleChildScrollView(
                  //       scrollDirection: Axis.vertical,
                  //       child: Center(
                  //         child: Column(
                  //           children: [
                  //             for (int i = 0;
                  //                 i < widget.listLandBuilding.length;
                  //                 i++)

                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: TextFormField(
                      controller: titleNumber,
                      onChanged: (value) {
                        setState(() {
                          widget.listData[widget.index]['title_number'] = value;
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: kwhite,
                        filled: true,
                        labelText: "Title Number",
                        labelStyle: const TextStyle(color: kTextLightColor),
                        prefixIcon: const Icon(Icons.location_on_rounded,
                            color: kImageColor),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
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
                  const SizedBox(height: 10),
                  if (_byesData == null && get_bytes == null)
                    Obx(
                      () {
                        if (verbalData.isVerbalImage.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (verbalData.listImage.isEmpty) {
                          return const Center(child: Text('No Image'));
                        } else {
                          return Column(
                            children: [
                              if (verbalData.listImage.isNotEmpty &&
                                  verbalData.listImage[0]['verbalImage'] !=
                                      null &&
                                  verbalData.listImage[0]['verbalImage'] !=
                                      "No")
                                Image(
                                    height: 150,
                                    image: MemoryImage(
                                      base64Decode(verbalData.listImage[0]
                                          ['verbalImage']),
                                    ),
                                    fit: BoxFit.cover),
                            ],
                          );
                        }
                      },
                    ),
                  if (_byesData != null && cropORopen == false)
                    SizedBox(
                      height: 150,
                      child: Image.memory(
                        _byesData!,
                      ),
                    )
                  else if (get_bytes != null && cropORopen == true)
                    SizedBox(height: 150, child: Image.memory(get_bytes!)),
                  if (_byesData != null)
                    IconButton(
                        onPressed: () {
                          _cropImage();
                        },
                        icon: const Icon(
                          Icons.crop,
                          size: 35,
                          color: Colors.grey,
                        )),
                  const SizedBox(height: 10.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 30),
                      Text("Road",
                          style: TextStyle(
                              color: (widget.listData[widget.index]['road'] ==
                                      null)
                                  ? Colors.red
                                  : whiteColor,
                              fontSize: 14)),
                    ],
                  ),

                  const SizedBox(height: 5),
                  waitingCheck
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          child: SizedBox(
                            width: double.infinity,
                            child: OptionRoadNew(
                              pwidth: 250,
                              hight: 45,
                              list: listOptin,
                              valueId: "road_id",
                              // valueName: "road_name",
                              valueName: "road_name",
                              lable: widget.listData[widget.index]
                                      ['road_name'] ??
                                  "",
                              onbackValue: (value) {
                                setState(() {
                                  List<String> parts = value!.split(',');

                                  lable = parts[1];
                                  widget.listData[widget.index]['road'] =
                                      int.parse(parts[0].toString());
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
                    padding: const EdgeInsets.only(right: 30, left: 30),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            openImgae();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Image',
                                  style: TextStyle(
                                      color: greyColorNolot,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Container(
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
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  widget.listData[widget.index]
                                          ['property_type_name'] ??
                                      "Property Type",
                                  style: TextStyle(
                                      color: greyColorNolot,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              propertyType(
                                lable: "propertyTypes *",
                                value: (value) {
                                  setState(() {
                                    widget.listData[widget.index]
                                        ['property_type_id'] = int.parse(value);
                                  });
                                },
                                valueName: "propertyTypes *",
                                valuenameback: (value) {},
                              ),
                            ],
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
                    bankName:
                        'Bank (${widget.listData[widget.index]['bank_name'] ?? ""})',
                    branchName:
                        'Branch (${widget.listData[widget.index]['bank_branch_name'] ?? ""})',
                    bank: (value) {
                      setState(() {
                        widget.listData[widget.index]['verbal_bank_id'] =
                            int.parse(value);
                      });
                    },
                    bankbranch: (value) {
                      setState(() {
                        widget.listData[widget.index]['verbal_bank_branch_id'] =
                            int.parse(value);
                      });
                    },
                  ),

                  FormTwinNController(
                    controller1:
                        widget.listData[widget.index]['verbal_owner'] ?? "",
                    controller2:
                        widget.listData[widget.index]['verbal_contact'] ?? "",
                    label1: 'Owner',
                    label2: 'Contact',
                    controller1Back: (input) {
                      setState(() {
                        widget.listData[widget.index]['verbal_owner'] = input!;
                      });
                    },
                    controller2Back: (input) {
                      setState(() {
                        widget.listData[widget.index]['verbal_contact'] =
                            input!;
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
                  FormTwinNController(
                    controller1: widget.listData[widget.index]
                            ['verbal_bank_officer'] ??
                        "",
                    controller2: widget.listData[widget.index]
                            ['verbal_bank_contact'] ??
                        "",
                    label1: 'Bank Officer',
                    label2: 'Contact',
                    controller1Back: (input) {
                      setState(() {
                        widget.listData[widget.index]['verbal_bank_officer'] =
                            input!;
                      });
                    },
                    controller2Back: (input) {
                      setState(() {
                        widget.listData[widget.index]['verbal_bank_contact'] =
                            input!;
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
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      controller: widget.addressController,
                      decoration: InputDecoration(
                        fillColor: kwhite,
                        filled: true,
                        labelText: "Phum optional",
                        labelStyle: const TextStyle(color: kTextLightColor),
                        prefixIcon: const Icon(Icons.location_on_rounded,
                            color: kImageColor),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
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

  Widget textTitle(title, i, indexselect) {
    return (indexselect != i)
        ? Text(
            title,
            style: const TextStyle(color: kPrimaryColor, fontSize: 12),
          )
        : Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              alignment: Alignment.center,
              height: 25,
              child: Text(
                title,
                style: const TextStyle(color: kPrimaryColor, fontSize: 12),
              ),
            ),
          );
  }

  Widget textName(title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
              color: kImageColor, fontSize: 13, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  // bool waiting = false;
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

  TextStyle NameProperty() {
    return TextStyle(
        color: kImageColor, fontSize: 13, fontWeight: FontWeight.bold);
  }
}
