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
import 'package:web_admin/page/navigate_home/percentage/Percentage_compare.dart';
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
import '../navigate_home/Approvel/submit_list.dart';
import '../navigate_home/Customer/component/Web/editText/dropdowntxt.dart';
import '../navigate_home/Report/page/v_point_list_page.dart';
import '../navigate_home/User/setAdmin.dart';
import '../navigate_home/admin/allow_option.dart';
import '../../Widgets/drawerMenu.dart';
import '../../Widgets/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import '../navigate_home/admin/att_staff.dart';

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
    // updateUserStatus();

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
    // controllerUpdate.checkUpdate(widget.listUser[0]['agency'].toString());
  }

  Authentication authentication = Authentication();
  bool hasUnsavedData = true;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Future<void> updateUserStatus() async {
  //   await authentication
  //       .checkAdminUser(int.parse(authentication.listlocalhost[0]['agency'].toString()));
  //   final QuerySnapshot result = await _firestore
  //       .collection('users')
  //       .where('id_agent', isEqualTo: authentication.listlocalhost[0]['agency'].toString())
  //       .limit(1)
  //       .get();

  //   if (result.docs.isNotEmpty) {
  //     // User found
  //     final userDocRef = result.docs.first.reference;
  //     await userDocRef.update({
  //       'isOnline': true,
  //       'lastActive': FieldValue.serverTimestamp(),
  //     });

  //     html.window.onBeforeUnload.listen((event) async {
  //       event.preventDefault();
  //       await userDocRef.update({
  //         'isOnline': false,
  //         'lastActive': FieldValue.serverTimestamp(),
  //       });
  //       Future.delayed(const Duration(seconds: 30), () async {
  //         await userDocRef.update({
  //           'isOnline': true,
  //           'lastActive': FieldValue.serverTimestamp(),
  //         });
  //       });
  //     });
  //   }
  //   controllerUpdate.checkUpdate(authentication.listlocalhost[0]['agency'].toString());
  // }

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
  // int type = 7;
  @override
  Widget build(BuildContext context) {
    // imageLogoAdmin = Get.put(ImageLogoAdmin());
    authentication = Get.put(Authentication());
    optionHome = Get.put(OptionHome());
    w = MediaQuery.of(context).size.width;
    controllerUpdate = Get.put(ControllerUpdate());
    return Obx(
      () {
        if (authentication.isLocalhost.value) {
          return const WaitingFunction();
        } else if (authentication.listlocalhost.isEmpty) {
          return const SizedBox(
            child: Text(('No Data')),
          );
        } else {
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: backgroundScreen,
            // drawer: DrawerWidget(
            //     email: authentication.listlocalhost[0]['username'].toString(),
            //     listUser: authentication.listlocalhost,
            //     password:
            //         authentication.listlocalhost[0]['username'].toString()),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (widget.device == 't' || widget.device == 'd')
                    ? DrawerOption(
                        // listTitle: [],
                        onBack: (value) {
                          setState(() {
                            type = value;
                          });
                        },
                        device: widget.device,
                        email: authentication.listlocalhost[0]['username']
                            .toString(),
                        listUser: authentication.listlocalhost,
                      )
                    : const SizedBox(),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: Column(
                      children: [
                        profile(),
                        if (type == 0 &&
                            authentication.listlocalhost[0]['check_dashbord']
                                    .toString() ==
                                "1")
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: whileColors),
                              child: Obx(
                                () {
                                  if (optionHome.isVerbal.value) {
                                    return const WaitingFunction();
                                  } else {
                                    return SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              optionTxt(
                                                  "All Clients",
                                                  optionHome
                                                      .countAllUsers.value,
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
                                                optionTxt(
                                                    "Client Top Up",
                                                    "N/A",
                                                    Icons.verified,
                                                    false,
                                                    ""),
                                                const SizedBox(width: 10),
                                                optionTxt(
                                                    "VPoint Client Used",
                                                    "N/A",
                                                    Icons.verified,
                                                    false,
                                                    ""),
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
                                              } else if (optionHome
                                                  .dataMap.isEmpty) {
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
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: greyColor),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15),
                                                            child: PieChart(
                                                              dataMap:
                                                                  optionHome
                                                                      .dataMap,
                                                              animationDuration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          800),
                                                              chartLegendSpacing:
                                                                  32,
                                                              chartRadius:
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      3.2,
                                                              colorList:
                                                                  colorList,
                                                              initialAngleInDegree:
                                                                  0,
                                                              chartType:
                                                                  ChartType
                                                                      .ring,
                                                              ringStrokeWidth:
                                                                  32,
                                                              centerText:
                                                                  "Data",
                                                              legendOptions:
                                                                  const LegendOptions(
                                                                showLegendsInRow:
                                                                    false,
                                                                legendPosition:
                                                                    LegendPosition
                                                                        .right,
                                                                showLegends:
                                                                    true,
                                                                legendShape:
                                                                    BoxShape
                                                                        .circle,
                                                                legendTextStyle:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              chartValuesOptions:
                                                                  const ChartValuesOptions(
                                                                showChartValueBackground:
                                                                    true,
                                                                showChartValues:
                                                                    true,
                                                                showChartValuesInPercentage:
                                                                    false,
                                                                showChartValuesOutside:
                                                                    false,
                                                                decimalPlaces:
                                                                    1,
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
                                                                onPressed:
                                                                    () {},
                                                                icon: Icon(
                                                                    Icons
                                                                        .refresh,
                                                                    color:
                                                                        greenColors,
                                                                    size: 25)),
                                                            Text(
                                                              "  Refrech",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      greyColor,
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
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          )
                        else if (type == 0 &&
                            authentication.listlocalhost[0]['check_dashbord']
                                    .toString() ==
                                "0")
                          const Expanded(
                              child: Padding(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(
                              width: double.infinity,
                            ),
                          )),
                        if (type != 0)
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: double.infinity,
                              child: detailOption(),
                            ),
                          )),
                        // Text("type : $type")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
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
  final completer = Completer<Uint8List>();

  double fontsizepf = 12;
  Widget profile() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
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
                                                  '${(authentication.listlocalhost[0]['url'] == null) ? url : authentication.listlocalhost[0]['url']}'),
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
                                          if (input == null || input.isEmpty) {
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
                        Text(
                            authentication.listlocalhost[0]['username']
                                .toString(),
                            style: TextStyle(
                                color: whileColors,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(
                            authentication.listlocalhost[0]['username']
                                .toString(),
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
              IconButton(
                  onPressed: () {
                    authentication.getAgentByID(
                        authentication.listlocalhost[0]['agency'].toString());
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: whileColors,
                    size: 35,
                  )),
              const Spacer(),
              // Text(
              //   'Refrech',
              //   style: TextStyle(color: whileColors),
              // ),
              // const SizedBox(width: 5),
              // IconButton(
              //     onPressed: () {},
              //     icon: Icon(
              //       Icons.refresh,
              //       color: whileColors,
              //       size: 35,
              //     )),
              ///PPPPPPPPP
              const SizedBox(width: 20),
              TextButton(
                  onPressed: () {
                    controllerUpdate
                        .checkUpdate(widget.listUser[0]['agency'].toString());
                  },
                  child: CircleAvatar(
                      radius: 20,
                      backgroundColor: whileColors,
                      child: Icon(Icons.refresh))),
              Obx(() {
                if (controllerUpdate.checkS.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controllerUpdate.listSystem.isEmpty) {
                  return const Center(
                    child: Text('No Data'),
                  );
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
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            )
                          else
                            const Text(
                              "Update Done!",
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          if (controllerUpdate.checkUpdateNew.value == 1)
                            InkWell(
                              onTap: () async {
                                await controllerUpdate.checkUpdateDone(
                                    authentication.listlocalhost[0]['agency']
                                        .toString());
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
              if (authentication.listlocalhost[0]['agency'].toString() == "28")
                const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

//109
  Widget detailOption() {
    switch (type) {
      case 0:
        return const Text('Home Page');
      case 107:
        return AllowOptions(
          listUsers: authentication.listlocalhost,
        );
      case 7:
        return ListSubmitAdmin(
            device: widget.device, listUser: authentication.listlocalhost);
      case 108:
        return const SetAdminClass();
      case 109:
        return AttTable(
          listUsers: authentication.listlocalhost,
        );
      //Setting Admin
      case 220:
        return VpointListPage();
      case 221:
        return const SizedBox();
      case 301:
        return PercentageClass(
          listUsers: widget.listUser,
        );
      // VpointDetailPage(
      //   vpoint: '',
      // );

      default:
        return const SizedBox();
    }
  }
}
