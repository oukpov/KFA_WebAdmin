// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pdf/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_admin/getx/Auth/Auth_agent.dart';
import '../../../../../../models/search_model.dart';
import '../../../../../components/ApprovebyAndVerifyby.dart';
import '../../../../Customs/ProgressHUD.dart';
import '../../../../Widgets/printer_com.dart';
import '../../../../Widgets/searchProperty.dart';
import '../../../../components/DropdownOption.dart';
import '../../../../components/colors.dart';
import '../../../../components/land.dart';
import '../../../../components/property35.dart';
import '../../../../components/raod_type.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../screen/Property/FirstProperty/component/Colors/appbar.dart';
import '../../../../screen/Property/Map/streetview_map.dart';
import '../../Customer/component/date_customer.dart';
import 'edit_comparable_new_page.dart';

class AddComparable extends StatefulWidget {
  const AddComparable(
      {super.key,
      required this.type,
      required this.addNew,
      required this.listlocalhosts});

  final OnChangeCallback type;
  final OnChangeCallback addNew;
  final List listlocalhosts;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AddComparable> {
  double panelHeightOpen = 0;
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  final Set<Marker> listMarkerIds = {};
  double latitude = 11.5489;
  double longitude = 104.9214;
  LatLng latLng = const LatLng(11.5489, 104.9214);
  String address = "";
  List<Marker> markers = [];
  List list = [];
  String sendAddrress = '';
  List data = [];
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

  List listRaod = [];
  List<String> listTypeRaodData = [];
  raodList(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listRaod', list);
    setState(() {
      listTypeRaodData = list;
      listRaod = list
          .map((item) => json.decode(item))
          .cast<Map<String, dynamic>>()
          .toList();
    });
  }

  void onMapTapped(double lat, double log) {
    LatLng position = const LatLng(11.5489, 104.9214);
    setState(() {
      if (lat > log) {
        position = LatLng(log, lat);
      } else {
        position = LatLng(lat, log);
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenStreetView(
          initialPosition: position,
        ),
      ),
    );
  }

  Future<void> _loadStringList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listTypeRaodData = prefs.getStringList('listRaod') ?? [];
      // listlocalhost = prefs.getStringList('localhost') ?? [];
      listagentData = prefs.getStringList('agentlist') ?? [];
      listpropertytData = prefs.getStringList('propertyList') ?? [];

      listRaod = listTypeRaodData
          .map((item) => json.decode(item))
          .cast<Map<String, dynamic>>()
          .toList();
      listagents = listagentData
          .map((item) => json.decode(item))
          .cast<Map<String, dynamic>>()
          .toList();
      listProperty = listpropertytData
          .map((item) => json.decode(item))
          .cast<Map<String, dynamic>>()
          .toList();
    });
    if (listTypeRaodData.isEmpty) {
      roadModel();
    }

