// ignore_for_file: sort_child_properties_last, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:web_admin/components/waiting.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';

import '../../../../components/colors.dart';
import '../../../../components/input_controller.dart';
import '../../../../getx/market_Price/markert_price.dart';
import '../../../../models/search_model.dart';

class InputRoad extends StatefulWidget {
  const InputRoad({
    super.key,
    required this.listUsers,
  });
  final List listUsers;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<InputRoad> {
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  List<Marker> markers = [];
  double latitude = 11.5489; //latitude
  double longitude = 104.9214;
  LatLng latLng = const LatLng(11.5489, 104.9214);
  String address = "";

  List list = [];

  String sendAddrress = '';
  List data = [];
  int page = 1;
  // ignore: prefer_typing_uninitialized_variables
  var pty;
  var formatter = NumberFormat("##,###,###,###", "en_US");
  var date = DateFormat('yyyy-MM-dd').format(DateTime(2020, 01, 01));
  var date1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool isApiCallProcess = false;
  late SearchRequestModel requestModel;
  late NumberPaginatorController _inputController;
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

  Future<void> googleMap(LatLng latLng) async {
    await findByPiont(latLng.latitude, latLng.longitude);
  }

  Future<void> findByPiont(double lat, double lng) async {
    try {
      var headers = {
        'Authorization':
            'hEXieWCKYKHKD1wVdiTHDjgwkbY9NwITq_F(bQ8tenn(yIUHbOVaQcRukkLZKnh(j]7Cg[1uhoD%-K5)hSP"2W74Qy7/Elf',
        'Content-Type': 'application/json'
      };
      var dio = Dio();
      var data = json.encode({"lat": lat, "lng": lng});
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
        List results = jsonResponse['results'] ?? [];

        for (var result in results) {
          List addressComponents = result['address_components'] ?? [];
          for (var component in addressComponents) {
            List types = component['types'] ?? [];
            if (types.contains('administrative_area_level_1')) {
              setState(() {
                province = component['short_name'] ?? '';
              });
            }
            if (types.contains('administrative_area_level_2')) {
              setState(() {
                district = component['short_name'] ?? '';
              });
            }
            if (
                // types.contains('locality') ||
                types.contains('administrative_area_level_3')) {
              setState(() {
                commune = component['short_name'] ?? '';
              });
            }
            if (types.contains('route')) {
              setState(() {
                longName = component['long_name'] ?? '';
                shortName = component['short_name'] ?? '';
              });
            }
          }
        }
        // print("province: $province");
        // print("Khan: $district");
        // print("SangKat: $commune");
        // print("longName: $longName");
        // print("shortName: $shortName");
        // Example: Call another function with the results
        await markertPrice.markertList(
            district ?? '', commune ?? '', shortName);
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> delete(id, int index) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/raod_ProvinceIDdelete/$id',
      options: Options(
        method: 'DELETE',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listProvince.removeAt(index);
      });
    }
  }

  Future<void> addMarkers(LatLng latLng) async {
    Marker marker = Marker(
      // draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
    );

    setState(() {
      listMarkerIds.clear();
      // data_adding_correct.clear();
      listMarkerIds.add(marker);
      getAddress(latLng);
      googleMap(latLng);
    });
  }

  final Set<Marker> listMarkerIds = {};

