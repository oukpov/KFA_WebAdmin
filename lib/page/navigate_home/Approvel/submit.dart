// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../components/ApprovebyAndVerifyby.dart';
import '../../../../components/bank_dropdown.dart';
import '../../../components/colors.dart';
import '../../../getx/component/getx._snack.dart';
import '../../../getx/submit_agent/agent_admin.dart';
import 'component/googleMapApprovel.dart';
import 'component/inputUpdate.dart';
import 'component/input_controller.dart';

class SubmitAgent extends StatefulWidget {
  const SubmitAgent(
      {super.key,
      required this.indexs,
      required this.backvalue,
      required this.idController,
      required this.device,
      required this.list,
      required this.usernameAgent,
      required this.docID,
      required this.page,
      required this.perpage,
      required this.listUser});
  final int indexs;
  final String idController;
  final String device;
  final String usernameAgent;
  final List list;
  final OnChangeCallback backvalue;
  final String docID;
  final int page;
  final int perpage;
  final List listUser;
  @override
  State<SubmitAgent> createState() => _Edit_Auto_with_propertyState();
}

class _Edit_Auto_with_propertyState extends State<SubmitAgent>
    with SingleTickerProviderStateMixin {
  int? opt;
  double? asking_price;
  String propertyType = '', propertyTypeValue = '';
  var code = 0;
  TextEditingController dateinput = TextEditingController();
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

  late List<dynamic> list_Khan;
  double? lat1;
  double? log2;
  String? filePath;
  void deleteItemToList(int Id) {
    setState(() {
      // lb.removeAt(Id);
      // deleteLand(landID);
    });
  }

  List listlandbuilding = [];
  Future<void> landbuilding() async {
    print("widget.docID : ${widget.docID}");
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_land?verbal_landid=${widget.docID}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listlandbuilding = jsonDecode(json.encode(response.data));
        // for (int i = 0; i < listlandbuilding.length; i++) {

        // lb.add(
        //   L_B(
        //       listlandbuilding[i]['verbal_land_type'].toString(),
        //       listlandbuilding[i]['verbal_land_des'].toString(),
        //       listlandbuilding[i]['verbal_land_dp'].toString(),
        //       listlandbuilding[i]['address'].toString(),
        //       listlandbuilding[i]['verbal_landid'].toString(),
        //       listlandbuilding[i]['verbal_land_area'],
        //       listlandbuilding[i]['verballandminsqm'],
        //       listlandbuilding[i]['verballandmaxsqm'],
        //       listlandbuilding[i]['verballandminvalue'],
        //       listlandbuilding[i]['verballandmaxvalue'] ?? 0),
        //   // L_B(autoverbalType, description, dep, widget.address, widget.landId,
        //   //     area, minSqm!, maxSqm!, totalMin!, totalMax ?? 0),
        // );
        // }
      });
    } else {
      // print(response.statusMessage);
    }
  }

  Future<void> deleteLandbuild(id) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/landbuilding/delete/$id',
      options: Options(
        method: 'DELETE',
      ),
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
    } else {
      // print(response.statusMessage);
    }
  }

  String verbalID = '';
  String propertytypeId = '0';
  String lats = "";
  String lngs = "";
  String approveId = "";
  String agent = "";
  String bankBranchId = "";
  String bankContact = "";
  String bankId = "0";
  String bankOfficer = "";
  String comment = "";
  String contact = "";
  String date = "";
  String image = "";
  String bankName = "";
  String bankbranch = "";
  int option = 0;
  String owner = "";
  String user = "";
  String verbalCom = "";
  String verbalCon = "30";
  List verbal = [];
  String? verbalProvinceID;
  String? verbalDistrictID;
  String? verbalCommuneID;
  String verbalKhan = "";
  String base64string = '';
  String address = '';
  int index = 0;
  File? file;
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> offsetAnimation;
  var formatter = NumberFormat("##,###,###,###", "en_US");
  @override
  void initState() {
    mainValue();
    optionDrop();
    landbuilding();
    lat1;
    log2;
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
    super.initState();
  }

  ListAgent listAgent = ListAgent();
  var sizeh = const SizedBox(height: 15);
  var listEdit;
  void mainValue() async {
    setState(() {
      // waiting = true;
    });
    listEdit = widget.list[widget.indexs];
    verbalID = listEdit['verbal_id'].toString();
    if (listEdit['latlong_la'] < listEdit['latlong_la']) {
      lats = listEdit['latlong_la'].toString();
      lngs = listEdit['latlong_log'].toString();
    } else {
      lats = listEdit['latlong_log'].toString();
      lngs = listEdit['latlong_la'].toString();
    }

    optionID.text = listEdit['verbal_option'].toString();
    if (optionID.text == "16") {
      optionIDText.text = "Normal/Center ";
    } else if (optionID.text == "17") {
      optionComment.text = '5%';
      optionIDText.text = "Corner1";
    } else if (optionID.text == "18") {
      optionComment.text = '3%';
      optionIDText.text = "Corner2";
    } else if (optionID.text == "19") {
      optionComment.text = '2%';
      optionIDText.text = "Corner3";
    } else if (optionID.text == "20") {
      optionComment.text = '1%';
      optionIDText.text = "Last One";
    }
    if (int.parse("${listEdit['borey'] ?? "0"}") == 0) {
      checkBorey = false;
    } else {
      checkBorey = true;
    }
    propertyTxt.text = listEdit['property_type_name'].toString();
    propertytypeId = listEdit['verbal_property_id'].toString();
    owner = listEdit['verbal_owner'] ?? "";
    contact = listEdit['verbal_contact'] ?? "";
    bankOfficer = listEdit['verbal_bank_officer'] ?? "";
    bankContact = listEdit['verbal_bank_contact'] ?? "";
    addressController.text = address = listEdit['verbal_address'] ?? "";
    bankName = listEdit['bank_name'] ?? "";
    bankId = (listEdit['verbal_bank_id'] == "0" ||
            listEdit['verbal_bank_id'] == null)
        ? "0"
        : listEdit['verbal_bank_id'].toString();
    date = listEdit['verbal_date'] ?? "";
    bankbranch = listEdit['bank_branch_name'] ?? "";
    bankBranchId = (listEdit['verbal_bank_branch_id'] == "0" ||
            listEdit['verbal_bank_branch_id'] == null)
        ? "0"
        : listEdit['verbal_bank_branch_id'].toString();
    option = listEdit['verbal_option'] ?? 0;
    date = listEdit['verbal_created_date'] ?? "";
    verbalKhan = listEdit['verbal_khan'] ?? "";
    await getimage();
  }

  Future<void> deleteLand(id) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/landbuilding/delete/$id',
      options: Options(
        method: 'DELETE',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> updateLandBuidling(landid) async {
    // print(
    //     "landid : $landid\n verballandminsqm : $verballandminsqm\n verballandmaxsqm : $verballandmaxsqm\n verballandminvalue : $verballandminvalue\n verballandmaxvalue : $verballandmaxvalue");
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "verbal_land_minsqm": verballandminsqm,
      "verbal_land_maxsqm": verballandmaxsqm,
      "verbal_land_minvalue": verballandminvalue,
      "verbal_land_maxvalue": verballandmaxvalue
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update/landbuilding/$landid',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      setState(() {
        indexselect = -1;
      });
    } else {
      // print(response.statusMessage);
    }
  }

  Future<void> updateAuto(var listData) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "agent_name": widget.usernameAgent,
      "agent_id": widget.idController,
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update/approvelAgent/$verbalID',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      // await updateFirebase();

      component.handleTap("Done!", "Update successfuly");
      listAgent.sendMessage(
        "Client ID : ${listData['control_user']} 🆔\nName : ${listData['username'] ?? ""} 👤\nPhone : ${listData['tel_num'] ?? ""} ☎️\nDate : ${listData['verbal_date']} ⏰\n---------------------------\nCode : ${listData['protectID'] ?? ""} 🔔\nSubmit Agent : Done! ✅\nApprove by Agent : ${widget.listUser[0]['username'] ?? ""}! 👨‍💻\nDate Done : $formattedDate ⏰\nLinkURl : https://oneclickonedollar.com/#/ 🌐",
      );
    }
  }

  Component component = Component();

  Future<void> updateFirebase() async {
    FirebaseFirestore.instance
        .collection('verbal_approvelTable')
        .doc(widget.docID)
        .update({
      'agent_id': widget.idController,
      'agent_name': widget.usernameAgent,
      'check': 0,
    });
  }

  @override
  void dispose() {
    controller.dispose();
    optionType.dispose();
    editAutoressController.dispose();
    optionComment.dispose();
    optionIDText.dispose();
    propertyTxt.dispose();
    propertyID.dispose();
    addressController.dispose();
    super.dispose();
  }

  TextEditingController optionType = TextEditingController();
  TextEditingController optionComment = TextEditingController();
  TextEditingController optionID = TextEditingController();
  TextEditingController optionIDText = TextEditingController();
  TextEditingController propertyTxt = TextEditingController();
  TextEditingController propertyID = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List listdata = [];
  List listImage = [];
  String? byesDatas;
  Future<void> getimage() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/images?protectID=${listEdit['protectID'].toString()}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      listImage = jsonDecode(json.encode(response.data));
      setState(() {
        if (listImage.isNotEmpty) {
          byesDatas = listImage[0]['verbalImage'].toString();
        } else {
          byesDatas = "No";
        }
      });
    }
  }

  String verballandminsqm = '',
      verballandmaxsqm = '',
      verballandminvalue = '',
      verballandmaxvalue = '';
  TextEditingController editAutoressController = TextEditingController();
  List listTitle = [
    {"title": "Cancle"},
    {"title": "OK"},
  ];
  bool checkrequest = false;
  Uint8List? getbytesMID;
  int? number;
  bool districtbool = false;

  int indexselect = -1;

  bool checkBorey = false;
  bool check = false;
  @override
  Widget build(BuildContext context) {
    final listAgent = Get.put(ListAgent());
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 40),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: (widget.device == 't')
                  ? 600
                  : (widget.device == 'd')
                      ? 500
                      : MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: waiting
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.remove_circle_outline_rounded,
                                    size: 35,
                                    color: greyColor,
                                  )),
                              const SizedBox(width: 10),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              const SizedBox(width: 40),
                              const Icon(
                                Icons.qr_code,
                                color: kImageColor,
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                verbalID,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () async {
                                  AwesomeDialog(
                                    width: 400,
                                    context: context,
                                    animType: AnimType.leftSlide,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.success,
                                    showCloseIcon: false,
                                    title: 'Do you want to Update',
                                    autoHide: const Duration(seconds: 2),
                                    btnOkOnPress: () async {
                                      await updateAuto(listEdit);
                                      await listAgent.listAgent(widget.perpage,
                                          widget.page, 3, "", "", "");
                                      Navigator.pop(context);
                                    },
                                    btnCancelOnPress: () {},
                                  ).show();
                                },
                                child: Card(
                                  elevation: 20,
                                  color: greenColors,
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromARGB(
                                            255, 42, 118, 10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Approve',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                        Icon(Icons.save_alt,
                                            color: Colors.white)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(right: 30, left: 30),
                            child: Row(
                              children: [
                                Text(!checkBorey ? "No Borey" : "Borey",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: greyColor,
                                        fontSize: 14)),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        checkBorey = !checkBorey;
                                      });
                                    },
                                    icon: Icon(
                                      !checkBorey
                                          ? Icons
                                              .check_box_outline_blank_rounded
                                          : Icons.check_box_outlined,
                                      color: greyColor,
                                    ))
                              ],
                            ),
                          ),
                          if (lats != null && lat1 == null)
                            InkWell(
                              onTap: () async {
                                await launchUrl(Uri.parse(
                                    "https://www.google.com/maps/place/${(double.parse(lats) < double.parse(lngs)) ? "$lats,$lngs" : "$lngs,$lats"}/@${(double.parse(lats) < double.parse(lngs)) ? "$lats,$lngs" : "$lngs,$lats"}2m/data=!3m1!1e3!4m4!3m3!8m2!3d${(double.parse(lats) < double.parse(lngs)) ? "$lats,$lngs" : "$lngs,$lats"}?entry=ttu"));
                              },
                              child: Container(
                                height: 250,
                                width: MediaQuery.of(context).size.width * 1,
                                margin: const EdgeInsets.only(
                                    top: 15, right: 30, left: 30),
                                child: FadeInImage.assetNetwork(
                                  placeholderCacheHeight: 120,
                                  placeholderCacheWidth: 120,
                                  fit: BoxFit.cover,
                                  placeholderFit: BoxFit.contain,
                                  placeholder: 'assets/earth.gif',
                                  image: (double.parse(lats) <
                                          double.parse(lngs))
                                      ? 'https://maps.googleapis.com/maps/api/staticmap?center=$lats,$lngs&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C$lats,$lngs&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'
                                      : 'https://maps.googleapis.com/maps/api/staticmap?center=$lngs,$lats&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C$lngs,$lats&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                ),
                              ),
                            )
                          else if (lat1 != null)
                            InkWell(
                              onTap: () async {
                                await slideUp(context);
                              },
                              child: Container(
                                height: 250,
                                width: MediaQuery.of(context).size.width * 1,
                                margin: const EdgeInsets.only(
                                    top: 15, right: 30, left: 30),
                                child: FadeInImage.assetNetwork(
                                  placeholderCacheHeight: 50,
                                  placeholderCacheWidth: 50,
                                  fit: BoxFit.cover,
                                  placeholderFit: BoxFit.fill,
                                  placeholder: 'assets/earth.gif',
                                  image:
                                      'https://maps.googleapis.com/maps/api/staticmap?center=${lat1},${log2}&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat1},${log2}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                                ),
                              ),
                            ),
                          if (lat1 == null && checkrequest == true)
                            request('Please select your location'),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.only(left: 30),
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        optionComment.text =
                                            "${newValue!.split(",")[0]}%";
                                        option = int.parse(
                                            newValue.split(",")[1].toString());
                                        load2(newValue.split(",")[1]);
                                      });
                                    },
                                    items: listOption
                                        .map<DropdownMenuItem<String>>(
                                          (value) => DropdownMenuItem<String>(
                                            value:
                                                "${value["opt_value"]},${value["opt_id"]}",
                                            child: Text(value["opt_des"]),
                                          ),
                                        )
                                        .toList(),
                                    icon: const Icon(Icons.arrow_drop_down,
                                        color: kImageColor),
                                    decoration: InputDecoration(
                                      fillColor: kwhite,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8),
                                      labelStyle:
                                          const TextStyle(color: kPrimaryColor),
                                      labelText: (optionIDText.text == "")
                                          ? "Option Select"
                                          : optionIDText.text,
                                      hintText: 'Select one',
                                      prefixIcon: const Icon(
                                        Icons.my_library_books_rounded,
                                        color: kImageColor,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: kPrimaryColor, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: kPrimaryColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  margin: const EdgeInsets.only(right: 30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    height: 40,
                                    child: TextFormField(
                                      controller: optionComment,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        fillColor: kwhite,
                                        filled: true,
                                        labelText: 'Comment',
                                        prefixIcon: const Icon(
                                          Icons.comment_sharp,
                                          color: kImageColor,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: kPrimaryColor, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: kPrimaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          if (listlandbuilding.length <= 1 &&
                              checkrequest == true)
                            request('request your land/building'),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 330,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (int i = 0;
                                        i < listlandbuilding.length;
                                        i++)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            indexselect =
                                                (indexselect == -1) ? i : -1;

                                            verballandminsqm =
                                                "${listlandbuilding[i]['verbal_land_minsqm'] ?? ""}";
                                            verballandmaxsqm =
                                                "${listlandbuilding[i]['verbal_land_maxsqm'] ?? ""}";
                                            verballandminvalue =
                                                "${listlandbuilding[i]['verbal_land_minvalue'] ?? ""}";
                                            verballandmaxvalue =
                                                "${listlandbuilding[i]['verbal_land_maxvalue'] ?? ""}";
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 10, 10),
                                          child: Container(
                                            width: 250,
                                            //height: 210,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: (indexselect == i)
                                                      ? 3
                                                      : 1,
                                                  color: (indexselect == i)
                                                      ? greenColors
                                                      : kPrimaryColor),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                            '${(listlandbuilding[i]['verbal_land_type'] == "" || listlandbuilding[i]['verbal_land_type'] == null) ? "" : listlandbuilding[i]['verbal_land_type']} ',
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
                                                                  (indexselect ==
                                                                          i)
                                                                      ? IconButton(
                                                                          icon:
                                                                              Icon(
                                                                            Icons.edit,
                                                                            color:
                                                                                greenColors,
                                                                            size:
                                                                                30,
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            AwesomeDialog(
                                                                              width: 400,
                                                                              context: context,
                                                                              animType: AnimType.leftSlide,
                                                                              headerAnimationLoop: false,
                                                                              dialogType: DialogType.success,
                                                                              showCloseIcon: false,
                                                                              title: 'Do you want to Update',
                                                                              autoHide: const Duration(seconds: 2),
                                                                              btnOkOnPress: () async {
                                                                                // print("checklandbulding => True");
                                                                                await updateLandBuidling(listlandbuilding[i]['verbal_land_id'].toString());
                                                                              },
                                                                              btnCancelOnPress: () {},
                                                                            ).show();
                                                                          },
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .edit,
                                                                          color:
                                                                              greyColorNolot,
                                                                          size:
                                                                              30,
                                                                        )),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5.0),
                                                const Divider(
                                                    height: 1,
                                                    thickness: 1,
                                                    color: kPrimaryColor),
                                                const SizedBox(height: 5),
                                                Text(
                                                  "${(listlandbuilding[i]['address'] == null || listlandbuilding[i]['address'] == "") ? "" : listlandbuilding[i]['address']}",
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
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
                                                        sizeh,
                                                        Text(
                                                          "Floor",
                                                          style: Label(),
                                                        ),
                                                        sizeh,
                                                        Text(
                                                          "Area",
                                                          style: Label(),
                                                        ),
                                                        sizeh,
                                                        Text(
                                                          'Min Value/Sqm',
                                                          style: Label(),
                                                        ),
                                                        sizeh,
                                                        Text(
                                                          'Max Value/Sqm',
                                                          style: Label(),
                                                        ),
                                                        sizeh,
                                                        Text(
                                                          'Min Value',
                                                          style: Label(),
                                                        ),
                                                        sizeh,
                                                        Text(
                                                          'Man Value',
                                                          style: Label(),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 15),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextInputUpdate(
                                                            type: "",
                                                            readonly: true,
                                                            backvalue:
                                                                (value) {},
                                                            value:
                                                                "${listlandbuilding[i]['verbal_land_des'] ?? ""}"),
                                                        TextInputUpdate(
                                                            type: "",
                                                            readonly: true,
                                                            backvalue:
                                                                (value) {},
                                                            value:
                                                                "${listlandbuilding[i]['verbal_land_dp'] ?? ""}"),
                                                        TextInputUpdate(
                                                            type: " m\u00B2",
                                                            readonly: true,
                                                            backvalue:
                                                                (value) {},
                                                            value:
                                                                "${listlandbuilding[i]['verbal_land_area'] ?? ""}"),
                                                        TextInputUpdate(
                                                            type: " \$",
                                                            readonly:
                                                                (indexselect ==
                                                                        i)
                                                                    ? false
                                                                    : true,
                                                            backvalue: (value) {
                                                              setState(() {
                                                                verballandminsqm =
                                                                    value;
                                                              });
                                                            },
                                                            value:
                                                                "${listlandbuilding[i]['verbal_land_minsqm'] ?? ""}"),
                                                        TextInputUpdate(
                                                            type: " \$",
                                                            readonly:
                                                                (indexselect ==
                                                                        i)
                                                                    ? false
                                                                    : true,
                                                            backvalue: (value) {
                                                              setState(() {
                                                                verballandmaxsqm =
                                                                    value;
                                                              });
                                                            },
                                                            value:
                                                                "${listlandbuilding[i]['verbal_land_maxsqm'] ?? ""}"),
                                                        TextInputUpdate(
                                                            type: " \$",
                                                            readonly:
                                                                (indexselect ==
                                                                        i)
                                                                    ? false
                                                                    : true,
                                                            backvalue: (value) {
                                                              setState(() {
                                                                verballandminvalue =
                                                                    value;
                                                              });
                                                            },
                                                            value:
                                                                "${listlandbuilding[i]['verbal_land_minvalue'] ?? ""}"),
                                                        TextInputUpdate(
                                                            type: " \$",
                                                            readonly:
                                                                (indexselect ==
                                                                        i)
                                                                    ? false
                                                                    : true,
                                                            backvalue: (value) {
                                                              setState(() {
                                                                verballandmaxvalue =
                                                                    value;
                                                              });
                                                            },
                                                            value:
                                                                "${listlandbuilding[i]['verbal_land_maxvalue'] ?? ""}")
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (byesDatas != "No" && listImage.isNotEmpty)
                            Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: MemoryImage(base64Decode(byesDatas!)),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(11),
                              ),
                            ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.only(right: 30, left: 30),
                            child: Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    // openImgae();
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
                                    // Padding: EdgeInsets.only(left: 30, right: 30),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: const [
                                            SizedBox(width: 10),
                                            Icon(
                                              Icons.map_sharp,
                                              color: kImageColor,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'choosed Photo',
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        )),
                                  ),
                                )),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: SizedBox(
                                  height: 45,
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,

                                    onChanged: (newValue) {
                                      setState(() {
                                        propertytypeId =
                                            newValue!.split(" ")[0];
                                        propertyTxt.text =
                                            newValue.split(" ")[1];
                                      });
                                    },

                                    items: []
                                        .map<DropdownMenuItem<String>>(
                                          (value) => DropdownMenuItem<String>(
                                            value:
                                                "${value["property_type_id"]} " +
                                                    value["property_type_name"],
                                            child: Text(
                                              value["property_type_name"],
                                              style: TextStyle(
                                                  fontSize: MediaQuery
                                                          .textScaleFactorOf(
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
                                          const EdgeInsets.symmetric(
                                              vertical: 8),
                                      labelText: (propertyTxt.text == "null" ||
                                              propertyTxt.text == "")
                                          ? 'Property'
                                          : propertyTxt.text,
                                      hintText: 'Select one',
                                      prefixIcon: const Icon(
                                        Icons.business_outlined,
                                        color: kImageColor,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: kPrimaryColor, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: kPrimaryColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ),
                          BankDropdownSearch(
                            bankbranchback: (value) {},
                            banknameback: (value) {},
                            bankName: "Bank : $bankName",
                            branchName: "Branch : $bankbranch",
                            bank: (value) {
                              setState(() {
                                bankId = value;
                              });
                            },
                            bankbranch: (value) {
                              setState(() {
                                bankBranchId = value;
                              });
                            },
                          ),
                          Row(
                            children: [
                              Input_controller(
                                  icon: const Icon(
                                    Icons.person,
                                    color: kImageColor,
                                  ),
                                  lable: 'Owner',
                                  pakage: 1,
                                  controllerback: (value) {
                                    setState(() {
                                      owner = value;
                                    });
                                  },
                                  value: owner,
                                  flex: 3),
                              const SizedBox(width: 10),
                              Input_controller(
                                  icon: const Icon(
                                    Icons.phone,
                                    color: kImageColor,
                                  ),
                                  lable: 'Contact',
                                  pakage: 2,
                                  controllerback: (value) {
                                    setState(() {
                                      contact = value;
                                    });
                                  },
                                  value: contact,
                                  flex: 3),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Input_controller(
                                  icon: const Icon(
                                    Icons.work,
                                    color: kImageColor,
                                  ),
                                  lable: 'Bank Officer',
                                  pakage: 1,
                                  controllerback: (value) {
                                    setState(() {
                                      bankOfficer = value;
                                    });
                                  },
                                  value: bankOfficer,
                                  flex: 3),
                              const SizedBox(width: 10),
                              Input_controller(
                                  icon: const Icon(
                                    Icons.phone,
                                    color: kImageColor,
                                  ),
                                  lable: 'Contact',
                                  pakage: 2,
                                  controllerback: (value) {
                                    setState(() {
                                      bankContact = value;
                                    });
                                  },
                                  value: bankContact,
                                  flex: 3),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: TextFormField(
                              controller: addressController,
                              onChanged: (value) {
                                setState(() {
                                  // controller.text = value;
                                  address = value;
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
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  bool firstTime = false;
  bool waiting = false;
  List listOption = [];
  void optionDrop() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/options'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        listOption = jsonData;
      });
    }
  }

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

  Future<void> slideUp(BuildContext context) async {
//=============================================================
    print('lats : $lats || lngs : $lngs');
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => GoogleMapApprovel(
                lat: double.parse(lats),
                log: double.parse(lngs),
              )),
    );

    setState(() {
      image = verbalID.toString();
    });
    if (!mounted) return;
  }

//===================== Upload Image to MySql Server
  List listOptions = [];
  void load2(id) async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/options?opt_id=$id'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        listOptions = jsonData;

        // print(_list);
      });
    }
  }

  TextStyle Label() {
    return const TextStyle(color: kPrimaryColor, fontSize: 11);
  }

  TextStyle Name() {
    return const TextStyle(
        color: kImageColor, fontSize: 14, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return const TextStyle(
        color: kImageColor, fontSize: 11, fontWeight: FontWeight.bold);
  }
}