    if (listagentData.isEmpty) {
      agentList();
    } else {
      for (int i = 0; i < listagents.length; i++) {
        listvalueModel.add(listagents[i]);
      }
    }
    if (listpropertytData.isEmpty) {
      propertyList();
    } else {
      for (int i = 0; i < listProperty.length; i++) {
        listPropertyModel.add(listProperty[i]);
      }
    }
    topAgent();
    getAPI();
  }

  List listRaodNBorey = [
    {"road_id": 1, "road_name": "Main Roads"},
    {"road_id": 2, "road_name": "Sub Road"},
  ];
  List listRaodBorey = [
    {"road_id": 38, "road_name": "Borey Residential"},
    {"road_id": 39, "road_name": "Borey Commercial"},
  ];
  bool waitingCheck = false;
  bool waitingCheckFull = false;
  List<Map<dynamic, dynamic>> listvalueModel = [];
  List listagents = [];
  List<String> listagentData = [];
  Future<void> agentList() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/agent/list',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data;
      setState(() {
        listagentData = responseData.map((item) => json.encode(item)).toList();
        agentListlocal(listagentData);
      });
    }
  }

  Authentication authentication = Authentication();

  int countwaiting = 0;
  int countwaitingfull = 0;
  List<Map<dynamic, dynamic>> listPropertyModel = [];
  List listProperty = [];
  List<String> listpropertytData = [];
  Future<void> propertyList() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/properties_dropdown',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data;
      setState(() {
        listpropertytData =
            responseData.map((item) => json.encode(item)).toList();
        propertyListlocal(listpropertytData);
      });
    }
  }

  agentListlocal(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('agentlist', list);
    setState(() {
      listagentData = list;
      listagents = list
          .map((item) => json.decode(item))
          .cast<Map<String, dynamic>>()
          .toList();
      for (int i = 0; i < listagents.length; i++) {
        listvalueModel.add(listagents[i]);
      }
    });
  }

  propertyListlocal(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('propertyList', list);
    setState(() {
      listpropertytData = list;
      listProperty = list
          .map((item) => json.decode(item))
          .cast<Map<String, dynamic>>()
          .toList();
      for (int i = 0; i < listProperty.length; i++) {
        listPropertyModel.add(listagents[i]);
      }
    });
  }

  Future<void> roadModel() async {
    var headers = {'Content-Type': 'application/json'};

    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/road',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data['roads'];
      setState(() {
        listTypeRaodData =
            responseData.map((item) => json.encode(item)).toList();
        typeRaod(listTypeRaodData);
      });
    }
  }

  typeRaod(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listTypeRaod', list);
    setState(() {
      listTypeRaodData = list;
      listRaod = list
          .map((item) => json.decode(item))
          .cast<Map<String, dynamic>>()
          .toList();
    });
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

  bool checkProperty = false;
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

  bool checkList = false;
  late String autoverbalType;
  final TextEditingController priceController = TextEditingController();
  final TextEditingController totalPrice = TextEditingController();
  final TextEditingController totalPriceSqm = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController pricepersqm = TextEditingController();
  final TextEditingController totalland = TextEditingController();
  final TextEditingController askingPricett = TextEditingController();
  final TextEditingController offerredPrice = TextEditingController();
  final TextEditingController floorcontroller = TextEditingController();
  final TextEditingController latcontroller = TextEditingController();
  final TextEditingController logcontroller = TextEditingController();
  final TextEditingController province = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController commune = TextEditingController();
  @override
  void dispose() {
    totalPrice.dispose();
    searchMap.dispose();
    priceController.dispose();
    offerredPrice.dispose();
    super.dispose();
    distanceController.dispose();
  }

  var chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  String randomString(int strlen) {
    Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < strlen; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

  @override
  void initState() {
    verbalID = "${widget.listlocalhosts[0]['agency']}${randomString(9)}";

    _handleLocationPermission();
    _loadStringList();
    listOptin = listRaodNBorey;
    roadList = listRaodNBorey;
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

  bool watingList = false;
  List listcom = [];

  Future<void> waitinggetList(url) async {
    setState(() {
      watingList = true;
    });
    await Future.wait([getlist(url)]);
    setState(() {
      watingList = false;
    });
  }

  Future<void> getlist(url) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/$url/${widget.listlocalhosts[0]['agency']}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listcom = jsonDecode(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      color: const Color.fromARGB(255, 0, 49, 212),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: _uiSteup(context),
    );
  }

  bool fullScreen = false;
  Widget _uiSteup(BuildContext context) {
    panelHeightOpen = (groupValue == 0)
        ? MediaQuery.of(context).size.height * 0.35
        : MediaQuery.of(context).size.height * 0.15;
    return Scaffold(
      body: fullScreen
          ? fullTable()
          : (refrech
              ? const Center(child: CircularProgressIndicator())
              : mapShow()),
    );
  }

  bool searchBool = false;
  String comparedropdown = '';
  String comparedropdown2 = '';
  int groupValue = 0;
  bool isChecked = false;
  bool isChecked_all = false;
  var id_route;
  String? remark;
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

  Future<void> mainsearch() async {
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search/place/mapUse?query=${searchMap.text}'));
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
        // print('No.1');
        findlocation(LatLng(
            double.parse(requestModel.lat), double.parse(requestModel.lng)));
        // getAddress(latLng);
        // Show(requestModel);
      } else if (comparedropdown2 != "" && typedrawerSe == false) {
        // print('No.3');

        maincheck();
        getAddress(latLng);
        Show(requestModel);
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
      // points.clear();
      // polygons.clear();
      markers.clear();
    });
  }

  int? propertyID;
  int? agentID;
  int? roadID;
  BitmapDescriptor? customIcon;
  bool clickMap = false;
  Future<void> addManyMarkers(LatLng latLng) async {
    if (checkpoint == false) {
      // clearMarkers();
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(40, 40)),
              'assets/images/pin.png')
          .then((d) {
        customIcon = d;
      });

      final int markerCount = markers.length;
      final MarkerId markerId = MarkerId(markerCount.toString());
      Marker marker = Marker(
        markerId: markerId,
        position: latLng,
        icon: customIcon ?? BitmapDescriptor.defaultMarker,
        onDragEnd: (value) {
          latLng = value;
        },
      );

      setState(() {
        markers.add(marker);
        listMarkerIds.add(marker);
        _createPolygon();

        LatLng centroid = _calculatePolygonCentroid(
            markers.map((marker) => marker.position).toList());
        requestModel.lat = centroid.latitude.toString();
        requestModel.lng = centroid.longitude.toString();
        haveValue = false;
        clickMap == false;
      });
    }
  }

  String? start;
  String? end;
  int? agenttypeid;
  int? comparableroad;
  int? comparablepropertyid;
  bool search = false;
  Future<void> searchDate() async {
    var headers = {'Content-Type': 'application/json'};
    var dio = Dio();

    // Filter out null values from query parameters
    var queryParams = {
      if (start != null) "start": start,
      if (end != null) "end": end,
      if (propertyID != null) "comparable_property_id": propertyID,
      if (agentID != null) "agenttype_id": agentID,
      if (roadID != null) "comparable_road": roadID,
    };

    try {
      var response = await dio.get(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable/date/search',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        setState(() {
          listcom = jsonDecode(json.encode(response.data));
        });
      } else {
        print('Error: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> searchWaiting() async {
    setState(() {
      search = true;
    });
    if (controllSearch.text == "") {
      await Future.wait([searchDate()]);
    } else {
      await Future.wait([searchLike()]);
    }

    setState(() {
      search = false;
    });
  }

  Future<void> searchLike() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable_searchUse?search=${controllSearch.text}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listcom = jsonDecode(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  bool dropRestart = false;
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

  List roadList = [
    // {"road_id": 1, "road_name": "Main Road"},
    // {"road_id": 2, "road_name": "Sub Road"}
  ];
  bool viewMap = false;
  TextEditingController controllSearch = TextEditingController();
  int indexland = 0;
  Widget fullTable() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        fullScreen = false;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: greyColor,
                      size: 25,
                    )),
              ),
              const SizedBox(width: 10),
              Text(
                "Borey",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: !checkVerbal ? colorsRed : greyColor,
                    fontSize: 14),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      doneORudone = !doneORudone;
                      waitingCheckFull = true;
                      // checkboreyTP = !checkboreyTP;
                      if (!doneORudone) {
                        checkborey = 0;
                        roadList = listRaodNBorey;
                      } else {
                        checkborey = 1;
                        roadList = listRaodBorey;
                      }
                      _timer = Timer.periodic(const Duration(seconds: 1),
                          (Timer timer) async {
                        setState(() {
                          countwaitingfull++;
                        });

                        if (countwaitingfull >= 1) {
                          _timer.cancel();
                          waitingCheckFull = false;
                        }
                      });
                    });
                  },
                  icon: Icon(doneORudone
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank)),
              const SizedBox(width: 50),
              waitingCheckFull
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        width: 150,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          onChanged: (newValue) {
                            setState(() {
                              roadID = int.parse(newValue!);
                            });
                          },
                          items: roadList
                              .map<DropdownMenuItem<String>>(
                                (value) => DropdownMenuItem<String>(
                                  value: value["road_id"].toString(),
                                  child: Text(value["road_name"]),
                                ),
                              )
                              .toList(),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: kImageColor,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            fillColor: kwhite,
                            filled: true,
                            labelText: "Raod",
                            hintText: 'Select one',
                            prefixIcon: const Icon(
                              Icons.edit_road_outlined,
                              color: kImageColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: kPrimaryColor, width: 2.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1,
                                color: kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownOption(
                  icon: Icons.real_estate_agent_outlined,
                  dataid: "property_type_id",
                  dataname: "property_type_name",
                  listData: listPropertyModel,
                  lable: "PropertyType",
                  value: (value) {
                    setState(() {
                      propertyID = int.parse(value);
                    });
                  },
                  valuenameback: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownOption(
                  icon: Icons.support_agent_outlined,
                  dataid: "agenttype_id",
                  dataname: "agenttype_name",
                  listData: listvalueModel,
                  lable: "Agent",
                  value: (value) {
                    setState(() {
                      agentID = int.parse(value);
                      print("Agent => $agentID");
                    });
                  },
                  valuenameback: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DateExpaned(
                    value: (value) {
                      setState(() {
                        start = value;
                      });
                    },
                    filedname: "Start"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DateExpaned(
                    value: (value) {
                      setState(() {
                        end = value;
                      });
                    },
                    filedname: "End"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  width: 250,
                  child: TextFormField(
                    controller: controllSearch,
                    decoration: InputDecoration(
                      fillColor: kwhite,
                      filled: true,
                      labelText: "Search",
                      labelStyle: const TextStyle(color: kTextLightColor),
                      prefixIcon: const Icon(Icons.search, color: kImageColor),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      searchWaiting();
                    },
                    child: Icon(Icons.search, color: whiteColor, size: 30)),
              ),
              const SizedBox(width: 20)
            ],
          ),
          search
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: whiteColor),
                  ),
                  child: PaginatedDataTable(
                    horizontalMargin: 5.0,
                    arrowHeadColor: Colors.blueAccent[300],
                    columns: [
                      for (int i = 0; i < listTitle.length; i++)
                        DataColumn(
                          label: Text(
                            listTitle[i]['title'].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color.fromARGB(255, 5, 11, 67)),
                          ),
                        ),
                    ],
                    dataRowHeight: 40,
                    rowsPerPage: on_row,
                    onRowsPerPageChanged: (value) {
                      setState(() {
                        on_row = value!;
                      });
                    },
                    source: _DataSource(
                        listBlock: authentication.listblock,
                        listlocalhosts: widget.listlocalhosts,
                        checklocation: (value) {
                          setState(() {
                            fullScreen = false;
                            var indexs = value;
                            if (indexs != null) {
                              listMarkerIds.clear();
                              data_adding_correct = [listcom[indexs]];
                              Future.delayed(const Duration(seconds: 2), () {
                                if (data_adding_correct.isNotEmpty) {
                                  if (data_adding_correct[0]
                                              ['comparable_property_id']
                                          .toString() ==
                                      '15') {
                                    markerType(0, 'l.png');
                                  } else if (data_adding_correct[0]
                                              ['comparable_property_id']
                                          .toString() ==
                                      '10') {
                                    markerType(0, 'f.png');
                                  } else if (data_adding_correct[0]
                                              ['comparable_property_id']
                                          .toString() ==
                                      '33') {
                                    markerType(0, 'v.png');
                                  } else if (data_adding_correct[0]
                                              ['comparable_property_id']
                                          .toString() ==
                                      '14') {
                                    markerType(0, 'h.png');
                                  } else if (data_adding_correct[0]
                                              ['comparable_property_id']
                                          .toString() ==
                                      '4') {
                                    markerType(0, 'b.png');
                                  } else if (data_adding_correct[0]
                                              ['comparable_property_id']
                                          .toString() ==
                                      '29') {
                                    markerType(0, 'v.png');
                                  } else {
                                    markerType(0, 'a.png');
                                  }
                                  mapController?.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                              target: LatLng(
                                                  data_adding_correct[0]
                                                      ['latlong_log'],
                                                  data_adding_correct[0]
                                                      ['latlong_la']),
                                              zoom: 20)));
                                }
                              });
                            }
                          });
                        },
                        context: context,
                        count_row: listcom.length,
                        data: listcom,
                        listback: (value) {},
                        setStateCallback: _setState,
                        userID: widget.listlocalhosts[0]['agency'].toString()),
                  ),
                ),
        ],
      ),
    );
  }

  List listOptin = [];
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
  String checkdropdown = '';
  List listBuilding = [];
  bool boreybutton = false;
  bool checkcalculate = false;
  bool checkcalculateBuilding = false;
  Future<void> calculate() async {
    setState(() {
      double askingPrice = double.tryParse(askingPricett.text) ?? 0;
      // double totalPrice = double.tryParse(totalPriceSqm.text) ?? 0;
      double totalLand = double.tryParse(totalland.text) ?? 1.0;
      double pricepersqmN = double.tryParse(pricepersqm.text) ?? 0;
      if (!checkcalculate) {
        //Asking Price
        double pricepersqmresult = askingPrice / totalLand;
        pricepersqm.text = pricepersqmresult.toStringAsFixed(0);
      } else if (pricepersqmN != 0) {
        //Asking PriceTT
        double askingPricettresult = totalLand * pricepersqmN;
        askingPricett.text = askingPricettresult.toStringAsFixed(0);
      }
    });
  }

  void calculatebuilding() {
    setState(() {
      double totolprice = double.tryParse(totalPrice.text) ?? 0.0;
      double offeredPrice = double.tryParse(offerredPrice.text) ?? 0.0;
      double totalPriceSqmN = double.tryParse(totalPriceSqm.text) ?? 1;
      //Sould Out Price
      if (!checkcalculateBuilding) {
        double result = (totolprice * offeredPrice);
        totalPriceSqm.text = result.toStringAsFixed(0);
      } else {
        //Offerred Price
        double result = (totalPriceSqmN / totolprice);
        offerredPrice.text = result.toStringAsFixed(0);
      }
    });
  }

  int? comparablePropertyID;
  int? comparableRoad;
  double? comparableLandLength;
  double? comparableLandWidth;
  double? comparableLandTotal;
  double? comparableAddingPrice;
  double? comparableboughtprice;
  double? comparableSoldLength;
  double? comparableSoldWidth;
  double? comparableSoldTotal;
  double? comparableAmount;
  String? comparablePhone;
  double? latlongLog;
  double? latlongLa;
  // List<String> listlocalhost = [];
  // List widget.listlocalhosts = [];
  int? protectID;

  // loginLocal(List<String> list) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('localhost', list);
  //   setState(() {
  //     listlocalhost = list;
  //     widget.listlocalhosts = list.map((element) => element.toString()).toList();
  //   });
  // }

  // void firstLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     listlocalhost = prefs.getStringList('localhost') ?? [];
  //     widget.listlocalhosts = listlocalhost
  //         .map((item) => json.decode(item))
  //         .cast<Map<String, dynamic>>()
  //         .toList();
  //   });
  // }

  // String username = '';
  // // String password = '';
  // Future<void> login() async {
  //   var headers = {'Content-Type': 'application/json'};
  //   var data = json.encode({"username": username, "password": password});
  //   var dio = Dio();
  //   var response = await dio.request(
  //     'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/login/KFA',
  //     options: Options(
  //       method: 'POST',
  //       headers: headers,
  //     ),
  //     data: data,
  //   );

  //   if (response.statusCode == 200) {
  //     var responseData = response.data;
  //     setState(() {
  //       checkemail = responseData['success'];

  //       widget.listlocalhosts = response.data['user'];
  //       checkemails(checkemail);
  //       listlocalhost =
  //           widget.listlocalhosts.map((item) => json.encode(item)).toList();
  //       loginLocal(listlocalhost);
  //     });
  //   } else {
  //     print(response.statusMessage);
  //   }
  // }

  bool checksave = false;
  int count = 0;
  late Timer _timer;
  void main(int second) async {
    count = 0;
    checksave = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      setState(() {
        if (timer.isActive) {
          count++;
        }
        if (count == second) {
          _timer.cancel();
          checksave = false;
        }
      });
    });
  }

  Future<void> addComparable() async {
    protectID = int.parse(
        "${widget.listlocalhosts[0]['agency']}${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(100)}");
    // print('protectID => $protectID');
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "comparable_property_id": comparablePropertyID,
      "comparable_road": comparableRoad,
      "protectID": protectID,
      "comparable_land_length": comparableLandLength,
      "borey": checkborey,
      "comparable_land_width": comparableLandWidth,
      "comparable_land_total": comparableLandTotal,
      "comparable_adding_price":
          (pricepersqm.text == '') ? null : pricepersqm.text,
      "comparableAmount":
          (askingPricett.text == '') ? null : askingPricett.text,
      "comparable_sold_length": comparableSoldLength,
      "comparable_sold_width": comparableSoldWidth,
      "comparable_sold_total": (totalPrice.text == '') ? null : totalPrice.text,
      "comparable_sold_price":
          (totalPriceSqm.text == '') ? null : totalPriceSqm.text,
      "comparableaddprice":
          (offerredPrice.text == '') ? null : offerredPrice.text,
      "comparable_phone": comparablePhone,
      "latlong_log": latcontroller.text,
      "latlong_la": logcontroller.text,
      "comparabl_user": widget.listlocalhosts[0]['agency'].toString(),
      "comparable_remark": remark,
      "province": province.text,
      "district": district.text,
      "commune": commune.text,
      "comparable_floor":
          (floorcontroller.text == '') ? null : floorcontroller.text,
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/add/comparableAgent',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        "Done",
        "Post Successfuly",
        colorText: Colors.black,
        padding:
            const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
        borderColor: const Color.fromARGB(255, 48, 47, 47),
        borderWidth: 1.0,
        borderRadius: 5,
        backgroundColor: const Color.fromARGB(255, 235, 242, 246),
        icon: const Icon(Icons.add_alert),
      );
      refrechValue();
      setState(() {
        countCredit = countCredit + 1;
      });
    } else {
      print(response.statusMessage);
    }
  }

  List listOwner = [];
  Future<void> getOwner(id) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/owner/$id',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listOwner = jsonDecode(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  List totally = [
    {
      'numer_id': 1,
      'type': 'Totally',
    },
    {
      'numer_id': 2,
      'type': 'Sqm',
    }
  ];
  bool checkboreyTP = false;
  int checkborey = 0;
  int ls = 0;
  int boreyvalue = 0;
  bool refrech = false;
  Future<void> refrechValue() async {
    setState(() {
      refrech = true;
    });
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        refrech = false;
      });
    });
    setState(() {
      comparablePropertyID = null;
      comparableRoad = null;
      comparableLandLength = null;
      comparableLandWidth = null;
      comparableLandTotal = null;
      comparableAddingPrice = null;
      comparableboughtprice = null;
      comparableSoldLength = null;
      comparableSoldWidth = null;
      comparableSoldTotal = null;
      comparableAmount = null;
      comparablePhone = null;
      latlongLog = null;
      latlongLa = null;
      priceController.clear();
      totalPrice.clear();
      totalPriceSqm.clear();
      pricepersqm.clear();
      totalland.clear();
      askingPricett.clear();
      offerredPrice.clear();
      floorcontroller.clear();
      latcontroller.clear();
      logcontroller.clear();
      ls = 0;
    });
  }

  int countCredit = 0;
  int top = 0;
  Future<void> getAPI() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/credit_Agent/${widget.listlocalhosts[0]['agency']}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        countCredit = jsonDecode(json.encode(response.data))['credit'];
        top = jsonDecode(json.encode(response.data))['No'];
        checktop = true;
      });
    } else {
      print(response.statusMessage);
    }
  }

  bool checktop = false;
  List listTop = [];
  Future<void> topAgent() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/topagent',
      options: Options(
        method: 'GET',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      setState(() {
        listTop = jsonDecode(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  List icontop = [
    {'icon': 'no1.png'},
    {'icon': 'no2.png'},
    {'icon': 'no3.png'},
    {'icon': 'no4.png'},
    {'icon': 'no5.png'},
    {'icon': 'no6.png'},
    {'icon': 'no7.png'},
    {'icon': 'no8.png'},
    {'icon': 'no9.png'},
    {'icon': 'no10.png'}
  ];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool checkpricepersqm = false;
  bool checkraod = false;
  bool checkownerphone = false;
  bool checklat = false;
  bool checklog = false;
  bool checkaskingPrice = false;
  bool checkdelete = false;
  List listTitle = [
    {"title": "No"},
    {"title": "Action"},
    {"title": "Property Type"},
    {"title": "Land Size"},
    {"title": "Building Size"},
    {"title": "Asking"},
    {"title": "Offered"},
    {"title": "Bought"},
    {"title": "Sold Out"},
    {"title": "Location"},
    {"title": "Agency"},
    {"title": "Code"},
    {"title": "Survey Date"},
  ];
  void _setState(VoidCallback fn) {
    setState(fn);
  }

  int on_row = 20;

  Widget mapShow() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Row(
            children: [
              Container(
                color: appback,
                height: MediaQuery.of(context).size.height,
                width: 750,
                child: SingleChildScrollView(
                    child: Stack(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: 500,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30, left: 30),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  IconButton(
                                      onPressed: () {
                                        // widget.type(100);
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: whiteColor,
                                        size: 25,
                                      )),
                                  const SizedBox(height: 10),
                                  if (checktop)
                                    Row(
                                      children: [
                                        if (top < 10)
                                          Image.asset(
                                            'assets/icons/${icontop[top - 1]['icon']}',
                                            height: 80,
                                            fit: BoxFit.fitHeight,
                                          )
                                        else
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: greyColorNolots,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                top.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                    color: blackColor),
                                              ),
                                            ),
                                          ),
                                        const SizedBox(width: 10),
                                        Text(
                                          '($countCredit)',
                                          style: TextStyle(
                                            color: colorsRed,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          '${widget.listlocalhosts[0]['username']}',
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 17,
                                          ),
                                        ),
                                        const Spacer(),
                                        const SizedBox(width: 5),
                                        Text(
                                          "View Map  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: !checkVerbal
                                                  ? colorsRed
                                                  : greyColor,
                                              fontSize: 14),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                doneORudone = !doneORudone;
                                                viewMap = !viewMap;
                                              });
                                            },
                                            icon: Icon(
                                                viewMap
                                                    ? Icons.check_box_outlined
                                                    : Icons
                                                        .check_box_outline_blank,
                                                color: whiteColor)),
                                        const SizedBox(width: 10),
                                        watingList
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    checkdelete = !checkdelete;
                                                  });
                                                  await authentication
                                                      .blockAgent();
                                                  if (checkdelete) {
                                                    await waitinggetList(
                                                        'getComparableNew');
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.change_circle,
                                                  color: Color.fromARGB(
                                                      255, 77, 230, 82),
                                                  size: 30,
                                                ))
                                      ],
                                    ),
                                  Row(
                                    children: [
                                      Text(
                                        "Search by Latitude and Longitude",
                                        style: TextStyle(
                                            color: whiteColor, fontSize: 15),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          addMarker(latLng);
                                          getAddress(latLng);
                                          Show(requestModel);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: colorsRed,
                                              border: Border.all(
                                                  width: 2, color: whiteColor)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.map_outlined,
                                                color: whiteColor,
                                                size: 20,
                                              ),
                                              Text(
                                                '  Check Comparable',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: whiteColor,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
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
                                                onTap: () {},
                                                onFieldSubmitted: (value) {
                                                  setState(() {
                                                    if (j == 0) {
                                                      requestModel.lat =
                                                          value.toString();
                                                      latcontroller.text =
                                                          value.toString();
                                                    } else {
                                                      requestModel.lng =
                                                          value.toString();
                                                      logcontroller.text =
                                                          value.toString();
                                                    }
                                                  });
                                                },
                                                onChanged: (value) async {
                                                  setState(() {
                                                    maincheck();
                                                    if (j == 0) {
                                                      requestModel.lat =
                                                          value.toString();
                                                      latcontroller.text =
                                                          value.toString();
                                                    } else {
                                                      requestModel.lng =
                                                          value.toString();
                                                      logcontroller.text =
                                                          value.toString();
                                                    }
                                                  });
                                                  await findlocation(LatLng(
                                                      double.parse(
                                                          requestModel.lat),
                                                      double.parse(
                                                          requestModel.lng)));
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
                                                              getAddress(LatLng(
                                                                  double.parse(
                                                                      requestModel
                                                                          .lat),
                                                                  double.parse(
                                                                      requestModel
                                                                          .lng)));
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
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                  const SizedBox(height: 20),
                                  if (!checkdelete)
                                    Text(
                                      'PropertyType *',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorsRed,
                                          fontSize: 15),
                                    )
                                  else
                                    Row(
                                      children: [
                                        Text(
                                          'Comparable List',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: colorsRed,
                                              fontSize: 15),
                                        ),
                                        const Spacer(),
                                        Text(
                                          !checkList
                                              ? 'Your New Data  '
                                              : 'Your All Data  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: whiteColor,
                                              fontSize: 15),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                checkList = !checkList;
                                                if (checkList) {
                                                  waitinggetList(
                                                      'getComparable');
                                                } else {
                                                  waitinggetList(
                                                      'getComparableNew');
                                                }
                                              });
                                            },
                                            icon: Icon(!checkList
                                                ? Icons.check_box_outlined
                                                : Icons
                                                    .check_box_outline_blank_rounded),
                                            color: whiteColor),
                                        Text(
                                          'Full  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: whiteColor,
                                              fontSize: 15),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                fullScreen = true;
                                              });
                                              await authentication.blockAgent();
                                            },
                                            icon: Icon(
                                              Icons
                                                  .screen_search_desktop_outlined,
                                              size: 30,
                                              color: whiteColor,
                                            ))
                                      ],
                                    ),
                                  const SizedBox(height: 5),
                                  if (!checkdelete)
                                    propertyType(
                                      lable: "PropertyType *",
                                      value: (value) {
                                        setState(() {
                                          ls = int.parse(value!);
                                          comparablePropertyID =
                                              int.parse(value);
                                        });
                                      },
                                      valueName: "PropertyType *",
                                      valuenameback: (value) {},
                                    ),
                                  if (!checkdelete) const SizedBox(height: 10),
                                  if (ls != 0 && !checkdelete)
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              width: 2, color: whiteColor)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                //CheckBorey
                                                Text(
                                                  'Borey  ',
                                                  style: TextStyle(
                                                      color: whiteColor,
                                                      fontSize: 15),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        waitingCheck = true;
                                                        checkboreyTP =
                                                            !checkboreyTP;
                                                        if (!checkboreyTP) {
                                                          checkborey = 0;
                                                          listOptin =
                                                              listRaodNBorey;
                                                        } else {
                                                          checkborey = 1;
                                                          listOptin =
                                                              listRaodBorey;
                                                        }
                                                        _timer = Timer.periodic(
                                                            const Duration(
                                                                seconds: 1),
                                                            (Timer
                                                                timer) async {
                                                          setState(() {
                                                            countwaiting++;
                                                          });

                                                          if (countwaiting >=
                                                              1) {
                                                            _timer.cancel();
                                                            waitingCheck =
                                                                false;
                                                          }
                                                        });
                                                      });
                                                    },
                                                    icon: Icon(
                                                        !checkboreyTP
                                                            ? Icons
                                                                .check_box_outline_blank_outlined
                                                            : Icons
                                                                .check_box_outlined,
                                                        size: 25,
                                                        color: whiteColor),
                                                    color: whiteColor),
                                                const Spacer(),
                                                const SizedBox(width: 10),
                                                checksave
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : InkWell(
                                                        onTap: () async {
                                                          // if (data_adding_correct
                                                          //     .isEmpty) {
                                                          //   Get.snackbar(
                                                          //     'Please Check Frist on Map',
                                                          //     "",
                                                          //     colorText:
                                                          //         Colors.black,
                                                          //     padding:
                                                          //         const EdgeInsets
                                                          //                 .only(
                                                          //             right: 50,
                                                          //             left: 50,
                                                          //             top: 20,
                                                          //             bottom:
                                                          //                 20),
                                                          //     borderColor:
                                                          //         const Color
                                                          //                 .fromARGB(
                                                          //             255,
                                                          //             48,
                                                          //             47,
                                                          //             47),
                                                          //     borderWidth: 1.0,
                                                          //     borderRadius: 5,
                                                          //     backgroundColor:
                                                          //         const Color
                                                          //                 .fromARGB(
                                                          //             255,
                                                          //             235,
                                                          //             242,
                                                          //             246),
                                                          //     icon: const Icon(
                                                          //         Icons
                                                          //             .add_alert),
                                                          //   );
                                                          // } else {
                                                          if (validateAndSave()) {
                                                            main(10);
                                                            if (totalland
                                                                        .text !=
                                                                    '' &&
                                                                askingPricett
                                                                        .text !=
                                                                    '' &&
                                                                latcontroller
                                                                        .text !=
                                                                    '' &&
                                                                logcontroller
                                                                        .text !=
                                                                    '' &&
                                                                comparableRoad !=
                                                                    null &&
                                                                comparablePhone !=
                                                                    null) {
                                                              await calculate();
                                                              await addComparable();
                                                            } else {
                                                              Get.snackbar(
                                                                'Please Check Requeest*',
                                                                "",
                                                                colorText:
                                                                    Colors
                                                                        .black,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            50,
                                                                        left:
                                                                            50,
                                                                        top: 20,
                                                                        bottom:
                                                                            20),
                                                                borderColor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        48,
                                                                        47,
                                                                        47),
                                                                borderWidth:
                                                                    1.0,
                                                                borderRadius: 5,
                                                                backgroundColor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        235,
                                                                        242,
                                                                        246),
                                                                icon: const Icon(
                                                                    Icons
                                                                        .add_alert),
                                                              );
                                                            }
                                                          }
                                                          // }
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: 40,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  greenColors,
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color:
                                                                      whiteColor)),
                                                          child: Text(
                                                            'Save',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    whiteColor,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      )
                                              ],
                                            ),
                                            if (ls != 0)
                                              Landbuilding(
                                                checkvalidate: true,
                                                title: 'Land',
                                                l: (value) {
                                                  setState(() {
                                                    comparableLandLength =
                                                        value ?? 0;
                                                  });
                                                },
                                                total: (value) {
                                                  setState(() {
                                                    totalland.text =
                                                        value.toString();
                                                    comparableLandTotal =
                                                        double.parse(
                                                            value.toString());
                                                    calculate();
                                                  });
                                                },
                                                w: (value) {
                                                  setState(() {
                                                    comparableLandWidth =
                                                        value ?? 0;
                                                  });
                                                },
                                              ),
                                            const SizedBox(height: 10),
                                            Text("Asking Price",
                                                style: TextStyle(
                                                    color: !checkpricepersqm
                                                        ? whiteColor
                                                        : colorsRed,
                                                    fontSize: 14)),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    height: 40,
                                                    child: TextFormField(
                                                      validator: (value) {
                                                        if (pricepersqm.text ==
                                                                '' ||
                                                            pricepersqm.text ==
                                                                '0') {
                                                          setState(() {
                                                            checkpricepersqm =
                                                                true;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            checkpricepersqm =
                                                                false;
                                                          });
                                                        }
                                                      },
                                                      // readOnly: true,
                                                      controller: pricepersqm,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          checkcalculate = true;
                                                          calculate();
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8),
                                                        prefixIcon: const Icon(
                                                          Icons.payments,
                                                          color: kImageColor,
                                                        ),
                                                        // hintText: 'Price Per SQM',
                                                        fillColor: kwhite,
                                                        filled: true,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color:
                                                                      kPrimaryColor,
                                                                  width: 2.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            width: 1,
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    height: 35,
                                                    child:
                                                        DropdownButtonFormField<
                                                            String>(
                                                      //value: genderValue,
                                                      isExpanded: true,

                                                      onChanged: (newValue) {
                                                        setState(() {});
                                                      },
                                                      items: totally
                                                          .map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                            (value) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                              value: value[
                                                                      "numer_id"]
                                                                  .toString(),
                                                              child: Text(value[
                                                                  "type"]),
                                                              onTap: () {
                                                                setState(() {});
                                                              },
                                                            ),
                                                          )
                                                          .toList(),
                                                      // add extra sugar..
                                                      icon: const Icon(
                                                        Icons.arrow_drop_down,
                                                        color: kImageColor,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8),
                                                        fillColor: kwhite,
                                                        filled: true,
                                                        labelText: 'Select',
                                                        hintText: 'Select',
                                                        prefixIcon: const Icon(
                                                          Icons
                                                              .discount_outlined,
                                                          color: kImageColor,
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color:
                                                                      kPrimaryColor,
                                                                  width: 2.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            width: 1,
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Text("Asking Price(TTAmount)",
                                                style: TextStyle(
                                                    color: !checkaskingPrice
                                                        ? whiteColor
                                                        : colorsRed,
                                                    fontSize: 14)),
                                            const SizedBox(height: 5),
                                            SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                validator: (value) {
                                                  setState(() {
                                                    if (askingPricett.text ==
                                                        '') {
                                                      checkaskingPrice = true;
                                                    } else {
                                                      checkaskingPrice = false;
                                                    }
                                                  });
                                                },
                                                controller: askingPricett,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                onChanged: (value) {
                                                  setState(() {
                                                    checkcalculate = false;
                                                    calculate();
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 10),
                                                  prefixIcon: const Icon(
                                                    Icons
                                                        .question_answer_outlined,
                                                    color: kImageColor,
                                                  ),
                                                  hintText:
                                                      'Asking Price(TTAmount)',
                                                  hintStyle: TextStyle(
                                                      color: greyColorNolots),
                                                  fillColor: kwhite,
                                                  filled: true,
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                kPrimaryColor,
                                                            width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1,
                                                            color:
                                                                kPrimaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text("Road *",
                                                style: TextStyle(
                                                    color: !checkraod
                                                        ? whiteColor
                                                        : colorsRed,
                                                    fontSize: 14)),
                                            const SizedBox(height: 5),
                                            waitingCheck
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : SizedBox(
                                                    height: 45,
                                                    width: double.infinity,
                                                    child: OptionRoadNew(
                                                      pwidth: 250,
                                                      hight: 35,
                                                      list: listOptin,
                                                      valueId: "road_id",
                                                      valueName: "road_name",
                                                      lable: "Road",
                                                      onbackValue: (value) {
                                                        setState(() {
                                                          List<String> parts =
                                                              value!.split(',');

                                                          comparableRoad =
                                                              int.parse(parts[0]
                                                                  .toString());
                                                          print(
                                                              "Route : $comparableRoad");
                                                        });
                                                      },
                                                    ),
                                                  ),
                                            if (comparablePropertyID != 15)
                                              const SizedBox(height: 10),
                                            if (comparablePropertyID != 15)
                                              Landbuilding(
                                                checkvalidate: false,
                                                title: 'Building',
                                                l: (value) {
                                                  setState(() {
                                                    comparableSoldLength =
                                                        value ?? 0;
                                                  });
                                                },
                                                total: (value) {
                                                  setState(() {
                                                    totalPrice.text =
                                                        value.toString();

                                                    comparableSoldTotal =
                                                        double.parse(
                                                            value.toString());
                                                    calculatebuilding();
                                                  });
                                                },
                                                w: (value) {
                                                  setState(() {
                                                    comparableSoldWidth =
                                                        value ?? 0;
                                                  });
                                                },
                                              ),
                                            if (comparablePropertyID != 15)
                                              if (comparablePropertyID != 15)
                                                const SizedBox(height: 10),
                                            if (comparablePropertyID != 15)
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Offered Price",
                                                            style: TextStyle(
                                                                color:
                                                                    whiteColor,
                                                                fontSize: 14)),
                                                        const SizedBox(
                                                            height: 5),
                                                        SizedBox(
                                                          height: 40,
                                                          child: TextFormField(
                                                            controller:
                                                                offerredPrice,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                checkcalculateBuilding =
                                                                    false;
                                                                calculatebuilding();
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          10),
                                                              prefixIcon:
                                                                  const Icon(
                                                                Icons
                                                                    .question_answer_outlined,
                                                                color:
                                                                    kImageColor,
                                                              ),
                                                              hintText:
                                                                  'Offered Price',
                                                              hintStyle: TextStyle(
                                                                  color:
                                                                      greyColorNolots),
                                                              fillColor: kwhite,
                                                              filled: true,
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        width:
                                                                            1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        width:
                                                                            1,
                                                                        color:
                                                                            kPrimaryColor),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        Text("",
                                                            style: TextStyle(
                                                                color:
                                                                    whiteColor,
                                                                fontSize: 14)),
                                                        const SizedBox(
                                                            height: 5),
                                                        SizedBox(
                                                          height: 40,
                                                          child:
                                                              DropdownButtonFormField<
                                                                  String>(
                                                            isExpanded: true,
                                                            onChanged:
                                                                (newValue) {
                                                              setState(() {});
                                                            },
                                                            items: totally
                                                                .map<
                                                                    DropdownMenuItem<
                                                                        String>>(
                                                                  (value) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                    value: value[
                                                                            "numer_id"]
                                                                        .toString(),
                                                                    child: Text(
                                                                        value[
                                                                            "type"]),
                                                                    onTap: () {
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                )
                                                                .toList(),
                                                            // add extra sugar..
                                                            icon: const Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color:
                                                                  kImageColor,
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8),
                                                              fillColor: kwhite,
                                                              filled: true,
                                                              labelText: 'Sqm',
                                                              hintText: 'Sqm',
                                                              prefixIcon:
                                                                  const Icon(
                                                                Icons
                                                                    .discount_outlined,
                                                                color:
                                                                    kImageColor,
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        width:
                                                                            2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      kPrimaryColor,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            if (comparablePropertyID != 15)
                                              const SizedBox(height: 10),
                                            if (comparablePropertyID != 15)
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Sold Out Price",
                                                            style: TextStyle(
                                                                color:
                                                                    whiteColor,
                                                                fontSize: 14)),
                                                        const SizedBox(
                                                            height: 5),
                                                        SizedBox(
                                                          height: 40,
                                                          child: TextFormField(
                                                            controller:
                                                                totalPriceSqm,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                checkcalculateBuilding =
                                                                    true;
                                                                calculatebuilding();
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          10),
                                                              prefixIcon:
                                                                  const Icon(
                                                                Icons
                                                                    .question_answer_outlined,
                                                                color:
                                                                    kImageColor,
                                                              ),
                                                              hintText:
                                                                  'Sold Out Price',
                                                              hintStyle: TextStyle(
                                                                  color:
                                                                      greyColorNolots),
                                                              fillColor: kwhite,
                                                              filled: true,
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        width:
                                                                            1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        width:
                                                                            1,
                                                                        color:
                                                                            kPrimaryColor),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        Text("",
                                                            style: TextStyle(
                                                                color:
                                                                    whiteColor,
                                                                fontSize: 14)),
                                                        const SizedBox(
                                                            height: 5),
                                                        SizedBox(
                                                          height: 40,
                                                          child:
                                                              DropdownButtonFormField<
                                                                  String>(
                                                            //value: genderValue,
                                                            isExpanded: true,
                                                            onChanged:
                                                                (newValue) {
                                                              setState(() {});
                                                            },
                                                            items: totally
                                                                .map<
                                                                    DropdownMenuItem<
                                                                        String>>(
                                                                  (value) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                    value: value[
                                                                            "numer_id"]
                                                                        .toString(),
                                                                    child: Text(
                                                                        value[
                                                                            "type"]),
                                                                    onTap: () {
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                )
                                                                .toList(),
                                                            // add extra sugar..
                                                            icon: const Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color:
                                                                  kImageColor,
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8),
                                                              fillColor: kwhite,
                                                              filled: true,
                                                              labelText: 'Sqm',
                                                              hintText: 'Sqm',
                                                              prefixIcon:
                                                                  const Icon(
                                                                Icons
                                                                    .discount_outlined,
                                                                color:
                                                                    kImageColor,
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        width:
                                                                            2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      kPrimaryColor,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                if (comparablePropertyID !=
                                                        15 &&
                                                    ls != 0)
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Floor",
                                                            style: TextStyle(
                                                                color:
                                                                    whiteColor,
                                                                fontSize: 14)),
                                                        const SizedBox(
                                                            height: 5),
                                                        SizedBox(
                                                          height: 40,
                                                          child: TextFormField(
                                                            controller:
                                                                floorcontroller,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                floorcontroller
                                                                        .text =
                                                                    value;
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          10),
                                                              prefixIcon:
                                                                  const Icon(
                                                                Icons
                                                                    .question_answer_outlined,
                                                                color:
                                                                    kImageColor,
                                                              ),
                                                              hintText: 'Floor',
                                                              hintStyle: TextStyle(
                                                                  color:
                                                                      greyColorNolots),
                                                              fillColor: kwhite,
                                                              filled: true,
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        width:
                                                                            2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        width:
                                                                            1,
                                                                        color:
                                                                            kPrimaryColor),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                if (comparablePropertyID !=
                                                        15 &&
                                                    ls != 0)
                                                  const SizedBox(width: 10),
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Owner Phone *",
                                                          style: TextStyle(
                                                              color: whiteColor,
                                                              fontSize: 14)),
                                                      const SizedBox(height: 5),
                                                      SizedBox(
                                                        height: 40,
                                                        child: TextFormField(
                                                          validator: (value) {
                                                            if (value == '') {
                                                              setState(() {
                                                                checkownerphone =
                                                                    true;
                                                              });
                                                            } else {
                                                              setState(() {
                                                                checkownerphone =
                                                                    false;
                                                              });
                                                            }
                                                          },
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              comparablePhone =
                                                                  value;
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 8,
                                                                    horizontal:
                                                                        10),
                                                            prefixIcon:
                                                                const Icon(
                                                              Icons
                                                                  .question_answer_outlined,
                                                              color:
                                                                  kImageColor,
                                                            ),
                                                            hintText:
                                                                'Owner Phone *',
                                                            hintStyle: TextStyle(
                                                                color: !checkownerphone
                                                                    ? greyColorNolots
                                                                    : colorsRed),
                                                            fillColor: kwhite,
                                                            filled: true,
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      width:
                                                                          2.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      width: 1,
                                                                      color:
                                                                          colorsRed),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      width: 1,
                                                                      color:
                                                                          kPrimaryColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                controller: province,
                                                onChanged: (value) {
                                                  setState(() {
                                                    province.text = value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  fillColor: kwhite,
                                                  filled: true,
                                                  labelText: "Province",
                                                  labelStyle: const TextStyle(
                                                      color: kTextLightColor),
                                                  prefixIcon: const Icon(
                                                      Icons.location_on_rounded,
                                                      color: kImageColor),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                kPrimaryColor,
                                                            width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1,
                                                            color:
                                                                kPrimaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                controller: district,
                                                onChanged: (value) {
                                                  setState(() {
                                                    district.text = value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  fillColor: kwhite,
                                                  filled: true,
                                                  labelText: "District",
                                                  labelStyle: const TextStyle(
                                                      color: kTextLightColor),
                                                  prefixIcon: const Icon(
                                                      Icons.location_on_rounded,
                                                      color: kImageColor),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                kPrimaryColor,
                                                            width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1,
                                                            color:
                                                                kPrimaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                controller: commune,
                                                onChanged: (value) {
                                                  setState(() {
                                                    commune.text = value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  fillColor: kwhite,
                                                  filled: true,
                                                  labelText: "Commune",
                                                  labelStyle: const TextStyle(
                                                      color: kTextLightColor),
                                                  prefixIcon: const Icon(
                                                      Icons.location_on_rounded,
                                                      color: kImageColor),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                kPrimaryColor,
                                                            width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1,
                                                            color:
                                                                kPrimaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                onChanged: (value) {
                                                  setState(() {
                                                    remark = value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  fillColor: kwhite,
                                                  filled: true,
                                                  labelText: "Remark",
                                                  labelStyle: const TextStyle(
                                                      color: kTextLightColor),
                                                  prefixIcon: const Icon(
                                                      Icons.read_more_sharp,
                                                      color: kImageColor),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                kPrimaryColor,
                                                            width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1,
                                                            color:
                                                                kPrimaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    height: 40,
                                                    child: TextFormField(
                                                      validator: (value) {
                                                        if (value == '') {
                                                          setState(() {
                                                            checklat = true;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            checklat = false;
                                                          });
                                                        }
                                                      },
                                                      controller: latcontroller,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          latcontroller.text =
                                                              value;
                                                        });
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8,
                                                                horizontal: 10),
                                                        prefixIcon: const Icon(
                                                          Icons
                                                              .question_answer_outlined,
                                                          color: kImageColor,
                                                        ),
                                                        hintText: 'Latitude *',
                                                        hintStyle: TextStyle(
                                                            color: !checklat
                                                                ? greyColorNolots
                                                                : colorsRed),
                                                        fillColor: kwhite,
                                                        filled: true,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color:
                                                                      kPrimaryColor,
                                                                  width: 2.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      kPrimaryColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    height: 40,
                                                    child: TextFormField(
                                                      validator: (value) {
                                                        if (value == '') {
                                                          setState(() {
                                                            checklog = true;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            checklog = false;
                                                          });
                                                        }
                                                      },
                                                      controller: logcontroller,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          logcontroller.text =
                                                              value;
                                                        });
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8,
                                                                horizontal: 10),
                                                        prefixIcon: const Icon(
                                                          Icons
                                                              .question_answer_outlined,
                                                          color: kImageColor,
                                                        ),
                                                        hintText: 'Longitude *',
                                                        hintStyle: TextStyle(
                                                            color: !checklog
                                                                ? greyColorNolots
                                                                : colorsRed),
                                                        fillColor: kwhite,
                                                        filled: true,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color:
                                                                      kPrimaryColor,
                                                                  width: 2.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      kPrimaryColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 30)
                                          ],
                                        ),
                                      ),
                                    )
                                  else if (checkdelete)
                                    (watingList)
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : Container(
                                            height: 500,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  width: 2, color: whiteColor),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: PaginatedDataTable(
                                                  // headingRowHeight: 6,
                                                  horizontalMargin: 5.0,
                                                  arrowHeadColor:
                                                      Colors.blueAccent[300],
                                                  columns: [
                                                    for (int i = 0;
                                                        i < listTitle.length;
                                                        i++)
                                                      DataColumn(
                                                        label: Text(
                                                          listTitle[i]['title']
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          5,
                                                                          11,
                                                                          67)),
                                                        ),
                                                      ),
                                                  ],
                                                  dataRowHeight: 35,
                                                  rowsPerPage: on_row,
                                                  onRowsPerPageChanged:
                                                      (value) {
                                                    setState(() {
                                                      on_row = value!;
                                                    });
                                                  },
                                                  source: _DataSource(
                                                      listBlock: authentication
                                                          .listblock,
                                                      listlocalhosts:
                                                          widget.listlocalhosts,
                                                      checklocation: (value) {},
                                                      context: context,
                                                      count_row: listcom.length,
                                                      data: listcom,
                                                      listback: (value) {
                                                        setState(() {
                                                          int indexs = 0;
                                                          try {
                                                            var decodedJson =
                                                                jsonDecode(
                                                                    value);
                                                            data_adding_correct =
                                                                decodedJson[
                                                                    'data'];
                                                            indexs =
                                                                decodedJson[
                                                                    'index'];
                                                            if (data_adding_correct
                                                                .isNotEmpty) {
                                                              if (data_adding_correct[
                                                                              indexs]
                                                                          [
                                                                          'comparable_property_id']
                                                                      .toString() ==
                                                                  '15') {
                                                                markerType(
                                                                    indexs,
                                                                    'l.png');
                                                              } else if (data_adding_correct[
                                                                              indexs]
                                                                          [
                                                                          'comparable_property_id']
                                                                      .toString() ==
                                                                  '10') {
                                                                markerType(
                                                                    indexs,
                                                                    'f.png');
                                                              } else if (data_adding_correct[
                                                                              indexs]
                                                                          [
                                                                          'comparable_property_id']
                                                                      .toString() ==
                                                                  '33') {
                                                                markerType(
                                                                    indexs,
                                                                    'v.png');
                                                              } else if (data_adding_correct[
                                                                              indexs]
                                                                          [
                                                                          'comparable_property_id']
                                                                      .toString() ==
                                                                  '14') {
                                                                markerType(
                                                                    indexs,
                                                                    'h.png');
                                                              } else if (data_adding_correct[
                                                                              indexs]
                                                                          [
                                                                          'comparable_property_id']
                                                                      .toString() ==
                                                                  '4') {
                                                                markerType(
                                                                    indexs,
                                                                    'b.png');
                                                              } else if (data_adding_correct[
                                                                              indexs]
                                                                          [
                                                                          'comparable_property_id']
                                                                      .toString() ==
                                                                  '29') {
                                                                markerType(
                                                                    indexs,
                                                                    'v.png');
                                                              } else {
                                                                markerType(
                                                                    indexs,
                                                                    'a.png');
                                                              }
                                                            }
                                                            listMarkerIds
                                                                .clear();
                                                            mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                                                target: LatLng(
                                                                    data_adding_correct[
                                                                            indexs]
                                                                        [
                                                                        'latlong_log'],
                                                                    data_adding_correct[
                                                                            indexs]
                                                                        [
                                                                        'latlong_la']),
                                                                zoom: 20)));
                                                          } catch (e) {
                                                            // print(e.toString());
                                                          }
                                                        });
                                                      },
                                                      setStateCallback:
                                                          _setState,
                                                      userID: widget
                                                          .listlocalhosts[0]
                                                              ['agency']
                                                          .toString()),
                                                ),
                                              ),
                                            ),
                                          )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: 250,
                          color: whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/top_agent.png',
                                        height: 50,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      Text("Top Credit Agent",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: greenColors,
                                              fontSize: 17)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    height: 420,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromARGB(
                                          255, 170, 225, 238),
                                    ),
                                    child: ListView.builder(
                                      itemCount: listTop.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Card(
                                            elevation: 10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: whiteColor,
                                              ),
                                              height: 70,
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  if (index < 10)
                                                    Image.asset(
                                                        'assets/icons/${icontop[index]['icon']}')
                                                  else
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor:
                                                          greyColorNolots,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Text(
                                                          '${index + 1}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17,
                                                              color:
                                                                  blackColor),
                                                        ),
                                                      ),
                                                    ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    listTop[index]
                                                            ['credit_agent']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: colorsRed),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    listTop[index]
                                                            ['agenttype_name']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: greyColor),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Owner's Check comparable",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: greyColorNolot),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    height: 300,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        border: Border.all(
                                            width: 1, color: greyColor),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: ListView.builder(
                                      itemCount: listOwner.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Card(
                                          elevation: 10,
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              radius: 15,
                                              backgroundColor: redColors,
                                              child: Text(
                                                "${(listOwner.length - index)}",
                                                style: TextStyle(
                                                    color: whiteColor),
                                              ),
                                            ),
                                            title: Text(
                                              listOwner[index]['name']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                            trailing: Text(
                                              listOwner[index]['type']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: (listOwner[index]
                                                              ['type'] ==
                                                          'Edit')
                                                      ? greenColors
                                                      : redColors,
                                                  fontSize: 12),
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
                        )
                      ],
                    ),
                    Positioned(
                      top: 160,
                      child: (listMap.isEmpty)
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Container(
                                height: 350,
                                width: 450,
                                color: whiteColor,
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
                            ),
                    )
                  ],
                )),
              ),
              Expanded(
                flex: 9,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GoogleMap(
                    markers: listMarkerIds.map((e) => e).toSet(),
                    initialCameraPosition: CameraPosition(
                      target: latLng,
                      zoom: 12.0,
                    ),
                    polygons: Set<Polygon>.of(polygons),
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    mapType: MapType.hybrid,
                    onMapCreated: (controller) {
                      //method called when map is created
                      setState(() {
                        mapController = controller;
                      });
                    },
                    onTap: (argument) {
                      if (viewMap) {
                        latLng = argument;
                        requestModel.lat = latLng.latitude.toString();
                        requestModel.lng = latLng.longitude.toString();
                        addMarkers(argument);
                        onMapTapped(double.parse(requestModel.lat),
                            double.parse(requestModel.lng));
                      } else {
                        setState(() {
                          listOwner = [];
                          if (checktypeMarker == false) {
                            if (comparedropdown2 != "") {
                              typedrawerSe == false;
                            }

                            typedrawer = true;
                            latLng = argument;
                            requestModel.lat = latLng.latitude.toString();
                            requestModel.lng = latLng.longitude.toString();
                            latcontroller.text = latLng.latitude.toString();
                            logcontroller.text = latLng.longitude.toString();
                            findByPiont(latLng.latitude, latLng.longitude);
                            if (comparedropdown2 == ""
                                //  &&typedrawerSe == false
                                ) {
                              addMarkers(argument);
                            } else if (comparedropdown2 != "" &&
                                typedrawerSe == false) {
                              addMarker(argument);
                              getAddress(argument);
                              Show(requestModel);
                            }
                          } else {
                            clickMap = true;
                            if (list.isNotEmpty) {
                              clearmarker = true;
                            }
                            if (typedrawerSe == false) {
                              addManyMarkers(argument);

                              // print('No.12');
                            }
                          }
                        });
                      }
                    },
                    onCameraMove: (CameraPosition cameraPositiona) {
                      cameraPosition = cameraPositiona; //when map is dragging
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkHlandbuilding = false;
  bool checkImage = false;
  String testback = '';
  bool checkmap = true;
  late String autoverbalTypeValue = '';
  String opionTypeID = '0';
  int optionValue = 0;
  String dep = "0";
  double hL = 0, lL = 0;
  double? minSqm, maxSqm, totalMin, totalMax, totalArea;
  String? des;
  bool checkMap = false;
  double hscreen = 780;
  String verbalID = '';
  List verbal = [];
  bool doneORudone = false;
  String area = '';
  double areas = 0;
  int i = 0;
  double? askingPrice;
  int idkhan = 0;
  Future<void> addOwner(
      comparableId, comparableUser, name, type, bool check, title) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "comparable_id": comparableId,
      "comparable_user": comparableUser,
      "name": name,
      "type": type,
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/add/owner',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      if (check = true) {
        await getOwner(comparableId);
        setState(() {
          isApiCallProcess = false;
        });
        // Navigator.pop(context);
        Get.snackbar(
          'Done',
          title,
          colorText: Colors.black,
          padding:
              const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
          borderColor: const Color.fromARGB(255, 48, 47, 47),
          borderWidth: 1.0,
          borderRadius: 5,
          backgroundColor: const Color.fromARGB(255, 235, 242, 246),
          icon: const Icon(Icons.add_alert),
        );
        setState(() {
          countCredit = countCredit + 1;
        });
      }
    } else {
      // print(response.statusMessage);
    }
  }

  void Clear() {
    setState(() {
      for (var i = 0; i < list.length; i++) {
        MarkerId markerId = MarkerId('$i');
        listMarkerIds.remove(markerId);
      }
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> markerType(int i, typeMarker) async {
    MarkerId markerId = MarkerId(i.toString());
    Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        double.parse(data_adding_correct[i]['latlong_log'].toString()),
        double.parse(data_adding_correct[i]['latlong_la'].toString()),
      ),
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(50, 50)),
          'assets/icons/$typeMarker'),
      onTap: () async {
        await getOwner(data_adding_correct[i]['comparable_id']);
        setState(() {
          priceController.text =
              data_adding_correct[i]['comparable_adding_price'].toString();
          updateproperty =
              data_adding_correct[i]['comparable_property_id'].toString();
          updateraod = data_adding_correct[i]['comparable_road'].toString();
          updatepropertyName =
              data_adding_correct[i]['comparable_property_id'].toString();
        });
        dailogMarkers(i);
      },
    );
    setState(() {
      isApiCallProcess = false;
      listMarkerIds.add(marker);
    });
  }

  bool check = false;
  Future<void> updatePrice(comparableID, price, username, comparableuserID,
      typeValue, protectID) async {
    setState(() {
      isApiCallProcess = true;
      if (typeValue == 'VN') {
        check = true;
      } else {
        check = false;
      }
    });

    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "check": check,
      "protectID": protectID,
      "comparable_id": comparableID,
      "comparable_adding_price": price,
      "comparable_property_id": updateproperty,
      "comparable_road": updateraod,
      "borey": checkborey
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update/price/${widget.listlocalhosts[0]['agency']}',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      setState(() {
        for (var element in data_adding_correct) {
          if (element['comparable_id'].toString() == comparableID) {
            element['comparable_adding_price'] = priceController.text;
            element['comparable_property_id'] = updateproperty;
            element['comparable_road'] = updateraod;
            element['property_type_name'] = updatepropertyName;
            element['road_name'] = updateraodName;
            element['borey'] = checkborey;
            break;
          }
        }
      });
      if (listOwner.isEmpty) {
        await addOwner(comparableID, comparableuserID, username.toString(),
            "Owner", false, json.encode(response.data).toString());
      }
      await addOwner(
          comparableID,
          widget.listlocalhosts[0]['agency'].toString(),
          widget.listlocalhosts[0]['username'].toString(),
          "Edit",
          true,
          json.encode(response.data).toString());
    }
  }

  bool checkRaod = false;

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

  Future<void> Show(SearchRequestModel requestModel) async {
    try {
      if (groupValue == 0) {
        setState(() {
          isApiCallProcess = true;
        });

        var headers = {'Content-Type': 'application/json'};
        var data = json.encode({
          "distance": distanceController.text,
          "num": requestModel.num,
          "lat": requestModel.lat,
          "lng": requestModel.lng,
        });
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/mapNew/map_actionUse',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        );

        if (response.statusCode == 200) {
          setState(() {
            doneORudone = false;
            list = jsonDecode(json.encode(response.data))['autoverbal'];
          });
        }
        if (list.length >= 5) {
          List<dynamic> filteredList = filterDuplicates(
              list, "comparable_adding_price", "latlong_la", "latlong_log");

          setState(() {
            isApiCallProcess = false;
            map = filteredList.asMap();
          });
          setState(() {
            for (int i = 0; i < map!.length; i++) {
              if (data_adding_correct.length == int.parse(requestModel.num)) {
                break;
              } else {
                data_adding_correct.add(map![i]);
              }
            }
          });
          if (data_adding_correct.isNotEmpty) {
            for (int i = 0; i < data_adding_correct.length; i++) {
              print(
                  "No.${data_adding_correct[i]['comparable_id']} : ${data_adding_correct[i]['comparable_property_id']}\n");
              if (data_adding_correct[i]['comparable_property_id'].toString() ==
                  '15') {
                markerType(i, 'l.png');
              } else if (data_adding_correct[i]['comparable_property_id']
                      .toString() ==
                  '10') {
                markerType(i, 'f.png');
              } else if (data_adding_correct[i]['comparable_property_id']
                      .toString() ==
                  '33') {
                markerType(i, 'v.png');
              } else if (data_adding_correct[i]['comparable_property_id']
                      .toString() ==
                  '14') {
                markerType(i, 'h.png');
              } else if (data_adding_correct[i]['comparable_property_id']
                      .toString() ==
                  '4') {
                markerType(i, 'b.png');
              } else if (data_adding_correct[i]['comparable_property_id']
                      .toString() ==
                  '29') {
                markerType(i, 'v.png');
              } else {
                markerType(i, 'a.png');
              }
            }
          }

          if (data_adding_correct.isNotEmpty) {
            if (data_adding_correct.length < 5) {
              setState(() {
                pty = null;
                comparedropdown = '';
              });

              // await Show(requestModel);
            }
          }
        } else {
          // nodata("We are devoloping!");
          getxsnackbar("Please Try again", "");

          // await Show(requestModel);
          setState(() {
            isApiCallProcess = false;
          });
        }
      } else {
        // for_market_price();
        getxsnackbar("We are Develop", "Please Try again");

        setState(() {
          isApiCallProcess = false;
        });
      }
    } on Exception catch (_) {
      // nodata("Please Try again");

      getxsnackbar("Connect is Slow", "Please Try again");
      setState(() {
        isApiCallProcess = false;
      });
    }
  }

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

  var colorstitle = const Color.fromARGB(255, 141, 140, 140);
  var colorsPrice = const Color.fromARGB(255, 241, 31, 23);
  List<dynamic> filterDuplicates(
      List<dynamic> list, String priceKey, String lat, String log) {
    Set<String> seenPriceAndLatLog = {};
    Set<String> seenLatLog = {};
    List<dynamic> uniqueList = [];

    for (var item in list) {
      String priceAndLatLogKey = "${item[priceKey]}_${item[lat]}_${item[log]}";
      String latLogKey = "${item[lat]}_${item[log]}";

      if (!seenPriceAndLatLog.contains(priceAndLatLogKey) &&
          !seenLatLog.contains(latLogKey)) {
        seenPriceAndLatLog.add(priceAndLatLogKey);
        seenLatLog.add(latLogKey);
        uniqueList.add(item);
      }
    }

    return uniqueList;
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
  Future<void> dailogMarkers(i) async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(left: 70, top: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor),
                  height: 550,
                  width: 330,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              const Text('Print ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 57, 56, 56),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              PrinterCom(item: data_adding_correct[i]),
                              if (data_adding_correct[i]['comparabl_user'] ==
                                  widget.listlocalhosts[0]['agency'])
                                const SizedBox(width: 10),
                              if (data_adding_correct[i]['comparabl_user'] ==
                                  widget.listlocalhosts[0]['agency'])
                                const Text('Edit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 57, 56, 56),
                                        fontSize: 14)),
                              if (data_adding_correct[i]['comparabl_user'] ==
                                  widget.listlocalhosts[0]['agency'])
                                EditDetail(item: data_adding_correct[i]),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                  onPressed: () async {
                                    updatePrice(
                                        data_adding_correct[i]['comparable_id']
                                            .toString(),
                                        priceController.text,
                                        data_adding_correct[i]['agenttype_name']
                                            .toString(),
                                        data_adding_correct[i]['comparabl_user']
                                            .toString(),
                                        data_adding_correct[i]['type_value'],
                                        data_adding_correct[i]['protectID']);
                                    // print(
                                    //     "protectID => ${data_adding_correct[i]['protectID']}");
                                  },
                                  child: const Text('Save')),
                              const SizedBox(width: 10),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                },
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  color: greyColor,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text('Price : ',
                                  style: TextStyle(
                                      color: kImageColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              textEdit(),
                              const Spacer(),
                              Row(
                                children: [
                                  const Text("View Map  "),
                                  IconButton(
                                      onPressed: () {
                                        onMapTapped(
                                            data_adding_correct[i]
                                                ['latlong_la'],
                                            data_adding_correct[i]
                                                ['latlong_log']);
                                      },
                                      icon: Icon(
                                        Icons.share_location,
                                        color: redColors,
                                      )),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 35,
                            // width: double.infinity,
                            child: PropertyDropdown35(
                              name: (value) {
                                // propertyType = value;
                                setState(() {
                                  updatepropertyName = value;
                                });
                              },
                              check_onclick: (value) {},
                              id: (value) {
                                setState(() {
                                  updateproperty = value;
                                });
                              },
                              // pro: list[0]['property_type_name'],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Property (${i + 1}) ${data_adding_correct[i]['property_type_name']}",
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Block Comparable Price : ",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: greyColor),
                              ),
                              TextButton(
                                onPressed: () {
                                  blocComparable(
                                      data_adding_correct[i]['comparable_id']);
                                },
                                child: Icon(
                                  Icons.block,
                                  color: greyColor,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 35,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,

                              onChanged: (newValue) {
                                setState(() {
                                  checkborey = int.parse(newValue!);
                                  // String roadDrop = newValue as String;
                                });
                              },

                              items: listBorey
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value["check"].toString(),
                                      child: Text(value["title"].toString()),
                                      // child: Text(
                                      //   value["name"],

                                      //   style: TextStyle(
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Colors.red),
                                      // ),
                                    ),
                                  )
                                  .toList(),
                              // add extra sugar..
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: kImageColor,
                              ),

                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                fillColor: Colors.white,
                                filled: true,
                                labelText:
                                    (data_adding_correct[i]['borey'] == 0)
                                        ? "No Borey"
                                        : "Borey",
                                hintStyle: TextStyle(
                                    color: blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                hintText: 'Select one',
                                prefixIcon: const Icon(
                                  Icons.edit_road_outlined,
                                  color: kImageColor,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: kPrimaryColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: kPrimaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 35,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,

                              onChanged: (newValue) {
                                setState(() {
                                  // String roadDrop = newValue as String;

                                  updateraod = newValue!.split(",")[0];
                                  updateraodName = newValue.split(",")[1];
                                });
                              },

                              items: listRaod
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value:
                                          "${value["road_id"]},${value["road_name"].toString()}",
                                      child:
                                          Text(value["road_name"].toString()),
                                      // child: Text(
                                      //   value["name"],

                                      //   style: TextStyle(
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Colors.red),
                                      // ),
                                    ),
                                  )
                                  .toList(),
                              // add extra sugar..
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: kImageColor,
                              ),

                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                fillColor: Colors.white,
                                filled: true,
                                labelText:
                                    "${data_adding_correct[i]['road_name']}",
                                // labelText: (searchraod.text == "")
                                //     ? 'Road'
                                //     : searchraod.text,
                                hintStyle: TextStyle(
                                    color: blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                hintText: 'Select one',
                                prefixIcon: const Icon(
                                  Icons.edit_road_outlined,
                                  color: kImageColor,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: kPrimaryColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: kPrimaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ID\'s property',
                                      style: TextStyle(fontSize: fontsizeD)),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                        color: kImageColor,
                                        fontSize: fontsizeD,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Text('Owner',
                                      style: TextStyle(fontSize: fontsizeD)),
                                  const SizedBox(height: 10),
                                  Text('Land-Width',
                                      style: TextStyle(fontSize: fontsizeD)),
                                  const SizedBox(height: 10),
                                  Text('Land-Length',
                                      style: TextStyle(fontSize: fontsizeD)),
                                  const SizedBox(height: 10),
                                  Text('Land-Total',
                                      style: TextStyle(fontSize: fontsizeD)),
                                  const SizedBox(height: 10),
                                  Text('Date Created',
                                      style: TextStyle(fontSize: fontsizeD)),
                                  const SizedBox(height: 10),
                                  Text('Type of Route',
                                      style: TextStyle(fontSize: fontsizeD)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '  :   ${(data_adding_correct[i]['type_value'] ?? "")} ${data_adding_correct[i]['comparable_id']}',
                                      style: TextStyle(fontSize: fontsizeD)),

                                  const SizedBox(height: 10),
                                  Text(
                                    '${priceController.text}\$',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 242, 11, 134),
                                        fontSize: fontsizeD,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Text(
                                  //   '${'  :   ' + data_adding_correct[i]['comparable_adding_price']}\$',
                                  //   style: TextStyle(
                                  //       color: const Color.fromARGB(
                                  //           255, 242, 11, 134),
                                  //       fontSize: fontsizeD,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                  const SizedBox(height: 10),
                                  Text(
                                      '  :   ${data_adding_correct[i]['agenttype_name']}',
                                      style: TextStyle(fontSize: fontsizeD)),
                                  const SizedBox(height: 10),
                                  Text(
                                      '  :   ' +
                                          "${data_adding_correct[i]['comparable_land_width'] ?? ""}",
                                      style: TextStyle(fontSize: fontsizeD)),
                                  const SizedBox(height: 10),
                                  Text(
                                      '  :   ' +
                                          "${data_adding_correct[i]['comparable_land_length'] ?? ""}",
                                      style: TextStyle(fontSize: fontsizeD)),
                                  const SizedBox(height: 10),
                                  if (data_adding_correct[i]
                                                  ['comparable_land_total']
                                              .toString() ==
                                          "" ||
                                      data_adding_correct[i]
                                                  ['comparable_land_total']
                                              .toString() ==
                                          "null")
                                    Text('  :   ',
                                        style: TextStyle(fontSize: fontsizeD))
                                  else
                                    Text(
                                        '  :   ${formatter.format(double.parse(data_adding_correct[i]['comparable_land_total'].replaceAll(",", "").toString()))}',
                                        style: TextStyle(fontSize: fontsizeD)),
                                  const SizedBox(height: 10),
                                  Text(
                                    '  :   ${data_adding_correct[i]['comparable_survey_date']}',
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                      '  :   ${data_adding_correct[i]['road_name']}',
                                      style: TextStyle(fontSize: fontsizeD))
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> blocComparable(id) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"comparable_id": id});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/blockGoogleMapUse',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
      Navigator.pop(context);
    } else {
      // print(response.statusMessage);
    }
  }

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

  Widget textPriceb(txt) {
    return Text(txt,
        style: TextStyle(
          fontSize: fontsize,
          color: colorsPrice,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget textPrice(txt) {
    return Text(txt, style: TextStyle(fontSize: fontsize, color: colorsPrice));
  }

  Widget textb(txt) {
    return Text(txt,
        style: TextStyle(
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
            color: colorstitle));
  }

  Widget text(txt) {
    return Text(txt, style: TextStyle(fontSize: fontsize, color: colorstitle));
  }

  String priceCm = '';
  var avg;
  Future<void> findByPiont(double la, double lo) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$la,$lo&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      List ls = jsonResponse['results'];
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
                district.text = (jsonResponse['results'][j]
                    ['address_components'][i]['short_name']);
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                checkSk = true;
                commune.text = (jsonResponse['results'][j]['address_components']
                    [i]['short_name']);
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_1") {
              province.text = (jsonResponse['results'][j]['address_components']
                  [i]['short_name']);
            }
          }
        }
      }
    }
  }

  ///converts `coordinates` to actual `address` using google map api
  Future<void> getAddress(LatLng latLng) async {
    // final coordinates = Coordinates(latLng.latitude, latLng.longitude);
    try {} catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOMETING WENT WRONG\nDID YOU ADD API KEY '),
        ),
      );
      rethrow;
    }
  }
}

