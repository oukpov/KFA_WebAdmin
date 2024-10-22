import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/page/navigate_home/Comparable/newComparable/clone_newcomparable.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';

import '../../../../Customs/ProgressHUD.dart';
import '../../../../getx/add_zone/add_zone.dart';

class ZoneMap extends StatefulWidget {
  const ZoneMap({super.key});

  @override
  State<ZoneMap> createState() => _ZoneMapState();
}

class _ZoneMapState extends State<ZoneMap> {
  final Set<Marker> listMarkerIds = {};
  List<Marker> markers = [];
  Set<Polygon> polygons = {};
  Future<void> waitAddMarker(LatLng latlong) async {
    setState(() {
      markerwait = true;
    });
    await Future.wait([addManyMarkers(latlong)]);
    setState(() {
      markerwait = false;
    });
  }

  Future<void> addManyMarkers(LatLng latLng) async {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(40, 40)),
            'assets/images/pin.png')
        .then((d) {});

    final int markerCount = markers.length;
    final MarkerId markerId = MarkerId(markerCount.toString());
    Marker marker = Marker(
      markerId: markerId,
      position: latLng,
      icon: BitmapDescriptor.defaultMarker,
      onDragEnd: (value) {
        latLng = value;
      },
    );

    setState(() {
      markers.add(marker);
      listMarkerIds.add(marker);
      listLatlong.add({
        "lat": latLng.latitude,
        "log": latLng.longitude,
        "market": marketvalue,
        "name_road": route
      });
      _createPolygon();
      LatLng centroid = _calculatePolygonCentroid(
          markers.map((marker) => marker.position).toList());
      print("listLatlong : $listLatlong");
    });
  }

  bool markerwait = false;
  LatLng _calculatePolygonCentroid(List<LatLng> points) {
    double centroidLat = 0.0;
    double centroidLng = 0.0;

    for (LatLng point in points) {
      centroidLat += point.latitude;
      centroidLng += point.longitude;
    }

    centroidLat /= points.length;
    centroidLng /= points.length;

    return LatLng(centroidLat, centroidLng);
  }

  Future<void> waitMarker(bool check) async {
    setState(() {
      markerwait = true;
    });
    await Future.wait([
      findByPiont(latlong!.latitude, latlong!.longitude, check),
      (route != "") ? addManyMarkers(latlong!) : noneMethod(),
    ]);
    setState(() {
      markerwait = false;
    });
  }

  Future<void> noneMethod() async {}
  List<LatLng> points = [];
  void _createPolygon() {
    for (Marker marker in markers) {
      points.add(marker.position);
    }
    final Polygon polygon = Polygon(
      polygonId: const PolygonId('polygon'),
      points: points,
      strokeWidth: 2,
      strokeColor: const Color.fromARGB(255, 5, 94, 167),
      fillColor: Colors.blue.withOpacity(0.2),
    );

    setState(() {
      polygons.add(polygon);
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
      route = "";
      listMarkerIds.clear();

      listMarkerIds.add(marker);
    });
  }

  Future<void> checkZoneSpecail() async {
    polygons.clear();

    Map<int, List<Map<String, dynamic>>> zonePoints = {
      1: [],
      2: [],
      3: [],
      4: [],
      5: [],
      6: [],
      7: [],
      8: [],
      9: [],
      10: [],
      11: [],
      12: [],
      13: [],
      14: [],
      15: [],
      16: [],
      17: [],
      18: [],
      19: [],
      20: []
    };

    for (var item in addZone.listZone) {
      int noZone = item['no_zone'];
      LatLng point = LatLng(item['lat'], item['log']);
      if (noZone >= 1 && noZone <= 20) {
        zonePoints[noZone]!.add({
          "point": point,
          "no_zone": item['no_zone'],
          "name_road": item['name_road']
        });
      }
    }

    for (int zone = 1; zone <= 20; zone++) {
      if (zonePoints[zone]!.isNotEmpty) {
        List<LatLng> polygonPoints =
            zonePoints[zone]!.map((entry) => entry['point'] as LatLng).toList();

        Polygon polygon = Polygon(
          onTap: () {
            setState(() {
              AwesomeDialog(
                alignment: Alignment.centerLeft,
                width: 400,
                context: context,
                animType: AnimType.leftSlide,
                headerAnimationLoop: false,
                dialogType: DialogType.success,
                showCloseIcon: false,
                title: 'Do you want to Delete this Zone?',
                btnOkOnPress: () async {
                  int noZone = 0;
                  String nameRoad = "";
                  for (var entry in zonePoints[zone]!) {
                    noZone = entry['no_zone'];
                    nameRoad = entry['name_road'];
                  }

                  await addZone.deleteZone(noZone, nameRoad);
                  setState(() {
                    checkFindlatlong = false;
                    listMarkerIds.clear();
                    polygons.clear();
                    markers.clear();
                    points.clear();
                    listLatlong.clear();
                    route = "";
                    listClicks.clear();
                    routeClick = "";
                    polygons.clear();
                  });
                },
                btnCancelOnPress: () {},
              ).show();
            });
          },
          polygonId: PolygonId('polygon_$zone'),
          points: polygonPoints,
          strokeWidth: 2,
          strokeColor: Colors.blue,
          fillColor: Colors.red.withOpacity(0.2),
        );

        setState(() {
          polygons.add(polygon);
        });
      }
    }
  }

  int? marketvalue;
  bool checkFindlatlong = false;
  LatLng? latlong;
  AddZone addZone = AddZone();
  List listLatlong = [];
  bool typeMap = false;
  bool checkMarker = false;
  bool marketRN = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProgressHUD(
      color: const Color.fromARGB(255, 0, 49, 212),
      inAsyncCall: markerwait,
      opacity: 0.3,
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: 450,
            color: appback,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: whiteColor,
                            size: 25,
                          ))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: whiteColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Type Map : ",
                                style:
                                    TextStyle(color: whiteColor, fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      typeMap = !typeMap;
                                    });
                                  },
                                  icon: Icon(
                                    typeMap
                                        ? Icons.check_box_outline_blank_outlined
                                        : Icons.check_box_outlined,
                                    color: whiteColor,
                                  )),
                              const SizedBox(width: 10),
                              Text(
                                "Check Name Road",
                                style:
                                    TextStyle(color: whiteColor, fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      marketvalue = null;
                                      marketRN = false;
                                      checkMarker = !checkMarker;
                                      checkFindlatlong = false;
                                      listMarkerIds.clear();
                                      polygons.clear();
                                      markers.clear();
                                      points.clear();
                                      listLatlong.clear();
                                      route = "";
                                      listClicks.clear();
                                      routeClick = "";
                                    });
                                  },
                                  icon: Icon(
                                    !checkMarker
                                        ? Icons.check_box_outline_blank_outlined
                                        : Icons.check_box_outlined,
                                    color: whiteColor,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (checkMarker)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Road Name : ",
                                  style: TextStyle(
                                      color: whiteColor, fontSize: 16),
                                ),
                                Text(
                                  route,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 250, 42, 27),
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          if (route != "" && !checkMarker)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Road Name Used : ",
                                      style: TextStyle(
                                          color: whiteColor, fontSize: 16),
                                    ),
                                    Text(
                                      route,
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 250, 42, 27),
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Road Name Click : ",
                                      style: TextStyle(
                                          color: whiteColor, fontSize: 16),
                                    ),
                                    Text(
                                      routeClick,
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 227, 231, 232),
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        AwesomeDialog(
                                          alignment: Alignment.centerLeft,
                                          width: 400,
                                          context: context,
                                          animType: AnimType.leftSlide,
                                          headerAnimationLoop: false,
                                          dialogType: DialogType.success,
                                          showCloseIcon: false,
                                          title: 'Do you want to add New Zone?',
                                          // autoHide: const Duration(seconds: 2),
                                          btnOkOnPress: () async {
                                            addZone.addZone(listLatlong);
                                          },
                                          btnCancelOnPress: () {},
                                        ).show();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 7, 167, 13),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                width: 1, color: whiteColor)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Add Zone',
                                              style:
                                                  TextStyle(color: whiteColor),
                                            ),
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: whiteColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          checkFindlatlong = false;
                                          listMarkerIds.clear();
                                          polygons.clear();
                                          markers.clear();
                                          points.clear();
                                          listLatlong.clear();
                                          marketvalue = null;
                                          route = "";
                                          listClicks.clear();
                                          routeClick = "";
                                          marketRN = false;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 222, 15, 0),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                width: 1, color: whiteColor)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Clear Markers',
                                              style:
                                                  TextStyle(color: whiteColor),
                                            ),
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: whiteColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Market : ",
                                      style: TextStyle(
                                          color: whiteColor, fontSize: 16),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            marketRN = !marketRN;
                                            if (!marketRN) {
                                              marketvalue = null;
                                            } else {
                                              marketvalue = 1;
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          !marketRN
                                              ? Icons
                                                  .check_box_outline_blank_outlined
                                              : Icons.check_box_outlined,
                                          color: whiteColor,
                                        )),
                                  ],
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (route != "" && !checkMarker)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Please Check Zone First",
                          style: TextStyle(color: whiteColor, fontSize: 16),
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  if (route != "" && !checkMarker)
                    Container(
                      height: MediaQuery.of(context).size.height * 0.62,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: whiteColor)),
                      child: ListView.builder(
                        itemCount: listClicks.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: whiteColor)),
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "No.${index + 1} Road : ",
                                  style: TextStyle(
                                      color: whiteColor, fontSize: 16),
                                ),
                                Text(
                                  listClicks[index]['road'].toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 250, 42, 27),
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: GoogleMap(
                onTap: (argument) async {
                  setState(() {
                    latlong = argument;
                  });
                  if (checkMarker == false) {
                    if (checkFindlatlong == false) {
                      await waitMarker(true);
                      print("No.1");
                    } else {
                      await waitMarker(false);
                      print("No.2");
                    }
                  } else {
                    addMarker(argument);
                    findByPiont(latlong!.latitude, latlong!.longitude, true);
                  }
                },
                mapType: typeMap ? MapType.normal : MapType.hybrid,
                markers: listMarkerIds.map((e) => e).toSet(),
                initialCameraPosition: const CameraPosition(
                  target: LatLng(11.549288, 104.898100),
                  zoom: 14,
                ),
                polygons: Set<Polygon>.of(polygons),
                onMapCreated: (GoogleMapController controller) {},
              ),
            ),
          )
        ],
      ),
    ));
  }

  List listClicks = [];
  String route = '';
  String routes = '';
  String routeClick = '';
  Future<void> findByPiont(double la, double lo, bool checkOnlyR) async {
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
                district = (jsonResponse['results'][j]['address_components'][i]
                        ['short_name'] ??
                    "");
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                checkSk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                        ['short_name'] ??
                    "");
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_1") {
              province = (jsonResponse['results'][j]['address_components'][i]
                      ['short_name'] ??
                  "");
            }
          }
        }
        if (jsonResponse['results'][j]['types'][0] == "route") {
          List r = jsonResponse['results'][j]['address_components'];
          for (int i = 0; i < r.length; i++) {
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "route") {
              setState(() {
                if (checkOnlyR == true) {
                  route = (jsonResponse['results'][j]['address_components'][i]
                          ['short_name'] ??
                      "");
                } else {
                  setState(() {
                    routeClick = (jsonResponse['results'][j]
                            ['address_components'][i]['short_name'] ??
                        "");
                    listClicks.add({"road": routeClick});
                  });
                }
                // print("route ==> $route");
              });
            }
          }
        }
      }
      if (checkOnlyR == true) {
        await addZone.fetchZone(route);
        await checkZoneSpecail();
        setState(() {
          checkFindlatlong = true;
        });
      }
    }
  }
}
