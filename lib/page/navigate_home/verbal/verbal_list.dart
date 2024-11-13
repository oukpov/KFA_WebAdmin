// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/page/navigate_home/verbal/edit_VerbalAgent.dart';
import 'package:web_admin/page/navigate_home/verbal/pdfVerbal.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';
import 'package:http/http.dart' as http;
import '../../../Customs/ProgressHUD.dart';
import '../../../components/waiting.dart';
import '../../../getx/verbal/verbal_agent.dart';
import '../Customer/component/date_customer.dart';
import 'ImageVerbal.dart';

class VerbalList extends StatefulWidget {
  const VerbalList({super.key, required this.listUser});
  final List listUser;
  @override
  State<VerbalList> createState() => _VerbalListState();
}

class _VerbalListState extends State<VerbalList> {
  late NumberPaginatorController _inputController;
  int page = 1;
  int perPage = 10;
  @override
  void initState() {
    _inputController = NumberPaginatorController();
    super.initState();
    pdfimage();
  }

  List listPage = [
    {"page": 10},
    {"page": 20},
    {"page": 40},
    {"page": 60},
    {"page": 80},
    {"page": 100},
  ];
  TextEditingController searchController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  VerbalAgents controller = VerbalAgents(iduser: "");
  var imagelogo;
  List listPDF = [];
  Future<void> pdfimage() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/pdf/20'));

