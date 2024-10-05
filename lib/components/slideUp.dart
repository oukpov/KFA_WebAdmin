// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_admin/components/property%20copy.dart';
import 'package:web_admin/components/property.dart';
import '../Customs/ProgressHUD.dart';
import '../models/search_model.dart';
import 'colors.dart';
import 'numDisplay.dart';

typedef OnChangeCallback = void Function(dynamic value);

class map_cross_verbal extends StatefulWidget {
  const map_cross_verbal(
      {super.key,
      required this.get_province,
      required this.get_district,
      required this.get_commune,
      required this.get_log,
      required this.get_lat,
      required this.asking_price,
      required this.get_min1,
      required this.get_max1,
      required this.get_min2,
      required this.get_max2});
  final OnChangeCallback get_province;
  final OnChangeCallback get_district;
  final OnChangeCallback get_commune;
  final OnChangeCallback get_log;
  final OnChangeCallback get_lat;
  final OnChangeCallback asking_price;
  final OnChangeCallback get_min1;
  final OnChangeCallback get_max1;
  final OnChangeCallback get_min2;
  final OnChangeCallback get_max2;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<map_cross_verbal> {
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 55.0;
  String googleApikey = "AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  final Set<Marker> listMarkerIds = new Set();
  double latitude = 11.5489; //latitude
  double longitude = 104.9214;
  LatLng latLng = const LatLng(11.5489, 104.9214);
  String address = "";
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List list = [];
  double adding_price = 0;
  String sendAddrress = '';
  List data = [];
  List formatted_address = [];
  List name_place = [];
  List ln = [];
  List lg = [];
  int num = 0;
  int groupValue = 0;
  String? name_of_place;
  var input;
  double h = 0;
  TextEditingController Tcon = new TextEditingController();
  double? wth;
  double? wth2;
  bool isChecked = true;
  GlobalKey<FormState> check = GlobalKey<FormState>();
  // ignore: prefer_typing_uninitialized_variables
  var pty;
  var formatter = NumberFormat("##,###,###,###", "en_US");
  var date = DateFormat('yyyy-MM-dd').format(DateTime(2020, 01, 01));
  var date1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool isApiCallProcess = false;
  // static const apiKey = "AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY";
  late LocatitonGeocoder geocoder = LocatitonGeocoder(googleApikey);
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

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      requestModel.lat = position.latitude.toString();
      requestModel.lng = position.longitude.toString();
    });
    // Marker newMarker = Marker(
    //   draggable: true,
    //   markerId: MarkerId('6'),
    //   position: LatLng(position.latitude, position.longitude),
    //   infoWindow: InfoWindow(title: 'KFA\'s Developer'),
    // );
    // setState(() {
    //   isWidgetVisible = true;
    //   listMarkerIds.clear();
    //   listMarkerIds.add(newMarker);
    // });
    // await Show(requestModel, LatLng(position.latitude, position.longitude));
    mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16.0,
      ),
    ));
  }

  @override
  void initState() {
    _handleLocationPermission();
    Future.delayed(const Duration(seconds: 3), () async {
      await _getCurrentLocation();
    });

    // getAddress(latLng);
    // ignore: unnecessary_new
    requestModel = new SearchRequestModel(
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      color: kPrimaryColor,
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: _uiSteup(context),
    );
  }

  Widget _uiSteup(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    if (w < 600) {
      wth = w * 0.8;
      wth2 = w * 0.5;
    } else {
      wth = w * 0.8;
      wth2 = w * 0.6;
    }
    _panelHeightOpen = MediaQuery.of(context).size.height * 0.30;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: Container(
            width: wth,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.only(right: 70, top: 10),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Form(
              key: check,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: wth2,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: Tcon,
                      onFieldSubmitted: (value) {
                        setState(() {
                          h = 0;
                          input = value;
                          name_place.clear();
                          formatted_address.clear();
                          lg.clear();
                          ln.clear();
                          if (num == 0) {
                            Find_Lat_log(value);
                          }
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            h = 0;
                            name_place.clear();
                          }
                          input = value;
                          name_place.clear();
                          formatted_address.clear();
                          lg.clear();
                          ln.clear();
                          h = 0;
                          num = 0;
                          Future.delayed(const Duration(seconds: 1), () {
                            getLocationResults(value.toString());
                          });
                        });
                      },
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        fillColor: const Color.fromARGB(255, 255, 165, 165),
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
                          name_place.clear();
                          lg.clear();
                          ln.clear();
                          formatted_address.clear();
                          h = 0;
                          num = 0;
                          Find_Lat_log(input);
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.red,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          listMarkerIds.clear();
                          _getCurrentLocation();
                        });
                      },
                      icon: const Icon(
                        Icons.person_pin_circle_outlined,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              setState(() {
                if (data_adding_correct.length == int.parse(requestModel.num)) {
                  widget.asking_price(adding_price);
                }
              });
              Navigator.pop(context);
            },
            icon: Icon(Icons.save_alt_outlined),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Dialog_for_comperable(context);
                },
                icon: Icon(Icons.line_style_rounded, color: Colors.white))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 20,
                  width: double.infinity,
                  color: Colors.indigo[900]),
              Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: GoogleMap(
                      markers: listMarkerIds.map((e) => e).toSet(),
                      zoomGesturesEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: latLng,
                        zoom: 12.0,
                      ),
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      mapType: MapType.hybrid,
                      onMapCreated: (controller) {
                        setState(() {
                          mapController = controller;
                        });
                      },
                      onTap: (argument) {
                        if (onclick == false) {
                          setState(() {
                            adding_price = 0;
                            listMarkerIds.clear();
                            data_adding_correct.clear();

                            requestModel.lat = argument.latitude.toString();
                            requestModel.lng = argument.longitude.toString();
                            widget.get_lat(requestModel.lat.toString());
                            widget.get_log(requestModel.lng.toString());
                            Show(requestModel, argument, context);
                          });
                        }
                      },
                      onCameraMove: (CameraPosition cameraPositiona) {
                        cameraPosition = cameraPositiona; //when map is dragging
                      },
                    ),
                  ),
                  if (name_place.length >= 1 && h != 0)
                    Positioned(
                      top: 0,
                      left: 10,
                      child: Container(
                          height: h,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          margin: EdgeInsets.only(left: 100, right: 70),
                          child: ListView.builder(
                              itemCount: name_place.length,
                              clipBehavior: Clip.antiAlias,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      Tcon;

                                      setState(() {
                                        onclick = true;
                                        isWidgetVisible = false;

                                        h = 0;
                                        Tcon;
                                        num =
                                            1; // use num for when user click on list search
                                        name_of_place !=
                                            name_place[index].toString();
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          poin_map_by_search(
                                              ln[index].toString(),
                                              lg[index].toString());
                                        });
                                      });
                                    },
                                    child: ListTile(
                                      title: Text(
                                        name_place[index],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        formatted_address[index],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ));
                              })),
                    ),
                ],
              ),
              SizedBox(height: 10.0),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20),
              //   child: ToFromDate(
              //     fromDate: (value) {
              //       requestModel.fromDate = value;
              //       print(requestModel.fromDate);
              //     },
              //     toDate: (value) {
              //       requestModel.toDate = value;
              //       // print(requestModel.toDate);
              //     },
              //   ),
              // ),
              SizedBox(height: 10.0),
              // LandSize(
              //   land_min: (value) {
              //     setState(() {
              //       requestModel.land_min = value;
              //       print(requestModel.fromDate);
              //     });
              //   },
              //   land_max: (value) {
              //     setState(() {
              //       requestModel.land_max = value;
              //       print(requestModel.toDate);
              //     });
              //   },
              // ),
              ListTile(
                title: const Text('Comperable Price'),
                leading: GFRadio(
                  type: GFRadioType.square,
                  size: GFSize.SMALL,
                  value: 0,
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = int.parse(value.toString());
                    });
                  },
                  inactiveIcon: null,
                  activeBorderColor: Color.fromARGB(0, 16, 220, 98),
                  inactiveBorderColor: Color.fromARGB(255, 16, 36, 220),
                  radioColor: Color.fromARGB(255, 47, 106, 71),
                ),
              ),
              ListTile(
                title: const Text('Market Price'),
                leading: GFRadio(
                  type: GFRadioType.square,
                  size: GFSize.SMALL,
                  value: 1,
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = int.parse(value.toString());
                    });
                  },
                  inactiveIcon: null,
                  activeBorderColor: Color.fromARGB(0, 16, 220, 98),
                  inactiveBorderColor: Color.fromARGB(255, 16, 36, 220),
                  radioColor: Color.fromARGB(255, 47, 106, 71),
                ),
              ),
              SizedBox(height: 10.0),
              NumDisplay(
                  onSaved: (newValue) => setState(() {
                        requestModel.num = newValue!;
                      })),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Container(
                    width: (!isChecked)
                        ? MediaQuery.of(context).size.width * 0.7
                        : MediaQuery.of(context).size.width * 1,
                    height: 60,
                    child: PropertyDropdown(
                      name: (value) {
                        // propertyType = value;
                      },
                      onslide: (value) {
                        setState(() {
                          onclick = true;
                          isChecked = false;
                        });
                      },
                      id: (value) {
                        setState(() {
                          pty = value;
                        });
                        Future.delayed(const Duration(seconds: 2), () async {
                          onclick = false;
                        });
                      },
                      // pro: list[0]['property_type_name'],
                    ),
                  ),
                  Container(
                    width: (!isChecked)
                        ? MediaQuery.of(context).size.width * 0.2
                        : 0,
                    height: 60,
                    child: GFCheckbox(
                      size: GFSize.SMALL,
                      activeBgColor: Color.fromARGB(0, 33, 149, 243),
                      activeBorderColor: Color.fromARGB(0, 33, 149, 243),
                      onChanged: (value) {
                        setState(() {
                          isChecked = value;
                          pty = null;
                        });
                        Future.delayed(const Duration(seconds: 2), () async {
                          onclick = false;
                        });
                      },
                      value: isChecked,
                      inactiveIcon: const Center(
                          child:
                              Text("Show all", textAlign: TextAlign.justify)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 200),
              // Distance(
              //     onSaved: (input) => setState(() {
              //           requestModel.distance = input!;
              //         })),
              addPaddingWhenKeyboardAppears(),
            ],
          ),
        ));
  }

  String proxiedURL = '';
  String offsetURL = '';
  String componentsURL = '';
  Future<void> getLocationResults(String inputText) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/textsearch/json';
    String type = 'address';
    String input = Uri.encodeComponent("${inputText} in khmer");
    proxiedURL =
        'https://cors-anywhere.herokuapp.com/$baseURL?query=$input&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8';
    componentsURL = '$proxiedURL&language=Khmer';

    final Map<String, dynamic> response =
        await http.get(Uri.parse('$componentsURL'), headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Methods': 'GET,HEAD'
    }).then((value) => jsonDecode(value.body));

    List ls = response['results'];
    List ac;
    name_place.clear();
    for (int j = 0; j < ls.length; j++) {
      // ac = ls[j]['formatted_address'];

      var data_lnlg = response['results'][j]['geometry']['location'];

      lg.add(data_lnlg["lat"]);
      ln.add(data_lnlg["lng"]);
      setState(() {
        if (h == 0 || h < 250) {
          h += 60;
        }
        name_place.add(ls[j]['name'].toString());
        formatted_address.add(ls[j]['formatted_address'].toString());
      });
    }
  }

  bool isWidgetVisible = true;
  Future<void> Find_Lat_log(var place) async {
    var check_charetor = place.split(',');
    if (check_charetor.length == 1) {
      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?address=${check_charetor[0]} in cambodai&region=kh&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8';
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
          Find_by_piont(value.latitude, value.longitude, context);
        },
        infoWindow: InfoWindow(title: 'KFA\'s Developer'),
      );
      setState(() {
        isWidgetVisible = true;
        listMarkerIds.clear();
        Find_by_piont(lati, longi, context);
        listMarkerIds.add(newMarker);
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
          Find_by_piont(value.latitude, value.longitude, context);
        },
        infoWindow: InfoWindow(title: 'KFA\'s Developer'),
      );
      setState(() {
        isWidgetVisible = true;
        listMarkerIds.clear();
        Find_by_piont(lati, longi, context);
        listMarkerIds.add(newMarker);
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

  bool onclick = false;

  void Clear() {
    setState(() {
      for (var i = 0; i < list.length; i++) {
        MarkerId markerId = MarkerId('$i');
        listMarkerIds.remove(markerId);
      }
    });
  }

  Future<void> poin_map_by_search(var ln, var lg) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lg},${ln}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));
    var jsonResponse = json.decode(response.body);
    setState(() {
      latLng = LatLng(double.parse(lg), double.parse(ln));
      Marker newMarker = Marker(
        draggable: true,
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        onDragEnd: (value) {
          latLng = value;
          Find_by_piont(value.latitude, value.longitude, context);
        },
        infoWindow: InfoWindow(title: 'KFA\'s Developer'),
      );
      listMarkerIds.clear();
      listMarkerIds.add(newMarker);
      onclick = true;
    });

    mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 13)));
    List ls = jsonResponse['results'];
    List ac;
    // for (int j = 0; j < ls.length; j++) {
    //   ac = jsonResponse['results'][j]['address_components'];
    //   for (int i = 0; i < ac.length; i++) {
    //     if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
    //         "administrative_area_level_3") {
    //       setState(() {});
    //     }
    //     if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
    //         "administrative_area_level_2") {
    //       setState(() {});
    //     }
    //   }
    // }
  }

  List data_adding_correct = [];
  double? min, max;
  var commune, district;
  var maxSqm1, minSqm1;
  var maxSqm2, minSqm2;
  Future<void> Show(SearchRequestModel requestModel, LatLng location,
      BuildContext context) async {
    setState(() {
      isApiCallProcess = true;
      listMarkerIds.clear();
      Marker newMarker = Marker(
        draggable: true,
        markerId: MarkerId(location.toString()),
        position: location,
      );
      listMarkerIds.add(newMarker);
    });
    final Jsondata;
    if (pty != null) {
      Jsondata = {
        "property_type_id": pty,
        "num": requestModel.num,
        "lat": requestModel.lat,
        "lng": requestModel.lng,
      };
    } else {
      Jsondata = {
        "num": requestModel.num,
        "lat": requestModel.lat,
        "lng": requestModel.lng,
      };
    }
    final rs = await http.post(
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/map_action'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(Jsondata));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list = jsonData['autoverbal'];
      });
    }

    Map map = list.asMap();
    if (requestModel.lat.isEmpty || requestModel.lng.isEmpty) {
      setState(() {
        isApiCallProcess = false;
        onclick = true;
      });

      // ignore: use_build_context_synchronously
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Please tap on map to select location',
        btnOkOnPress: () {
          Future.delayed(const Duration(seconds: 2), () async {
            onclick = false;
          });
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    } else {
      setState(() {
        isApiCallProcess = false;
        max = 0;
        min = 0;
      });
      if (map.isEmpty) {
        markers.clear();
        setState(() {
          onclick = true;
        });
        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'No data found!',
          desc: "You can try to change Property.",
          btnOkOnPress: () {
            Future.delayed(const Duration(seconds: 2), () async {
              onclick = false;
            });
          },
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.blue,
        ).show();
      } else {
        int index = 0;
        for (var i = 0; i < map.length; i++) {
          if (i == 0) {
            if (map[i]['comparable_adding_price'] == '') {
              map[i]['comparable_adding_price'] = '0';
              adding_price +=
                  double.parse(map[i]['comparable_adding_price']) / map.length;
              print(map[i]['comparable_adding_price']);
            } else if (map[i]['comparable_adding_price'].contains(',')) {
              adding_price += double.parse(
                      map[i]['comparable_adding_price'].replaceAll(",", "")) /
                  map.length;
              print(map[i]['comparable_adding_price']);
              //print(map[i]['comparable_adding_price'].split(",")[0]);
            } else {
              adding_price +=
                  (double.parse(map[i]['comparable_adding_price'])) /
                      map.length;
            }
            setState(() {
              data_adding_correct.add(map[i]);
              // widget.asking_price(adding_price);
            });
          } else if (i > 0) {
            if ((data_adding_correct.length == int.parse(requestModel.num)) ||
                (i == map.length - 1)) {
              break;
            } else {
              if ((map[i]['latlong_log'] != map[i - 1]['latlong_log']) &&
                  (map[i]['comparable_adding_price'] !=
                      map[i - 1]['comparable_adding_price'])) {
                if (map[i]['comparable_adding_price'] == '') {
                  map[i]['comparable_adding_price'] = '0';
                  adding_price +=
                      double.parse(map[i]['comparable_adding_price']) /
                          int.parse(requestModel.num);
                } else if (map[i]['comparable_adding_price'].contains(',')) {
                  // print(map[i]['comparable_adding_price'].replaceAll(",", ""));
                  adding_price += double.parse(map[i]['comparable_adding_price']
                          .replaceAll(",", "")) /
                      int.parse(requestModel.num);
                } else {
                  adding_price +=
                      (double.parse(map[i]['comparable_adding_price'])) /
                          int.parse(requestModel.num);
                }
                setState(() {
                  data_adding_correct.add(map[i]);
                });
              }
            }
          }
        }
        if (groupValue == 0) {
          for (int i = 0; i < data_adding_correct.length; i++) {
            MarkerId markerId = MarkerId(i.toString());
            if (data_adding_correct[i]['comparable_property_id'] == 15) {
              Marker marker = Marker(
                markerId: markerId,
                position: LatLng(
                  double.parse(
                      data_adding_correct[i]['latlong_log'].toString()),
                  double.parse(data_adding_correct[i]['latlong_la'].toString()),
                ),
                icon: await BitmapDescriptor.fromAssetImage(
                    ImageConfiguration(size: Size(50, 50)),
                    'assets/icons/l.png'),
                onTap: () {
                  setState(() {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          alignment: Alignment.topCenter,
                          contentPadding: const EdgeInsets.only(top: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          content: showDia(i)),
                    );
                  });
                },
              );
              setState(() {
                isApiCallProcess = false;
                listMarkerIds.add(marker);
              });
            } else if (data_adding_correct[i]['comparable_property_id'] == 10) {
              Marker marker = Marker(
                markerId: markerId,
                position: LatLng(
                  double.parse(
                      data_adding_correct[i]['latlong_log'].toString()),
                  double.parse(data_adding_correct[i]['latlong_la'].toString()),
                ),
                icon: await BitmapDescriptor.fromAssetImage(
                    ImageConfiguration(size: Size(50, 50)),
                    'assets/icons/f.png'),
                onTap: () {
                  setState(() {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          alignment: Alignment.topCenter,
                          contentPadding: const EdgeInsets.only(top: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          content: showDia(i)),
                    );
                  });
                },
              );
              setState(() {
                isApiCallProcess = false;
                listMarkerIds.add(marker);
              });
            } else if (data_adding_correct[i]['comparable_property_id'] == 33) {
              Marker marker = Marker(
                markerId: markerId,
                position: LatLng(
                  double.parse(
                      data_adding_correct[i]['latlong_log'].toString()),
                  double.parse(data_adding_correct[i]['latlong_la'].toString()),
                ),
                icon: await BitmapDescriptor.fromAssetImage(
                    ImageConfiguration(size: Size(50, 50)),
                    'assets/icons/v.png'),
                onTap: () {
                  setState(() {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          alignment: Alignment.topCenter,
                          contentPadding: const EdgeInsets.only(top: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          content: showDia(i)),
                    );
                  });
                },
              );
              setState(() {
                isApiCallProcess = false;
                listMarkerIds.add(marker);
              });
            } else if (data_adding_correct[i]['comparable_property_id'] == 14) {
              Marker marker = Marker(
                markerId: markerId,
                position: LatLng(
                  double.parse(
                      data_adding_correct[i]['latlong_log'].toString()),
                  double.parse(data_adding_correct[i]['latlong_la'].toString()),
                ),
                icon: await BitmapDescriptor.fromAssetImage(
                    ImageConfiguration(size: Size(50, 50)),
                    'assets/icons/h.png'),
                onTap: () {
                  setState(() {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          alignment: Alignment.topCenter,
                          contentPadding: const EdgeInsets.only(top: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          content: showDia(i)),
                    );
                  });
                },
              );
              setState(() {
                isApiCallProcess = false;
                listMarkerIds.add(marker);
              });
            } else if (data_adding_correct[i]['comparable_property_id'] == 4) {
              Marker marker = Marker(
                markerId: markerId,
                position: LatLng(
                  double.parse(
                      data_adding_correct[i]['latlong_log'].toString()),
                  double.parse(data_adding_correct[i]['latlong_la'].toString()),
                ),
                icon: await BitmapDescriptor.fromAssetImage(
                    ImageConfiguration(size: Size(50, 50)),
                    'assets/icons/b.png'),
                onTap: () {
                  setState(() {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          alignment: Alignment.topCenter,
                          contentPadding: const EdgeInsets.only(top: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          content: showDia(i)),
                    );
                  });
                },
              );
              setState(() {
                isApiCallProcess = false;
                listMarkerIds.add(marker);
              });
            } else if (data_adding_correct[i]['comparable_property_id'] == 29) {
              Marker marker = Marker(
                markerId: markerId,
                position: LatLng(
                  double.parse(
                      data_adding_correct[i]['latlong_log'].toString()),
                  double.parse(data_adding_correct[i]['latlong_la'].toString()),
                ),
                icon: await BitmapDescriptor.fromAssetImage(
                    ImageConfiguration(size: Size(50, 50)),
                    'assets/icons/v.png'),
                onTap: () {
                  setState(() {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          alignment: Alignment.topCenter,
                          contentPadding: const EdgeInsets.only(top: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          content: showDia(i)),
                    );
                  });
                },
              );
              setState(() {
                isApiCallProcess = false;
                listMarkerIds.add(marker);
              });
            } else {
              Marker marker = Marker(
                markerId: markerId,
                position: LatLng(
                  double.parse(
                      data_adding_correct[i]['latlong_log'].toString()),
                  double.parse(data_adding_correct[i]['latlong_la'].toString()),
                ),
                icon: await BitmapDescriptor.fromAssetImage(
                    ImageConfiguration(size: Size(50, 50)),
                    'assets/icons/a.png'),
                onTap: () {
                  setState(() {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          alignment: Alignment.topCenter,
                          contentPadding: const EdgeInsets.only(top: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          content: showDia(i)),
                    );
                  });
                },
              );
              setState(() {
                isApiCallProcess = false;
                listMarkerIds.add(marker);
              });
            }
          }
          Dialog_for_comperable(context);
        } else {
          await Find_by_piont(double.parse(requestModel.lat),
              double.parse(requestModel.lng), context);
        }

        // print("\n\n\n\n\nkoko ${listMarkerIds.length}  \n\n\n\n\n");
      }
    }
  }

  Widget showDia(int i) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text('ID\'s property', style: TextStyle(fontSize: 12)),
                  Text('Type\'s property', style: TextStyle(fontSize: 12)),
                  Text(
                    'Price',
                    style: TextStyle(
                        color: kImageColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text('Owner', style: TextStyle(fontSize: 12)),
                  Text('Land-Width', style: TextStyle(fontSize: 12)),
                  Text('Land-Length', style: TextStyle(fontSize: 12)),
                  Text('Land-Total', style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '  :   ' +
                          data_adding_correct[i]['comparable_id'].toString(),
                      style: TextStyle(fontSize: 12)),
                  Text('  :   ' + data_adding_correct[i]['property_type_name'],
                      style: TextStyle(fontSize: 12)),
                  Text(
                    '  :   ' +
                        data_adding_correct[i]['comparable_adding_price'] +
                        '\$',
                    style: TextStyle(
                        color: kImageColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text('  :   ' + data_adding_correct[i]['agenttype_name'],
                      style: TextStyle(fontSize: 12)),
                  Text(
                      '  :   ' +
                          data_adding_correct[i]['comparable_land_width'],
                      style: TextStyle(fontSize: 12)),
                  Text(
                      '  :   ' +
                          data_adding_correct[i]['comparable_land_length'],
                      style: TextStyle(fontSize: 12)),
                  Text(
                      '  :   ' +
                          formatter.format(double.parse(data_adding_correct[i]
                                  ['comparable_land_total']
                              .replaceAll(",", "")
                              .toString())),
                      style: TextStyle(fontSize: 12)),
                  // Text('  :   ' + map[i]['comparable_survey_date']),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -5,
          right: -1,
          child: IconButton(
            alignment: Alignment.topRight,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.cancel_outlined,
              color: Colors.redAccent,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

  Future Dialog_for_comperable(BuildContext context) {
    min = adding_price - (0.1 * adding_price);
    max = adding_price - (0.05 * adding_price);
    return (groupValue == 0)
        ? showDialog(
            context: context,
            builder: (context) => AlertDialog(
              alignment: Alignment.topCenter,
              contentPadding: const EdgeInsets.only(top: 1),
              content: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 0; i < data_adding_correct.length; i++)
                            Card(
                              elevation: 10,
                              child: ListTile(
                                title: Text(
                                    "comparable id : " +
                                        data_adding_correct[i]['comparable_id']
                                            .toString(),
                                    style: TextStyle(fontSize: 12)),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "property : " +
                                            data_adding_correct[i]
                                                    ['property_type_name']
                                                .toString(),
                                        style: TextStyle(fontSize: 10)),
                                    Text(
                                        "Owner : " +
                                            data_adding_correct[i]
                                                    ['agenttype_name']
                                                .toString(),
                                        style: TextStyle(fontSize: 10)),
                                    Text(
                                        "adding price : " +
                                            formatter.format(double.parse(
                                                data_adding_correct[i][
                                                        'comparable_adding_price']
                                                    .replaceAll(",", "")
                                                    .toString())) +
                                            "\$",
                                        style: TextStyle(fontSize: 10)),
                                    Text(
                                        "Date : " +
                                            data_adding_correct[i]
                                                    ['comparable_survey_date']
                                                .toString(),
                                        style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("minimum : ${formatter.format(min)}\$",
                                  style: TextStyle(
                                    fontSize: 11,
                                    decorationStyle: TextDecorationStyle.dashed,
                                    decoration: TextDecoration.underline,
                                  )),
                              Text("maximum : ${formatter.format(max)}\$",
                                  style: TextStyle(
                                    fontSize: 11,
                                    decorationStyle: TextDecorationStyle.dashed,
                                    decoration: TextDecoration.underline,
                                  )),
                            ],
                          ),
                          Text(
                              "Avg price of property : " +
                                  formatter.format(adding_price).toString() +
                                  "\$",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                decorationStyle: TextDecorationStyle.dashed,
                                decoration: TextDecoration.underline,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -5,
                    right: -1,
                    child: IconButton(
                      alignment: Alignment.topRight,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Colors.redAccent,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : showDialog(
            context: context,
            builder: (context) => AlertDialog(
                alignment: Alignment.topCenter,
                contentPadding: const EdgeInsets.only(top: 1),
                content: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 800,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Residential",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 220, 221, 223),
                                boxShadow: const [
                                  BoxShadow(blurRadius: 1, color: Colors.grey)
                                ],
                                border: Border.all(
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Avg = ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text("${formatter.format(C_avg)}\$",
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 242, 11, 134)))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Min = ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text("${formatter.format(maxSqm2)}\$",
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 242, 11, 134)))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Max = ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text("${formatter.format(minSqm2)}\$",
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 242, 11, 134)))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              "Commercial",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 220, 221, 223),
                                border: Border.all(
                                  width: 0.2,
                                ),
                                boxShadow: const [
                                  BoxShadow(blurRadius: 1, color: Colors.grey)
                                ],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Avg = ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text("${formatter.format(R_avg)}\$",
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 242, 11, 134)))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Min = ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text("${formatter.format(maxSqm1)}\$",
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 242, 11, 134)))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Max = ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text("${formatter.format(minSqm1)}\$",
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 242, 11, 134)))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              ' $commune /  $district',
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -5,
                        right: -1,
                        child: IconButton(
                          alignment: Alignment.topRight,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: Colors.redAccent,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
  }

  ///converts `address` to actual `coordinates` using google map api
  Future<void> getLatLang(String adds) async {
    try {
      final address = await geocoder.findAddressesFromQuery(adds);
      var message = address.first.coordinates.toString();
      latitude = address.first.coordinates.latitude!;
      longitude = address.first.coordinates.longitude!;
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 10)));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOMETING WENT WRONG\nDID YOU ADD API KEY '),
        ),
      );
      rethrow;
    }
  }

  Future<void> Find_by_piont(double la, double lo, BuildContext context) async {
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
                print("district : " + district + "\n");
                widget.get_district(jsonResponse['results'][j]
                    ['address_components'][i]['short_name']);
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                check_sk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
                print("commune : " + commune + "\n");
                widget.get_commune(jsonResponse['results'][j]
                    ['address_components'][i]['short_name']);
              });
            }
          }
        }
      }
      if (groupValue == 1) {
        final response_rc = await http.get(Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/check_price?Khan_Name=${district.toString()}&Sangkat_Name=${commune.toString()}'));
        var jsonResponse_rc = json.decode(response_rc.body);

        setState(() {
          maxSqm1 = double.parse(
              jsonResponse_rc['residential'][0]['Min_Value'].toString());
          minSqm1 = double.parse(
              jsonResponse_rc['residential'][0]['Max_Value'].toString());
          maxSqm2 = double.parse(
              jsonResponse_rc['commercial'][0]['Min_Value'].toString());
          minSqm2 = double.parse(
              jsonResponse_rc['commercial'][0]['Max_Value'].toString());
          R_avg = (double.parse(maxSqm1.toString()) +
                  double.parse(minSqm1.toString())) /
              2;
          C_avg = (double.parse(maxSqm2.toString()) +
                  double.parse(minSqm2.toString())) /
              2;
          // widget.get_max1!(maxSqm1);
          // widget.get_min1!(minSqm1);
          // widget.get_max2!(maxSqm2);
          // widget.get_min2!(minSqm2);
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  alignment: Alignment.topCenter,
                  contentPadding: const EdgeInsets.only(top: 1),
                  content: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 800,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/looo.png',
                                  height: 40,
                                  width: 120,
                                ),
                                SizedBox(height: 5),
                                const Text(
                                  "Residential",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 220, 221, 223),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 1, color: Colors.grey)
                                    ],
                                    border: Border.all(
                                      width: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text("Avg = ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text("${formatter.format(C_avg)}\$",
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 242, 11, 134)))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              const Text("Min = ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  "${formatter.format(maxSqm2)}\$",
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 242, 11, 134)))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("Max = ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  "${formatter.format(minSqm2)}\$",
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 242, 11, 134)))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  "Commercial",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 220, 221, 223),
                                    border: Border.all(
                                      width: 0.2,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 1, color: Colors.grey)
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text("Avg = ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text("${formatter.format(R_avg)}\$",
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 242, 11, 134)))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              const Text("Min = ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  "${formatter.format(maxSqm1)}\$",
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 242, 11, 134)))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("Max = ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  "${formatter.format(minSqm1)}\$",
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 242, 11, 134)))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  ' $commune /  $district',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 10),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: -5,
                          right: -1,
                          child: IconButton(
                            alignment: Alignment.topRight,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Colors.redAccent,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )));
          // Future.delayed(const Duration(seconds: 3), () async {
          //   return () =>
          // });
        });
        // ignore: use_build_context_synchronously
      }
    } else {
      print(response.statusCode);
    }
  }

  dynamic R_avg, C_avg;
}
