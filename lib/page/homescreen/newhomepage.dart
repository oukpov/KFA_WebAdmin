// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
// import 'package:fl_animated_linechart/chart/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_admin/components/waiting.dart';
import 'package:web_admin/page/homescreen/ToalData.dart';
import '../../Profile/components/FieldBox.dart';
import '../../Profile/components/TwinBox.dart';
import '../../Profile/components/singleBox.dart';
import '../../Widgets/widgets.dart';
import '../../components/colors.dart';
import '../../components/colors/colors.dart';
import '../../getx/Auth/Auth_agent.dart';
import '../../getx/checkUpdate/updateCheck.dart';
import '../../getx/component/logo.dart';
import '../../getx/option/option.dart';
import '../../screen/Property/FirstProperty/ResponseDevice/responsive_layout.dart';
import '../navigate_home/Approvel/classSubmit.dart';
import '../navigate_home/AutoVerbal/AutoVerbal.dart';
import '../navigate_home/AutoVerbal/Zone/add_zone.dart';
import '../navigate_home/Auto_verbal/Add/googlemap_verbal.dart';
import '../navigate_home/Comparable/add_comparable_new_page.dart';
import '../navigate_home/Customer/List/customer_list.dart';
import '../navigate_home/Customer/component/Web/editText/dropdowntxt.dart';
import '../navigate_home/Customer/map_in_list_search _autoverbal.dart';

import '../navigate_home/Customer/responsiveDevice.dart/addnew.dart';
import '../navigate_home/Report/Total_amount.dart';
import '../navigate_home/Report/Transetoin/history.dart';
import '../navigate_home/Report/customer/menu.dart';
import '../navigate_home/Report/page/about_us_page.dart';
import '../navigate_home/Report/page/comparable_case_bar_chart.dart';
import '../navigate_home/Report/page/comparable_case_page.dart';
import '../navigate_home/Report/page/contact_us_page.dart';
import '../navigate_home/Report/page/faq_page.dart';
import '../navigate_home/Report/page/slider_page.dart';
import '../navigate_home/Report/page/sponsor_list_page.dart';
import '../navigate_home/Report/page/userlist_for_adminpage.dart';
import '../navigate_home/Report/page/userlist_page.dart';
import '../navigate_home/Report/page/v_point_page.dart';
import '../navigate_home/Report/responsvie/responsivereportyear.dart';
import '../navigate_home/User/control_user.dart';
import '../navigate_home/User/list_notivigation.dart';
import '../navigate_home/User/use_vpoint.dart';
import '../navigate_home/verbal/Add_VerbalAgent.dart';
import '../navigate_setting/Accompany_by/Acompany_List.dart';
import '../navigate_setting/Accompany_by/Acompany_new.dart';
import '../navigate_setting/Appraiser/Appraiser_list.dart';
import '../navigate_setting/Appraiser/Appraiser_new.dart';
import '../navigate_setting/Approved/Approved_list.dart';
import '../navigate_setting/Inspector/Inspector_List.dart';
import '../navigate_setting/Inspector/Inspector_new.dart';
import '../navigate_setting/Register/Register_List.dart';
import '../navigate_setting/Register/Register_new.dart';
import '../navigate_setting/agency/Agency_list.dart';
import '../navigate_setting/agency/Agency_new.dart';
import '../navigate_setting/assign/Assign_new.dart';
import '../navigate_setting/auto/auto_list.dart';
import '../navigate_setting/auto/check_District.dart';
import '../navigate_setting/auto/new_auto.dart';
import '../navigate_setting/bank/bank/bank_list.dart';
import '../navigate_setting/bank/bank/new_bank.dart';
import '../navigate_setting/bank/brand/brand_list.dart';
import '../navigate_setting/bank/brand/new_brand.dart';
import '../../Widgets/drawerMenu.dart';
import '../../Widgets/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import '../navigate_setting/online/add_agent.dart';
import '../navigate_setting/online/isonline.dart';
import 'component/list.dart';