    if (rs.statusCode == 200) {
      setState(() {
        listPDF = jsonDecode(rs.body);

        if (listPDF.isNotEmpty) {
          imagelogo = listPDF[0]['image'].toString();
        }
      });
    }
  }

  Future<void> restartDate() async {
    setState(() {
      searchController.clear();
      startController.clear();
      endController.clear();
    });
  }

  Future<void> checkDate() async {
    checkSearchDate = true;
    await Future.wait([
      restartDate(),
    ]);
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        checkSearchDate = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      color: Colors.transparent,
      inAsyncCall: controller.isVerbal.value,
      opacity: 0.3,
      child: _uiSteup(context),
    );
  }

  bool checkSearchDate = false;
  final _formKey = GlobalKey<FormState>();
  Widget _uiSteup(BuildContext context) {
    final controller =
        Get.put(VerbalAgents(iduser: widget.listUser[0]['agency'].toString()));
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                color: const Color.fromARGB(255, 68, 165, 244),
                height: 60,
                width: double.infinity,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: whiteColor,
                        )),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(width: 0.5, color: greyColorNolot)),
                      height: 40,
                      width: 300,
                      child: TextFormField(
                        controller: searchController,
                        onSaved: (value) {
                          setState(() {
                            searchController.text = value!;
                          });
                        },
                        onFieldSubmitted: (value) {
                          controller.searchVerbal(
                              value,
                              startController.text,
                              endController.text,
                              widget.listUser[0]['agency'].toString());
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(9),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          suffixIcon: InkWell(
                            onTap: () async {
                              _formKey.currentState!.save();
                              await controller.searchVerbal(
                                  searchController.text,
                                  startController.text,
                                  endController.text,
                                  widget.listUser[0]['agency'].toString());
                            },
                            child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: appback,
                                  border:
                                      Border.all(width: 0.5, color: greyColor),
                                ),
                                child: Icon(
                                  Icons.search,
                                  color: whiteColor,
                                )),
                          ),
                          icon: const SizedBox(width: 10),
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                searchController.clear();
                              });
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: blackColor,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: '  Search listing here...',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    checkSearchDate
                        ? const SizedBox()
                        : Row(
                            children: [
                              DateExpaned(
                                  value: (value) {
                                    setState(() {
                                      startController.text = value;
                                    });
                                  },
                                  filedname: 'StartDate'),
                              const SizedBox(width: 10),
                              DateExpaned(
                                  value: (value) {
                                    setState(() {
                                      endController.text = value;
                                    });
                                  },
                                  filedname: 'EndDate'),
                            ],
                          ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: whiteColor,
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              checkDate();
                            },
                            icon: Icon(
                              Icons.clear_outlined,
                              color: greyColor,
                            )),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: blueColor,
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              controller.searchVerbal(
                                  "",
                                  startController.text,
                                  endController.text,
                                  widget.listUser[0]['agency'].toString());
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: greyColor,
                            )),
                      ),
                    ),
                    const SizedBox(width: 10)
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () {
                  if (controller.isVerbalAgent.value) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.83,
                        width: double.infinity,
                        child: const WaitingFunction());
                  } else if (controller.listVerbalAgent.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.83,
                      width: double.infinity,
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.83,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: controller.listVerbalAgent.length,
                        itemBuilder: (context, index) =>
                            cards(index, controller.listVerbalAgent),
                      ),
                    );
                  }
                },
              ),
              // if (controller.listVerbalAgent.isNotEmpty)
              // if (controller.isVerbalAgent.value)
              //   const SizedBox()
              // else if (controller.listVerbalAgent.isNotEmpty)
              Obx(
                () {
                  if (controller.isVerbalAgent.value) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.83,
                        width: double.infinity,
                        child: const WaitingFunction());
                  } else if (controller.listVerbalAgent.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.83,
                      width: double.infinity,
                    );
                  } else {
                    return Padding(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 20),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.2, color: greyColor)),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 50,
                                  width: 70,
                                  child: SizedBox(
                                    height: 40,
                                    child: DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      onChanged: (newValue) async {
                                        if (!controller.isVerbalAgent.value) {
                                          setState(() {
                                            perPage =
                                                int.parse(newValue ?? '0');
                                          });
                                        }
                                      },
                                      items: listPage
                                          .map<DropdownMenuItem<String>>(
                                            (value) => DropdownMenuItem<String>(
                                              value: value["page"].toString(),
                                              child: Text(
                                                value["page"].toString(),
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
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
                                                vertical: 8, horizontal: 10),
                                        labelText: "Page",
                                        hintText:
                                            controller.perPage.value.toString(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: kPrimaryColor, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            width: 1,
                                            color: kPrimaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                flex: 9,
                                child: NumberPaginator(
                                  controller: _inputController,
                                  numberPages: controller.lastPage.value,
                                  onPageChange: (int index) async {
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      setState(() {
                                        page = index + 1;
                                      });
                                    });
                                  },
                                  initialPage: 0,
                                  config: NumberPaginatorUIConfig(
                                    buttonShape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                    buttonUnselectedForegroundColor: blackColor,
                                    buttonUnselectedBackgroundColor:
                                        whiteNotFullColor,
                                    buttonSelectedForegroundColor: whiteColor,
                                    buttonSelectedBackgroundColor: appback,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cards(int index, List list) {
    final controller =
        Get.put(VerbalAgents(iduser: widget.listUser[0]['agency'].toString()));
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          height: 200,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(217, 255, 255, 255),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Verbal ID',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'ReferrentN',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " : ${list[index]['verbal_id']}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          " : ${list[index]['referrenceN'] ?? "N/A"}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const SizedBox(height: 2),
                        Text(
                          " : ${list[index]['verbal_created_date'] ?? "N/A"}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: Image.asset("assets/images/GoogleMap.png"),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${list[index]['verbal_address'] ?? "N/A"}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (widget.listUser[0]["agency"].toString() == "28")
                          GFButton(
                              onPressed: () async {
                                setState(() {
                                  controller.isVerbalAgent.value = true;
                                });
                                Future.delayed(const Duration(seconds: 1),
                                    () async {
                                  setState(() {
                                    controller.isVerbalAgent.value = false;
                                  });
                                  await controller.fetchImageLandbuilding(
                                      list[index]['verbal_code'].toString());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditVerbalAgent(
                                          verbalImage:
                                              controller.verbalImage.value,
                                          index: index,
                                          listVerbal:
                                              controller.listVerbalAgent,
                                          listVerbalLandbuilding:
                                              controller.fetchVerbalLandBYCode,
                                          type: (value) {},
                                          listUser: widget.listUser,
                                          addNew: (value) {},
                                        ),
                                      ));
                                });
                              },
                              text: "   Edit ",
                              color: const Color.fromARGB(255, 34, 219, 5),
                              icon: Icon(
                                Icons.edit,
                                color: whiteColor,
                              )),
                        const SizedBox(width: 10),
                        if (widget.listUser[0]["agency"].toString() == "28")
                          GFButton(
                              onPressed: () {
                                AwesomeDialog(
                                  padding: const EdgeInsets.only(
                                      right: 30, left: 30, bottom: 10, top: 10),
                                  alignment: Alignment.center,
                                  width: 350,
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  headerAnimationLoop: false,
                                  title: "Do you want to delete?",
                                  btnOkOnPress: () async {
                                    await controller.deleteVerbal(
                                        list[index]['verbal_code'].toString());
                                    await controller.searchVerbal(
                                        "",
                                        "",
                                        "",
                                        widget.listUser[0]['agency']
                                            .toString());
                                  },
                                  btnCancelOnPress: () {},
                                ).show();
                              },
                              text: "   Delete ",
                              color: const Color.fromARGB(255, 224, 13, 2),
                              icon: Icon(
                                Icons.delete,
                                color: whiteColor,
                              )),
                        const SizedBox(width: 10),
                        GFButton(
                            onPressed: () async {
                              setState(() {
                                controller.isVerbalAgent.value = true;
                              });
                              Future.delayed(const Duration(seconds: 1),
                                  () async {
                                setState(() {
                                  controller.isVerbalAgent.value = false;
                                });
                                await controller.fetchVerbalAll(
                                    list[index]['verbal_code'].toString());
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return SaveImageVerbalAgent(
                                      listLandbuilding:
                                          controller.fetchVerbalLandBYCode,
                                      listVerbal: controller.fetchVerbalBYCode,
                                      check: true,
                                      listUser: widget.listUser,
                                      type: (value) {
                                        setState(() {
                                          // widget.type(value);
                                        });
                                      },
                                      i: 0,
                                    );
                                  },
                                );
                              });
                            },
                            text: "Save Image",
                            color: Colors.green,
                            icon: Image.asset(
                              'assets/images/save_image.png',
                              height: 25,
                            )),
                        const SizedBox(width: 10),
                        if (imagelogo != null)
                          PDFVerbal(
                            verbalCode: list[index]['verbal_code'].toString(),
                            listUser: widget.listUser,
                            type: (value) {
                              if (value == true) {
                                setState(() {
                                  controller.isVerbalAgent.value = true;
                                });
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    controller.isVerbalAgent.value = false;
                                  });
                                });
                              }
                            },
                            check: true,
                            listLandbuilding: const [],
                            listVerbal: const [],
                            i: 0,
                            imageLogo: imagelogo,
                          )
                        else
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
