import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../components/colors.dart';
import '../../../component/Colors/appbar.dart';
import '../../../component/Header.dart';
import '../../../component/Model/EmailSave/EmailSave.dart';
import '../../../component/fonttext/fontText.dart';
import '../../DetailScreen/DetailAll.dart';
import 'EmailSave/Responsive.dart';

class MyListings extends StatefulWidget {
  const MyListings(
      {super.key, required this.device, required this.myIdcontroller});
  final String device;
  final String myIdcontroller;
  @override
  State<MyListings> createState() => _MyListingsState();
}

class _MyListingsState extends State<MyListings> {
  List listOptionLast = [
    {'title': 'All Beds'},
    {'title': 'All Baths'},
    {'title': 'All Grid View'},
    {'title': 'Options'},
  ];
  List listTitle = [
    {'title': 'All Province / City'},
    {'title': 'All District / Khan'},
    {'title': 'All Commune / Sangkat'},
    {'title': 'All Listing'},
    {'title': 'All Property Types'},
    {'title': 'All Buildings'},
  ];
  List listShow = [
    {'title': '12'},
    {'title': '24'},
    {'title': '36'},
    {'title': '48'},
    {'title': '60'},
    {'title': '72'},
    {'title': '100'},
  ];

  List bedslistings = [
    {'title': 'All Beds', 'count': '0'},
    {'title': '1 Bed', 'count': '1'},
    {'title': '2 Beds', 'count': '2'},
    {'title': '3 Beds', 'count': '3'},
    {'title': '4 Beds', 'count': '4'},
    {'title': '5 Beds', 'count': '5'},
    {'title': '6 Beds', 'count': '6'},
    {'title': '7 Beds', 'count': '7'},
    {'title': '8 Beds', 'count': '8'},
    {'title': '9 Beds', 'count': '9'},
    {'title': '10 Beds', 'count': '10'},
  ];
  List bathslistings = [
    {'title': 'All Baths'},
    {'title': '1 Bath'},
    {'title': '2 Baths'},
    {'title': '3 Baths'},
    {'title': '4 Baths'},
    {'title': '5 Baths'},
    {'title': '6 Baths'},
    {'title': '7 Baths'},
    {'title': '8 Baths'},
    {'title': '9 Baths'},
    {'title': '10 Baths'},
  ];
  List gridViewListings = [
    {'title': 'Grid View', 'index': '1'},
    {'title': 'Table View', 'index': '2'},
    {'title': 'Map View', 'index': '3'},
  ];
  List<Icon> gridViewListingsIcon = const [
    Icon(Icons.grid_on_outlined),
    Icon(Icons.table_view),
    Icon(Icons.location_on),
  ];
  List list = [];
  Future<void> value() async {
    var headers = {'Content-Type': 'application/json'};
    // var data =
    //     json.encode({"email": "oukpov@gmail.com", "password": "Pov8888"});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_Sale_all_2',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      // data: data,
    );

