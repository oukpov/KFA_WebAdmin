// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:http/http.dart' as http;
import 'package:number_paginator/number_paginator.dart';
import '../../../../components/ApprovebyAndVerifyby.dart';
import '../../../components/colors.dart';
import '../../../getx/verbal/verbal.dart';
import '../../../getx/verbal/verbal_list.dart';
import '../../../models/verbalModel/verbal_model.dart';
import '../../../screen/Property/FirstProperty/component/Colors/appbar.dart';
import '../Customer/component/date.dart';
import 'companen/pdf.dart';
import 'companen/saveImage.dart';
import 'Edit/googlemap_Editverbal.dart';

class ListAuto extends StatefulWidget {
  const ListAuto(
      {super.key,
      required this.type,
      required this.device,
      required this.id_control_user,
      required this.listUser,
      required this.checkcolor});
  final String id_control_user;
  final List listUser;
  final OnChangeCallback type;
  final String device;
  final bool checkcolor;

  @override
  State<ListAuto> createState() => _ListAutoState();
}

class _ListAutoState extends State<ListAuto> {
  // List list1 = [];

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

  int page = 1;
  // List list = [];
  List listPage = [
    {"page": 10},
    {"page": 20},
    {"page": 40},
    {"page": 60},
    {"page": 80},
    {"page": 100},
  ];
  late VerbalData verbalData;
  @override
  void initState() {
    main();

    pdfimage();
    super.initState();
    _inputController = NumberPaginatorController();
  }

  void main() async {
    verbalData = Get.isRegistered<VerbalData>()
        ? Get.find<VerbalData>()
        : Get.put(VerbalData());

    setState(() {
      listProtect = verbalData.list;
      print(
          "listProtect : ${listProtect.length} || verbalData.list : ${verbalData.list.length}");
    });
  }

  bool awaitAuto = false;

