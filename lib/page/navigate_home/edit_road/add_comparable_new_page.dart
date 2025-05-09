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
import '../../../../components/colors.dart';
import '../../../../components/property35.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../screen/Property/FirstProperty/component/Colors/appbar.dart';
import '../../../../screen/Property/Map/streetview_map.dart';
import '../Comparable/edit_comparable_new_page.dart';

class ChangeRaod extends StatefulWidget {
  const ChangeRaod(
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

class _HomePageState extends State<ChangeRaod> {
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

  String? floorcontroller;
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
  // final TextEditingController floorcontroller = TextEditingController();
  final TextEditingController latcontroller = TextEditingController();
  final TextEditingController logcontroller = TextEditingController();
  final TextEditingController province = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController commune = TextEditingController();
  String provinces = "";
  String districts = "";
  String communes = "";
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
      body: mapShow(),
    );
  }

  bool searchBool = false;
  String comparedropdown = '';
  String comparedropdown2 = '';
  int groupValue = 0;
  bool isChecked = false;
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
      // print(response.reasonPhrase);
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
        // getAddress(latLng);
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

    // print("start : $start && end : $end");
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
        // print('Error: ${response.statusMessage}');
      }
    } catch (e) {
      // print('Error: $e');
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
      // print(response.statusMessage);
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
  List listMarket = [
    {
      "title": "Market",
      "check": 1,
    },
    {
      "title": "No Market",
      "check": 0,
    }
  ];
  List listCondo = [
    {
      "title": "Condo",
      "check": 1,
    },
    {
      "title": "No Condo",
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
  double priceLand = 0;
  Future<void> calculate() async {
    setState(() {
      double askingPrice = double.tryParse(askingPricett.text) ?? 0;
      double totalPrice = double.tryParse(totalPriceSqm.text) ?? 0;
      double totalLand = double.tryParse(totalland.text) ?? 1.0;
      double pricepersqmN = double.tryParse(pricepersqm.text) ?? 0;
      if (!checkcalculate) {
        //Asking Price
        priceLand = totalLand * pricepersqmN;
        double pricepersqmresult = askingPrice / totalLand;
        pricepersqm.text = pricepersqmresult.toStringAsFixed(0);
      } else if (pricepersqmN != 0) {
        //Asking PriceTT
        priceLand = totalLand * pricepersqmN;
        double askingPricettresult = totalLand * pricepersqmN + totalPrice;
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
        askingPricett.text =
            (double.parse(totalPriceSqm.text) + priceLand).toString();
      } else {
        //Offerred Price
        askingPricett.text =
            (double.parse(totalPriceSqm.text) + priceLand).toString();
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
  int? protectID;

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

  int? comparableUser;
  int market = 0;
  int condo = 0;
  Future<void> addComparable() async {
    protectID = int.parse(
        "${widget.listlocalhosts[0]['agency']}${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(100)}");
    // print('protectID => $protectID');
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "comparable_property_id": comparablePropertyID,
      "comparable_road": comparableRoad,
      "protectID": protectID,
      "markert": market,
      "condo": condo,
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
      "comparabl_user":
          comparableUser ?? widget.listlocalhosts[0]['agency'].toString(),
      "comparable_remark": remark,
      "province": provinces,
      "district": districts,
      "commune": communes,
      "comparable_floor": (floorcontroller == null) ? null : floorcontroller,
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
        comparableUser = null;
        // print("protectID : $protectID");
      });
    } else {
      // print(response.statusMessage);
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
      // print(response.statusMessage);
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
      floorcontroller = null;
      latcontroller.clear();
      logcontroller.clear();
      ls = 0;
    });
  }

  int top = 0;

  bool checktop = false;
  List listTop = [];

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
  int on_row = 20;
  bool checkMarket = false;
  bool condobool = false;
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
                width: 500,
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
                                        const SizedBox(width: 10),
                                        Text(
                                          '${widget.listlocalhosts[0]['username']}',
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 17,
                                          ),
                                        ),
                                        const Spacer(),
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
                                          if (int.parse(requestModel.num) <=
                                              100) {
                                            addMarker(latLng);

                                            Show(requestModel);
                                          } else {
                                            Get.snackbar(
                                              'Pleas try again',
                                              "Only < 100",
                                              colorText: Colors.black,
                                              padding: const EdgeInsets.only(
                                                  right: 50,
                                                  left: 50,
                                                  top: 20,
                                                  bottom: 20),
                                              borderColor: const Color.fromARGB(
                                                  255, 48, 47, 47),
                                              borderWidth: 1.0,
                                              borderRadius: 5,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 235, 242, 246),
                                              icon: const Icon(Icons.add_alert),
                                            );
                                          }
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
                                      onChanged: (value) {
                                        setState(() {
                                          requestModel.num = value;
                                        });
                                      },
                                      textInputAction: TextInputAction.search,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        hintText: "  Number",
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 15),
                                        hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 118, 116, 116),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
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
                                                controller: (j == 0)
                                                    ? latcontroller
                                                    : logcontroller,
                                                onTap: () {},
                                                onChanged: (value) async {
                                                  setState(() {
                                                    maincheck();
                                                    if (j == 0) {
                                                      requestModel.lat =
                                                          value.toString();
                                                    } else {
                                                      requestModel.lng =
                                                          value.toString();
                                                    }
                                                  });
                                                },
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 280,
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
                      setState(() {
                        latcontroller.clear();
                        logcontroller.clear();
                      });
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
                              // getAddress(argument);
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
      "markert": market,
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
            element['markert'] = market;
            element['borey'] = checkborey;
            element['condo'] = condo;
            break;
          }
        }
      });
      Get.back();
      Get.snackbar(
        'Done',
        "Update Successfuly",
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
        isApiCallProcess = false;
      });
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
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/mapNew/DataAll',
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
          // print("list : ${list.length}");
        });
      }
      if (list.isNotEmpty) {
        List<dynamic> filteredList = filterDuplicates(
            list, "comparable_adding_price", "latlong_la", "latlong_log");

        setState(() {
          isApiCallProcess = false;
          map = filteredList.asMap();
        });
        setState(() {
          for (int i = 0; i < map!.length; i++) {
            data_adding_correct.add(map![i]);
          }
        });
        if (data_adding_correct.isNotEmpty) {
          for (int i = 0; i < data_adding_correct.length; i++) {
            switch (
                data_adding_correct[i]['comparable_property_id'].toString()) {
              case '15':
                markerType(i, 'l.png');
                break;
              case '10':
                markerType(i, 'f.png');
                break;
              case '33':
                markerType(i, 'f.png');
                break;
              case '14':
                markerType(i, 'h.png');
                break;
              case '4':
                markerType(i, 'b.png');
                break;
              case '29':
                markerType(i, 'v.png');
                break;
              default:
                markerType(i, 'a.png');
                break;
            }
            // if (data_adding_correct[i]['comparable_property_id'].toString() ==
            //     '15') {
            // } else if (data_adding_correct[i]['comparable_property_id']
            //         .toString() ==
            //     '10') {
            //   markerType(i, 'f.png');
            // } else if (data_adding_correct[i]['comparable_property_id']
            //         .toString() ==
            //     '33') {
            //    markerType(i, 'f.png');
            // } else if (data_adding_correct[i]['comparable_property_id']
            //         .toString() ==
            //     '14') {
            //   markerType(i, 'h.png');
            // } else if (data_adding_correct[i]['comparable_property_id']
            //         .toString() ==
            //     '4') {
            //   markerType(i, 'b.png');
            // } else if (data_adding_correct[i]['comparable_property_id']
            //         .toString() ==
            //     '29') {
            //   markerType(i, 'v.png');
            // } else {
            //   markerType(i, 'a.png');
            // }
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
                  height: 600,
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
                              if (data_adding_correct[i]['comparabl_user']
                                      .toString() ==
                                  widget.listlocalhosts[0]['agency'].toString())
                                const SizedBox(width: 10),
                              if (data_adding_correct[i]['comparabl_user']
                                      .toString() ==
                                  widget.listlocalhosts[0]['agency'].toString())
                                const Text('Edit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 57, 56, 56),
                                        fontSize: 14)),
                              if (data_adding_correct[i]['comparabl_user']
                                      .toString() ==
                                  widget.listlocalhosts[0]['agency'].toString())
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
                                            double.parse(data_adding_correct[i]
                                                    ['latlong_la']
                                                .toString()),
                                            double.parse(data_adding_correct[i]
                                                    ['latlong_log']
                                                .toString()));
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
                          SizedBox(
                            height: 35,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,

                              onChanged: (newValue) {
                                setState(() {
                                  condo = int.parse(newValue!);

                                  // String roadDrop = newValue as String;
                                });
                              },

                              items: listCondo
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value["check"].toString(),
                                      child: Text(value["title"].toString()),
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
                                labelText: (data_adding_correct[i]['condo']
                                                .toString() ==
                                            "0" ||
                                        data_adding_correct[i]['condo'] == null)
                                    ? "No Condo"
                                    : "Condo",
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
                                  market = int.parse(newValue!);
                                  print("market => $market");
                                  // String roadDrop = newValue as String;
                                });
                              },

                              items: listMarket
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value["check"].toString(),
                                      child: Text(value["title"].toString()),
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
                                labelText: (data_adding_correct[i]['markert']
                                                .toString() ==
                                            "0" ||
                                        data_adding_correct[i]['markert'] ==
                                            null)
                                    ? "No Market"
                                    : "Market",
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
                                  market = int.parse(newValue!);
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
                                labelText: (data_adding_correct[i]['borey']
                                            .toString() ==
                                        "0")
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

                              items: listRaodNBorey
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
    // final response = await http.get(Uri.parse(
    //     'https://maps.googleapis.com/maps/api/geocode/json?latlng=$la,$lo&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));
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
                districts = district.text = (jsonResponse['results'][j]
                    ['address_components'][i]['short_name']);
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                checkSk = true;
                communes = commune.text = (jsonResponse['results'][j]
                    ['address_components'][i]['short_name']);
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_1") {
              provinces = province.text = (jsonResponse['results'][j]
                  ['address_components'][i]['short_name']);
            }
          }
        }
      }
    }
  }

  ///converts `coordinates` to actual `address` using google map api
  // Future<void> getAddress(LatLng latLng) async {
  //   // final coordinates = Coordinates(latLng.latitude, latLng.longitude);
  //   try {} catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('SOMETING WENT WRONG\nDID YOU ADD API KEY '),
  //       ),
  //     );
  //     rethrow;
  //   }
  // }
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
              ((item['comparabl_user'].toString() ==
                          listlocalhosts[0]['agency'].toString()) ||
                      (listlocalhosts[0]['agency'].toString() == "28"))
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
              //listBlock[0]['delete_agent']
              ((listlocalhosts[0]['agency'].toString() == "28"))
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
          'https://maps.googleapis.com/maps/api/staticmap?center=${(log > lat) ? "$lat,$log" : "$log,$lat"}&zoom=15&size=1080x920&maptype=normal&markers=color:red%7C%7C${(log > lat) ? "$lat,$log" : "$log,$lat"}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));
      getbytes = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  List iconIcon = const [Icons.edit, Icons.delete];
  List listIcon = const [Icons.print, Icons.edit, Icons.delete];

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
      // print(response.statusMessage);
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
