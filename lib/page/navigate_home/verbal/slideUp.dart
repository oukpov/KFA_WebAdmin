// ignore_for_file: use_build_context_synchronously

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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:web_admin/components/property35_search.dart';
import 'package:web_admin/page/navigate_home/verbal/verbal_list.dart';
import '../../../../models/search_model.dart';
import '../../../Customs/ProgressHUD.dart';
import '../../../Customs/formTwinN.dart';
import '../../../Customs/formnum.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:universal_html/html.dart' as html;
import '../../../components/Dateform.dart';
import '../../../components/autoVerbalType_search.dart';
import '../../../components/colors.dart';
import '../../../components/date.dart';
import '../../../components/property35.dart';
import '../../../getx/component/getx._snack.dart';
import '../../../getx/verbal/verbal_agent.dart';
import '../../../models/verbalAgentMode.dart';
import '../../../screen/Property/FirstProperty/component/Colors/appbar.dart';

class VerbalAgent extends StatefulWidget {
  const VerbalAgent(
      {super.key,
      required this.type,
      required this.listUser,
      required this.addNew});

  final OnChangeCallback type;
  final OnChangeCallback addNew;
  final List listUser;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<VerbalAgent> with TickerProviderStateMixin {
  double _panelHeightOpen = 0;
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  final Set<Marker> listMarkerIds = {};
  double latitude = 11.5489; //latitude
  double longitude = 104.9214;
  LatLng latLng = const LatLng(11.5489, 104.9214);
  String address = "";
  List<Marker> markers = [];
  List list = [];
  double addingPrice = 0;
  double addingPriceVerbal = 0;
  double addingPriceSimple = 0;
  String sendAddrress = '';
  List data = [];
  // double add_min = 20.0, add_max = 20.0;
  // ignore: prefer_typing_uninitialized_variables
  var pty;
  var formatter = NumberFormat("##,###,###,###", "en_US");
  var date = DateFormat('yyyy-MM-dd').format(DateTime(2020, 01, 01));
  var date1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool isApiCallProcess = false;
  late SearchRequestModel requestModel;
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services'),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  TextEditingController addressController = TextEditingController();
  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latLng = LatLng(position.latitude, position.longitude);

      Marker marker = Marker(
        markerId: const MarkerId('mark'),
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
      setState(() {
        markers.clear();

        listMarkerIds.add(marker);
        requestModel.lat = latLng.latitude.toString();
        requestModel.lng = latLng.longitude.toString();
        findlocation(latLng);
      });
    });
  }

  bool checkDone = false;
  Future<void> findlocation(LatLng latlog) async {
    setState(() {
      searchBool = true;
      latLng = LatLng(latlog.latitude, latlog.longitude);
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 17)));
      Marker marker = Marker(
        draggable: true,
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        onDragEnd: (value) {
          latLng = value;
        },
      );
      setState(() {
        listMarkerIds.clear();
        listMarkerIds.add(marker);
        requestModel.lat = latLng.latitude.toString();
        requestModel.lng = latLng.longitude.toString();
      });
    });
  }

  bool checkFunction = false;

  late String autoverbalType;
  // Data dataModel = Data();
  final TextEditingController priceController = TextEditingController();
  TextEditingController searchraod = TextEditingController();
  TextEditingController searchlatlog = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController controllerDrop = TextEditingController();
  final TextEditingController controllerDS = TextEditingController();
  final TextEditingController controllerArea = TextEditingController();
  final TextEditingController referrenceNController = TextEditingController();
  final TextEditingController underPropertyRightController =
      TextEditingController();
  final TextEditingController titleDeedNController = TextEditingController();
  @override
  void dispose() {
    controllerDrop.dispose();
    searchlatlog.dispose();
    searchraod.dispose();
    searchMap.dispose();
    priceController.dispose();
    super.dispose();
    distanceController.dispose();
    controllerDS.dispose();
  }

  var intValue = Random().nextInt(10);
  late AnimationController acontroller;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );
  @override
  void initState() {
    verbalAgentModel.referrenceN =
        referrenceNController.text = "ARF${DateFormat('yy').format(now)} - ";
    verbalAgentModel.verbalCode =
        "${widget.listUser[0]['agency']}${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(100)}";
    verbalAgentModel.verbalImage = "No";
    _handleLocationPermission();
    pdfimage();
    acontroller = AnimationController(
      duration: const Duration(milliseconds: 645),
      vsync: this,
    );
    animation = CurvedAnimation(parent: acontroller, curve: Curves.linear);
    acontroller.reset();
    offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.3),
    ).animate(
      CurvedAnimation(
        parent: acontroller,
        curve: Curves.easeInOutBack,
      ),
    );
    distanceController.text = '5';
    requestModel = SearchRequestModel(
      property_type_id: "",
      num: "5",
      lat: "",
      lng: "",
      land_min: "0",
      land_max: "",
      distance: "",
      fromDate: "",
      toDate: "",
    );

    autoverbalType = "";
    super.initState();
  }

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

  int countwaiting = 0;
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      color: const Color.fromARGB(255, 0, 49, 212),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: _uiSteup(context),
    );
  }

  Widget _uiSteup(BuildContext context) {
    _panelHeightOpen = (groupValue == 0)
        ? MediaQuery.of(context).size.height * 0.35
        : MediaQuery.of(context).size.height * 0.15;

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        color: appback,
                        height: MediaQuery.of(context).size.height,
                        width: 500,
                        child: SingleChildScrollView(
                            child: Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  IconButton(
                                    onPressed: () {
                                      widget.type(100);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: whiteColor,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, right: 5, left: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            searchComparable();
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color.fromARGB(
                                                    255, 241, 15, 3),
                                                border: Border.all(
                                                    width: 1,
                                                    color: whiteColor)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Search Price',
                                                  style: TextStyle(
                                                      color: whiteColor,
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(width: 5),
                                                Icon(Icons.search,
                                                    color: whiteColor, size: 25)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Text(
                                    "Search by Latitude and Longitude",
                                    style: TextStyle(
                                        color: whiteColor, fontSize: 15),
                                  ),

                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      for (int j = 0;
                                          j < listlatlog.length;
                                          j++)
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: (j == 0) ? 10 : 0),
                                            child: Container(
                                              height: 35,
                                              // width: 170,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: whiteColor,
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: blackColor)),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                // controller: searchlatlog,
                                                onFieldSubmitted: (value) {
                                                  setState(() {
                                                    if (j == 0) {
                                                      // lat = double.parse(value);
                                                      requestModel.lat =
                                                          value.toString();
                                                    } else {
                                                      // log = double.parse(value);
                                                      requestModel.lng =
                                                          value.toString();
                                                    }
                                                  });
                                                },
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (j == 0) {
                                                      // lat = double.parse(value);
                                                      requestModel.lat =
                                                          value.toString();
                                                    } else {
                                                      // log = double.parse(value);
                                                      requestModel.lng =
                                                          value.toString();
                                                    }
                                                  });
                                                },
                                                //,
                                                textInputAction:
                                                    TextInputAction.search,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10,
                                                          horizontal: 8),
                                                  suffixIcon: (j == 0)
                                                      ? const SizedBox()
                                                      : IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              maincheck();
                                                              checklatlog =
                                                                  false;
                                                              findlocation(LatLng(
                                                                  double.parse(
                                                                      requestModel
                                                                          .lat),
                                                                  double.parse(
                                                                      requestModel
                                                                          .lng)));
                                                              // findlocation(LatLng(
                                                              //     11.499263, 104.874885));
                                                              findByPiont(
                                                                  double.parse(
                                                                      requestModel
                                                                          .lat),
                                                                  double.parse(
                                                                      requestModel
                                                                          .lng));
                                                              // getAddress(LatLng(
                                                              //     double.parse(
                                                              //         requestModel
                                                              //             .lat),
                                                              //     double.parse(
                                                              //         requestModel
                                                              //             .lng)));
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.search,
                                                            color: greyColor,
                                                          )),

                                                  fillColor: Colors.white,
                                                  hintText: listlatlog[j]
                                                          ['title']
                                                      .toString(),
                                                  border: InputBorder.none,
                                                  // contentPadding:
                                                  //     const EdgeInsets.symmetric(
                                                  //         vertical: 8, horizontal: 5),
                                                  hintStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 118, 116, 116),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Search Map",
                                    style: TextStyle(
                                        color: whiteColor, fontSize: 15),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 35,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: whiteColor,
                                        border: Border.all(
                                            width: 0.5, color: blackColor)),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: searchMap,
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          onSearchChanged();
                                        });
                                      },
                                      onChanged: (value) {
                                        onSearchChanged();
                                      },
                                      textInputAction: TextInputAction.search,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        suffixIcon: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                onSearchChanged();
                                                h = 0;
                                              });
                                            },
                                            child: Icon(
                                              Icons.search,
                                              color: whiteColor,
                                              size: 20,
                                            )),
                                        suffix: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                searchMap.clear();
                                                listMap = [];
                                              });
                                            },
                                            icon: Icon(
                                              Icons.remove_circle_outline,
                                              color: greyColorNolot,
                                            )),
                                        fillColor: Colors.white,
                                        hintText: "  Search",
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 10),
                                        hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 118, 116, 116),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Divider(height: 3, color: greyColorNolots),
                                  const SizedBox(height: 10),
                                  if (comparedropdown2 != "")
                                    Text('Specail Option',
                                        style: TextStyle(
                                            color: whiteColor, fontSize: 12)),
                                  if (comparedropdown2 != "")
                                    const SizedBox(height: 10),
                                  // Row(
                                  //   children: [
                                  //     if (comparedropdown2 != "")
                                  //       Expanded(
                                  //         flex: 1,
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               right: 10),
                                  //           child: SizedBox(
                                  //             height: 35,
                                  //             child: DropdownButtonFormField<
                                  //                 String>(
                                  //               //value: genderValue,

                                  //               value:
                                  //                   searchlatlog.text.isNotEmpty
                                  //                       ? searchlatlog.text
                                  //                       : null,
                                  //               isExpanded: true,
                                  //               onChanged: (newValue) {
                                  //                 setState(() {
                                  //                   clearmarker = true;
                                  //                   searchlatlog.text =
                                  //                       newValue ?? "";
                                  //                   if (newValue == 'N') {
                                  //                     comparedropdown = '';
                                  //                   } else {
                                  //                     comparedropdown =
                                  //                         newValue!;
                                  //                     comparedropdown2 = 'P';
                                  //                   }
                                  //                   checkdropdown =
                                  //                       comparedropdown;

                                  //                   print(
                                  //                       '==> $comparedropdown');
                                  //                 });
                                  //               },

                                  //               items: controller.listdropdown
                                  //                   .map<
                                  //                       DropdownMenuItem<
                                  //                           String>>(
                                  //                     (value) =>
                                  //                         DropdownMenuItem<
                                  //                             String>(
                                  //                       value: value["type"]
                                  //                           .toString(),
                                  //                       child: Padding(
                                  //                         padding:
                                  //                             const EdgeInsets
                                  //                                     .only(
                                  //                                 bottom: 7),
                                  //                         child: Row(
                                  //                           children: [
                                  //                             Expanded(
                                  //                                 flex: 1,
                                  //                                 child:
                                  //                                     Padding(
                                  //                                   padding: const EdgeInsets
                                  //                                           .only(
                                  //                                       right:
                                  //                                           5),
                                  //                                   child: SizedBox(
                                  //                                       height: 70,
                                  //                                       // radius: 15,
                                  //                                       // backgroundColor: Colors.white,
                                  //                                       child: (value['id'] == 1)
                                  //                                           ? Image.asset(
                                  //                                               listassetImage[0]['image'].toString(),
                                  //                                             )
                                  //                                           : (value['id'] == 2)
                                  //                                               ? Image.asset(listassetImage[1]['image'].toString())
                                  //                                               : (value['id'] == 3)
                                  //                                                   ? Image.asset(listassetImage[2]['image'].toString())
                                  //                                                   : (value['id'] == 4)
                                  //                                                       ? Image.asset(listassetImage[3]['image'].toString())
                                  //                                                       : (value['id'] == 5)
                                  //                                                           ? Image.asset(listassetImage[4]['image'].toString())
                                  //                                                           : (value['id'] == 6)
                                  //                                                               ? Image.asset(listassetImage[5]['image'].toString())
                                  //                                                               : (value['id'] == 7)
                                  //                                                                   ? Image.asset(listassetImage[6]['image'].toString())
                                  //                                                                   : Image.asset(listassetImage[7]['image'].toString())),
                                  //                                 )),
                                  //                             Expanded(
                                  //                               flex: 2,
                                  //                               child: Text(
                                  //                                   value["title"]
                                  //                                       .toString(),
                                  //                                   style: const TextStyle(
                                  //                                       fontWeight:
                                  //                                           FontWeight
                                  //                                               .bold,
                                  //                                       fontSize:
                                  //                                           14)),
                                  //                             ),
                                  //                             Expanded(
                                  //                                 flex: 4,
                                  //                                 child: Text(
                                  //                                     value[
                                  //                                         "name"],
                                  //                                     style: const TextStyle(
                                  //                                         fontSize:
                                  //                                             12))),
                                  //                           ],
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                   )
                                  //                   .toList(),
                                  //               // add extra sugar..
                                  //               icon: const Icon(
                                  //                 Icons.arrow_drop_down,
                                  //                 color: kImageColor,
                                  //               ),

                                  //               decoration: InputDecoration(
                                  //                 contentPadding:
                                  //                     const EdgeInsets
                                  //                             .symmetric(
                                  //                         vertical: 0,
                                  //                         horizontal: 0),
                                  //                 fillColor: Colors.white,
                                  //                 filled: true,
                                  //                 labelText: 'Special Option',
                                  //                 hintText: 'Select one',
                                  //                 prefixIcon: const Icon(
                                  //                   Icons.home_outlined,
                                  //                   color: kImageColor,
                                  //                 ),
                                  //                 focusedBorder:
                                  //                     OutlineInputBorder(
                                  //                   borderSide:
                                  //                       const BorderSide(
                                  //                           color:
                                  //                               kPrimaryColor,
                                  //                           width: 2.0),
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(
                                  //                           10.0),
                                  //                 ),
                                  //                 enabledBorder:
                                  //                     OutlineInputBorder(
                                  //                   borderSide:
                                  //                       const BorderSide(
                                  //                     width: 1,
                                  //                     color: kPrimaryColor,
                                  //                   ),
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(
                                  //                           10.0),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //   ],
                                  // ),

                                  const SizedBox(height: 5),
                                  // Row(
                                  //   children: [
                                  //     // Expanded(
                                  //     //   flex: 1,
                                  //     //   child: NumDisplay(
                                  //     //       onSaved: (newValue) => setState(() {
                                  //     //             requestModel.num = newValue!;
                                  //     //           })),
                                  //     // ),
                                  //     // const SizedBox(width: 10),
                                  //     //DDDDDDDD
                                  //     if (groupValue == 0)
                                  //       Expanded(
                                  //         flex: 1,
                                  //         child: SizedBox(
                                  //           child: searchType
                                  //               ? const SizedBox()
                                  //               : PropertySearch(
                                  //                   height: 35,
                                  //                   name: (value) {},
                                  //                   checkOnclick: (value) {
                                  //                     setState(() {
                                  //                       isChecked = value;
                                  //                       isChecked_all = false;
                                  //                     });
                                  //                   },
                                  //                   id: (value) {
                                  //                     setState(() {
                                  //                       if (value == '37') {
                                  //                         pty = null;
                                  //                         showAll = true;
                                  //                       } else {
                                  //                         pty = value;
                                  //                         showAll = true;
                                  //                       }
                                  //                     });
                                  //                   },
                                  //                 ),
                                  //         ),
                                  //       ),
                                  //   ],
                                  // ),
                                  const SizedBox(height: 10),
                                  addLandBuilding()
                                ],
                              ),
                            ),
                            Positioned(
                              top: 280,
                              child: (listMap.isEmpty)
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 350,
                                        width: 450,
                                        child: ListView.builder(
                                          itemCount: listMap.length,
                                          itemBuilder: (context, index) =>
                                              InkWell(
                                            onTap: () {
                                              setState(() {
                                                var location = listMap[index]
                                                    ['geometry']['location'];
                                                LatLng lat = LatLng(
                                                    double.parse(location['lat']
                                                        .toString()),
                                                    double.parse(location['lng']
                                                        .toString()));
                                                findlocation(lat);
                                              });
                                            },
                                            child: Container(
                                              color: whiteColor,
                                              height: 30,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: greyColorNolot,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    listMap[index]['name']
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            )
                          ],
                        )),
                      ),
                      Expanded(
                        flex: 6,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: GoogleMap(
                            markers: listMarkerIds.map((e) => e).toSet(),
                            initialCameraPosition: CameraPosition(
                              target: latLng,
                              zoom: 12.0,
                            ),
                            // polygons: Set<Polygon>.of(polygons),
                            // polygons: polygons,
                            polygons: Set<Polygon>.of(polygons),
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true,
                            mapType: MapType.hybrid,
                            onMapCreated: (controller) {
                              setState(() {
                                mapController = controller;
                              });
                            },

                            onTap: (argument) {
                              setState(() {
                                polygons.clear();
                                listBuilding = [];
                                checkGoogleMap = true;
                                // isApiCallProcess = true;

                                typedrawer = false;
                                latLng = argument;
                                requestModel.lat = latLng.latitude.toString();
                                requestModel.lng = latLng.longitude.toString();
                                findByPiont(double.parse(requestModel.lat),
                                    double.parse(requestModel.lng));
                                if (groupValue == 0) {
                                  addMarkers(argument);
                                } else {
                                  addMarkers(argument);
                                  findByPiont(double.parse(requestModel.lat),
                                      double.parse(requestModel.lng));
                                }
                              });
                            },
                            onCameraMove: (CameraPosition cameraPositiona) {
                              cameraPosition = cameraPositiona;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool searchBool = false;
  String comparedropdown = '';
  String comparedropdown2 = '';
  int groupValue = 0;
  bool isChecked = false;
  bool isChecked_all = false;
  // var id_route;

  double h = 0;
  List listMap = [];
  TextEditingController searchMap = TextEditingController();
  bool searchGoogle = false;
  Future<void> waitingSearch() async {
    searchGoogle = true;
    Future.wait([mainsearch()]);
    setState(() {
      searchGoogle = false;
    });
  }

  Timer? _debounce;
  Future<void> mainsearch() async {
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search/place/map?query=${searchMap.text}'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)['data'];
      setState(() {
        listMap = jsonResponse['results'];

        for (int i = 0; i < listMap.length; i++) {
          if (h == 0 || h < 240) {
            h += 35;
          }
        }
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  void onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      mainsearch();
    });
  }

  DateTime now = DateTime.now();
  SizedBox addPaddingWhenKeyboardAppears() {
    final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance.window.viewInsets,
      WidgetsBinding.instance.window.devicePixelRatio,
    );

    final bottomOffset = viewInsets.bottom;
    const hiddenKeyboard = 0.0; // Always 0 if keyboard is not opened
    final isNeedPadding = bottomOffset != hiddenKeyboard;

    return SizedBox(height: isNeedPadding ? bottomOffset : hiddenKeyboard);
  }

  List listassetImage = [
    {"image": "assets/icons/Approved.png"},
    {"image": "assets/icons/house.png"},
    {"image": "assets/icons/Comparable.png"},
    {"image": "assets/icons/land.png"},
    {"image": "assets/icons/area.png"},
    {"image": "assets/icons/condo.png"},
    {"image": "assets/icons/Appraiser.png"},
    {"image": "assets/icons/locations.png"},
  ];
  bool showAll = false;
  bool ontap = true;
  Future<void> addMarkers(LatLng latLng) async {
    Marker marker = Marker(
      // draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      onDragEnd: (value) {
        latLng = value;
      },
    );

    setState(() {
      typedrawerSe = true;
      haveValue = false;
      route = "";
      listMarkerIds.clear();
      data_adding_correct.clear();
      listMarkerIds.add(marker);
      requestModel.lat = latLng.latitude.toString();
      requestModel.lng = latLng.longitude.toString();
    });
  }

  Future<void> addMarker(LatLng latLng) async {
    Marker marker = Marker(
      visible: true,
      draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      onDragEnd: (value) {
        latLng = value;
      },
    );

    setState(() {
      haveValue = false;
      route = "";
      listMarkerIds.clear();
      data_adding_correct.clear();
      listMarkerIds.add(marker);
      requestModel.lat = latLng.latitude.toString();
      requestModel.lng = latLng.longitude.toString();
    });
  }

  Future aloadMenu() {
    return showDialog(
        builder: (context) => const AlertDialog(
              title: Text(
                'Please point Map First',
                style: TextStyle(),
              ),

              // content: ,
            ),
        context: context);
  }

  List<LatLng> points = [];
  Set<Polygon> polygons = {};
  bool clearMarker = false;
  bool checkpoint = false;
  bool checkpointSearch = false;
  void searchComparable() {
    setState(() {
      checkpoint = true;
      if (comparedropdown2 != "") {
        typedrawerSe == false;
      }
      if (comparedropdown2 == "" && typedrawerSe == false) {
        typedrawer = true;
        typedrawerSe = true;
        clearMarkeronly();
        findlocation(LatLng(
            double.parse(requestModel.lat), double.parse(requestModel.lng)));
      } else if (comparedropdown2 != "" && typedrawerSe == false) {
        maincheck();

        findlocation(LatLng(
            double.parse(requestModel.lat), double.parse(requestModel.lng)));
      }
    });
  }

  bool checktypeMarker = false;
  void maincheck() {
    checkpoint = true;
    listMarkerIds.clear();
    markers.clear();
    data_adding_correct.clear();
  }

  void clearMarkers() {
    setState(() {
      checkpoint = true;
      data_adding_correct.clear();
      listMarkerIds.clear();
      points.clear();
      polygons.clear();
      markers.clear();
      list.clear();
      checkpoint = false;
    });
  }

  void clearMarkeronly() {
    setState(() {
      data_adding_correct.clear();
      listMarkerIds.clear();
      markers.clear();
    });
  }

  bool checkGoogleMap = false;

  BitmapDescriptor? customIcon;
  bool clickMap = false;

  bool dropRestart = false;

  String approveId = "";
  String agent = "";
  String bankBranchId = "";
  String bankContact = "";
  String bankId = "0";
  String bankOfficer = "";
  String comment = "";
  String contact = "";
  String image = "";
  int option = 0;
  String owner = "";
  String user = "";
  String verbalCom = "";
  String verbalCon = "30";

  int indexland = 0;
  List listMarkers = [
    {"title": "Marker"},
    {"title": "Markers"},
  ];
  List listlatlog = [
    {"title": "latitude"},
    {"title": "longitude"},
  ];
  List listBorey = [
    {
      "title": "Borey",
      "check": 1,
    },
    {
      "title": "No Borey",
      "check": 0,
    }
  ];
  int? opt;
  String benifit = "";
  bool clearmarker = false;
  bool checklatlog = false;
  LatLng? latlogModel;
  bool typedrawer = false;
  bool typedrawerSe = false;
  bool moveOption = false;
  late Animation<double> animation;
  late Animation<Offset> offsetAnimation;
  String valuedropdown = '';
  int selectindex = 0;
  int selectindexs = 0;
  double sizeh = 40;
  String checkdropdown = '';
  List listBuilding = [];

  bool checkHlandbuilding = false;
  bool checkImage = false;
  String testback = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkmap = true;
  late String autoverbalTypeValue = '';
  String opionTypeID = '0';
  int optionValue = 0;
  String dep = "0";
  double hL = 0, lL = 0;
  double avgmin = 0, avgmax = 0;
  double? minSqm, maxSqm, totalMin, totalMax, totalArea;
  String? des;
  bool watingList = false;
  final _formKey = GlobalKey<FormState>();
  Component component = Component();
  List listProperty = [];
  VerbalAgents verbalAgent = VerbalAgents(iduser: "");
  VerbalAgentModel verbalAgentModel = VerbalAgentModel();
  TextEditingController provinceController = TextEditingController();
  TextEditingController ditrictController = TextEditingController();
  TextEditingController communeController = TextEditingController();
  Widget addLandBuilding() {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 5, top: 10, left: 10, bottom: 10),
          child: Row(
            children: [
              Text("Verbal", style: TextStyle(color: whiteColor, fontSize: 15)),
              const Spacer(),
              Text("Verbal List",
                  style: TextStyle(color: whiteColor, fontSize: 15)),
              watingList
                  ? const Center(child: CircularProgressIndicator())
                  : IconButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VerbalList(listUser: widget.listUser),
                            ));
                      },
                      icon: const Icon(
                        Icons.change_circle,
                        color: Color.fromARGB(255, 77, 230, 82),
                        size: 30,
                      ))
            ],
          ),
        ),
        if (checkGoogleMap == true)
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: whiteColor),
                  borderRadius: BorderRadius.circular(5)),
              height: 302,
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Land / Building',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: whiteColor),
                          ),
                          !checkmap
                              ? const Text(
                                  '   Please Find Price on Map',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 240, 24, 9)),
                                )
                              : const SizedBox(),
                          const Spacer(),
                          ElevatedButton(
                              onPressed: () async {
                                // await Show(requestModel);
                                setState(() {
                                  try {
                                    if (validateAndSave() &&
                                        controllerDS.text != "") {
                                      if (checkHlandbuilding == false) {
                                        hscreen = hscreen + 320;
                                      }

                                      addItemToList(area);
                                      checkHlandbuilding = true;
                                    }
                                  } catch (e) {
                                    // print("Please");
                                  }
                                });
                              },
                              child: const Text("Calculator price",
                                  style: TextStyle(fontSize: 12))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 35,
                              width: double.infinity,
                              child: ApprovebyAndVerifybySearch(
                                listback: (value) {
                                  setState(() {
                                    var list = value;
                                    if (int.parse(list['autoverbal_id']
                                                .toString()) !=
                                            100 &&
                                        list['autoverbal_id'] != 9) {
                                      minSqm =
                                          double.parse(list['min'].toString());
                                      maxSqm =
                                          double.parse(list['max'].toString());
                                    }
                                    // print("=====> type : ${list['type']}");
                                  });
                                },
                                name: (value) {
                                  setState(() {
                                    controllerDS.text = value;
                                  });
                                },
                                id: (value) {
                                  setState(() {
                                    autoverbalTypeValue = value;
                                  });
                                },
                                defaultValue: const {
                                  'type': 'LS',
                                  'autoverbal_id': '100'
                                },
                              ),
                            ),
                          ),
                          if (autoverbalTypeValue != "100")
                            const SizedBox(width: 10),
                          if (autoverbalTypeValue != "100")
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 35,
                                child: FormN(
                                  label: "Floors",
                                  iconname: const Icon(
                                      Icons.calendar_month_outlined,
                                      color: kImageColor),
                                  onSaved: (newValue) {
                                    setState(() {
                                      dep = newValue!;

                                      if (totalArea != null) {
                                        totalArea =
                                            totalArea! * double.parse(dep);
                                      }
                                      totalArea;
                                      areas = totalArea!;
                                    });
                                  },
                                ),
                              ),
                            )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 35,
                              child: FormN(
                                label: "Min",
                                iconname: const Icon(
                                    Icons.h_plus_mobiledata_outlined,
                                    color: kImageColor),
                                onSaved: (newValue) {
                                  setState(() {
                                    minSqm = double.parse(newValue!);
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 35,
                              child: FormN(
                                label: "Max",
                                iconname: const Icon(Icons.blur_linear_outlined,
                                    color: kImageColor),
                                onSaved: (newValue) {
                                  setState(() {
                                    maxSqm = double.parse(newValue!);
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 35,
                              child: FormN(
                                label: "Head",
                                iconname: const Icon(
                                    Icons.h_plus_mobiledata_outlined,
                                    color: kImageColor),
                                onSaved: (newValue) {
                                  setState(() {
                                    h = double.parse(newValue!);
                                    // if (lL != 0) {
                                    //   totalArea = h * lL;
                                    //   areas = totalArea!;
                                    // } else {
                                    //   totalArea = h;
                                    // }
                                    // controllerArea.text = areas.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 35,
                              child: FormN(
                                label: "Length",
                                iconname: const Icon(Icons.blur_linear_outlined,
                                    color: kImageColor),
                                onSaved: (newValue) {
                                  setState(() {
                                    if (newValue == "") {
                                      controllerArea.clear();
                                    }
                                    lL = double.parse(newValue!);

                                    // if (h != 0) {
                                    //   totalArea = h * lL;
                                    //   areas = totalArea!;
                                    // } else {
                                    //   totalArea = lL;
                                    // }
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                          height: 35,
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: controllerArea,
                                onChanged: (value) {
                                  setState(() {
                                    areas = double.parse(
                                        double.parse(value).toStringAsFixed(2));
                                  });
                                },
                                decoration: InputDecoration(
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  filled: true,
                                  labelText: "Area (m\u00B2)",
                                  prefixIcon: const Icon(Icons.layers,
                                      color: kImageColor),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(0, 126, 250, 1),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(0, 126, 250, 1)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 249, 0, 0),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 249, 0, 0),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  errorStyle: const TextStyle(
                                      height: 0), // Hide error text
                                ),
                                validator: (input) {
                                  if (input == null || input.isEmpty) {
                                    return ''; // Return empty string to trigger error state
                                  }
                                  return null;
                                },
                              )),
                            ],
                          )),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          readOnly: true,
                          controller: controllerDS,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: kwhite,
                            filled: true,
                            labelText: "Description",
                            labelStyle: const TextStyle(fontSize: 14),
                            prefixIcon: const Icon(
                              Icons.description,
                              color: kImageColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: kPrimaryColor, width: 2.0),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        if (listBuilding.isNotEmpty && checkHlandbuilding == true)
          Padding(
            padding:
                const EdgeInsets.only(right: 5, left: 5, bottom: 30, top: 10),
            child: Container(
              alignment: Alignment.center,
              height: (_byesData != null || get_bytes != null)
                  ? hscreen + 150
                  : hscreen,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            const SizedBox(width: 30),
                            const Icon(Icons.qr_code,
                                color: kImageColor, size: 23),
                            const SizedBox(width: 10),
                            Text(verbalAgentModel.verbalCode.toString(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor)),
                            const SizedBox(width: 10),
                            const Spacer(),
                            InkWell(
                              //PPPPPPPP
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  setState(() {
                                    verbalAgentModel.referrenceN =
                                        referrenceNController.text;
                                    verbalAgentModel.titleDeedN =
                                        titleDeedNController.text;
                                    verbalAgentModel.underPropertyRight =
                                        underPropertyRightController.text;
                                    verbalAgentModel.verbalUser =
                                        widget.listUser[0]['agency'].toString();
                                    verbalAgentModel.verbalAddress =
                                        addressController.text;
                                    verbalAgentModel.latlongLa =
                                        requestModel.lat;
                                    verbalAgentModel.latlongLog =
                                        requestModel.lng;
                                    verbalAgentModel.verbalAddress =
                                        "${provinceController.text}, ${ditrictController.text}, ${communeController.text}";
                                  });

                                  if (listBuilding.isNotEmpty) {
                                    await verbalAgent.addVerbalModel(
                                      verbalAgentModel,
                                      context,
                                      listBuilding,
                                    );
                                    if (verbalAgent.varListVerbal.isNotEmpty) {
                                      setState(() {
                                        checkHlandbuilding = false;
                                        checkGoogleMap = false;

                                        // Future.delayed(
                                        //     const Duration(seconds: 1), () {
                                        verbalAgentModel.clear();
                                        verbalAgentModel.verbalCode =
                                            "${widget.listUser[0]['agency']}${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(100)}";
                                        verbalAgentModel.verbalImage = 'No';
                                        _byesData = null;
                                        get_bytes = null;
                                        areas = 0;
                                        route = null;
                                        pty = null;

                                        provinceController.clear();
                                        ditrictController.clear();
                                        communeController.clear();
                                        controllerArea.clear();
                                        controllerDS.clear();
                                        controllerDrop.clear();
                                        priceController.clear();
                                        titleDeedNController.clear();
                                        underPropertyRightController.clear();
                                        listBuilding = [];
                                        verbalAgentModel
                                            .referrenceN = referrenceNController
                                                .text =
                                            "ARF${DateFormat('yy').format(now)} - ";
                                        // });
                                      });
                                    }
                                  } else {
                                    component.handleTap(
                                        "Please Check Land/Building", "");
                                  }
                                }
                              },
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: greyColor),
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
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, top: 20),
                          child: SizedBox(
                            height: sizeh,
                            width: double.infinity,
                            child: TextFormField(
                              controller: referrenceNController,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: blackColor,
                                  fontWeight: FontWeight.bold),
                              onSaved: (value) {
                                setState(() {
                                  referrenceNController.text = value!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        width: 1.5, color: blueColor)),
                                label: Text('Reference N',
                                    style: TextStyle(
                                        color: greyColor, fontSize: 12)),
                              ),
                            ),
                          ),
                        ),
                        if (requestModel.lat != "")
                          InkWell(
                            onTap: () async {},
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
                                    'https://maps.googleapis.com/maps/api/staticmap?center=${requestModel.lat},${requestModel.lng}&zoom=15&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${requestModel.lat},${requestModel.lng}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8',
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, top: 10),
                          child: SizedBox(
                            height: 35,
                            width: double.infinity,
                            child: TextFormField(
                              controller: titleDeedNController,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: blackColor,
                                  fontWeight: FontWeight.bold),
                              onSaved: (value) {
                                setState(() {
                                  titleDeedNController.text = value!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        width: 1.5, color: blueColor)),
                                label: Text('Title Deed N°',
                                    style: TextStyle(
                                        color: greyColor, fontSize: 12)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, top: 10),
                          child: SizedBox(
                            height: 35,
                            width: double.infinity,
                            child: TextFormField(
                              controller: underPropertyRightController,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: blackColor,
                                  fontWeight: FontWeight.bold),
                              onSaved: (value) {
                                setState(() {
                                  underPropertyRightController.text = value!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        width: 1.5, color: blueColor)),
                                label: Text('Under Property Right',
                                    style: TextStyle(
                                        color: greyColor, fontSize: 12)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, top: 10),
                          child: SizedBox(
                            height: sizeh,
                            width: double.infinity,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 12,
                                  color: blackColor,
                                  fontWeight: FontWeight.bold),
                              controller: provinceController,
                              onSaved: (value) {
                                setState(() {
                                  provinceController.text = value!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        width: 1.5, color: blueColor)),
                                label: Text('Province',
                                    style: TextStyle(
                                        color: greyColor, fontSize: 12)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, top: 10),
                          child: SizedBox(
                            height: sizeh,
                            width: double.infinity,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 12,
                                  color: blackColor,
                                  fontWeight: FontWeight.bold),
                              controller: ditrictController,
                              onSaved: (value) {
                                setState(() {
                                  distanceController.text = value!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        width: 1.5, color: blueColor)),
                                label: Text('District',
                                    style: TextStyle(
                                        color: greyColor, fontSize: 12)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, top: 10),
                          child: SizedBox(
                            height: sizeh,
                            width: double.infinity,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 12,
                                  color: blackColor,
                                  fontWeight: FontWeight.bold),
                              controller: communeController,
                              onSaved: (value) {
                                setState(() {
                                  communeController.text = value!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        width: 1.5, color: blueColor)),
                                label: Text('Commune',
                                    style: TextStyle(
                                        color: greyColor, fontSize: 12)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        DateComponents(
                          title: "Issued Date",
                          value: (value) {
                            setState(() {
                              verbalAgentModel.issuedDate = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        if (listBuilding.isNotEmpty)
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 280,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Center(
                                child: Column(
                                  children: [
                                    for (int i = 0;
                                        i < listBuilding.length;
                                        i++)
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 10),
                                        child: Container(
                                          width: 270,
                                          //height: 210,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: kPrimaryColor),
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
                                                          '${listBuilding[i]['verbal_landid']}',
                                                          style: NameProperty(),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                              size: 30,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                listBuilding
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Depreciation",
                                                        style: Label(),
                                                      ),
                                                      const SizedBox(height: 3),
                                                      if (listBuilding[i][
                                                              'verbal_land_des'] !=
                                                          "LS")
                                                        Text(
                                                          "Floor",
                                                          style: Label(),
                                                        ),
                                                      const SizedBox(height: 3),
                                                      Text(
                                                        "Area",
                                                        style: Label(),
                                                      ),
                                                      const SizedBox(height: 3),
                                                      Text(
                                                        'Min Value/Sqm',
                                                        style: Label(),
                                                      ),
                                                      const SizedBox(height: 3),
                                                      Text(
                                                        'Max Value/Sqm',
                                                        style: Label(),
                                                      ),
                                                      const SizedBox(height: 3),
                                                      Text(
                                                        'Min Value',
                                                        style: Label(),
                                                      ),
                                                      const SizedBox(height: 3),
                                                      Text(
                                                        'Max Value',
                                                        style: Label(),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 15),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        ' : ${listBuilding[i]['verbal_land_des'] ?? ""}',
                                                        style: Name(),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      if (listBuilding[i][
                                                              'verbal_land_des'] !=
                                                          "LS")
                                                        Text(
                                                          ' : ${listBuilding[i]['verbal_land_dp'] ?? ""}',
                                                          style: Name(),
                                                        ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        ' : ${listBuilding[i]['verbal_land_area'] ?? ""} m\u00B2',
                                                        style: Name(),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        // ' : ${formatNumber(double.parse("${widget.listLandBuilding[i]['verbal_land_minsqm'] ?? 0}"))}\$',
                                                        ' : ${listBuilding[i]['verbal_land_minsqm'] ?? ""} \$',
                                                        style: Name(),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        ' : ${listBuilding[i]['verbal_land_maxsqm'] ?? ""} \$',
                                                        // ' : ${formatNumber(double.parse("${widget.listLandBuilding[i]['verbal_land_maxsqm'] ?? 0}"))}\$',
                                                        style: Name(),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        ' : ${listBuilding[i]['verbal_land_minvalue'] ?? ""} \$',
                                                        // ' : ${formatNumber(double.parse("${widget.listLandBuilding[i]['verbal_land_minvalue'] ?? 0}"))}\$',
                                                        style: Name(),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        ' : ${listBuilding[i]['verbal_land_maxvalue'] ?? ""} \$',
                                                        // ' : ${formatNumber(double.parse("${widget.listLandBuilding[i]['verbal_land_maxvalue'] ?? 0}"))}\$',
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
                              if (_byesData != null && cropORopen == false)
                                SizedBox(
                                  height: 150,
                                  child: Image.memory(
                                    _byesData!,
                                  ),
                                )
                              else if (get_bytes != null && cropORopen == true)
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
                        Padding(
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          child: Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  openImgae();
                                },
                                child: Container(
                                  height: sizeh,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: kPrimaryColor,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
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
                              )),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  // width: double.infinity,

                                  child: PropertySearch(
                                    h: sizeh,
                                    // pro: "Land",
                                    name: (value) {
                                      // propertyType = value;
                                    },
                                    checkOnclick: (value) {
                                      setState(() {});
                                    },
                                    id: (value) {
                                      setState(() {
                                        verbalAgentModel.verbalPropertyId =
                                            value.toString();
                                      });
                                    },
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: PropertyDropdown(
                              //     name: (value) {
                              //       // propertyType = value;
                              //     },
                              //     id: (value) {
                              //       setState(() {
                              //         dataModel.propertyTypeId =
                              //             int.parse(value.toString());
                              //       });
                              //     },
                              //     // pro: list[0]['property_type_name'],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        FormTwinN(
                          h: 40,
                          Label1: 'Owner',
                          Label2: 'Contact',
                          onSaved1: (input) {
                            setState(() {
                              verbalAgentModel.verbalOwner = input!;
                            });
                          },
                          onSaved2: (input) {
                            setState(() {
                              verbalAgentModel.verbalContact = input!;
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
                        const SizedBox(height: 50),
                      ],
                    ),
                  )),
            ),
          ),
      ],
    );
  }

  int count = 0;
  bool checkMap = false;
  double hscreen = 890;
  bool checkVC = false;
  int buildingID = 0;
  void addItemToList(area) {
    setState(() {
      buildingID = Random().nextInt(1000) + 1;
      totalMin = minSqm! * areas;
      totalMax = maxSqm! * areas;
    });
    listBuilding.add({
      "id": buildingID,
      "verbal_land_type": autoverbalTypeValue,
      "verbal_land_des": controllerDS.text,
      "verbal_land_dp": dep,
      "verbal_land_area": areas,
      "verbal_land_minsqm": minSqm!.toStringAsFixed(0),
      "verbal_land_maxsqm": maxSqm!.toStringAsFixed(0),
      "verbal_land_minvalue": totalMin!.toStringAsFixed(0),
      "verbal_land_maxvalue": totalMax!.toStringAsFixed(0),
      "address": verbalAgentModel.verbalAddress,
      "verbal_landid": verbalAgentModel.verbalCode
    });
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
      // int fileSizeInBytes = file.size;
      // print('File size: $fileSizeInBytes bytes');
      reader.onLoadEnd.listen((event) {
        setState(() {
          _byesData = const Base64Decoder()
              .convert(reader.result.toString().split(',').last);
          _selectedFile = _byesData;
          imageUrl = html.Url.createObjectUrlFromBlob(file.slice());
          comporessList(_byesData!);
          cropORopen = false;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  List verbal = [];
  bool doneORudone = false;
  String area = '';
  double areas = 0;
  int i = 0;
  double? askingPrice;
  int idkhan = 0;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool checkRaods = false;
  String? updateraod;
  String updateproperty = '';
  String updatepropertyName = '';
  String updateraodName = '';
  bool roadType = false;
  bool haveValue = false;
  bool checkRaodDrop = false;
  List data_adding_correct = [];
  double? min, max;
  Map? map;
  bool checkVerbal = false;
  bool checkPrice = false;

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

  void nodata(title) {
    setState(() {
      markers.clear();
      AwesomeDialog(
        width: 400,
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        title: title,
        desc: "You can try to again to find your property on GoogleMap!",
        btnOkOnPress: () {
          setState(() {
            typedrawer = false;
            isApiCallProcess = false;
          });
          // setState(() {
          //   typedrawer = false;
          //   typedrawerSe = false;
          //   if (comparedropdown != '') {
          //     comparedropdown2 = "P";
          //   }
          //   isApiCallProcess = false;
          // });
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.blue,
      ).show();
    });
  }

  double fontsizes = 15;
  bool checkblock = false;
  double fontsizeD = 14;
  Widget textEdit() {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 100,
      child: TextFormField(
        controller: priceController,
        decoration: InputDecoration(
          fillColor: kwhite,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          labelStyle: const TextStyle(color: kPrimaryColor),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: kPrimaryColor),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  double heightModel = 50;
  double fontsize = 14;
  bool checkMaps = false;
  var colorbackground = const Color.fromARGB(255, 242, 242, 244);
  String? commune, district, province;
  var route;
  dynamic R_avg, C_avg;
  final completer = Completer<Uint8List>();
  html.File? cropimageFile;
  String? _croppedBlobUrl;
  bool cropORopen = false;
  Future<void> findByPiont(double la, double lo) async {
    var headers = {
      'Authorization':
          'hEXieWCKYKHKD1wVdiTHDjgwkbY9NwITq_F(bQ8tenn(yIUHbOVaQcRukkLZKnh(j]7Cg[1uhoD%-K5)hSP"2W74Qy7/Elf',
      'Content-Type': 'application/json'
    };
    var data = json.encode({"lat": la, "lng": lo});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/findlatlog/Map',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      var jsonResponse = response.data;

      List ls = jsonResponse['results'] ?? [];

      List ac;
      bool checkSk = false, checkKn = false;
      for (int j = 0; j < ls.length; j++) {
        ac = jsonResponse['results'][j]['address_components'];
        for (int i = 0; i < ac.length; i++) {
          if (checkKn == false || checkSk == false) {
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "political") {
              setState(() {
                checkKn = true;
                ditrictController.text = district = (jsonResponse['results'][j]
                        ['address_components'][i]['short_name'] ??
                    "");
                // print("district : $district");
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                checkSk = true;
                communeController.text = commune = (jsonResponse['results'][j]
                        ['address_components'][i]['short_name'] ??
                    "");
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_1") {
              provinceController.text = province = (jsonResponse['results'][j]
                      ['address_components'][i]['short_name'] ??
                  "");
            }
          }
        }
      }
      verbalAgentModel.verbalAddress =
          "${(province == null) ? "" : province}, ${(district == null) ? "" : district}, ${(commune == null) ? "" : commune}";
    }
  }

  Uint8List? get_bytes;
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

  Future<Uint8List> comporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );
    setState(() {
      verbalAgentModel.verbalImage = base64.encode(result);
    });

    return result;
  }

  TextStyle Label() {
    return const TextStyle(color: kPrimaryColor, fontSize: 12);
  }

  TextStyle Name() {
    return const TextStyle(
        color: kImageColor, fontSize: 13, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return const TextStyle(
        color: kImageColor, fontSize: 13, fontWeight: FontWeight.bold);
  }
}