  @override
  void dispose() {
    controller.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  VerbalAdd verbalAdd = VerbalAdd();
  bool check = false;
  List listTitle = [
    {"title": "All Verbal"},
    {"title": "Your Verbal"},
  ];
  TextEditingController search = TextEditingController();
  bool checkType = false;
  String url = '';

  Uint8List? get_bytes1;
  Uint8List? bytes2;
  List listImage = [];

  Future<void> getimageMap(lat, log) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=$log,$lat&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C$log,$lat&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));
      get_bytes1 = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  bool button = false;

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController controller = TextEditingController();
  late NumberPaginatorController _inputController;
  List listProtect = [];
  String searchText = '';
  bool typeverbal = false;
  @override
  Widget build(BuildContext context) {
    return check
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            width: (widget.device == 't')
                ? MediaQuery.of(context).size.width * 0.8
                : (widget.device == 'd')
                    ? MediaQuery.of(context).size.width * 0.65
                    : MediaQuery.of(context).size.width,
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/wait.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 10),
                const CircularProgressIndicator(),
              ],
            )),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            width: (widget.device == 't')
                ? MediaQuery.of(context).size.width * 0.8
                : (widget.device == 'd')
                    ? MediaQuery.of(context).size.width * 0.65
                    : MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: widget.checkcolor
                    ? const EdgeInsets.only(right: 30, left: 30)
                    : const EdgeInsets.only(right: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.checkcolor
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.type(false);
                                  });
                                },
                                icon: Icon(Icons.arrow_back, color: blackColor))
                            : const SizedBox(),
                        Text(
                          '   List Auto Verbal',
                          style: TextStyle(
                              color:
                                  !widget.checkcolor ? whiteColor : greyColor,
                              fontSize: 18),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              checkType = false;
                            });
                            await verbalData.listviewVerbal(
                                widget.listUser[0]['agency'],
                                verbalData.perPage.value,
                                page,
                                startDateController.text,
                                endDateController.text,
                                checkType,
                                search.text);
                            setState(() {
                              if (verbalData.isverbal.value) {
                                listProtect = verbalData.list;
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Text("All Verbal  ",
                                  style: TextStyle(
                                      color: !widget.checkcolor
                                          ? whiteColor
                                          : greyColor,
                                      fontSize: 13)),
                              Icon(
                                  (checkType)
                                      ? Icons.check_box_outline_blank
                                      : Icons.check_box_outlined,
                                  color: !widget.checkcolor
                                      ? whiteColor
                                      : greyColor)
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              checkType = true;
                            });
                            await verbalData.listviewVerbal(
                                widget.listUser[0]['agency'],
                                verbalData.perPage.value,
                                page,
                                startDateController.text,
                                endDateController.text,
                                checkType,
                                search.text);
                            setState(() {
                              if (verbalData.isverbal.value) {
                                listProtect = verbalData.list;
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Text("Your Verbal  ",
                                  style: TextStyle(
                                      color: !widget.checkcolor
                                          ? whiteColor
                                          : greyColor,
                                      fontSize: 13)),
                              Icon(
                                  (!checkType)
                                      ? Icons.check_box_outline_blank
                                      : Icons.check_box_outlined,
                                  color: !widget.checkcolor
                                      ? whiteColor
                                      : greyColor)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 0.5, color: greyColorNolot)),
                          height: 40,
                          width: 300,
                          child: TextFormField(
                            controller: controller,
                            onChanged: (value) async {
                              setState(() {
                                search.text = value;
                              });
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
                                  await verbalData.listviewVerbal(
                                      widget.listUser[0]['agency'],
                                      verbalData.perPage.value,
                                      page,
                                      startDateController.text,
                                      endDateController.text,
                                      checkType,
                                      search.text);
                                  setState(() {
                                    if (verbalData.isverbal.value) {
                                      listProtect = verbalData.list;
                                    }
                                  });
                                },
                                child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: appback,
                                      border: Border.all(
                                          width: 0.5, color: greyColor),
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
                                    controller.clear();
                                    search.clear();
                                    listProtect = verbalData.list;
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
                        CircleAvatar(
                          backgroundColor: whiteColor,
                          child: Center(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    search.clear();
                                    controller.clear();
                                    verbalData.list.value = listProtect;
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: greyColor,
                                )),
                          ),
                        ),
                        const SizedBox(width: 10),
                        DatePicker(
                            value: (value) {
                              setState(() {
                                startDateController.text = value;
                              });
                            },
                            filedname: 'StartDate'),
                        const SizedBox(width: 10),
                        DatePicker(
                            value: (value) {
                              setState(() {
                                endDateController.text = value;
                              });
                            },
                            filedname: 'EndDate'),
                        const Spacer(),
                        Text("Refrech  ",
                            style: TextStyle(
                                color:
                                    !widget.checkcolor ? whiteColor : greyColor,
                                fontSize: 14)),
                        IconButton(
                            onPressed: () async {
                              await verbalData.listviewVerbal(
                                  widget.listUser[0]['agency'],
                                  verbalData.perPage.value,
                                  page,
                                  startDateController.text,
                                  endDateController.text,
                                  checkType,
                                  "");
                              setState(() {
                                if (verbalData.isverbal.value) {
                                  listProtect = verbalData.list;
                                }
                              });
                            },
                            icon: Icon(
                              Icons.change_circle,
                              color: !widget.checkcolor ? whiteColor : appback,
                              size: 35,
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Obx(() {
                        if (verbalData.isverbal.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (verbalData.list.isEmpty) {
                          return const Text('No Data');
                        } else {
                          return ListView.builder(
                              itemCount: listProtect.length,
                              itemBuilder: (context, index) =>
                                  cards(index, listProtect));
                        }
                      }),
                    ),
                    if (verbalData.list.isNotEmpty)
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 20),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(width: 0.2, color: greyColor)),
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
                                          setState(() {
                                            verbalData.lastPage.value =
                                                int.parse(newValue ?? '0');
                                          });
                                          await verbalData.listviewVerbal(
                                              widget.listUser[0]['agency'],
                                              verbalData.perPage.value,
                                              page,
                                              startDateController.text,
                                              endDateController.text,
                                              checkType,
                                              search.text);
                                        },
                                        items: listPage
                                            .map<DropdownMenuItem<String>>(
                                              (value) =>
                                                  DropdownMenuItem<String>(
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
                                          hintText: verbalData.perPage.value
                                              .toString(),
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
                                    numberPages: verbalData.lastPage.value,
                                    onPageChange: (int index) async {
                                      setState(() {
                                        page = index + 1;
                                      });

                                      await verbalData.listviewVerbal(
                                          widget.listUser[0]['agency'],
                                          verbalData.perPage.value,
                                          page,
                                          startDateController.text,
                                          endDateController.text,
                                          checkType,
                                          search.text);
                                      setState(() {
                                        if (!verbalData.isverbal.value) {
                                          listProtect = verbalData.list;
                                        }
                                      });
                                    },
                                    initialPage: 0,
                                    config: NumberPaginatorUIConfig(
                                      buttonShape: BeveledRectangleBorder(
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                      buttonUnselectedForegroundColor:
                                          blackColor,
                                      buttonUnselectedBackgroundColor:
                                          whiteNotFullColor,
                                      buttonSelectedForegroundColor: whiteColor,
                                      buttonSelectedBackgroundColor: blueColor,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      )
                    else
                      const SizedBox()
                  ],
                ),
              ),
            ),
          );
  }

  Widget cards(int i, List listProtect) {
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
                        Text(
                          'Bank',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Bank Branch',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Property Type',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
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
                          " : ${listProtect[i]['verbal_id']}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          " : ${listProtect[i]['bank_name'] ?? "N/A"}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          " : ${listProtect[i]['bank_branch_name'] ?? "N/A"}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          " : ${listProtect[i]['property_type_name'] ?? "N/A"}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          " : ${listProtect[i]['verbal_date'] ?? "N/A"}",
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
                    SizedBox(
                      height: 100,
                      width: 200,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholderFit: BoxFit.contain,
                        placeholder: 'assets/earth.gif',
                        image:
                            "https://maps.googleapis.com/maps/api/staticmap?center=${(listProtect[i]["latlong_log"] > listProtect[i]["latlong_la"]) ? "${listProtect[i]["latlong_la"]},${listProtect[i]["latlong_log"]}" : "${listProtect[i]["latlong_log"]},${listProtect[i]["latlong_la"]}"}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(listProtect[i]["latlong_log"] > listProtect[i]["latlong_la"]) ? "${listProtect[i]["latlong_la"]},${listProtect[i]["latlong_log"]}" : "${listProtect[i]["latlong_log"]},${listProtect[i]["latlong_la"]}"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI",
                      ),
                    ),
                    const SizedBox(width: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GFButton(
                          onPressed: () {
                            AwesomeDialog(
                              alignment: Alignment.centerLeft,
                              width: 450,
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Done',
                              desc: "Do you want to delete?",
                              btnOkOnPress: () {
                                if (listProtect[i]["type_value"].toString() ==
                                    "T") {
                                  verbalAdd.deleteAuto(
                                      "protectID", listProtect[i]["protectID"]);
                                } else {
                                  verbalAdd.deleteAuto(
                                      "verbal_id", listProtect[i]["verbal_id"]);
                                }
                                listProtect.removeAt(i);
                              },
                              btnCancelOnPress: () {},
                            ).show();
                          },
                          text: "Delete",
                          color: colorsRed,
                          icon: const Icon(Icons.delete,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    blurRadius: 5,
                                    offset: Offset(1, 0.5))
                              ],
                              size: 20),
                        ),
                        const SizedBox(width: 10),
                        GFButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditVerbalAdmin(
                                      type: (value) {},
                                      listUser: widget.listUser,
                                      addNew: (value) {},
                                      listData: listProtect,
                                      // listData: listProtect
                                      //     .map((json) => Data.fromJson(json))
                                      //     .toList(),
                                      index: i),
                                ));
                            // Get.to(EditVerbalAdmin(
                            //     type: (value) {},
                            //     listUser: widget.listUser,
                            //     addNew: (value) {},
                            //     // listData: listProtect,
                            //     listData: listProtect
                            //         .map((json) => Data.fromJson(json))
                            //         .toList(),
                            //     index: i));
                            // showModalBottomSheet(
                            //   backgroundColor: Colors.transparent,
                            //   context: context,
                            //   isScrollControlled: true,
                            //   builder: (BuildContext context) {
                            //     return SingleChildScrollView(
                            //       child: Column(
                            //         children: [
                            //           EditAutoVerbal(
                            //               index: i,
                            //               listData: listProtect,
                            //               hscreen: 750,
                            //               listUser: widget.listUser,
                            //               device: "d",
                            //               verbalID: listProtect[i]["verbal_id"]
                            //                   .toString(),
                            //               creditAgent: (value) {},
                            //               creditPoint: 12),
                            //         ],
                            //       ),
                            //     );
                            //   },
                            // );
                          },
                          text: "Edit",
                          color: greenColors,
                          icon: const Icon(Icons.edit,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    blurRadius: 5,
                                    offset: Offset(1, 0.5))
                              ],
                              size: 20),
                        ),
                        const SizedBox(width: 10),
                        GFButton(
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return SaveImageVerbal(
                                  landbuildigID: (listProtect[i]["type_value"]
                                              .toString() ==
                                          "T")
                                      ? listProtect[i]["protectID"].toString()
                                      : listProtect[i]["verbal_id"].toString(),
                                  listUser: widget.listUser,
                                  type: (value) {
                                    setState(() {
                                      widget.type(value);
                                    });
                                  },
                                  list: listProtect,
                                  i: i,
                                  verbalId:
                                      listProtect[i]["verbal_id"].toString(),
                                );
                              },
                            );
                          },
                          text: "Image",
                          color: const Color.fromARGB(255, 8, 8, 140),
                          icon: const Icon(Icons.photo_library_outlined,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    blurRadius: 5,
                                    offset: Offset(1, 0.5))
                              ],
                              size: 20),
                        ),
                        const SizedBox(width: 10),
                        if (imagelogo != null)
                          PDFButton(
                            imagelogo: imagelogo,
                            i: i,
                            iconpdfcolor: Colors.red,
                            list: listProtect,
                            verbalId: listProtect[0]['verbal_id'].toString(),
                          )
                        else
                          const Center(
                            child: CircularProgressIndicator(),
                          )
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