class homescreen extends StatefulWidget {
  const homescreen(
      {super.key,
      required this.device,
      required this.id,
      required this.url,
      required this.listUser});
  final String id;
  final String device;
  final String url;
  final List listUser;
  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  double fontsizes = 11;
  bool drawer = false;
  double w = 0;
  int selectindex = -1;
  int selectindexs = -1;
  bool isObscure = true;
  var url = "https://img.icons8.com/fluency/100/user-male-circle.png";
  String? firstName;
  String? lastName;
  String? gender;
  String? telNum;
  String? email;
  String? password;
  String? knownFrom;
  String? username;
  String? controlleruser;
  List listReportOption = [];
  List listAdminOption = [];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    updateUserStatus();
    getWingData();
    getAbabankData();
    getUpayData();
    getOtherData();
    DateTime now = DateTime.now();
    DateTime onewday = DateTime(now.year, now.month, now.day);
    DateTime twowday = DateTime(now.year, now.month, now.day + 1);
    String formattedDatenow = DateFormat('yyyy-MM-dd').format(onewday);
    String formattedDateago = DateFormat('yyyy-MM-dd').format(twowday);
    countnotifcations(formattedDatenow, formattedDateago);
  }

  Authentication authentication = Authentication();
  bool hasUnsavedData = true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> updateUserStatus() async {
    await authentication
        .checkAdminUser(int.parse(widget.listUser[0]['agency'].toString()));
    final QuerySnapshot result = await _firestore
        .collection('users')
        .where('id_agent', isEqualTo: widget.listUser[0]['agency'].toString())
        .limit(1)
        .get();

    if (result.docs.isNotEmpty) {
      // User found
      final userDocRef = result.docs.first.reference;
      await userDocRef.update({
        'isOnline': true,
        'lastActive': FieldValue.serverTimestamp(),
      });

      html.window.onBeforeUnload.listen((event) async {
        event.preventDefault();
        await userDocRef.update({
          'isOnline': false,
          'lastActive': FieldValue.serverTimestamp(),
        });
        Future.delayed(const Duration(seconds: 30), () async {
          await userDocRef.update({
            'isOnline': true,
            'lastActive': FieldValue.serverTimestamp(),
          });
        });
      });
    }
    controllerUpdate.checkUpdate(widget.listUser[0]['agency'].toString());
  }

  Future<void> clearAllExcept(String exceptionKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get all keys in SharedPreferences
    Set<String> keys = prefs.getKeys();

    // Iterate through all keys and remove each one except the exception
    for (String key in keys) {
      if (key != exceptionKey) {
        await prefs.remove(key); // Remove all except listlocalhostC
      }
    }
  }

  String countNotification = '';
  List listnotificationlist = [];
  void countnotifcations(formattedDatenow, formattedDateago) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_nativigatoin_2?start=$formattedDatenow&end=$formattedDateago',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listnotificationlist = jsonDecode(json.encode(response.data));
        countNotification = listnotificationlist.length.toString();
      });
    } else {
      print(response.statusMessage);
    }
  }

  var wingData, ababankData, upayData, otherData;
  Future<void> getWingData() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    try {
      print('Making request to Wing API...');
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/wingbank-data',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          wingData =
              double.parse(json.decode(response.data.toString()).toString())
                  .toStringAsFixed(2);
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred during API call: ${e.toString()}');
    }
  }

  Future<void> getAbabankData() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/ababank-data',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        ababankData =
            double.parse(json.decode(response.data.toString()).toString())
                .toStringAsFixed(2);
      });
    } else {
      // print(response.statusMessage);
    }
  }

  Future<void> getUpayData() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/upaybank-data',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        upayData =
            double.parse(json.decode(response.data.toString()).toString())
                .toStringAsFixed(2);
      });
    } else {
      // print(response.statusMessage);
    }
  }

  Future<void> getOtherData() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/otherbank-data',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        otherData =
            double.parse(json.decode(response.data.toString()).toString())
                .toStringAsFixed(2);
      });
    } else {
      // print(response.statusMessage);
    }
  }

  // ImageLogoAdmin imageLogoAdmin = ImageLogoAdmin();
  OptionHome optionHome = OptionHome();
  LogoImageKFA logoImageKFA = LogoImageKFA();
  final colorList = <Color>[
    const Color.fromARGB(255, 248, 151, 5),
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.grey,
    Colors.pink,
    const Color.fromARGB(255, 161, 22, 231),
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.cyan,
  ];

  int type = 0;
  @override
  Widget build(BuildContext context) {
    // imageLogoAdmin = Get.put(ImageLogoAdmin());
    optionHome = Get.put(OptionHome());
    w = MediaQuery.of(context).size.width;
    controllerUpdate = Get.put(ControllerUpdate());
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundScreen,
      drawer: DrawerWidget(
          email: widget.listUser[0]['username'].toString(),
          listUser: widget.listUser,
          password: widget.listUser[0]['username'].toString()),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.device == 't' || widget.device == 'd')
              ? DrawerOption(
                  device: widget.device,
                  email: widget.listUser[0]['username'].toString(),
                  listUser: widget.listUser,
                )
              : const SizedBox(),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: (widget.device == 't')
                ? MediaQuery.of(context).size.width * 0.8
                : (widget.device == 'd')
                    ? MediaQuery.of(context).size.width * 0.65
                    : MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: (widget.device == 't' || widget.device == 'd')
                    ? const EdgeInsets.only(
                        right: 30, left: 30, top: 10, bottom: 10)
                    : const EdgeInsets.only(
                        right: 10, left: 10, top: 10, bottom: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    profile(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          // margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whileColors),
                          child: Obx(
                            () {
                              if (optionHome.isVerbal.value) {
                                return const WaitingFunction();
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        optionTxt(
                                            "All Clients",
                                            optionHome.countAllUsers.value,
                                            Icons.person,
                                            true,
                                            "images/User.png"),
                                        const SizedBox(width: 10),
                                        optionTxt(
                                            "All Verbals",
                                            optionHome.countVerbals.value
                                                .toString(),
                                            Icons.verified,
                                            true,
                                            "icons/Verbal1.png"),
                                        const SizedBox(width: 10),
                                        optionTxt(
                                            "All Auto Verbals",
                                            optionHome.countAutoVs.value
                                                .toString(),
                                            Icons.verified,
                                            false,
                                            ""),
                                        const SizedBox(width: 10),
                                        optionTxt("All Agents", "N/A",
                                            Icons.verified, false, ""),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          optionTxt(
                                              "VPoint Used",
                                              "N/A",
                                              Icons.person,
                                              true,
                                              "images/v.png"),
                                          const SizedBox(width: 10),
                                          optionTxt("Client Top Up", "N/A",
                                              Icons.verified, false, ""),
                                          const SizedBox(width: 10),
                                          optionTxt("VPoint Client Used", "N/A",
                                              Icons.verified, false, ""),
                                          const SizedBox(width: 10),
                                          optionTxt("All Partner", "N/A",
                                              Icons.verified, false, ""),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          optionTxt(
                                              "ABA Bank",
                                              "${ababankData ?? '0'} USD",
                                              Icons.person,
                                              true,
                                              "images/aba.jpeg"),
                                          const SizedBox(width: 10),
                                          optionTxt(
                                              "Wing Bank",
                                              "${wingData ?? '0'} USD",
                                              Icons.verified,
                                              true,
                                              "images/wing.png"),
                                          const SizedBox(width: 10),
                                          optionTxt(
                                              "U Pay",
                                              "${upayData ?? '0'} USD",
                                              Icons.verified,
                                              true,
                                              "images/UPAY-logo.png"),
                                          const SizedBox(width: 10),
                                          optionTxt(
                                              "Other",
                                              "${otherData ?? '0'} USD",
                                              Icons.verified,
                                              false,
                                              ""),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Obx(
                                      () {
                                        if (optionHome.isVerbal.value) {
                                          return const WaitingFunction();
                                        } else if (optionHome.dataMap.isEmpty) {
                                          return const SizedBox(
                                            child: SizedBox(),
                                          );
                                        } else {
                                          return Stack(
                                            children: [
                                              Container(
                                                height: 200,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: greyColor),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: PieChart(
                                                        dataMap:
                                                            optionHome.dataMap,
                                                        animationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    800),
                                                        chartLegendSpacing: 32,
                                                        chartRadius:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3.2,
                                                        colorList: colorList,
                                                        initialAngleInDegree: 0,
                                                        chartType:
                                                            ChartType.ring,
                                                        ringStrokeWidth: 32,
                                                        centerText: "Data",
                                                        legendOptions:
                                                            const LegendOptions(
                                                          showLegendsInRow:
                                                              false,
                                                          legendPosition:
                                                              LegendPosition
                                                                  .right,
                                                          showLegends: true,
                                                          legendShape:
                                                              BoxShape.circle,
                                                          legendTextStyle:
                                                              TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        chartValuesOptions:
                                                            const ChartValuesOptions(
                                                          showChartValueBackground:
                                                              true,
                                                          showChartValues: true,
                                                          showChartValuesInPercentage:
                                                              false,
                                                          showChartValuesOutside:
                                                              false,
                                                          decimalPlaces: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                  left: 200,
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                              Icons.refresh,
                                                              color:
                                                                  greenColors,
                                                              size: 25)),
                                                      Text(
                                                        "  Refrech",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: greyColor,
                                                            fontSize: 13),
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    AnimatedLineChartExample()
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          (widget.device == 'd')
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  color: whiteColor,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < 5; i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 300,
                              width: double.infinity,
                              color: greyColorNolots,
                            ),
                          )
                      ],
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget optionTxt(
      String txt, String value, IconData icon, bool bool, String imageAssets) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 60,
        // width: 150,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: greyColor),
          color: whileColors,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 5),
            if (bool == false)
              CircleAvatar(
                radius: 20,
                backgroundColor: blueColor,
                child: Icon(
                  icon,
                  color: whileColors,
                ),
              )
            else
              CircleAvatar(
                backgroundColor: blueColor,
                backgroundImage: AssetImage("assets/$imageAssets"),
                radius: 20,
              ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  txt,
                  style: TextStyle(
                      color: greyColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(
                      color: colorsRed,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List listControllerTitle = [];
  List listControllerIcons = [];

  Widget homeOptioWrap() {
    return Wrap(
      alignment:
          (widget.device == 'm') ? WrapAlignment.center : WrapAlignment.start,
      children: [
        // (widget.listUser[0]['agency'].toString() == "28") ?  listTitle.length:

        for (int index = 0; index < listControllerTitle.length; index++)
          PopupMenuButton(
            elevation: 15,
            itemBuilder: (context) {
              return [
                if (index == 0)
                  for (int i = 0; i < customeroption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ResponsiveCustomer(
                                      email: '',
                                      idController: widget.id,
                                      myIdController: '',
                                    );
                                  },
                                ));
                              } else {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const Customer_List();
                                  },
                                ));
                              }
                            },
                            child: textfield(
                                customeroption[i]['title'].toString())))
                else if (index == 1)
                  for (int i = 0; i < valuationoption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              switch (i) {
                                case 0:
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return const New_Executive();
                                  //   },
                                  // ));
                                  break;
                                case 1:
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return Executive_List();
                                  //   },
                                  // ));
                                  break;

                                default:
                                // Navigator.push(context, MaterialPageRoute(
                                //   builder: (context) {
                                //     return Executive_approvals();
                                //   },
                                // ));
                              }
                            },
                            child: textfield(
                                valuationoption[i]['title'].toString())))
                else if (index == 2)
                  for (int i = 0; i < comparableotion.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              switch (i) {
                                // case 0:
                                //   Navigator.push(context, MaterialPageRoute(
                                //     builder: (context) {
                                //       return ResponsivenewcomparableAdd(
                                //         id: widget.id.toString(),
                                //         name: "",
                                //       );
                                //     },
                                //   ));
                                //   break;
                                case 0:
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return AddComparable(
                                        listlocalhosts: widget.listUser,
                                        addNew: (value) {},
                                        // listUser: widget.listUser,
                                        type: (value) {},
                                      );
                                    },
                                  ));
                                //   break;
                                // case 3:
                                //   Navigator.of(context).push(MaterialPageRoute(
                                //       builder: (context) =>
                                //           const comparable_search()));
                                //   break;
                                // case 4:
                                //   Navigator.of(context).push(MaterialPageRoute(
                                //       builder: (context) =>
                                //           const List_comparable_filter()));
                                //   break;
                                // default:
                                //   Navigator.push(context, MaterialPageRoute(
                                //     builder: (context) {
                                //       return Executive_approvals();
                                //     },
                                //   ));
                              }
                            },
                            child: textfield(
                                comparableotion[i]['title'].toString())))
                else if (index == 3)
                  PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResponsiveLayout(
                                    myIdController: '',
                                    email: '',
                                    idController: '',
                                  ),
                                ));
                          },
                          child: textfield('HomeProperty')))
                else if (index == 4)
                  for (int i = 0; i < listAdminOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              switch (i) {
                                case 0:
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => VerbalAdmin(
                                            addNew: (value) {},
                                            listUser: widget.listUser,
                                            type: (value) {},
                                          )));
                                  break;
                                case 1:
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const Show_autoVerbals()));
                                  break;
                                default:
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ZoneMap(
                                            listLocalHost: widget.listUser,
                                          )));
                                  break;
                              }
                            },
                            child: textfield(
                                listAdminOption[i]['title'].toString())))
                else if (index == 5)
                  for (int i = 0; i < verbalOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerbalAgent(
                                            type: (value) {},
                                            listUser: widget.listUser,
                                            addNew: (value) {},
                                          )));
                            },
                            child:
                                textfield(verbalOption[i]['title'].toString())))
                else if (index == 6)
                  for (int i = 0; i < approvelList.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ClassSubmit(
                                        device: widget.device,
                                        listUser: widget.listUser)));

                                // setState(() {
                                //   type = 70;
                                //   print("OKOK : $type");
                                // });
                              }
                            },
                            child:
                                textfield(approvelList[i]['title'].toString())))
                else if (index == 7)
                  for (int i = 0; i < userOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              switch (i) {
                                case 0:
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => UserListPage(
                                          id: widget.listUser[0]['id']
                                              .toString())));
                                  break;
                                case 1:
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => UserListForAdmin(
                                          id: widget.listUser[0]['id']
                                              .toString())));
                                  break;
                                case 2:
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const CTL_User()));
                                  break;
                                case 3:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Notivigation_day(),
                                      ));
                                  break;

                                default:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => User_Vpoint(
                                          controller_user: widget.id,
                                        ),
                                      ));
                                  break;
                              }
                            },
                            child:
                                textfield(userOption[i]['title'].toString())))
                else if (index == 8)
                  for (int i = 0; i < listReportOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              switch (i) {
                                case 0:
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return MenuCostomerResport(id: widget.id);
                                    },
                                  ));
                                  break;
                                case 2:
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        content: IntrinsicWidth(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                title: const Text(
                                                    'Comparable Year Report'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ResponsiveReportYear(),
                                                    ),
                                                  );
                                                },
                                              ),
                                              ListTile(
                                                title: const Text(
                                                    'Comparable Case'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ComparableCasePage(),
                                                    ),
                                                  );
                                                },
                                              ),
                                              ListTile(
                                                title: const Text(
                                                    'Comparable Case Bar Chart'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ComparableCaseBarChartPage(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  break;
                                case 5:
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const Total_Amount();
                                    },
                                  ));
                                  break;
                                case 6:
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const Trastoin_Payment();
                                    },
                                  ));
                                  break;
                                case 7:
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return AddUser();
                                    },
                                  ));
                                  break;
                                default:
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const IsOnline();
                                    },
                                  ));
                              }
                            },
                            child: textfield(
                                listReportOption[i]['title'].toString())))
                else if (index == 9)
                  for (int i = 0; i < adminControllerList.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              switch (i) {
                                case 0:
                                  AwesomeDialog(
                                    padding: const EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                        bottom: 10,
                                        top: 10),
                                    alignment: Alignment.center,
                                    width: 400,
                                    context: context,
                                    dialogType: DialogType.question,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: "Client Update!",
                                    desc:
                                        "Do you want Allow to client All for New Update?",
                                    btnOkOnPress: () async {
                                      await controllerUpdate
                                          .checkUpdateClientAll(context);
                                    },
                                    btnCancelOnPress: () {},
                                  ).show();
                                  break;
                                case 1:
                                  AwesomeDialog(
                                    padding: const EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                        bottom: 10,
                                        top: 10),
                                    alignment: Alignment.center,
                                    width: 400,
                                    context: context,
                                    dialogType: DialogType.question,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: "Admin Update!",
                                    desc:
                                        "Do you want Allow to Admin All for New Update?",
                                    btnOkOnPress: () async {
                                      await controllerUpdate
                                          .checkUpdateAll(context);
                                    },
                                    btnCancelOnPress: () {},
                                  ).show();
                                  break;
                                case 2:
                                  AwesomeDialog(
                                    padding: const EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                        bottom: 10,
                                        top: 10),
                                    alignment: Alignment.center,
                                    width: 400,
                                    context: context,
                                    dialogType: DialogType.question,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: "Off Client System!",
                                    desc: "Do you want Off system Client?",
                                    btnOkOnPress: () async {
                                      await controllerUpdate.checkOFFSystemAll(
                                          1, 1, context);
                                    },
                                    btnCancelOnPress: () {},
                                  ).show();
                                  break;

                                case 3:
                                  AwesomeDialog(
                                    padding: const EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                        bottom: 10,
                                        top: 10),
                                    alignment: Alignment.center,
                                    width: 400,
                                    context: context,
                                    dialogType: DialogType.question,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: "Open Client System!",
                                    desc: "Do you want Open system Client?",
                                    btnOkOnPress: () async {
                                      await controllerUpdate.checkOFFSystemAll(
                                          1, 0, context);
                                    },
                                    btnCancelOnPress: () {},
                                  ).show();
                                  break;
                                case 4:
                                  AwesomeDialog(
                                    padding: const EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                        bottom: 10,
                                        top: 10),
                                    alignment: Alignment.center,
                                    width: 400,
                                    context: context,
                                    dialogType: DialogType.question,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: "Off Admin System!",
                                    desc: "Do you want Off system Admin?",
                                    btnOkOnPress: () async {
                                      await controllerUpdate.checkOFFSystemAll(
                                          2, 2, context);
                                    },
                                    btnCancelOnPress: () {},
                                  ).show();
                                  break;
                                case 5:
                                  AwesomeDialog(
                                    padding: const EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                        bottom: 10,
                                        top: 10),
                                    alignment: Alignment.center,
                                    width: 400,
                                    context: context,
                                    dialogType: DialogType.question,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: "Open Admin System!",
                                    desc: "Do you want Open system Admin?",
                                    btnOkOnPress: () async {
                                      await controllerUpdate.checkOFFSystemAll(
                                          2, 0, context);
                                    },
                                    btnCancelOnPress: () {},
                                  ).show();
                                  break;
                                case 6:
                                  break;
                                default:
                              }
                            },
                            child: textfield(
                                adminControllerList[i]['title'].toString())))
                // else if(index==9)
              ];
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 15,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: whiteColor),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        listControllerIcons[index]['icon'].toString(),
                        fit: BoxFit.cover,
                        height: 90,
                        width: (widget.device == 't' || widget.device == 'd')
                            ? 100
                            : 125,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        listControllerTitle[index]['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontsizes,
                            color: (selectindexs == index)
                                ? blueColor
                                : greyColorNolot),
                      ),
                      const SizedBox(height: 30)
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget settingOptionWrap() {
    return Wrap(
      alignment:
          (widget.device == 'm') ? WrapAlignment.center : WrapAlignment.start,
      children: [
        for (int index = 0; index < optionIconListsetting.length; index++)
          PopupMenuButton(
            elevation: 15,
            itemBuilder: (context) {
              return [
                if (index == 1)
                  for (int i = 0; i < registerOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {},
                            child: textfield(
                                registerOption[i]['title'].toString())))
                else if (index == 2)
                  for (int i = 0; i < autoOptions.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (index == 2) {
                                for (int i = 0; i < registerOption.length; i++)
                                  if (i == 0) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NewAuto()));
                                  }
                                if (i == 1) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AutoList()));
                                }
                                if (i == 2) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const District()));
                                }
                              }
                            },
                            child:
                                textfield(autoOptions[i]['title'].toString())))
                else if (index == 4)
                  for (int i = 0; i < bankOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const new_Bank()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Bank_list()));
                              }
                            },
                            child:
                                textfield(bankOption[i]['title'].toString())))
                else if (index == 5)
                  for (int i = 0; i < brandOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const new_Brand()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Brand_list()));
                              }
                            },
                            child:
                                textfield(brandOption[i]['title'].toString())))
                else if (index == 6)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => New_Agency()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Agency_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 9)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => New_Assign()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Assign_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 10)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const New_Inspector()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Assign_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 11)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const New_Inspector()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Assign_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 12)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const New_Register()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Register_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 13)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const New_Acompany()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Acompany_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 14)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const New_Acompany()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Approved_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 15)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const New_Appraiser()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Appraiser_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 19)
                  for (int i = 0; i < vpointOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => VpointListPage()));
                            },
                            child:
                                textfield(vpointOption[i]['title'].toString())))
                else if (index == 20)
                  for (int i = 0; i < sponsorOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SponsorListPage()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const SliderPage()));
                              }
                            },
                            child: textfield(
                                sponsorOption[i]['title'].toString())))
                else if (index == 21)
                  for (int i = 0; i < faqOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Get.to(() => FaqPage(),
                                    preventDuplicates: false);
                              }
                              if (i == 1) {
                                Get.to(() => const ContactUsPage(),
                                    preventDuplicates: false);
                              }
                              if (i == 2) {
                                Get.to(() => const AboutUsPage(),
                                    preventDuplicates: false);
                              }
                            },
                            child: textfield(faqOption[i]['title'].toString())))
              ];
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 15,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: whiteColor),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        optionIconListsetting[index]['icon'].toString(),
                        fit: BoxFit.cover,
                        height: 80,
                        width: (widget.device == 't' || widget.device == 'd')
                            ? 100
                            : 125,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        listTitlesetting[index]['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontsizes,
                            color: (selectindexs == index)
                                ? blueColor
                                : greyColorNolot),
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  ControllerUpdate controllerUpdate = ControllerUpdate();
  int onrow = 10;
  String dd = '';
  Uint8List? getBytes;
  Uint8List? byesData;

  String? croppedBlobUrl;
  html.File? cropimageFile;
  Future<void> cropImage() async {
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
      getBytes = Uint8List.fromList(bytes);
      // await
      setState(() {
        croppedBlobUrl = croppedFile.path;
        saveBlobToFile(croppedBlobUrl!, croppedFile.path);
        Navigator.pop(context);
      });

      if (cropimageFile != null) {}
    }
  }

  Future<void> saveBlobToFile(String blobUrl, String filename) async {
    final response = await http.get(Uri.parse(blobUrl));
    final bytes = response.bodyBytes;

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/$filename";
  }

  List bank = [
    {'title': 'Bank'},
    {'title': 'Private'},
    {'title': 'Other'},
  ];
  List genderlist = [
    {'title': 'Male'},
    {'title': 'Female'},
    {'title': 'Other'},
  ];
  Random random = Random();

  String imageUrl = '';
  Uint8List? selectedFile;
  // late File croppedFile;
  final completer = Completer<Uint8List>();
  // Future<void> openImgae() async {
  //   html.FileUploadInputElement uploadInput = html.FileUploadInputElement();

  //   uploadInput.multiple = true;
  //   uploadInput.draggable = true;
  //   uploadInput.click();

  //   uploadInput.onChange.listen((event) {
  //     final files = uploadInput.files;
  //     final file = files!.elementAt(0);
  //     final reader = html.FileReader();
  //     reader.onLoadEnd.listen((event) {
  //       setState(() {
  //         byesData = const Base64Decoder()
  //             .convert(reader.result.toString().split(',').last);
  //         selectedFile = byesData;
  //         croppedFile = File.fromRawPath(byesData!);
  //         imageUrl = html.Url.createObjectUrlFromBlob(file.slice());
  //         // Navigator.pop(context);
  //       });
  //     });
  //     reader.readAsDataUrl(file);
  //   });
  // }

  double fontsizepf = 12;
  Widget profile() {
    return Container(
      height: 100,
      width: (widget.device == 'd' || widget.device == 't')
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 26, 50, 209),
            Color.fromARGB(255, 39, 92, 206),
            Color.fromARGB(255, 39, 92, 206),
            Color.fromARGB(255, 6, 172, 201),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.1, 0.2, 0.3, 0.5],
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      (widget.device == 'm')
                          ? IconButton(
                              onPressed: () {
                                scaffoldKey.currentState!.openDrawer();
                              },
                              icon: Icon(
                                Icons.menu,
                                color: whileColors,
                              ))
                          : const SizedBox(),
                      const SizedBox(width: 10),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Profile',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: greyColor)),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                            Icons.remove_circle_outline))
                                  ]),
                              const SizedBox(height: 10),
                              Container(
                                height: 120,
                                width: 300,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: whileColors,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {});
                                        },
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            if (byesData == null)
                                              GFAvatar(
                                                size: 40,
                                                backgroundImage: NetworkImage(
                                                    '${(widget.listUser[0]['url'] == null) ? url : widget.listUser[0]['url']}'),
                                              )
                                            else if (byesData != null &&
                                                getBytes == null)
                                              GFAvatar(
                                                size: 40,
                                                backgroundImage:
                                                    MemoryImage(byesData!),
                                              )
                                            else
                                              GFAvatar(
                                                size: 40,
                                                backgroundImage:
                                                    MemoryImage(getBytes!),
                                              ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      cropImage();
                                                    },
                                                    icon: Icon(
                                                      Icons.crop,
                                                      color: whileColors,
                                                      size: 20,
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      // openImgae();
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: whileColors,
                                                      size: 20,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Name : $username',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: fontsizepf,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'ID : $controlleruser',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: fontsizepf,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  TwinBox(
                                    labelText1: 'Firstname',
                                    labelText2: 'Lastname',
                                    fname: firstName.toString(),
                                    lname: lastName.toString(),
                                    get_fname: (value) {
                                      setState(() {
                                        // requestModel!.first_name = value;
                                      });
                                    },
                                    get_lname: (value) {
                                      setState(() {
                                        // requestModel!.last_name = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      DropDowntxt(
                                        txtvalue: gender.toString(),
                                        validator: true,
                                        flex: 3,
                                        value: (value) {},
                                        list: genderlist,
                                        valuedropdown: 'title',
                                        valuetxt: 'title',
                                      ),
                                      const SizedBox(width: 5),
                                      DropDowntxt(
                                        txtvalue: knownFrom.toString(),
                                        validator: true,
                                        flex: 3,
                                        value: (value) {},
                                        list: bank,
                                        valuedropdown: 'title',
                                        valuetxt: 'title',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const SingleBox(
                                    phone: "",
                                  ),
                                  const SizedBox(height: 10),
                                  Field_box(
                                    name: 'email',
                                    email: email.toString(),
                                    get_email: (value) {
                                      setState(() {
                                        email = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          // controller: Password!,
                                          onChanged: (input) {
                                            setState(() {
                                              password = input;
                                            });
                                          },
                                          // obscureText: isObscure,
                                          decoration: InputDecoration(
                                            fillColor: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            filled: true,
                                            labelText: 'Your Password',
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                color: const Color.fromRGBO(
                                                    169, 203, 56, 1),
                                                isObscure
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isObscure = !isObscure;
                                                });
                                              },
                                            ),
                                          ),
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return 'require *';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     ElevatedButton(
                              //       child: const Text('Save Change'),
                              //       onPressed: () async {
                              //         if (byesData != null) {
                              //           updateimage();
                              //           print('uploard');
                              //         }
                              //         // updateUser();
                              //       },
                              //     ),
                              //     const SizedBox(width: 15),
                              //     ElevatedButton(
                              //       child: const Text('Log Out'),
                              //       onPressed: () {
                              //         Navigator.pop(context);
                              //         Navigator.pop(context);
                              //       },
                              //     )
                              //   ],
                              // ),
                              // const SizedBox(height: 30),
                            ],
                          ))
                        ],
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(url.toString()),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.listUser[0]['username'].toString(),
                              style: TextStyle(
                                  color: whileColors,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Text(widget.listUser[0]['username'].toString(),
                              style: TextStyle(
                                color: whileColors,
                                fontSize: 12,
                              )),
                        ],
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
                const Spacer(),
                Obx(() {
                  if (controllerUpdate.checkS.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            if (controllerUpdate.checkUpdateNew.value == 1)
                              const Text(
                                "Update New ",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 14),
                              )
                            else
                              const Text(
                                "Update Done! ",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 14),
                              ),
                            if (controllerUpdate.checkUpdateNew.value == 1)
                              InkWell(
                                onTap: () async {
                                  await controllerUpdate.checkUpdateDone(
                                      widget.listUser[0]['agency'].toString());
                                  html.window.location.reload();
                                  await clearAllExcept("localhost");
                                },
                                child: Image.asset(
                                  "assets/images/refresh.png",
                                  height: 35,
                                  width: 35,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
                const SizedBox(width: 10),
                if (widget.listUser[0]['agency'].toString() == "28")
                  const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
