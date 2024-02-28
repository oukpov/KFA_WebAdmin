import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../../Auth/login.dart';
import '../../../../../../Profile/contants.dart';
import '../../../../Getx_api/hometype.dart';
import '../../../../Getx_api/vetbal_controller.dart';
import '../../../component/Colors/appbar.dart';
import '../../../component/Colors/colors.dart';
import '../../ListProperty/ListProPerty.dart';
import '../../../component/OPtion/Option.dart';

class OptoinBottomSheetContent extends StatefulWidget {
  OptoinBottomSheetContent(
      {super.key,
      required this.hResponse,
      required this.raDius,
      required this.priceDropdownMin,
      required this.priceDropdownMax,
      required this.email,
      required this.idUserController,
      required this.myIdController});
  double hResponse = 0;
  double raDius = 0;
  final String priceDropdownMin;
  final String priceDropdownMax;
  final String email;
  final String idUserController;
  final String myIdController;
  @override
  State<OptoinBottomSheetContent> createState() =>
      _OptoinBottomSheetContentState();
}

class _OptoinBottomSheetContentState extends State<OptoinBottomSheetContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    animationBehavior: AnimationBehavior.preserve,
    vsync: this,
  );
  late final Animation<Offset> offsetAnimationON = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, -0.05),
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.linear,
  ));
  late final Animation<Offset> offsetAnimationDOWN = Tween<Offset>(
    begin: Offset.zero,
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.elasticIn,
  ));
  int selectedIdx = -1;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List title = [
    {"title": "For Sale"},
    {"title": "For Rent"},
    {"title": "Sell"},
  ];
  List searchList = [
    {"title": "For Sale"},
    {"title": "For Rent"},
    {"title": "Sell"},
  ];
  List listImage = [
    {"image": "assets/icons/villa.png"},
    {"image": "assets/icons/land.png"},
    {"image": "assets/icons/Flat.png"},
    {"image": "assets/icons/villaTwin.png"},
    {"image": "assets/icons/LinkHouse.png"},
    {"image": "assets/icons/House.png"},
    {"image": "assets/icons/condo.png"},
    {"image": "assets/icons/apartment.png"},
    {"image": "assets/icons/office.png"},
  ];
  String min = '', max = '';

  final controllerHometype = Controller_hometype();
  final controllerVerbal = Controller_verbal();
  int selectedIdxs = 0;
  double h = 0;
  double hbottom = 0;
  @override
  void initState() {
    h = widget.hResponse - 0.62;
    super.initState();
    controllerHometype.verbal_Hometype();
    controllerVerbal.verbal_Commune_25_all();
  }

  String query = '';
  String provinces = '';
  String hometypes = '';
  String districts = '';
  String communes = '';
  String baths = '';
  String beds = '';

  Future<void> moreOPTion(hometype) async {
    if (typeClick == false) {
      query = 'type=$types&hometype=$hometype';
    } else {
      query =
          'bed=$beds&bath=$baths&property_type_id=$provinces&hometype=$hometypes&min=$min&max=$max';
    }
    if (query != '') {
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/More_option?$query',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        List list = jsonDecode(json.encode(response.data));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListProperty(
                  myIdController: widget.myIdController,
                  email: widget.email,
                  idUsercontroller: widget.idUserController,
                  device: 'Mobile',
                  drawerType: types,
                  list: list,
                  optionDropdown: true),
            ));
      } else {
        print(response.statusMessage);
      }
    }
  }

  bool typeClick = false;
  String bathroomDropdown = '';
  String bedhroomDropdown = '';
  String priceDropdownMin = '';
  String priceDropdownMax = '';
  String typeDropdown = '';
  String provinceDropdown = '';
  bool click = false;
  double w = 0;
  String types = 'For Sale';
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(right: 0, left: 0, bottom: 20),
        child: Container(
          height: MediaQuery.of(context).size.height * h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: whiteColor,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Wrap(
                    children: [
                      Container(
                        height: 50,
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: List.generate(
                            title.length,
                            (int j) => Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIdx = (selectedIdx == j) ? -1 : j;
                                    if (selectedIdx == 0) {
                                      types = 'For Sale';
                                    } else if (selectedIdx == 1) {
                                      types = 'For Rent';
                                    } else if (selectedIdx == 2) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Login(),
                                          ));
                                    }
                                  });

                                  // print(j);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: (selectedIdx == j)
                                        ? const Color.fromARGB(255, 8, 25, 202)
                                        : const Color.fromARGB(
                                            255, 237, 236, 236),
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Text(
                                    '${title[j]['title']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: (selectedIdx == j)
                                            ? whiteColor
                                            : blackColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Wrap(
                      children: [
                        for (int i = 0; i < listType.length; i++)
                          InkWell(
                            onHover: (value) {
                              setState(() {
                                selectedIdxs = (selectedIdxs == i) ? -1 : i;
                                (selectedIdxs == i)
                                    ? controller.forward()
                                    : controller.reverse();
                              });
                            },
                            onTap: () {
                              setState(() {
                                typeClick = false;
                                moreOPTion(listType[i]['type'].toString());
                              });
                            },
                            child: SlideTransition(
                              position: (selectedIdxs == i)
                                  ? offsetAnimationON
                                  : offsetAnimationDOWN,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: widget.raDius,
                                      backgroundImage: AssetImage(
                                          '${listImage[i]['image']}'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child:
                                          Text(listType[i]['type'].toString()),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            setState(() {
                              click = !click;
                              if (click) {
                                hbottom = 0.47;
                              } else {
                                hbottom = 0;
                              }
                            });
                          },
                          child: Container(
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 0.5,
                                  color:
                                      const Color.fromARGB(255, 196, 193, 193)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (click)
                                  Icon(
                                    Icons.keyboard_arrow_up_sharp,
                                    color: appback,
                                  )
                                else
                                  Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: appback,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        if (w < 1000)
                          optionMobile()
                        else
                          optionTabletAndDekTop()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget optionMobile() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: (click)
            ? SizedBox(
                height: MediaQuery.of(context).size.height * hbottom,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Wrap(
                        children: [
                          dropDown(
                              '  All Property Type',
                              priceDropdownMax,
                              controllerHometype.list_hometype,
                              'hometype',
                              'hometype',
                              500,
                              1),
                          dropDown(
                              '  All Province/City',
                              priceDropdownMax,
                              controllerVerbal.list_cummone,
                              'property_type_id',
                              'Name_cummune',
                              500,
                              2),
                          dropDown('  All District/Khan', developing,
                              developing, 'value', 'type', 500, 3),
                          dropDown('  All Cummune/Sangkat', developing,
                              developing, 'value', 'type', 500, 4),
                          dropDown('  All Bathrooms', priceDropdownMax,
                              listBathrooms, 'value', 'id', 500, 5),
                          dropDown('  All Bedrooms', priceDropdownMax,
                              listBedrooms, 'value', 'id', 500, 6),
                          dropDown('  Price min', priceDropdownMax, listPrice,
                              'value', 'id', 500, 7),
                          dropDown('  Price max', priceDropdownMax, listPrice,
                              'value', 'id', 500, 8),
                          const SizedBox(height: 10),
                        ],
                      ),
                      buttonSearch()
                    ],
                  ),
                ))
            : const SizedBox());
  }

  Widget optionTabletAndDekTop() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: (click)
            ? SizedBox(
                height: MediaQuery.of(context).size.height * hbottom,
                width: double.infinity,
                child: Column(
                  children: [
                    Wrap(
                      children: [
                        dropDown(
                            '  All Property Type',
                            priceDropdownMax,
                            controllerHometype.list_hometype,
                            'value',
                            'id',
                            300,
                            1),
                        dropDown(
                            '  All Province/City',
                            priceDropdownMax,
                            controllerVerbal.list_cummone,
                            'value',
                            'id',
                            300,
                            2),
                        dropDown('  All District/Khan', developing, developing,
                            'value', 'type', 300, 3),
                        dropDown('  All Cummune/Sangkat', developing,
                            developing, 'value', 'type', 300, 4),
                        dropDown('  All Bathrooms', priceDropdownMax, listPrice,
                            'value', 'id', 300, 5),
                        dropDown('  All Bedrooms', priceDropdownMax, listPrice,
                            'value', 'id', 300, 6),
                        dropDown('  Price min', priceDropdownMax, listPrice,
                            'value', 'id', 300, 7),
                        dropDown('  Price max', priceDropdownMax, listPrice,
                            'value', 'id', 300, 8),
                        const SizedBox(height: 10),
                      ],
                    ),
                    buttonSearch()
                  ],
                ),
              )
            : const SizedBox());
  }

  Widget buttonSearch() {
    return InkWell(
      onTap: () {
        typeClick = true;
        moreOPTion('');
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: 45,
          width: 300,
          decoration: BoxDecoration(
              color: appback, borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              Text(
                'Search',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String selectedPrice = '';
  String? provinceID;
  String? option = '';
  String? option_ = '';
  bool options = false;
  Widget dropDown(text, values, List list, valueDrop, nameDropDown, w, i) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 0, left: 10),
      child: Container(
        decoration: BoxDecoration(
            // border: Border.all(width: 0.7, color: greyColorNolot),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)),
        height: 40,
        width: w,
        child: DropdownButtonFormField<String>(
          icon: const Icon(Icons.arrow_drop_down_outlined),
          decoration: InputDecoration(
            fillColor: kwhite,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            filled: true,
            labelText: text,
            labelStyle: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * 14),
            hintText: text,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: blueColor, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: greyColorNolot,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          ),
          items: list
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value["$valueDrop"].toString(),
                  child: Center(
                    child: Text(
                      '  ${value["$nameDropDown"]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.textScaleFactorOf(context) * 14,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              if (i == 1) {
                hometypes = value!;
              } else if (i == 2) {
                provinces = value!;
              }
              // else if (i == 3) {
              //   // districts = value!;
              //   snackbar('We are Deverloping', context);
              // } else if (i == 4) {
              //   // communes = value!;
              //   snackbar('We are Deverloping', context);
              // }
              else if (i == 5) {
                baths = value!;
              } else if (i == 6) {
                beds = value!;
              } else if (i == 7) {
                min = value!;
              } else if (i == 8) {
                max = value!;
              }
            });
          },
        ),
      ),
    );
  }

  List list = [];
  Future<void> opTionMore() async {
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/More_option'));
    // '${widget.url}'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      list = jsonData;
      setState(() {
        list;
        print(list.toString());
      });
    }
  }
}