    if (response.statusCode == 200) {
      setState(() {
        list = jsonDecode(json.encode(response.data));
        if (list.length != 0) {
          main();
          isChecked = List.generate(list.length, (index) => false);
          for (int i = 0; i < list.length; i++) {
            emailSave(list, i, isChecked[i]);
          }
          // listEmailSave = list;
        }
      });
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> falseAll() async {
    print('Click');
    setState(() {
      isChecked = List.generate(list.length, (index) => false);
      for (int i = 0; i < list.length; i++) {
        updateCheck(list, i, isChecked[i]);
      }
    });
  }

  @override
  void initState() {
    value();

    super.initState();
  }

  List<bool> isChecked = [];
  List<bool> isCheckedTrue = [];
  int favoriteLike = -1;
  void main() {
    lengthOfList = list.length;
    // lengthOfList = 1;
    double totalContainers = lengthOfList / 24;
    if (totalContainers.runtimeType == double) {
      totalPage = totalContainers.toInt() + 1;

      if (lengthOfList > 24) {
        startpage = 0;
        deTailPage4 = 24;
      } else {
        startpage = 0;
        deTailPage4 = lengthOfList;
      }
    } else {
      totalPage = int.parse(totalContainers.toString());
      print('No.2 => ${totalPage.toString()}');
    }
  }

//EmailSaveModel
  List<EmailSaveModel> lb = [
    EmailSaveModel('', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
        '', '', '', '', '', '', '', '', '', '', '', '', '', '', false)
  ];
  List listEmailSave = [];
  Future<void> emailSave(List list, i, check) async {
    listEmailSave.add({
      "id_ptys": list[i]['id_ptys'].toString(),
      "price": list[i]['price'].toString(),
      "sqm": list[i]['sqm'].toString(),
      "bed": list[i]['bed'].toString(),
      "bath": list[i]['bath'].toString(),
      "type": list[i]['type'].toString(),
      "land": list[i]['land'].toString(),
      "address": list[i]['address'].toString(),
      "Title": list[i]['Title'].toString(),
      "description": list[i]['description'].toString(),
      "hometype": list[i]['hometype'].toString(),
      "property_type_id": list[i]['property_type_id'].toString(),
      "url": list[i]['url'].toString(),
      "urgent": list[i]['urgent'].toString(),
      "lat": list[i]['lat'].toString(),
      "log": list[i]['log'].toString(),
      "Name_cummune": list[i]['Name_cummune'].toString(),
      "Private_Area": list[i]['Private_Area'].toString(),
      "Livingroom": list[i]['Livingroom'].toString(),
      "Parking": list[i]['Parking'].toString(),
      "size_w": list[i]['size_w'].toString(),
      "Size_l": list[i]['Size_l'].toString(),
      "floor": list[i]['floor'].toString(),
      "land_l": list[i]['land_l'].toString(),
      "land_w": list[i]['land_w'].toString(),
      "size_house": list[i]['size_house'].toString(),
      "total_area": list[i]['total_area'].toString(),
      "price_sqm": list[i]['price_sqm'].toString(),
      "aircon": list[i]['aircon'].toString(),
      "check": check,
    });
    lb.add(
      EmailSaveModel(
          list[i]['id_ptys'].toString(),
          list[i]['price'].toString(),
          list[i]['sqm'].toString(),
          list[i]['bed'].toString(),
          list[i]['bath'].toString(),
          list[i]['type'].toString(),
          list[i]['land'].toString(),
          list[i]['address'].toString(),
          list[i]['Title'].toString(),
          list[i]['description'].toString(),
          list[i]['hometype'].toString(),
          list[i]['property_type_id'].toString(),
          list[i]['url'].toString(),
          list[i]['urgent'].toString(),
          list[i]['lat'].toString(),
          list[i]['log'].toString(),
          list[i]['Name_cummune'].toString(),
          list[i]['Private_Area'].toString(),
          list[i]['Livingroom'].toString(),
          list[i]['Parking'].toString(),
          list[i]['size_w'].toString(),
          list[i]['Size_l'].toString(),
          list[i]['floor'].toString(),
          list[i]['land_l'].toString(),
          list[i]['land_w'].toString(),
          list[i]['size_house'].toString(),
          list[i]['total_area'].toString(),
          list[i]['price_sqm'].toString(),
          list[i]['aircon'].toString(),
          check),
    );
  }

  Future updateCheck(List list, i, check) async {
    setState(() {
      listEmailSave[i]['check'] = check;
    });
  }

  String province = '';
  String district = '';
  String commune = '';
  String hometype = '';
  String beds = '';
  String baths = '';

  Future<void> searchProperty() async {
    setState(() {
      query = '$beds$baths$province$district$commune$hometype';
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/More_option?bed=2',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      list = jsonDecode(json.encode(response.data));
      setState(() {
        if (list.length != 0) {
          main();
          isChecked = List.generate(list.length, (index) => false);
        }
      });

      print(query);
    } else {
      print(response.statusMessage);
    }
  }

  var waitListBack = [];
  int lengthOfList = 11;
  int currentPage = 0;
  int deTailPage = 0;
  int deTailPage4 = 0;
  int totalPage = 0;
  double totalPages = 0;
  int startpage = 0;
  double w = 0;
  bool button = false;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;

    l = (w - 1199) / 4;
    if (w > 560) {
      r = (w - 560) / 1.7;
    }
    return Scaffold(
      backgroundColor: backgroundScreen,
      appBar: AppBar(
        title: Text(w.toString()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(w.toString()),
              GestureDetector(
                onTap: () async {
                  String recipient = 'oukpovsiemreap@gmail.com';
                  String subject = 'oukpovsiemreap12@gmail.com';
                  String body =
                      'https://w7.pngwing.com/pngs/711/308/png-transparent-blue-dragon-illustration-tattoo-chinese-dragon-japanese-dragon-drawing-handsome-dragon-blue-ink-dragon-thumbnail.png';

                  final Uri email = Uri(
                    scheme: 'mailto',
                    path: recipient,
                    queryParameters: {
                      'subject': subject,
                      'body': body,
                    },
                  );
                  if (await canLaunchUrl(email)) {
                    await launchUrl(email);
                  } else {
                    debugPrint('error');
                  }
                },
                child: Container(
                  height: 70,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: kwhite_new,
                  ),
                  child: const Center(
                    child: Text(
                      "Send",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: whiteColor),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (openORclose)
                        Wrap(
                          children: [
                            for (int i = 0; i < listTitle.length; i++)
                              if (widget.device == 'M')
                                dropDownOptionMobile(listTitle[i]['title'],
                                    'title', 'title', 12, listTitle, 1)
                              else if (widget.device == 'T')
                                dropDownOptionMobile(listTitle[i]['title'],
                                    'title', 'title', 12, listTitle, 0.43)
                              else
                                dropDownOption(
                                  listTitle[i]['title'],
                                  220,
                                  'title',
                                  'title',
                                  12,
                                  listTitle,
                                )
                          ],
                        ),
                      Wrap(
                        children: [
                          if (widget.device == 'M')
                            SizedBox(
                                child: Wrap(
                              children: [
                                dropDownShowMobile(
                                    'Show', 1, 'title', 'title', 12, listShow),
                                const SizedBox(height: 10),
                                searchShowTabletDekTop(1)
                              ],
                            ))
                          else if (widget.device == 'T')
                            SizedBox(
                              child: Wrap(
                                children: [
                                  dropDownShowTabletDekTop('Show', 'title',
                                      'title', 12, listShow, 0.15),
                                  const SizedBox(height: 10),
                                  searchShowTabletDekTop(0.6)
                                ],
                              ),
                            ),
                        ],
                      ),
                      if (widget.device == 'M')
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Form(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: whiteNotFullColor50,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      optionUnderMobile(
                                          true,
                                          0.28,
                                          10,
                                          'All Beds',
                                          'count',
                                          'title',
                                          bedslistings,
                                          1),
                                      const SizedBox(width: 10),
                                      optionUnderMobile(
                                          true,
                                          0.28,
                                          10,
                                          'All Baths',
                                          'count',
                                          'title',
                                          bedslistings,
                                          2),
                                      const SizedBox(width: 10),
                                      optionUnderMobile(
                                          true,
                                          0.31,
                                          10,
                                          'Grid View',
                                          'index',
                                          'title',
                                          gridViewListings,
                                          3),
                                      const SizedBox(width: 10),
                                      optionControlerDropdown(
                                          0.28, 45, 'Option')
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (widget.device == 'T')
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Form(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: whiteNotFullColor50,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      optionUnderMobile(
                                          true,
                                          0.21,
                                          12,
                                          'All Beds',
                                          'count',
                                          'title',
                                          bedslistings,
                                          1),
                                      const SizedBox(width: 10),
                                      optionUnderMobile(
                                          true,
                                          0.21,
                                          12,
                                          'All Baths',
                                          'count',
                                          'title',
                                          bedslistings,
                                          2),
                                      const SizedBox(width: 10),
                                      optionUnderMobile(
                                          true,
                                          0.21,
                                          12,
                                          'Grid View',
                                          'index',
                                          'title',
                                          gridViewListings,
                                          3),
                                      const SizedBox(width: 10),
                                      optionControlerDropdown(
                                          0.21, 45, 'Option')
                                      // optionUnderMobile(
                                      //     true,
                                      //     0.21,
                                      //     12,
                                      //     'Option',
                                      //     'title',
                                      //     'title',
                                      //     bedslistings,
                                      //     4),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (widget.device == 'D')
                        SizedBox(
                          child: Wrap(
                            children: [
                              dropDownShowTabletDekTop(
                                  '12', 'title', 'title', 12, listShow, 0.1),
                              searchShowTabletDekTop(0.24),
                              Form(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: whiteNotFullColor50,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            optionUnderTablet(
                                                true,
                                                0.1,
                                                10,
                                                'All Beds',
                                                'count',
                                                'title',
                                                bedslistings,
                                                1),
                                            const SizedBox(width: 10),
                                            optionUnderTablet(
                                                true,
                                                0.1,
                                                10,
                                                'All Baths',
                                                'count',
                                                'title',
                                                bedslistings,
                                                2),
                                            const SizedBox(width: 10),
                                            optionUnderTablet(
                                                true,
                                                0.1,
                                                10,
                                                'Grid View',
                                                'index',
                                                'title',
                                                gridViewListings,
                                                3),
                                            const SizedBox(width: 10),
                                            optionControlerDropdown(
                                                0.1, 45, 'Option')
                                            // optionUnderTablet(
                                            //     true,
                                            //     0.1,
                                            //     10,
                                            //     'Option',
                                            //     'title',
                                            //     'title',
                                            //     bedslistings,
                                            //     4),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return ResponsiveEmailSave(
                        myIdcontroller: widget.myIdcontroller,
                        listAll: list,
                        checkboxValues: (value) {
                          setState(() {
                            isChecked = value;
                            for (int i = 0; i < deTailPage4; i++) {
                              updateCheck(list, i, isChecked[i]);
                            }
                          });
                        },
                        listBack: (value) {
                          if (value == true) {
                            print('==========> Is True');
                          }
                          // setState(() {
                          //   waitListBack = value;
                          //   if (waitListBack.length == 0) {
                          //     listEmailSave = value;
                          //   }
                          // });
                        },
                        list: listEmailSave,
                      );
                    },
                  );
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: whiteColor),
                  child: Row(
                    children: const [
                      SizedBox(width: 10),
                      Icon(Icons.email_outlined),
                      SizedBox(width: 5),
                      Text('Email'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // if (list.length != 0) tableView()
              if (w < 770) listNumber(25, 10, 20),
              if (w >= 770 && w < 1199) listNumber(5, 5, 27),
              if (w < 770 && opTionBack == 1)
                optionPropertyMobile()
              else if (w < 1199 && opTionBack == 1)
                optionPropertyTablet()
              else if (opTionBack == 1)
                optionPropertyDekTop()
              else if (opTionBack == 2)
                tableView()
              // else if (opTionBack == 3)
              // mapView()
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDownOptionMobile(
      text, valueDrop, nameDropdown, font, List list, wOptio) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * wOptio,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.5, color: greyColor)),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            icon: null,
            fillColor: kwhite,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            filled: true,
            // labelText: text,
            labelStyle: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * font),
            hintText: text,
            hintStyle: TextStyle(color: blackColor),

            border: InputBorder.none,

            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          ),
          items: list
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value["$valueDrop"].toString(),
                  child: Center(
                    child: Text(
                      " ${value["$nameDropdown"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * font,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              print('$value');
            });
          },
        ),
      ),
    );
  }

  Widget dropDownOption(
      text, wDropDown, valueDrop, nameDropdown, font, List list) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 10),
      child: Container(
        height: 45,
        width: wDropDown,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.5, color: greyColor)),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            icon: null,
            fillColor: kwhite,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            filled: true,
            // labelText: text,
            labelStyle: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * font),
            hintText: text,
            hintStyle: TextStyle(color: blackColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appback, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.5,
                color: Color.fromARGB(255, 127, 127, 127),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            border: InputBorder.none,

            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: kerror,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          items: list
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value["$valueDrop"],
                  child: Center(
                    child: Text(
                      " ${value["$nameDropdown"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * font,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget dropDownShowMobile(
      text, wDropDown, valueDrop, nameDropdown, font, List list) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * wDropDown,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.5, color: greyColor)),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            icon: Container(
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text('Show'),
            ),
            fillColor: kwhite,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            filled: true,
            // labelText: text,
            labelStyle: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * font),
            hintText: text,
            hintStyle: TextStyle(color: blackColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appback, width: 1.0),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.5,
                color: Color.fromARGB(255, 127, 127, 127),
              ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
            ),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: kerror,
              ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
            ),
          ),
          items: list
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value["$valueDrop"],
                  child: Center(
                    child: Text(
                      " ${value["$nameDropdown"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * font,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget dropDownShowTabletDekTop(
      text, valueDrop, nameDropdown, font, List list, i) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 0, right: 5),
      child: Container(
        height: 45,
        width: (i == 1)
            ? MediaQuery.of(context).size.width * 0.7
            : MediaQuery.of(context).size.width * 0.15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.5, color: greyColor)),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            prefixIcon: Container(
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: whiteNotFullColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Show',
                style: TextStyle(color: blackColor),
              ),
            ),
            fillColor: kwhite,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            filled: true,
            // labelText: text,
            labelStyle: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * font),
            label: Text(' $text'),
            hintStyle: TextStyle(color: blackColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appback, width: 1.0),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.5,
                color: Color.fromARGB(255, 127, 127, 127),
              ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
            ),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: kerror,
              ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
            ),
          ),
          items: list
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value["$valueDrop"],
                  child: Center(
                    child: Text(
                      " ${value["$nameDropdown"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * font,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
    );
  }

  int opTionBack = 1;
  Widget optionUnderMobile(
      device, wOptio, font, text, valueDrop, nameDropdown, List list, i) {
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width * wOptio,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          icon: null,
          fillColor: whiteNotFullColor50,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          filled: true,
          labelStyle: TextStyle(
              fontSize: MediaQuery.of(context).textScaleFactor * font),
          hintText: text,
          hintStyle: TextStyle(color: blackColor),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        ),
        items: list
            .map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
                value: value["$valueDrop"].toString(),
                child: SizedBox(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          if (i == 1)
                            const Icon(Icons.bed_outlined)
                          else if (i == 2)
                            const Icon(Icons.bathtub_outlined)
                          else
                            (value['index'].toString() == '1')
                                ? const Icon(Icons.grid_on_outlined)
                                : (value['index'].toString() == '2')
                                    ? const Icon(Icons.table_view)
                                    : const Icon(Icons.location_on),
                          Text(
                            " ${value["$nameDropdown"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * font,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            opTionBack = int.parse(value.toString());
          });
        },
      ),
    );
  }

  Widget optionUnderTablet(
      device, wOptio, font, text, valueDrop, nameDropdown, List list, i) {
    return SizedBox(
      height: 45,
      width: 150,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          icon: null,
          fillColor: whiteNotFullColor50,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          filled: true,
          // labelText: text,
          labelStyle: TextStyle(
              fontSize: MediaQuery.of(context).textScaleFactor * font),
          hintText: text,
          hintStyle: TextStyle(color: blackColor),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        ),
        items: list
            .map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
                value: value["$valueDrop"],
                child: SizedBox(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // if (i == 1)
                          //   const Icon(Icons.bed_outlined)
                          // else if (i == 2)
                          //   const Icon(Icons.bathtub_outlined)
                          // else
                          //   (value['index'].toString() == '1')
                          //       ? const Icon(Icons.grid_on_outlined)
                          //       : (value['index'].toString() == '2')
                          //           ? const Icon(Icons.table_view)
                          //           : const Icon(Icons.location_on),
                          Text(
                            " ${value["$nameDropdown"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: blackColor,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * font,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            opTionBack = int.parse(value!);
          });
        },
      ),
    );
  }

  bool openORclose = false;
  Widget optionControlerDropdown(w, h, text) {
    return InkWell(
      onTap: () {
        setState(() {
          openORclose = !openORclose;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * h,
        width: MediaQuery.of(context).size.width * w,
        color: whiteNotFullColor50,
        child: Row(
          children: [
            Text(text),
            !openORclose
                ? const Icon(Icons.arrow_drop_down)
                : const Icon(Icons.arrow_drop_up_outlined)
          ],
        ),
      ),
    );
  }

  String query = '';
  double h = 0;
  Widget searchShowTabletDekTop(w) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.7, color: blackColor),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        height: 45,
        width: MediaQuery.of(context).size.width * w,
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              query = value;
              // proertySearch(value);
              if (value == '') {
                h = 0;
              }
            });
          },
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.textScaleFactorOf(context) * 12,
          ),
          decoration: InputDecoration(
            prefixIcon: Form(
              child: Container(
                width: 50,
                color: whiteNotFullColor,
                child: Icon(
                  Icons.search,
                  color: blackColor,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.all(9),
            focusedBorder:
                const OutlineInputBorder(borderSide: BorderSide.none),
            suffixIcon: Form(
                child: InkWell(
              onTap: () {
                searchProperty();
              },
              child: Container(
                alignment: Alignment.center,
                width: 60,
                color: greenColors,
                child: Text(
                  'Search',
                  style: TextStyle(color: whiteColor),
                ),
              ),
            )),
            border: InputBorder.none,
            hintText: '  Search listing here...',
          ),
        ),
      ),
    );
  }