  String provinecheck = "";
  String provinecheckID = "";
  Set<Polygon> polygons = {};
  Future<void> provinceCheck() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/raodProvince',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        var jsonresponse = jsonDecode(json.encode(response.data));
        provinecheck = jsonresponse[0]['province_name'].toString();
        provinecheckID = jsonresponse[0]['province_ID'].toString();
      });
    } else {
      print(response.statusMessage);
    }
  }

  List listProvince = [];
  Future<void> getvalueAdd() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/raod_ProvinceID',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listProvince = jsonDecode(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  @override
  void initState() {
    provinceCheck();
    _handleLocationPermission();

    dropdown();
    getvalueAdd();
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
    _inputController = NumberPaginatorController();
    super.initState();
  }

  double h = 0;
  List listMap = [];
  Future<void> mainSearch() async {
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
    }
  }

  Timer? _debounce;
  void onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      mainSearch();
    });
  }

  MarkertPrice markertPrice = MarkertPrice();
  double fontSize = 14;
  TextEditingController searchMap = TextEditingController();
  //////
  bool checkBool = false;
  int id = 0;
  @override
  Widget build(BuildContext context) {
    markertPrice = Get.put(MarkertPrice());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 115, 124, 154),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      if (!checkBool)
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: 500,
                          color: appback,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 30),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: whiteColor,
                                          )),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          markertPrice.listPiganation(10, 1);
                                          setState(() {
                                            checkBool = !checkBool;
                                          });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: whiteColor,
                                          child: const Icon(
                                            Icons.refresh,
                                            size: 30,
                                            color:
                                                Color.fromARGB(255, 3, 133, 7),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      ElevatedButton(
                                          child: const Text('Add Main Road',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13)),
                                          onPressed: () {
                                            AwesomeDialog(
                                                    width: 400,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    context: context,
                                                    title:
                                                        "Do you want to Add Road?",
                                                    titleTextStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: greyColor),
                                                    animType:
                                                        AnimType.leftSlide,
                                                    headerAnimationLoop: false,
                                                    dialogType:
                                                        DialogType.question,
                                                    showCloseIcon: false,
                                                    btnOkOnPress: () async {
                                                      await addraod(shortName);
                                                    },
                                                    btnCancelOnPress: () {},
                                                    onDismissCallback:
                                                        (type) {})
                                                .show();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 150,
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 2, color: Colors.black)),
                                    child: Row(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '- Long Name',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: fontSize,
                                                      color: greyColorNolots),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '- Short Name',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: fontSize,
                                                      color: greyColorNolots),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '- Province',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: fontSize,
                                                      color: greyColorNolots),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '- District',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: fontSize,
                                                      color: greyColorNolots),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '- Commune',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: fontSize,
                                                      color: greyColorNolots),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '\t\t\t:\t\t\t$longName',
                                                  style: TextStyle(
                                                    fontSize: fontSize,
                                                    color: blackColor,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '\t\t\t:\t\t\t$shortName',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: fontSize,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '\t\t\t:\t\t\t${province ?? ""}',
                                                  style: TextStyle(
                                                    fontSize: fontSize,
                                                    color: blackColor,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '\t\t\t:\t\t\t${district ?? ""}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: fontSize,
                                                    color: blackColor,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '\t\t\t:\t\t\t${commune ?? ""}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: fontSize,
                                                    color: blackColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 40,
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
                                  const SizedBox(height: 15),
                                  Divider(
                                    height: 1,
                                    color: whiteColor,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Market Price',
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    height: 520,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: whiteColor),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Obx(
                                        () {
                                          if (markertPrice.isMarkert.value) {
                                            return const WaitingFunction();
                                          } else
                                          // if (markertPrice
                                          //     .listMarkertR.isEmpty)
                                          {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    const Spacer(),
                                                    InkWell(
                                                      onTap: () {
                                                        // print("Road : $shortName");
                                                        AwesomeDialog(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          width: 400,
                                                          context: context,
                                                          dialogType: DialogType
                                                              .success,
                                                          animType: AnimType
                                                              .rightSlide,
                                                          headerAnimationLoop:
                                                              false,
                                                          title: 'Done',
                                                          desc:
                                                              "Do you want to Save",
                                                          btnOkOnPress:
                                                              () async {
                                                            markertPrice
                                                                .markertPrice(
                                                              district!,
                                                              commune!,
                                                              province!,
                                                              markertPrice
                                                                  .minValueR
                                                                  .value,
                                                              markertPrice
                                                                  .maxValueR
                                                                  .value,
                                                              markertPrice
                                                                  .minValueC
                                                                  .value,
                                                              markertPrice
                                                                  .maxValueC
                                                                  .value,
                                                              /////// Markert Price Old
                                                              markertPrice
                                                                  .minOldValueR
                                                                  .value,
                                                              markertPrice
                                                                  .maxOldValueR
                                                                  .value,
                                                              markertPrice
                                                                  .minOldValueC
                                                                  .value,
                                                              markertPrice
                                                                  .maxOldValueC
                                                                  .value,
                                                              shortName,
                                                              markertPrice
                                                                  .roadName
                                                                  .value,
                                                              latLng.latitude
                                                                  .toString(),
                                                              latLng.longitude
                                                                  .toString(),
                                                              widget
                                                                  .listUsers[0]
                                                                      ['agency']
                                                                  .toString(),
                                                              markertPrice
                                                                  .khanID.value,
                                                              markertPrice
                                                                  .sangkatID
                                                                  .value,
                                                            );
                                                          },
                                                          btnCancelOnPress:
                                                              () {},
                                                        ).show();
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 1,
                                                                color:
                                                                    greyColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: whiteColor),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text('Save  ',
                                                                style: TextStyle(
                                                                    color:
                                                                        greyColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Icon(Icons.save_alt,
                                                                color:
                                                                    greyColor)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  'Residential Markert Price',
                                                  style: TextStyle(
                                                    color: whiteColor,
                                                    fontSize: fontSize,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                SizedBox(
                                                  width: 500,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: InputController(
                                                            title: "Min Value",
                                                            controllerback:
                                                                (value) {
                                                              setState(() {
                                                                markertPrice
                                                                        .minValueR
                                                                        .value =
                                                                    value;
                                                              });
                                                            },
                                                            value: markertPrice
                                                                .minValueR
                                                                .value),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        flex: 1,
                                                        child: InputController(
                                                            title: "Max Value",
                                                            controllerback:
                                                                (value) {
                                                              setState(() {
                                                                markertPrice
                                                                        .maxValueR
                                                                        .value =
                                                                    value;
                                                              });
                                                            },
                                                            value: markertPrice
                                                                .maxValueR
                                                                .value),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Text(
                                                  'Commercial Markert Price',
                                                  style: TextStyle(
                                                    color: whiteColor,
                                                    fontSize: fontSize,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                SizedBox(
                                                  width: 500,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: InputController(
                                                            title: "Min Value",
                                                            controllerback:
                                                                (value) {
                                                              setState(() {
                                                                markertPrice
                                                                        .minValueC
                                                                        .value =
                                                                    value;
                                                              });
                                                            },
                                                            value: markertPrice
                                                                .minValueC
                                                                .value),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        flex: 1,
                                                        child: InputController(
                                                            title: "Max Value",
                                                            controllerback:
                                                                (value) {
                                                              setState(() {
                                                                markertPrice
                                                                        .maxValueC
                                                                        .value =
                                                                    value;
                                                              });
                                                            },
                                                            value: markertPrice
                                                                .maxValueC
                                                                .value),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                Container(
                                                  height: 180,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: whiteColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: whiteColor,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '- Residential Markert Price',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: blackColor,
                                                              fontSize:
                                                                  fontSize,
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          // if (markertPrice
                                                          //         .listMarkertC
                                                          //         .isNotEmpty &&
                                                          //     markertPrice
                                                          //         .listMarkertR
                                                          //         .isNotEmpty)
                                                          //   IconButton(
                                                          //       onPressed: () {
                                                          //         AwesomeDialog(
                                                          //           alignment:
                                                          //               Alignment
                                                          //                   .centerLeft,
                                                          //           width: 400,
                                                          //           context:
                                                          //               context,
                                                          //           dialogType:
                                                          //               DialogType
                                                          //                   .question,
                                                          //           animType:
                                                          //               AnimType
                                                          //                   .rightSlide,
                                                          //           headerAnimationLoop:
                                                          //               false,
                                                          //           title:
                                                          //               'Done',
                                                          //           desc:
                                                          //               "Do you want to deleted!",
                                                          //           btnOkOnPress:
                                                          //               () async {
                                                          //             markertPrice.deleteMarkert(
                                                          //                 markertPrice
                                                          //                     .sangkatID
                                                          //                     .value,
                                                          //                 markertPrice
                                                          //                     .khanID
                                                          //                     .value);
                                                          //           },
                                                          //           btnCancelOnPress:
                                                          //               () {},
                                                          //         ).show();
                                                          //       },
                                                          //       icon:
                                                          //           const Icon(
                                                          //         Icons.delete,
                                                          //         color: Colors
                                                          //             .red,
                                                          //       ))
                                                        ],
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border:
                                                                    Border.all(
                                                                  width: 1,
                                                                  color:
                                                                      greyColorNolot,
                                                                )),
                                                        child: Row(
                                                          children: [
                                                            textWhile(
                                                              "Min Value :",
                                                              markertPrice
                                                                  .minOldValueR
                                                                  .value
                                                                  .toString(),
                                                            ),
                                                            textWhile(
                                                              "Max Value :",
                                                              markertPrice
                                                                  .maxOldValueR
                                                                  .value
                                                                  .toString(),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        '- Commercial Markert Price',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: blackColor,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border:
                                                                    Border.all(
                                                                  width: 1,
                                                                  color:
                                                                      greyColorNolot,
                                                                )),
                                                        child: Row(
                                                          children: [
                                                            textWhile(
                                                              "Min Value :",
                                                              markertPrice
                                                                  .minOldValueC
                                                                  .value
                                                                  .toString(),
                                                            ),
                                                            textWhile(
                                                              "Max Value :",
                                                              markertPrice
                                                                  .maxOldValueC
                                                                  .value
                                                                  .toString(),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: 40,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: whiteColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: whiteColor,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Main Road From Map : ",
                                                          style: TextStyle(
                                                              color: greyColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  fontSize),
                                                        ),
                                                        Text(
                                                          shortName,
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize:
                                                                  fontSize),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: 40,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: whiteColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: whiteColor,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Main Road: ",
                                                          style: TextStyle(
                                                              color: greyColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  fontSize),
                                                        ),
                                                        Text(
                                                          markertPrice
                                                              .roadName.value,
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize:
                                                                  fontSize),
                                                        ),
                                                        const Spacer(),
                                                        if (shortName !=
                                                                'Unnamed Road' &&
                                                            shortName != '')
                                                          IconButton(
                                                              onPressed: () {
                                                                AwesomeDialog(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  width: 400,
                                                                  context:
                                                                      context,
                                                                  dialogType:
                                                                      DialogType
                                                                          .question,
                                                                  animType: AnimType
                                                                      .rightSlide,
                                                                  headerAnimationLoop:
                                                                      false,
                                                                  title: 'Done',
                                                                  desc:
                                                                      "Do you want to Deleted!?",
                                                                  btnOkOnPress:
                                                                      () async {
                                                                    markertPrice
                                                                        .deletetedMainRoad(
                                                                      shortName,
                                                                      /////// Markert Price Old
                                                                      markertPrice
                                                                          .minOldValueR
                                                                          .value,
                                                                      markertPrice
                                                                          .maxOldValueR
                                                                          .value,
                                                                      markertPrice
                                                                          .minOldValueC
                                                                          .value,
                                                                      markertPrice
                                                                          .maxOldValueC
                                                                          .value,
                                                                      /////// Markert Price New
                                                                      markertPrice
                                                                          .minValueR
                                                                          .value,
                                                                      markertPrice
                                                                          .maxValueR
                                                                          .value,
                                                                      markertPrice
                                                                          .minValueC
                                                                          .value,
                                                                      markertPrice
                                                                          .maxValueC
                                                                          .value,
                                                                      ////////
                                                                      shortName,
                                                                      markertPrice
                                                                          .roadName
                                                                          .value,
                                                                      latLng
                                                                          .latitude
                                                                          .toString(),
                                                                      latLng
                                                                          .longitude
                                                                          .toString(),
                                                                      widget
                                                                          .listUsers[
                                                                              0]
                                                                              [
                                                                              'agency']
                                                                          .toString(),
                                                                    );
                                                                  },
                                                                  btnCancelOnPress:
                                                                      () {},
                                                                ).show();
                                                              },
                                                              icon: const Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              ))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: 500,
                          color: appback,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, left: 30),
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: whiteColor,
                                          )),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            checkBool = !checkBool;
                                          });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: whiteColor,
                                          child: const Icon(
                                            Icons.refresh,
                                            size: 30,
                                            color:
                                                Color.fromARGB(255, 3, 133, 7),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Obx(
                                    () {
                                      if (markertPrice.isData.value) {
                                        return const WaitingFunction();
                                      } else if (markertPrice
                                          .listData.isEmpty) {
                                        return const SizedBox();
                                      } else {
                                        return Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 1, color: whiteColor)),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.85,
                                          width: double.infinity,
                                          child: ListView.builder(
                                            itemCount:
                                                markertPrice.listData.length,
                                            itemBuilder: (context, index) =>
                                                Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: blackColor)),
                                                width: double.infinity,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          textblack(
                                                            "No.${index + 1}",
                                                          ),
                                                          const Spacer(),
                                                          textblack(
                                                            "Name : ${markertPrice.listData[index]['username'] ?? ""},",
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          textblack(
                                                            "Date : ${markertPrice.listData[index]['create_date'] ?? ""}",
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      textblackB(
                                                        "- New Residential",
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          textDet(
                                                              "Min Value : ",
                                                              "${markertPrice.listData[index]['min_valueR'] ?? ""}\$"),
                                                          const SizedBox(
                                                              width: 10),
                                                          textDet(
                                                              "Max Value : ",
                                                              "${markertPrice.listData[index]['max_valueR'] ?? ""}\$"),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      textblackB(
                                                        "- New Commercial",
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          textDet(
                                                              "Min Value : ",
                                                              "${markertPrice.listData[index]['min_valueC'] ?? ""}\$"),
                                                          const SizedBox(
                                                              width: 10),
                                                          textDet(
                                                              "Max Value : ",
                                                              "${markertPrice.listData[index]['max_valueC'] ?? ""}\$"),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      textblackB(
                                                        "- Old Residential",
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          textDet(
                                                              "Min Value : ",
                                                              "${markertPrice.listData[index]['min_old_valueR'] ?? ""}\$"),
                                                          const SizedBox(
                                                              width: 10),
                                                          textDet(
                                                              "Max Value : ",
                                                              "${markertPrice.listData[index]['max_old_valueR'] ?? ""}\$"),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      textblackB(
                                                        "- Old Commercial",
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          textDet(
                                                              "Min Value : ",
                                                              "${markertPrice.listData[index]['min_old_valueC'] ?? ""}\$"),
                                                          const SizedBox(
                                                              width: 10),
                                                          textDet(
                                                              "Max Value : ",
                                                              "${markertPrice.listData[index]['max_old_valueC'] ?? ""}\$"),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Divider(
                                                        thickness: 2,
                                                        color: greyColor,
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          textDet("Road New : ",
                                                              "${markertPrice.listData[index]['main_road'] ?? ""}\$"),
                                                          const SizedBox(
                                                              width: 10),
                                                          textDet("Old Road : ",
                                                              "${markertPrice.listData[index]['main_road_old'] ?? ""}\$"),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  Obx(
                                    () {
                                      if (markertPrice.listData.isEmpty) {
                                        return const SizedBox();
                                      } else {
                                        return SizedBox(
                                          height: 45,
                                          child: NumberPaginator(
                                            controller: _inputController,
                                            numberPages:
                                                markertPrice.lastPage.value,
                                            onPageChange: (int index) async {
                                              setState(() {
                                                page = index + 1;
                                              });
                                              markertPrice.listPiganation(
                                                  10, page);
                                            },
                                            initialPage: 0,
                                            config: NumberPaginatorUIConfig(
                                              buttonShape:
                                                  BeveledRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                              ),
                                              buttonUnselectedForegroundColor:
                                                  blackColor,
                                              buttonUnselectedBackgroundColor:
                                                  whiteNotFullColor,
                                              buttonSelectedForegroundColor:
                                                  whiteColor,
                                              buttonSelectedBackgroundColor:
                                                  blueColor,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        top: 270,
                        child: (listMap.isEmpty)
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 30, top: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 350,
                                  width: 450,
                                  child: ListView.builder(
                                    itemCount: listMap.length,
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        setState(() {
                                          var location = listMap[index]
                                              ['geometry']['location'];
                                          LatLng lat = LatLng(
                                              double.parse(
                                                  location['lat'].toString()),
                                              double.parse(
                                                  location['lng'].toString()));
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
                                              listMap[index]['name'].toString(),
                                              overflow: TextOverflow.ellipsis,
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
                  ),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: GoogleMap(
                        markers: listMarkerIds.map((e) => e).toSet(),
                        polygons: Set<Polygon>.of(polygons),
                        zoomGesturesEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: latLng,
                          zoom: 12.0,
                        ),

                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        mapType: MapType.hybrid, //map type
                        onMapCreated: (controller) {
                          //method called when map is created
                          setState(() {
                            mapController = controller;
                          });
                        },
                        onTap: (argument) async {
                          setState(() {
                            province = "N/A";
                            district = "N/A";
                            commune = "N/A";
                            road = "N/A";
                            requestModel.lat = argument.latitude.toString();
                            requestModel.lng = argument.longitude.toString();
                          });
                          addMarkers(argument);
                        },
                        // onLongPress: (argument) {
                        //   Marker marker = Marker(
                        //     markerId: const MarkerId('mark'),
                        //     position: argument,
                        //     icon: BitmapDescriptor.defaultMarkerWithHue(
                        //         BitmapDescriptor.hueRed),
                        //   );
                        //   setState(() {
                        //     shortName = "";
                        //     markerMap.clear();
                        //     data_adding_correct.clear();
                        //     markerMap.add(marker);
                        //     requestModel.lat = argument.latitude.toString();
                        //     requestModel.lng = argument.longitude.toString();
                        //     getAddress(argument);
                        //     Show(requestModel);
                        //   });
                        // },
                        onCameraMove: (CameraPosition cameraPositiona) {
                          cameraPosition =
                              cameraPositiona; //when map is dragging
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int selectindex = -1;
  void addRaodLocal(raod) {
    setState(() {
      selectindex = listProvince.length;
      id = listProvince[0]['id'] + 1;
    });

    listProvince.add({
      "id": "$id",
      "name_road": raod,
      "noted": "1",
      "provine_Id": provinecheckID,
      "province_name": province,
      "create_date": date1,
    });
  }

  String? district, commune, province, road;
  Future<void> addraod(raod) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "name_road": raod,
      "province_name": province,
      "provine_Id": provinecheckID,
      "noted": 1,
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/add/raod',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      var message = response.data;
      // print(message.toString());
      if (shortName == 'Unnamed Road' || longName == 'Unnamed Road') {
        AwesomeDialog(
            context: context,
            animType: AnimType.leftSlide,
            headerAnimationLoop: false,
            dialogType: DialogType.error,
            showCloseIcon: false,
            autoHide: const Duration(seconds: 10),
            body: const Center(
              child: Text("Unnamed Road"),
            ),
            btnOkOnPress: () {},
            onDismissCallback: (type) {});
      } else {
        if (message['message'] == 'This road already exists') {
          AwesomeDialog(
                  width: 300,
                  alignment: Alignment.centerLeft,
                  context: context,
                  animType: AnimType.leftSlide,
                  headerAnimationLoop: false,
                  dialogType: DialogType.question,
                  showCloseIcon: false,
                  autoHide: const Duration(seconds: 10),
                  body: const Center(
                    child: Text("This road already exists"),
                  ),
                  btnOkOnPress: () {},
                  onDismissCallback: (type) {})
              .show();
        } else {
          AwesomeDialog(
                  width: 300,
                  alignment: Alignment.centerLeft,
                  context: context,
                  animType: AnimType.leftSlide,
                  headerAnimationLoop: false,
                  dialogType: DialogType.success,
                  showCloseIcon: false,
                  autoHide: const Duration(seconds: 10),
                  body: const Center(
                    child: Text("Road inserted successfully"),
                  ),
                  btnOkOnPress: () {},
                  onDismissCallback: (type) {})
              .show();
          addRaodLocal(raod);
        }
        // provinceCheck();
      }
    }
  }

  String comparedropdown = '';
  int groupValue = 0;
  bool isChecked = false;

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          const SizedBox(
            height: 12.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 18.0,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                "More Option",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),

          addPaddingWhenKeyboardAppears(),
        ],
      ),
    );
  }

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

  bool showAll = false;
  bool ontap = true;

  List listdropdown = [];
  Future<void> dropdown() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/compare/dropdown',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listdropdown = jsonDecode(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  // List data_adding_correct = [];
  double? min, max;
  Map? map;
  Widget textblack(String title) {
    return Text(
      title,
      style: TextStyle(color: greyColor, fontSize: fontSize),
    );
  }

  Widget textblackB(String title) {
    return Text(
      title,
      style: TextStyle(
          color: blackColor, fontSize: fontSize, fontWeight: FontWeight.bold),
    );
  }

  Widget textDet(String title, String value) {
    return Row(
      children: [
        Text(
          "$title ",
          style: TextStyle(color: Colors.red, fontSize: fontSize),
        ),
        Text(
          value,
          style: TextStyle(color: greyColor, fontSize: fontSize),
        ),
      ],
    );
  }

  Widget textWhile(String title, String value) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Text(
            "$title ",
            style: TextStyle(color: Colors.red, fontSize: fontSize),
          ),
          Text(
            value,
            style: TextStyle(color: greyColor, fontSize: fontSize),
          ),
        ],
      ),
    );
  }

  Future<void> findlocation(LatLng latlog) async {
    setState(() {
      // searchBool = true;
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
        searchMap.clear();
        listMap = [];
      });
    });
  }

  Future<void> getAddress(LatLng latLng) async {
    final coordinates = Coordinates(latLng.latitude, latLng.longitude);
    try {} catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOMETING WENT WRONG\nDID YOU ADD API KEY '),
        ),
      );
      rethrow;
    }
  }

  String longName = '';
  String shortName = '';
}