class _DataSource extends DataTableSource {
  final List data;
  final int count_row;
  final BuildContext context;
  final String userID;
  final List listlocalhosts;
  final Function setStateCallback;
  final OnChangeCallback listback;
  final OnChangeCallback checklocation;
  final List listBlock;

  _DataSource({
    required this.listBlock,
    required this.listlocalhosts,
    required this.checklocation,
    required this.userID,
    required this.data,
    required this.count_row,
    required this.context,
    required this.setStateCallback,
    required this.listback,
  });
  List totally = [
    {
      'numer_id': 1,
      'type': 'Totally',
    },
    {
      'numer_id': 2,
      'type': 'Sqm',
    }
  ];

  int ls = 0;
  int comparablePropertyID = 0;
  double comparableSoldWidth = 0;
  double comparableSoldLength = 0;
  int selectindex = -1;

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
      color: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return index % 2 == 0
              ? const Color.fromARGB(168, 181, 181, 183)
              : Colors.white;
        },
      ),
      cells: [
        buildDataCell("${index + 1}", true, index),
        DataCell(
          Row(
            children: [
              PrinterCom(item: item),
              (item['comparabl_user'] == listlocalhosts[0]['agency'])
                  ? EditDetail(item: item)
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    setStateCallback(() {
                      checklocation(index);
                      Map<String, dynamic> jsonObject = {
                        "data": data,
                        "index": index,
                      };

                      // Convert the Map to a JSON string
                      String jsonString = jsonEncode(jsonObject);
                      listback(jsonString);
                    });
                  },
                  child: const Icon(Icons.edit_location_outlined,
                      color: Color.fromARGB(255, 145, 6, 52)),
                ),
              ),
              ((listBlock[0]['delete_agent'] == listlocalhosts[0]['agency']))
                  ? Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: InkWell(
                        onTap: () {
                          AwesomeDialog(
                            width: 400,
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: false,
                            title: 'Do you want to delete?',
                            // desc: "",
                            btnOkOnPress: () async {
                              await delete(
                                  item['protectID'],
                                  item['comparable_id'],
                                  index,
                                  item['type_value']);

                              // print(data[index].toString());
                            },
                            btnCancelOnPress: () {},
                            btnCancelColor: greyColorNolot,
                            btnOkColor: greyColorNolot,
                          ).show();
                        },
                        child: Icon(Icons.delete, color: colorsRed),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        buildDataCell(item['property_type_name'].toString(), true, index),
        buildDataCell(item['comparable_land_total'] ?? "", true, index),
        buildDataCell(item['comparable_sold_total'] ?? "", true, index),
        buildDataCell(item['comparable_adding_price'] ?? "", true, index),
        buildDataCell(item['comparableaddprice'] ?? "", true, index),
        buildDataCell("", true, index),
        buildDataCell(item['comparable_sold_price'] ?? "", true, index),
        buildDataCell(
            "${item['province'] ?? ""} ${item['district'] ?? ""} ${item['commune'] ?? ""}",
            true,
            index),
        buildDataCell(item['agenttype_name'] ?? "", true, index),
        buildDataCell(item['comparable_id'] ?? "", true, index),
        buildDataCell(item['comparableDate'].toString(), true, index),
      ],
    );
  }

  DataCell buildDataCell(text, bool fw, int index) {
    return DataCell(
      onTap: () {},
      Text(
        text.toString(),
        style: TextStyle(
            fontSize: 13,
            color: greyColor,
            fontWeight: fw ? FontWeight.bold : null),
      ),
    );
  }

  Uint8List? getbytes;
  Future<void> getimageMap(double lat, double log) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${(log > lat) ? "$lat,$log" : "$log,$lat"}&zoom=15&size=1080x920&maptype=normal&markers=color:red%7C%7C${(log > lat) ? "$lat,$log" : "$log,$lat"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));
      getbytes = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  List iconIcon = const [Icons.edit, Icons.delete];

  List listIcon = const [Icons.print, Icons.edit, Icons.delete];
  // Future<void> delete(protectID, int index) async {
  //   var dio = Dio();
  //   var response = await dio.request(
  //     'https://kfacrm.com/blog/public/api/delete/$protectID',
  //     options: Options(
  //       method: 'DELETE',
  //     ),
  //   );

  //   if (response.statusCode == 200) {
  //     setStateCallback(() {
  //       data.removeAt(index);

  //       listback(list);
  //       print("protectID => $protectID");
  //     });
  //   } else {
  //     print(response.statusMessage);
  //   }
  // }
  bool check = false;
  Future<void> delete(
      protectID, int comparableID, int index, String typeValue) async {
    setStateCallback(() {
      if (typeValue == 'VN') {
        check = true;
      } else {
        check = false;
      }
    });
    var headers = {'Content-Type': 'application/json'};
    var datas = json.encode(
        {"check": true, "comparable_id": comparableID, "protectID": protectID});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/delete/comsystem',
      options: Options(
        method: 'DELETE',
        headers: headers,
      ),
      data: datas,
    );

    if (response.statusCode == 200) {
      setStateCallback(() {
        data.removeAt(index);
        listback(list);
        Get.snackbar(
          "Done",
          json.encode(response.data),
          colorText: Colors.black,
          padding:
              const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
          borderColor: const Color.fromARGB(255, 48, 47, 47),
          borderWidth: 1.0,
          borderRadius: 5,
          backgroundColor: const Color.fromARGB(255, 235, 242, 246),
          icon: const Icon(Icons.add_alert),
        );
      });
    } else {
      print(response.statusMessage);
    }
  }

  pw.Widget txt(title) {
    return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 2),
        child: pw.Text(title,
            style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: const PdfColor.fromInt(0x29465B))));
  }

  pw.Widget txtbold(title) {
    return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 3),
        child: pw.Text(title,
            style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
                color: const PdfColor.fromInt(0x000000))));
  }

  pw.Widget txtSimple(title) {
    return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 3),
        child: pw.Text(title,
            style: const pw.TextStyle(
                fontSize: 11, color: PdfColor.fromInt(0x000000))));
  }

  @override
  int get rowCount => count_row;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