//Option Deplay
  Widget gridView() {
    return Wrap(
      children: [
        for (int i = 0; i < 20; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              width: 200,
              color: Colors.red,
            ),
          )
      ],
    );
  }

  Widget optionPropertyMobile() {
    setState(() {
      if (button == false) {
        deTailPage4 = list.length;
      }
    });
    return Wrap(
      direction: Axis.horizontal,
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        for (int i = startpage; i < deTailPage4; i++)
          if (w < 500)
            imageUrl(i, 200, 700, 0, list)
          else
            imageUrl(i, 250, 600, r, list)
      ],
    );
  }

  double r = 0;
  double l = 0;

  Widget optionPropertyTablet() {
    setState(() {
      if (button == false) {
        deTailPage4 = list.length;
      }
    });
    return Wrap(
      direction: Axis.horizontal,
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        for (int i = startpage; i < deTailPage4; i++)
          if (w >= 770 && w < 991)
            imageUrl(i, 200, 350, 0, list)
          else
            imageUrl(i, 200, 300, 0, list)
      ],
    );
  }

  Widget optionPropertyDekTop() {
    setState(() {
      if (button == false) {
        deTailPage4 = list.length;
      }
    });
    return Padding(
      padding: EdgeInsets.only(right: l, left: l),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 12.0,
        runSpacing: 12.0,
        children: <Widget>[
          for (int i = startpage; i < deTailPage4; i++)
            if (w > 1199) imageUrl(i, 180, 280, 0, list)
        ],
      ),
    );
  }

  int selectedIdx = -1;
  Widget imageUrl(int index, double hPic, wPic, r, List list) {
    var fontValue = TextStyle(
        fontSize: MediaQuery.textScaleFactorOf(context) * 13,
        color: const Color.fromARGB(255, 64, 65, 64));
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return DetailScreen(
              myIdcontroller: widget.myIdcontroller,
              index: index.toString(),
              list: list,
              verbalID: list[index]['id_ptys'].toString(),
            );
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: r, left: r),
        child: Form(
          child: Card(
            elevation: (selectedIdx == index) ? 20 : 0,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                width: wPic,
                child: Column(
                  children: [
                    // Container(
                    //   height: hPic,
                    //   width: wPic,
                    //   color: Colors.red,
                    //   child: Text('No. $index(page:$deTailPage4)'),
                    // )

                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              child: CachedNetworkImage(
                                imageUrl: list[index]['url'].toString(),
                                fit: BoxFit.cover,
                                height: hPic,
                                width: wPic,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )),
                        ),
                        // Positioned(
                        //   top: MediaQuery.of(context).size.height * 0.01,
                        //   child: type('type', 12, index, list),
                        // ),
                        Positioned(
                            top: 30,
                            left: 30,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      launch(
                                        'https://oneclickonedollar.com/listing/#/code/${list[index]['id_ptys']}',
                                        forceSafariVC: false,
                                        forceWebView: false,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.share,
                                      color: whiteColor,
                                      size: 35,
                                    )),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      // print(
                                      //     '${listFavoriteModel[index]['id_ptys']} && ${list[index]['id_ptys']} && ${list[index]['like']}');
                                      // if (listFavoriteModel[index]
                                      //         ['id_ptys'] ==
                                      //     list[index]['id_ptys']) {
                                      //   if (listFavoriteModel[index]['like']
                                      //           .toString() ==
                                      //       '1') {
                                      //     // print(index.toString());
                                      //     upDateUserFavorites(
                                      //         listFavoriteModel, index, 0);
                                      //   } else {
                                      //     upDateUserFavorites(
                                      //         listFavoriteModel, index, 1);
                                      //   }
                                      // }
                                    });
                                  },
                                  onHover: (value) {
                                    setState(() {
                                      selectedIdx =
                                          (selectedIdx == index) ? -1 : index;
                                      // favorite = !favorite;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.favorite_border_outlined,
                                    // color: (!favorite)
                                    //     ? ((list[index]['like'].toString() ==
                                    //             '1')
                                    //         ? greenColors
                                    //         : greyColor)
                                    // : ((selectedIdx == index)
                                    // ? redColors
                                    // : (list[index]['like']
                                    //             .toString() ==
                                    //         '1')
                                    //     ? greenColors
                                    //     : greyColor),
                                    size: 40,
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              fontSizes('', 'urgent', 12, index, list, context),
                              textS(context),
                              fontSizes(
                                  '', 'Name_cummune', 12, index, list, context),
                            ],
                          ),
                          size7,
                          Row(
                            children: [
                              fontSizes(
                                  'Price', 'price', 12, index, list, context),
                              textS(context),
                              fontSizes('Bed', 'bed', 12, index, list, context),
                            ],
                          ),
                          size7,
                          Row(
                            children: [
                              fontSizes(
                                  'Land', 'land', 12, index, list, context),
                              textS(context),
                              fontSizes(
                                  'Bath', 'bath', 12, index, list, context),
                            ],
                          ),
                          size7,
                          Text(
                            '${(list[index]['address'].toString() == "null") ? "" : list[index]['address']}, ${(list[index]['Name_cummune'].toString() == "null") ? "" : list[index]['Name_cummune']} ,Cambodia',
                            style: fontValue,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget listNumber(t, b, fs) {
    return Padding(
      padding: EdgeInsets.only(top: t, bottom: b),
      child: Text('${list.length} LISTING',
          style: TextStyle(
              fontSize: MediaQuery.textScaleFactorOf(context) * fs,
              color: appback)),
    );
  }

  int selectIndex = -1;
  List<Map<String, String>> listTitles = [
    {"title": "No"},
    {"title": "Action"},
    {"title": "Save Favorite"},
    {"title": "Picture"},
    {"title": "Title"},
    {"title": "Property Type"},
    {"title": "Price"},
    {"title": "Price Per Sqm"},
    {"title": "Listing Date"},
    {"title": "Bed"},
    {"title": "Bath"},
    {"title": "L-Size"},
    {"title": "B-Size"},
  ];
  Widget tableView() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.infinity,
          child: ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    dataRowHeight: 120,
                    dividerThickness: 1,
                    border: TableBorder.all(width: 1, color: whiteNotFullColor),
                    columns: [
                      for (int i = 0; i < listTitles.length; i++)
                        DataColumn(
                          label: Text(
                            '${listTitles[i]['title']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                    rows: [
                      for (int i = startpage; i < deTailPage4; i++)
                        DataRow(
                          cells: [
                            // DataCell(Text('0000$i')),
                            DataCell(Text('${list[i]['id_ptys']}')),
                            DataCell(Row(
                              children: [
                                PopupMenuButton(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                          child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: const [
                                            Icon(Icons.email_outlined),
                                            SizedBox(width: 8),
                                            Text('Email'),
                                          ],
                                        ),
                                      )),
                                      PopupMenuItem(
                                          child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: const [
                                            Icon(Icons.share),
                                            SizedBox(width: 8),
                                            Text('Shard'),
                                          ],
                                        ),
                                      )),
                                      PopupMenuItem(
                                          child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: const [
                                            Icon(Icons.print_outlined),
                                            SizedBox(width: 8),
                                            Text('Print'),
                                          ],
                                        ),
                                      )),
                                      PopupMenuItem(
                                          child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: const [
                                            Icon(Icons.picture_as_pdf_outlined),
                                            SizedBox(width: 8),
                                            Text('PDF'),
                                          ],
                                        ),
                                      )),
                                      PopupMenuItem(
                                          child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: const [
                                            Icon(Icons.message),
                                            SizedBox(width: 8),
                                            Text('Chat to us'),
                                          ],
                                        ),
                                      )),
                                    ];
                                  },
                                )
                                // IconButton(
                                //     onPressed: () {
                                //       setState(() {
                                //         selectIndex =
                                //             (selectIndex == i) ? -1 : i;
                                //       });
                                //     },
                                //     icon: const Icon(Icons.more_vert_outlined)),
                                // (selectIndex == i)
                                //     ? Padding(
                                //         padding: const EdgeInsets.all(10.0),
                                //         child: Container(
                                //           width: 140,
                                //           decoration: BoxDecoration(
                                //               color: const Color.fromARGB(
                                //                   255, 230, 229, 229),
                                //               borderRadius:
                                //                   BorderRadius.circular(5),
                                //               border: Border.all(
                                //                   width: 0.7,
                                //                   color: const Color.fromARGB(
                                //                       255, 230, 229, 229))),
                                //           child: Padding(
                                //             padding:
                                //                 const EdgeInsets.only(left: 10),
                                //             child: Column(
                                //               children: [
                                //                 for (int i = 0;
                                //                     i < listIcon.length;
                                //                     i++)
                                //                   Padding(
                                //                     padding:
                                //                         const EdgeInsets.only(
                                //                             top: 5),
                                //                     child: SizedBox(
                                //                       child: Row(
                                //                         children: [
                                //                           listIcon[i],
                                //                           Text(
                                //                             listShowModal[i]
                                //                                 ['title'],
                                //                             style: const TextStyle(
                                //                                 fontSize: 12,
                                //                                 fontWeight:
                                //                                     FontWeight
                                //                                         .bold),
                                //                           ),
                                //                         ],
                                //                       ),
                                //                     ),
                                //                   )
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       )
                                //     : const SizedBox()
                              ],
                            )),
                            DataCell(Container(
                              alignment: Alignment.center,
                              child: GFCheckbox(
                                size: GFSize.SMALL,
                                activeBgColor: GFColors.DANGER,
                                type: GFCheckboxType.circle,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked[i] = value;
                                    updateCheck(list, i, isChecked[i]);

                                    // emailSave(list, i);
                                  });
                                },
                                value: isChecked[i],
                                inactiveIcon: null,
                              ),
                            )),

                            DataCell(Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return DetailScreen(
                                        myIdcontroller: widget.myIdcontroller,
                                        index: i.toString(),
                                        list: list,
                                        verbalID: list[i]['id_ptys'].toString(),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  // color: Colors.red,
                                  decoration: BoxDecoration(
                                    image: (list[i]['url'] == null ||
                                            list[i]['url'].toString() == "")
                                        ? null
                                        : DecorationImage(
                                            image: NetworkImage(
                                                list[i]['url'].toString()),
                                            fit: BoxFit.cover),
                                  ),
                                  width: 170,
                                ),
                              ),
                            )),
                            DataCell(Text(list[i]['title'] ?? "")),
                            DataCell(Text(list[i]['hometype'] ?? "")),
                            DataCell(Text("${list[i]['price'] ?? ""}")),
                            DataCell(Text("${list[i]['price_sqm'] ?? ""}")),
                            DataCell(Text(list[i]['date'] ?? "")),
                            DataCell(Text("${list[i]['bed'] ?? ""}")),
                            DataCell(Text("${list[i]['bath'] ?? ""}")),
                            DataCell(Text("${list[i]['Size_l'] ?? ""}")),
                            DataCell(Text("${list[i]['size_house'] ?? ""}")),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (list.length != 0)
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 0.2, color: greyColor)),
                height: 40,
                width: 450,
                child: NumberPaginator(
                  numberPages: totalPage,
                  onPageChange: (int index) {
                    setState(() {
                      falseAll();
                      button = true;
                      currentPage = index + 1;
                      deTailPage = (currentPage * 20);
                      startpage =
                          (deTailPage - (currentPage - (currentPage - 1)) * 20);
                      //Take last Page
                      if (lengthOfList > 24) {
                        deTailPage4 = (currentPage * 20) + 4;
                      } else {
                        deTailPage4 = lengthOfList;
                      }

                      ///Detail Page
                      if (deTailPage4 > 24) {
                        startpage = (deTailPage -
                                (currentPage - (currentPage - 1)) * 20) +
                            4;
                        deTailPage4 = (currentPage * 20) + 4;
                      }
                      if (deTailPage4 > lengthOfList) {
                        startpage = ((currentPage - 1) * 20) + 4;
                        deTailPage4 = lengthOfList;
                      }
                    });
                  },
                  initialPage: 0,
                  config: NumberPaginatorUIConfig(
                    buttonShape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),

                    //noclick
                    buttonUnselectedForegroundColor: blackColor,
                    buttonUnselectedBackgroundColor: whiteNotFullColor,
                    //click
                    buttonSelectedForegroundColor: whiteColor,
                    buttonSelectedBackgroundColor: appback,
                  ),
                )),
          )
        else
          const SizedBox()
      ],
    );
  }

  // Widget mapView() {
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Container(
  //           height: MediaQuery.of(context).size.height * 0.6,
  //           width: double.infinity,
  //           child: MapLatLog(
  //             myIdcontroller: widget.myIdcontroller,
  //             get_commune: (value) {},
  //             get_district: (value) {},
  //             get_lat: (value) {},
  //             get_log: (value) {},
  //             get_province: (value) {},
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }
}


// Container(
//                                         alignment: Alignment.center,
//                                         height: 50,
//                                         child: PopupMenuButton(
//                                           child: Row(
//                                             children: [
//                                               const Text('All Bads'),
//                                               const SizedBox(width: 8),
//                                               Icon(
//                                                 Icons.arrow_drop_down_sharp,
//                                                 color: blackColor,
//                                               )
//                                             ],
//                                           ),
//                                           itemBuilder: (context) {
//                                             return [
//                                               for (int i = 0;
//                                                   i < bedslistings.length;
//                                                   i++)
//                                                 PopupMenuItem(
//                                                     child: InkWell(
//                                                   onTap: () {},
//                                                   child: Row(
//                                                     children: [
//                                                       const Icon(
//                                                           Icons.email_outlined),
//                                                       const SizedBox(width: 8),
//                                                       Text(bedslistings[i]
//                                                               ['title']
//                                                           .toString()),
//                                                     ],
//                                                   ),
//                                                 )),
//                                             ];
//                                           },
//                                         ),
//                                       ),