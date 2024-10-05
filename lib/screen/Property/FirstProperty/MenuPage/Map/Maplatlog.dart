// ignore_for_file: non_constant_identifier_names

import 'dart:collection';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../../../components/colors.dart';
import '../../../../../page/navigate_home/Comparable/comparable3/search_screen.dart/search_map_com.dart';
import '../../component/Colors/appbar.dart';
import '../DetailScreen/DetailAll.dart';

typedef OnChangeCallback = void Function(dynamic value);

const kGoogleApiKey = 'AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class MapLatLog extends StatefulWidget {
  const MapLatLog(
      {super.key,
      required this.get_province,
      required this.get_district,
      required this.get_commune,
      required this.get_log,
      required this.get_lat,
      required this.myIdcontroller});
  final OnChangeCallback get_province;
  final OnChangeCallback get_district;
  final OnChangeCallback get_commune;
  final OnChangeCallback get_log;
  final OnChangeCallback get_lat;
  final String myIdcontroller;
  @override
  State<MapLatLog> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<MapLatLog> {
  String sendAddrress = '';

  // final Set<Marker> _marker = Set();
  List<String> option = [
    'Residencial',
    'Commercial',
    'Agricultural',
  ];
  GoogleMapController? mapController;

  Position? currentPosition;

  Future<bool> handleLocationPermission() async {
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

  List<Map<String, dynamic>> dataOfVerbal = [];
  double? lat1;
  double? log1;
  Future<void> getDataComparable() async {
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/More_option?lng=$log1&lat=$lat1&count=30'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        dataOfVerbal = List<Map<String, dynamic>>.from(jsonResponse);
        // print(dataOfVerbal.toString());
        for (int i = 0; i < dataOfVerbal.length; i++) {
          List<MarkerData> markerDataList = [
            MarkerData(
              latLng: LatLng(
                double.parse(
                    dataOfVerbal[i]['lat'].toString()), // Switched lat and log
                double.parse(
                    dataOfVerbal[i]['log'].toString()), // Switched lat and log
              ),
              comparableId: dataOfVerbal[i]['id_ptys'].toString(),
              listWidgets: [],
            ),
          ];

          _addMarkers(markerDataList, i, dataOfVerbal);
        }
      });
    }
  }

  List list = [];
  void _addMarkers(List<MarkerData> markerDataList, int i, List list) async {
    for (var markerData in markerDataList) {
      Marker newMarker = Marker(
        // draggable: true,

        markerId: MarkerId(markerData.comparableId), // Use unique identifier
        position: markerData.latLng,
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(50, 50)),
            'assets/icons/${(list[i]['type'].toString() == "For Sale") ? "Sale.png" : "Rent.png"}'),
        infoWindow: InfoWindow(
          title: '${list[i]['type']}, ${list[i]['price']}',
          snippet: "${list[i]['id_ptys']} \$, ${list[i]['urgent'] ?? ""}",
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
        ),
      );
      markers.add(newMarker);
    }
  }

  Set<Marker> markers = {};

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16.0,
        ),
      ));
      lat1 = position.latitude;
      log1 = position.longitude;
      latLng = LatLng(lat1!, log1!);
      if (latLng.latitude != 0) {
        getDataComparable();
        _addMarker(latLng);
      } else {
        _addMarker(latLng);
      }
    });
  }

  double lat = 0;
  double log = 0;
  @override
  void initState() {
    handleLocationPermission();
    // getCurrentLocation();
    getDataComparable();
    super.initState();
  }

  Uint8List? _imageFile;
  LatLng latLng = const LatLng(11.519037, 104.915120);
  CameraPosition? cameraPosition;

  Future<void> _addMarker(LatLng latLng) async {
    Marker newMarker = Marker(
      draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      onDragEnd: (value) {
        latLng = value;
        Find_by_piont(value.latitude, value.longitude);
      },
      onTap: () {},
    );

    setState(() {
      markers.clear();
      markers.add(newMarker);

      Find_by_piont(latLng.latitude, latLng.longitude);
      // add the new marker to the list of _marker
    });
  }

  int num = 0;
  double h = 0;
  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 24.0);
  Set<Marker> markersList = {};
  late GoogleMapController googleMapController;
  int id = 1;

  List<MapType> style_map = [
    MapType.hybrid,
    MapType.normal,
  ];
  TextEditingController Tcon = TextEditingController();
  int index = 0;
  String? name_of_place;
  Set<Polygon> find_polygons = HashSet<Polygon>();
  GlobalKey<FormState> check = GlobalKey<FormState>();
  double? wth;
  double? wth2;
  var input;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    if (w < 600) {
      wth = w * 0.8;
      wth2 = w * 0.5;
    } else {
      wth = w * 0.5;
      wth2 = w * 0.3;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 10,
                ),
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Form(
                  key: check,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: Tcon,
                          onFieldSubmitted: (value) {
                            setState(() {
                              h = 0;
                              input = value;
                              if (num == 0) {
                                Find_Lat_log(value);
                              }
                            });
                          },
                          onChanged: (value) {
                            // name_place.clear();
                            setState(() {
                              input = value;
                              name_place.clear();
                              lg.clear();
                              ln.clear();
                              h = 0;
                              num = 0;
                              get_name_search(value, value);
                            });
                          },
                          textInputAction: TextInputAction.search,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: "Search",
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(top: 2),
                            hintStyle: TextStyle(
                              color: Colors.grey[850],
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 0.04,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              h = 0;
                            });
                          },
                          icon: Icon(Icons.remove_circle_outline_sharp,
                              color: blackColor)),
                      IconButton(
                          // splashRadius: 30,
                          hoverColor: Colors.black,
                          onPressed: () {
                            setState(() {
                              name_place.clear();
                              lg.clear();
                              ln.clear();

                              h = 0;
                              num = 0;
                              Find_Lat_log(input);
                            });
                          },
                          icon: Icon(
                            Icons.search,
                            size: 30,
                            color: blackColor,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
              height: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(target: latLng, zoom: 12),
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                onCameraMove: (CameraPosition cameraPositiona) {
                  cameraPosition = cameraPositiona; //when map is dragging
                },
                mapType: style_map[index],
                onTap: (argument) {
                  log = argument.longitude;
                  lat = argument.latitude;
                  widget.get_lat(argument.latitude.toString());
                  widget.get_log(argument.longitude.toString());
                  _addMarker(argument);
                },
              )),
          Positioned(
              right: 10,
              top: 40,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 21,
                child: IconButton(
                  icon: const Icon(
                    Icons.mp_sharp,
                    color: Color.fromRGBO(0, 184, 212, 1),
                    size: 25,
                  ),
                  onPressed: () {
                    setState(() {
                      if (index < 1) {
                        index = index + 1;
                      } else {
                        index = 0;
                      }
                    });
                  },
                ),
              )),
          if (name_place.length >= 1)
            Positioned(
              top: 2,
              left: 50,
              child: Container(
                height: h,
                width: MediaQuery.of(context).size.width * 0.7,
                color: Colors.white,
                child: ListView.builder(
                  itemCount: name_place.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            Find_Lat_log(name_place[index].toString());
                          },
                          child: Text(name_place[index].toString())),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appback,
        onPressed: () {
          setState(() {
            getCurrentLocation();
          });
        },
        child: Icon(
          Icons.location_on_outlined,
          color: whiteColor,
          size: 30,
        ),
      ),
    );
  }

  Future<void> Find_by_piont(double la, double lo) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${la},${lo}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));

    if (response.statusCode == 200) {
      // Successful response
      var jsonResponse = json.decode(response.body);
      var location = jsonResponse['results'][0]['geometry']['location'];
      var lati = location['lat'];
      var longi = location['lng'];
      widget.get_lat(lati.toString());
      widget.get_log(longi.toString());
      List ls = jsonResponse['results'];
      List ac;
      bool check_sk = false, check_kn = false;
      for (int j = 0; j < ls.length; j++) {
        ac = jsonResponse['results'][j]['address_components'];
        for (int i = 0; i < ac.length; i++) {
          if (check_kn == false || check_sk == false) {
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "political") {
              setState(() {
                check_kn = true;
                district = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
                // Load_khan(district);

                widget.get_district(jsonResponse['results'][j]
                    ['address_components'][i]['short_name']);
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                'administrative_area_level_1') {
              setState(() {
                check_sk = true;
                widget.get_province(jsonResponse['results'][j]
                    ['address_components'][i]['short_name']);
              });
            }
            //////////////////
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                check_sk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
                // Load_sangkat(commune);
                widget.get_commune(jsonResponse['results'][j]
                    ['address_components'][i]['short_name']);
              });
            }
          }
        }
      }

      // await Check_price_Area_commercial();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     action: SnackBarAction(
      //         label: "View",
      //         onPressed: () {
      //           showDialog(
      //             context: context,
      //             builder: (BuildContext context) {
      //               return AlertDialog(
      //                 title: const Text('Delial Image'),
      //                 content: Container(
      //                   height: 200,
      //                   decoration: BoxDecoration(
      //                       image: DecorationImage(
      //                           image: NetworkImage(
      //                               'https://maps.googleapis.com/maps/api/staticmap?center=${lati},${longi}&zoom=20&size=500x500&maptype=hybrid&_marker=color:red%7Clabel:K%7C${lati},${longi}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'))),
      //                 ),
      //               );
      //             },
      //           );
      //         }),
      //     content: Text(' $commune /  $district'),
      //   ),
      // );
    } else {
      // Error or invalid response
      print(response.statusCode);
    }
  }

  List name_place = [];
  Future<void> Find_Lat_log(var place) async {
    var check_charetor = place.split(',');
    if (check_charetor.length == 1) {
      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?address=${check_charetor[0]}&region=kh&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8';
      final response = await http.get(Uri.parse(url));
      final jsonResponse = json.decode(response.body);
      var location = jsonResponse['results'][0]['geometry']['location'];
      var lati = location['lat'];
      var longi = location['lng'];
      // widget.lat(lati.toString());
      // widget.log(longi.toString());
      latLng = LatLng(lati, longi);
      Marker newMarker = Marker(
        draggable: true,
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        onDragEnd: (value) {
          latLng = value;
          Find_by_piont(value.latitude, value.longitude);
        },
        infoWindow: InfoWindow(title: 'KFA\'s Developer'),
      );
      setState(() {
        markers.clear();
        Find_by_piont(lati, longi);
        markers.add(newMarker);
      });

      // print('------------------- $latitude');
      // print('------------------- $longitude');

      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 13)));
      List ls = jsonResponse['results'];
      List ac;
      for (int j = 0; j < ls.length; j++) {
        ac = jsonResponse['results'][j]['address_components'];
        for (int i = 0; i < ac.length; i++) {
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_3") {
            setState(() {
              // widget.commune(jsonResponse['results'][j]['address_components'][i]
              //     ['short_name']);
              print('Value ');
            });
          }
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_2") {
            setState(() {
              // widget.district(jsonResponse['results'][j]['address_components']
              //     [i]['short_name']);
            });
          }
        }
      }
    } else {
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${check_charetor[0]},${check_charetor[1]}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));

      // Successful response
      var jsonResponse = json.decode(response.body);
      var location = jsonResponse['results'][0]['geometry']['location'];
      var lati = location['lat'];
      var longi = location['lng'];
      // widget.lat(lati.toString());
      // widget.log(longi.toString());
      latLng = LatLng(lati, longi);
      Marker newMarker = Marker(
        draggable: true,
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        onDragEnd: (value) {
          latLng = value;
          Find_by_piont(value.latitude, value.longitude);
        },
        infoWindow: InfoWindow(title: 'KFA\'s Developer'),
      );
      setState(() {
        markers.clear();
        Find_by_piont(lati, longi);
        markers.add(newMarker);
      });

      // print('------------------- $latitude');
      // print('------------------- $longitude');

      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 13)));
      List ls = jsonResponse['results'];
      List ac;
      for (int j = 0; j < ls.length; j++) {
        ac = jsonResponse['results'][j]['address_components'];
        for (int i = 0; i < ac.length; i++) {
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_3") {
            setState(() {
              // widget.commune(jsonResponse['results'][j]['address_components'][i]
              //     ['short_name']);
            });
          }
          if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
              "administrative_area_level_2") {
            setState(() {
              // widget.district(jsonResponse['results'][j]['address_components']
              //     [i]['short_name']);
            });
          }
        }
      }
    }
  }

  // ignore: prefer_typing_uninitialized_variables
  var commune, district;
  List ac = [];
  List listMap = [];
  final Set<Marker> marker = Set(); //163
  List ln = [];
  List lg = [];
  Future<void> get_name_search(var name, typing) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/google/Map?query=$input',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      final list = jsonDecode(json.encode(response.data));
      listMap = list['results'];
      for (int j = 0; j < listMap.length; j++) {
        // ac = ls[j]['formatted_address'];
        var name = listMap[j]['name'].toString();
        var data_lnlg = list['results'][j]['geometry']['location'];
        if (h == 0 || h < 250) {
          if (typing != "") {
            h += 40;
          } else {
            h = 0;
          }
        }

        lg.add(data_lnlg["lat"]);
        ln.add(data_lnlg["lng"]);
        setState(() {
          name_place.add(name);
          // print(name_of_place);
        });
      }
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> poin_map_by_search(var ln, var lg) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lg},${ln}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));
    var jsonResponse = json.decode(response.body);
    latLng = LatLng(double.parse(lg), double.parse(ln));
    Marker newMarker = Marker(
      draggable: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      onDragEnd: (value) {
        latLng = value;
        Find_by_piont(value.latitude, value.longitude);
      },
      infoWindow: InfoWindow(title: 'KFA\'s Developer'),
    );
    setState(() {
      markers.clear();
      markers.add(newMarker);
    });
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 13)));
    List ls = jsonResponse['results'];
    List ac;
    for (int j = 0; j < ls.length; j++) {
      ac = jsonResponse['results'][j]['address_components'];
      for (int i = 0; i < ac.length; i++) {
        if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
            "administrative_area_level_3") {
          setState(() {});
        }
        if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
            "administrative_area_level_2") {
          setState(() {});
        }
      }
    }
  }
}
