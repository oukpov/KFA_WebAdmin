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
      infoWindow: InfoWindow(title: markerId.toString()),
      icon: BitmapDescriptor.defaultMarker,
      onTap: () {
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
            setState(() {
              points.removeWhere((point) =>
                  point.latitude == latLng.latitude &&
                  point.longitude == latLng.longitude);
              listLatlong.removeWhere((element) =>
                  element['lat'] == latLng.latitude &&
                  element['log'] == latLng.longitude);
              removeMarker(markerId);
              listClicks.removeWhere((element) =>
                  element['lat'] == latLng.latitude &&
                  element['lng'] == latLng.longitude);
              // print("listLatlong : ${listLatlong.length}");
            });
          },
          btnCancelOnPress: () {},
        ).show();
      },
      // onDrag: (value) {},
      // onDragStart: (value) {},
      draggable: true,
      onDragEnd: (value) {
        latLng = value;
        print(latLng.toString());
      },
    );

    setState(() {
      markers.add(marker);
      points.add(latLng);
      listMarkerIds.add(marker);
      listLatlong.add({
        "lat": latLng.latitude,
        "log": latLng.longitude,
        "type_zone": typeZone,
        "agency": widget.listLocalHost[0]['agency'] ?? 0,
        "name_road": route
      });
      _createPolygon();
      // LatLng centroid = _calculatePolygonCentroid(
      //     markers.map((marker) => marker.position).toList());
    });
  }

  void removeMarker(MarkerId markerId) {
    listMarkerIds.removeWhere((marker) => marker.markerId == markerId);
  }

  bool markerwait = false;
  // LatLng _calculatePolygonCentroid(List<LatLng> points) {
  //   double centroidLat = 0.0;
  //   double centroidLng = 0.0;

  //   for (LatLng point in points) {
  //     centroidLat += point.latitude;
  //     centroidLng += point.longitude;
  //   }

  //   centroidLat /= points.length;
  //   centroidLng /= points.length;

  //   return LatLng(centroidLat, centroidLng);
  // }

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

  Future<void> noneMethod() async {
    print("No Add");
  }

  List<LatLng> points = [];
  void _createPolygon() {
    // for (Marker marker in markers) {
    //   points.add(marker.position);
    // }
    _polygons.add(Polygon(
      polygonId: const PolygonId('polygon'),
      points: points,
      strokeWidth: 2,
      strokeColor: const Color.fromARGB(255, 5, 94, 167),
      fillColor: Colors.blue.withOpacity(0.2),
    ));
    print(points.toString());
  }

  // Future<void> addMarker(LatLng latLng) async {
  //   Marker marker = Marker(
  //     visible: true,
  //     draggable: true,
  //     markerId: MarkerId(latLng.toString()),
  //     position: latLng,
  //     onDragEnd: (value) {
  //       latLng = value;
  //     },
  //   );

  //   setState(() {
  //     route = "";
  //     listMarkerIds.clear();
  //     // listMarkerIds.add(marker);
  //   });
  // }

  bool checkOption = false;
  Future<void> checkZoneSpecail() async {
    polygons.clear();

    Map<int, List<Map<String, dynamic>>> zonePoints = {};

    int maxZoneNumber = 100000;

    for (int i = 1; i <= maxZoneNumber; i++) {
      zonePoints[i] = [];
    }

    for (var item in addZone.listZone) {
      int noZone = item['no_zone'] ?? 0;
      LatLng point = LatLng(item['lat'], item['log']);
      if (noZone >= 1 && noZone <= maxZoneNumber) {
        zonePoints[noZone]!.add({
          "point": point,
          "no_zone": item['no_zone'],
          "name_road": item['name_road']
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
                    _polygons.clear();
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
  // final List<LatLng> polygonCoordinates = [
  //   LatLng(11.525069724444075, 104.91717817131298),
  //   LatLng(11.518768869134183, 104.91577470242815),
  //   LatLng(11.517368659885603, 104.92016373239524),
  //   LatLng(11.526369883353812, 104.92973283842808),
  //   LatLng(11.52997029200921, 104.92325136394182), // Close the polygon
  // ];

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
                                            listClicks.clear();
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
                                            color: Color.fromARGB(
                                                255, 250, 42, 27),
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
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
                                if (route != "" && !checkMarker)
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Road Name Click : ",
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 14),
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
                                                      listClicks.clear();
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
                                                  listClicks.clear();
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
                        if (route != "" && !checkMarker)
                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 1, color: whiteColor)),
                            child: ListView.builder(
                              itemCount: listClicks.length,
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
                                        "No.${index + 1} Road : ",
                                        style: TextStyle(
                                            color: whiteColor, fontSize: 16),
                                      ),
                                      Text(
                                        listClicks[index]['road'].toString(),
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
                      if (checkFindlatlong == false) {
                        print("No.1");
                        await waitMarker(true);
                      } else {
                        print("No.2");
                        await waitMarker(false);
                      }
                    } else {
                      // addMarker(argument);
                      findByPiont(latlong!.latitude, latlong!.longitude, true);
                    }
                  }
                },
                mapType: typeMap ? MapType.normal : MapType.hybrid,
                markers: listMarkerIds.map((e) => e).toSet(),
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
                    listClicks.add({"road": routeClick, "lat": la, "lng": lo});
                  });
                }
                // print("route ==> $route");
              });
            }
          }
        }
      }
      if (checkOnlyR == true) {
        await addZone.fetchZoneLatlog(la, lo, distance);
        await checkZoneSpecail();
        setState(() {
          checkFindlatlong = true;
        });
      }
    }
  }
}
