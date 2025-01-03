import 'dart:convert';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';
import '../../../../Customs/ProgressHUD.dart';
import '../../../../getx/add_zone/add_zone.dart';
import '../../../../getx/component/getx._snack.dart';
import 'package:http/http.dart' as http;

class ZoneMap extends StatefulWidget {
  const ZoneMap({super.key, required this.listLocalHost});
  final List listLocalHost;
  @override
  State<ZoneMap> createState() => _ZoneMapState();
}

class _ZoneMapState extends State<ZoneMap> {
  final Set<Marker> listMarkerIds = {};
  List<Marker> markers = [];
  Set<Polygon> polygons = {};
  int indexPolygon = 0;
  final Random random = Random();
  Future<void> addMarkerAndPolygon(LatLng latLng) async {
    setState(() {
      // Add the initial point to the points list if not already present
      if (!points.contains(latLng)) {
        points.add(latLng);
      }
    });

    // Load custom icon
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(40, 40)),
      'assets/images/pin.png',
    );

    // Create marker ID
    int markerID = random.nextInt(1000);

    final MarkerId markerId = MarkerId(markerID.toString());

    // Add Polygon
    _polygons.add(Polygon(
      polygonId: PolygonId(markerID.toString()),
      points: points,
      strokeWidth: 1,
      strokeColor: const Color.fromARGB(255, 235, 42, 3),
      fillColor: colorback.withOpacity(0.05),
    ));

    // Add marker for each unique point in points list
    listMarkerIds.add(Marker(
      markerId: markerId,
      position: latLng,
      icon: icon,
      draggable: true,
      onTap: () {
        AwesomeDialog(
          width: 450,
          alignment: Alignment.centerLeft,
          context: context,
          dialogType: DialogType.success,
          title: 'Do you want to Delete Point Zone?',
          btnOkOnPress: () {
            setState(() {
              points.removeWhere((point) =>
                  point.latitude == latLng.latitude &&
                  point.longitude == latLng.longitude);
              listMarkerIds
                  .removeWhere((marker) => marker.markerId == markerId);
              listLatlong.removeWhere((element) =>
                  double.parse(element['lat'].toString()) == latLng.latitude &&
                  double.parse(element['log'].toString()) == latLng.longitude);
            });
          },
          btnCancelOnPress: () {},
        ).show();
      },
      onDragStart: (value) {
        setState(() {
          indexPolygon = points.indexOf(value);
        });
      },
      onDragEnd: (newPosition) {
        setState(() {
          for (int i = 0; i < points.length; i++) {
            if (indexPolygon == i) {
              points[i] = newPosition;
              listLatlong[i]['lat'] = newPosition.latitude;
              listLatlong[i]['log'] = newPosition.longitude;

              break;
            }
          }
          latLng = newPosition;
        });
      },
    ));

    setState(() {
      listLatlong.add({
        "lat": latLng.latitude,
        "log": latLng.longitude,
        "type_zone": typeZone,
        "agency": "${widget.listLocalHost[0]['agency'] ?? 0}",
        // "agency": "11",
        "name_road": ""
      });
    });
  }

  void removeMarker(MarkerId markerId) {
    listMarkerIds.removeWhere((marker) => marker.markerId == markerId);
  }

  bool markerwait = false;

  Future<void> waitMarker() async {
    setState(() {
      markerwait = true;
    });
    await Future.wait([
      (!checkFindlatlong)
          ? findByPiont(latlong!.latitude, latlong!.longitude)
          : addMarkerAndPolygon(latlong!),
    ]);
    setState(() {
      markerwait = false;
    });
  }

  var colorback = const Color.fromARGB(255, 255, 50, 50);
  List<LatLng> points = [];

  bool checkOption = false;
  Future<void> checkZoneSpecail() async {
    polygons.clear();

    Map<int, List<Map<String, dynamic>>> zonePoints = {};

    int maxZoneNumber = 100000;

    for (int i = 1; i <= maxZoneNumber; i++) {
      zonePoints[i] = [];
    }

    for (var item in addZone.listZone) {
      int noZone = int.parse("${item['no_zone'] ?? 0}");
      LatLng point = LatLng(double.parse(item['lat'].toString()),
          double.parse(item['log'].toString()));
      if (noZone >= 1 && noZone <= maxZoneNumber) {
        zonePoints[noZone]!.add({
          "point": point,
          "no_zone": item['no_zone'].toString(),
        });
      }
    }

    for (int zone = 1; zone <= maxZoneNumber; zone++) {
      if (zonePoints[zone]!.isNotEmpty) {
        List<LatLng> polygonPoints =
            zonePoints[zone]!.map((entry) => entry['point'] as LatLng).toList();

        _polygons.add(Polygon(
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
                    noZone = int.parse(entry['no_zone'].toString());
                    // nameRoad = entry['name_road'];
                  }

                  await addZone.deleteZone(noZone, nameRoad);
                  setState(() {
                    checkFindlatlong = false;
                    listMarkerIds.clear();
                    polygons.clear();
                    markers.clear();
                    points.clear();
                    _polygons.clear();
                    listLatlong.clear();
                    route = "";
                    listLatlong.clear();
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
        ));

        // setState(() {
        //   polygons.add(polygon);
        // });
      }
    }
  }

  Component component = Component();
  int? typeZone;
  bool checkFindlatlong = false;
  LatLng? latlong;
  AddZone addZone = AddZone();
  List listLatlong = [];
  bool typeMap = false;
  bool checkMarker = false;
  int typeZoneRN = -1;
  final Set<Polygon> _polygons = {};

  List listTypeZone = [
    {
      "id": 1,
      "title": "Market",
    },
    {
      "id": 2,
      "title": "Borey",
    },
    {
      "id": 3,
      "title": "Sub Road",
    },
    {
      "id": 4,
      "title": "Main Road",
    },
  ];
  bool searchGoogle = false;
  Future<void> waitingSearch() async {
    searchGoogle = true;
    Future.wait([mainsearch()]);
    setState(() {
      searchGoogle = false;
    });
  }

  double distance = 0.5;
  double h = 0;
  List listMap = [];
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

  LatLng latLng = const LatLng(11.5489, 104.9214);
  GoogleMapController? mapController;
  bool searchBool = false;
  Future<void> findlocation(LatLng latlog) async {
    setState(() {
      searchBool = true;
      // print("latLng : ${latLng.latitude} || longitude : ${latLng.longitude}");
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
      });
    });
  }

  LatLng _markerPosition = LatLng(11.556473531854941, 104.92818808498154);
  bool checkpoint = false;
  void maincheck() {
    checkpoint = true;
    listMarkerIds.clear();
    markers.clear();
  }

  List listlatlog = [
    {"title": "latitude"},
    {"title": "longitude"},
  ];
  double lat = 0, log = 0;
  TextEditingController searchMap = TextEditingController();
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
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Text(
                          "Search by Latitude and Longitude",
                          style: TextStyle(color: whiteColor, fontSize: 15),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            for (int j = 0; j < listlatlog.length; j++)
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: (j == 0) ? 10 : 0),
                                  child: Container(
                                    height: 35,
                                    // width: 170,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: whiteColor,
                                        border: Border.all(
                                            width: 0.5, color: blackColor)),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      // controller: searchlatlog,
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          if (j == 0) {
                                            // lat = double.parse(value);
                                            lat = double.parse(value);
                                          } else {
                                            log = double.parse(value);
                                          }
                                        });
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          if (j == 0) {
                                            // lat = double.parse(value);
                                            lat = double.parse(value);
                                          } else {
                                            // log = double.parse(value);
                                            log = double.parse(value);
                                          }
                                        });
                                      },
                                      //,
                                      textInputAction: TextInputAction.search,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 8),
                                        suffixIcon: (j == 0)
                                            ? const SizedBox()
                                            : IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    maincheck();

                                                    findlocation(
                                                        LatLng(lat, log));
                                                    // findlocation(LatLng(
                                                    //     11.499263, 104.874885));
                                                    // findByPiont(
                                                    //     double.parse(
                                                    //         requestModel.lat),
                                                    //     double.parse(
                                                    //         requestModel.lng));
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
                                        hintText:
                                            listlatlog[j]['title'].toString(),
                                        border: InputBorder.none,
                                        // contentPadding:
                                        //     const EdgeInsets.symmetric(
                                        //         vertical: 8, horizontal: 5),
                                        hintStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 118, 116, 116),
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
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
                          style: TextStyle(color: whiteColor, fontSize: 15),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: whiteColor,
                              border:
                                  Border.all(width: 0.5, color: blackColor)),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: searchMap,
                            onFieldSubmitted: (value) {
                              setState(() {
                                waitingSearch();
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                if (searchMap.text != '') {
                                  waitingSearch();
                                } else {
                                  listMap = [];
                                  // print('OK');
                                }
                              });
                            },
                            textInputAction: TextInputAction.search,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              suffixIcon: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      mainsearch();
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
                                    color: greyColorNolots,
                                  )),
                              fillColor: Colors.white,
                              hintText: "  Search",
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 10),
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 118, 116, 116),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 220,
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
                                      style: TextStyle(
                                          color: whiteColor, fontSize: 16),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            typeMap = !typeMap;
                                          });
                                        },
                                        icon: Icon(
                                          typeMap
                                              ? Icons
                                                  .check_box_outline_blank_outlined
                                              : Icons.check_box_outlined,
                                          color: whiteColor,
                                        )),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Check Name Road",
                                      style: TextStyle(
                                          color: whiteColor, fontSize: 16),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            typeZone = null;
                                            typeZoneRN = -1;
                                            checkMarker = !checkMarker;
                                            checkFindlatlong = false;
                                            listMarkerIds.clear();
                                            polygons.clear();
                                            _polygons.clear();
                                            points.clear();
                                            markers.clear();
                                            points.clear();
                                            listLatlong.clear();
                                            route = "";
                                            listLatlong.clear();
                                            routeClick = "";
                                            checkOption = false;
                                          });
                                        },
                                        icon: Icon(
                                          !checkMarker
                                              ? Icons
                                                  .check_box_outline_blank_outlined
                                              : Icons.check_box_outlined,
                                          color: whiteColor,
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                Container(
                                  height: 25,
                                  // width: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: whiteColor,
                                      border: Border.all(
                                          width: 0.5, color: blackColor)),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    // controller: searchlatlog,

                                    onChanged: (value) {
                                      setState(() {
                                        distance = double.parse(value);
                                      });
                                    },
                                    //,
                                    textInputAction: TextInputAction.search,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                    decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: "Distance",
                                      border: InputBorder.none,
                                      // contentPadding:
                                      //     const EdgeInsets.symmetric(
                                      //         vertical: 8, horizontal: 5),
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 118, 116, 116),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                if (!checkMarker)
                                  Column(
                                    children: [
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.start,
                                      //   children: [
                                      //     Text(
                                      //       "Road Name Used : ",
                                      //       style: TextStyle(
                                      //           color: whiteColor,
                                      //           fontSize: 16),
                                      //     ),
                                      //     Text(
                                      //       route,
                                      //       style: const TextStyle(
                                      //           color: Color.fromARGB(
                                      //               255, 250, 42, 27),
                                      //           fontSize: 14),
                                      //     ),
                                      //   ],
                                      // ),
                                      const SizedBox(height: 10),

                                      const SizedBox(height: 10),

                                      if (checkOption == true)
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                AwesomeDialog(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width: 400,
                                                  context: context,
                                                  animType: AnimType.leftSlide,
                                                  headerAnimationLoop: false,
                                                  dialogType:
                                                      DialogType.success,
                                                  showCloseIcon: false,
                                                  title:
                                                      'Do you want to add New Zone?',
                                                  btnOkOnPress: () async {
                                                    await addZone
                                                        .addZone(listLatlong);
                                                    setState(() {
                                                      checkFindlatlong = false;
                                                      listMarkerIds.clear();
                                                      polygons.clear();
                                                      markers.clear();
                                                      points.clear();
                                                      listLatlong.clear();
                                                      typeZone = null;
                                                      route = "";
                                                      listLatlong.clear();
                                                      routeClick = "";
                                                      _polygons.clear();
                                                      points.clear();
                                                      typeZoneRN = -1;
                                                      checkOption = false;
                                                      // typeZoneRN = false;
                                                    });
                                                  },
                                                  btnCancelOnPress: () {},
                                                ).show();
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 35,
                                                width: 130,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 7, 167, 13),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: whiteColor)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Add Zone',
                                                      style: TextStyle(
                                                          color: whiteColor),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
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
                                                  typeZone = null;
                                                  route = "";
                                                  listLatlong.clear();
                                                  routeClick = "";
                                                  _polygons.clear();
                                                  points.clear();
                                                  typeZoneRN = -1;
                                                  checkOption = false;
                                                  // typeZoneRN = false;
                                                });
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 35,
                                                width: 130,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 222, 15, 0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: whiteColor)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Clear Markers',
                                                      style: TextStyle(
                                                          color: whiteColor),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: whiteColor,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                // const SizedBox(height: 10),

                                // if (route != "" && !checkMarker)
                                Row(
                                  children: [
                                    for (int i = 0;
                                        i < listTypeZone.length;
                                        i++)
                                      SizedBox(
                                        height: 40,
                                        width: 100,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${listTypeZone[i]['title']}",
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 12),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    typeZoneRN =
                                                        (typeZoneRN == i)
                                                            ? -1
                                                            : i;
                                                    checkOption = true;
                                                    if (i == 0) {
                                                      typeZone = 1;
                                                    } else if (i == 1) {
                                                      typeZone = 2;
                                                    } else if (i == 2) {
                                                      typeZone = null;
                                                    } else if (i == 3) {
                                                      typeZone = 3;
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  (typeZoneRN == i)
                                                      ? Icons.check_box_outlined
                                                      : Icons
                                                          .check_box_outline_blank_outlined,
                                                  color: whiteColor,
                                                )),
                                          ],
                                        ),
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
                                style:
                                    TextStyle(color: whiteColor, fontSize: 16),
                              ),
                            ],
                          ),
                        const SizedBox(height: 10),
                        if (!checkMarker)
                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 1, color: whiteColor)),
                            child: ListView.builder(
                              itemCount: points.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: whiteColor)),
                                  height: 50,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "No.${index + 1} Latlong: ",
                                        style: TextStyle(
                                            color: whiteColor, fontSize: 16),
                                      ),
                                      Text(
                                        // listLatlong[index]['lat'].toString(),
                                        points[index].latitude.toString(),
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 250, 42, 27),
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
                  Positioned(
                    top: 140,
                    child: (listMap.isEmpty)
                        ? const SizedBox()
                        : Container(
                            height: 350,
                            width: 450,
                            color: whiteColor,
                            child: ListView.builder(
                              itemCount: listMap.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  setState(() {
                                    var location =
                                        listMap[index]['geometry']['location'];
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
                                        color: greyColorNolots,
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

                  if (checkOption == true) {
                    if (checkMarker == false) {
                      await waitMarker();
                    } else {
                      // addMarker(argument);
                      findByPiont(latlong!.latitude, latlong!.longitude);
                    }
                  }
                },
                mapType: typeMap ? MapType.normal : MapType.hybrid,
                // markers: listMarkerIds.map((e) => e).toSet(),
                markers: listMarkerIds,
                initialCameraPosition: CameraPosition(
                  target: _markerPosition,
                  zoom: 14,
                ),
                // polygons: Set<Polygon>.of(polygons),

                polygons: _polygons,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),
            ),
          )
        ],
      ),
    ));
  }

  // List listClicks = [];
  String route = '';
  String routes = '';
  String routeClick = '';
  Future<void> findByPiont(double la, double lo) async {
    await addZone.fetchZoneLatlog(la, lo, distance);
    await checkZoneSpecail();
    setState(() {
      checkOption = true;
      checkFindlatlong = true;
    });
  }
}
