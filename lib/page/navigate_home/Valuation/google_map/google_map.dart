// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_brace_in_string_interps, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, avoid_print, unnecessary_new, prefer_collection_literals, unused_field, unused_element, unused_local_variable, prefer_is_empty, use_build_context_synchronously, must_be_immutable, unnecessary_null_comparison

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../models/executive/comparable_list.dart';
import '../../../../models/executive/map_comparable_ex.dart';
import '../../Comparable/comparable3/search_screen.dart/list_markert.dart';
import '../Model/MapTable.dart';
import '../Model/tableSelcted.dart';
import '../Print/print.dart';
import '../class/list_Executive.dart';
import '../componen/textInput.dart';
import '../component/date.dart';
import 'Table.dart';

typedef OnChangeCallback = void Function(dynamic value);

const kGoogleApiKey = 'AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class Map_Search_Comparable_ extends StatefulWidget {
  Map_Search_Comparable_(
      {required this.delect_first_time,
      required this.back_f_value,
      required this.executive_map_table,
      required this.executive_map_table_comback,
      required this.list_CP,
      required this.list,
      required this.y_lat,
      required this.y_log,
      this.id,

      // required this.list_comparable,
      required this.listback,
      // required this.hh_,
      required this.get_province,
      required this.get_district,
      required this.get_commune,
      required this.get_log,
      required this.get_lat,
      required this.get_min1,
      required this.get_max1,
      required this.get_min2,
      required this.get_max2,
      required this.comparablecode,
      required this.listTable,
      required this.widgetList,
      required this.listisSelected,
      required this.listTableB,
      required this.widgetListB,
      required this.listisSelectedB});
  final OnChangeCallback get_province;
  final OnChangeCallback get_district;
  final OnChangeCallback comparablecode;
  final OnChangeCallback get_commune;
  final OnChangeCallback get_log;
  final OnChangeCallback get_lat;
  final OnChangeCallback get_min1;
  final OnChangeCallback get_max1;
  final OnChangeCallback get_min2;
  final OnChangeCallback get_max2;
  final OnChangeCallback y_lat;
  final OnChangeCallback listback;
  final OnChangeCallback y_log;
  final OnChangeCallback listTable;
  final OnChangeCallback widgetList;
  final OnChangeCallback listisSelected;
  final List listTableB;
  final List widgetListB;
  final List listisSelectedB;

  // final OnChangeCallback list_comparable;
  // print('widget.list ==> ${widget.list.length}');
  //                   print('listTable ==> ${listTable.length}');
  //                   print('listisSelected ==> ${listisSelected.length}');
  final OnChangeCallback delect_first_time;
  //
  final OnChangeCallback executive_map_table;
  List executive_map_table_comback;
  List list_CP = [];
  String? start;
  String? lat;

  // String? hh_;
  String? id;
  final OnChangeCallback back_f_value;
  final List list;

  @override
  State<Map_Search_Comparable_> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<Map_Search_Comparable_> {
  @override
  void initState() {
    super.initState();
    Last_id_comparable();
    Get_comparable_filter_id();
    if (widget.list.length > 0) {
      listTable = widget.listTableB;
      listisSelected = widget.listisSelectedB;
      widget.list != widget.widgetListB;
    }
  }

  bool switchValue = false;
  String sendAddrress = '';

  final Set<Marker> _marker = new Set();
  var _selectedValue;
  List<String> option = [
    'Residencial',
    'Commercial',
    'Agricultural',
  ];
  List totally = [
    {
      'numer_id': 1,
      'type': 'Open',
    },
    {
      'numer_id': 2,
      'type': 'off',
    }
  ];
  GoogleMapController? mapController;
  double hh = 0;
  String? _currentAddress;
  Position? _currentPosition;

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

  double? lat1;
  double? log1;

  Future<void> _getCurrentLocation() async {
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
      _addMarker(latLng);
    });
  }

  List list = [];
  List listTable = [];
  double? lat;
  double? log;
  Set<Polygon> _Find_polygons = HashSet<Polygon>();
  List<Color> FillColors = [
    Color.fromARGB(24, 252, 189, 0),
    Color.fromARGB(22, 155, 252, 0),
    Color.fromARGB(20, 0, 252, 42),
    Color.fromARGB(31, 0, 252, 218),
    Color.fromARGB(22, 181, 0, 252),
    Color.fromARGB(28, 252, 0, 55),
    Color.fromARGB(14, 160, 0, 252),
    Color.fromARGB(17, 21, 252, 0),
    Color.fromARGB(14, 252, 143, 0),
    Color.fromARGB(19, 252, 189, 0),
    Color.fromARGB(20, 0, 17, 252),
    Color.fromARGB(20, 252, 0, 0),
  ];
  List<String> Title = [
    "Khan Chamkar Mon",
    "Khan Daun Penh",
    "Khan 7 Makara",
    "Khan Tuol Kouk",
    "Khan Mean Chey",
    "Khan Chbar Ampov",
    "Khan Chroy Changvar",
    "Khan Sensok",
    "Khan Russey Keo",
    "Khan Dangkor",
    "Khan Pou Senchey",
    "Khan Preaek Pnov",
  ];
  int propertycomparableexecutiveid = 0;
  int propertycomparablecomid = 0;
  int propertycomparablestatus = 0;
  String propertycomparablecreatedby = '';
  String propertycomparablemodifydate = '';
  String remembertoken = '';
  List<Map_executive> lb = [Map_executive(0, 0, 0, '', '', '')];
  List<ModelTable> lbs = [
    ModelTable(
      '',
      '',
      '',
      '',
      0,
      '',
      0,
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      0,
      0,
      0,
      '',
      '',
      '',
      '',
      '',
      0,
      0,
      0,
      0,
      '',
      0,
      0,
      '',
      '',
      '',
      0,
    )
  ];
  void addItemToListTable() {
    // print('Comparable Id =========> $propertycomparablecomid');
    setState(() {
      listTable.add({
        'property_type_name': propertyTypeName,
        'provinces_name': provincesName,
        'district_name': districtName,
        'commune_name': communeName,
        'comparable_id': comparableId,
        'comparable_survey_date': comparableSurveyDate,
        'comparable_property_id': comparablePropertyId,
        'comparable_land_length': comparableLandLength,
        'comparable_land_width': comparableLandWidth,
        'comparable_land_total': comparableLandTotal,
        'comparable_sold_length': comparableSoldLength,
        'comparable_sold_width': comparableSoldWidth,
        'comparable_sold_total': comparableSoldTotal,
        'comparable_adding_price': comparableAddingPrice,
        'comparable_adding_total': comparableAddingTotal,
        'comparable_sold_price': comparableSoldPrice,
        'comparable_phone': comparablePhone,
        'comparable_sold_total_price': comparableSoldTotalPrice,
        'comparable_condition_id': comparableConditionId,
        'comparable_year': comparableYear,
        'comparable_address': comparableAddress,
        'comparable_province_id': comparableProvinceId,
        'comparable_district_id': comparableDistrictId,
        'comparable_commune_id': comparableCommuneId,
        'comparable_remark': comparableRemark,
        'comparableaddprice': comparableaddprice,
        'comparableaddpricetotal': comparableaddpricetotal,
        'comparableboughtprice': comparableboughtprice,
        'comparableAmount': comparableAmount,
        'latlong_log': latlongLog,
        'latlong_la': latlongLa,
        'comparabl_user': comparablUser,
        'comparable_con': comparableCon,
        'comparableboughtpricetotal': comparableboughtpricetotal,
        'compare_bank_id': compareBankId,
        'compare_bank_branch_id': compareBankBranchId,
        'com_bankofficer': comBankofficer,
        'com_bankofficer_contact': comBankofficerContact,
        'comparable_road': comparableRoad,
        'distance': distance,
      });
      lbs.add(
        ModelTable(
          propertyTypeName,
          provincesName,
          districtName,
          communeName,
          comparableId!,
          comparableSurveyDate!,
          comparablePropertyId!,
          comparableLandLength,
          comparableLandWidth,
          comparableLandTotal,
          comparableSoldLength,
          comparableSoldWidth,
          comparableSoldTotal,
          comparableAddingPrice,
          comparableAddingTotal,
          comparableSoldPrice,
          comparablePhone,
          comparableSoldTotalPrice,
          comparableConditionId,
          comparableYear,
          comparableAddress,
          comparableProvinceId!,
          comparableDistrictId!,
          comparableCommuneId!,
          comparableRemark,
          comparableaddprice,
          comparableaddpricetotal,
          comparableboughtprice,
          comparableAmount,
          latlongLog!,
          latlongLa!,
          comparablUser!,
          comparableCon!,
          comparableboughtpricetotal,
          compareBankId!,
          compareBankBranchId!,
          comBankofficer,
          comBankofficerContact,
          comparableRoad,
          distance!,
        ),
      );
    });
  }

  void addItemToList() {
    // print('Comparable Id =========> $propertycomparablecomid');
    setState(() {
      if (widget.list == []) {
        list.add({
          'propertycomparable_executive_id': int.parse(widget.id.toString()),
          'propertycomparable_com_id': propertycomparablecomid,
          'propertycomparable_status': 0,
          'propertycomparable_created_by': comparableSurveyDate,
          'propertycomparable_modify_date': propertycomparablemodifydate,
          'remember_token': null,
        });
        lb.add(
          Map_executive(
            int.parse(widget.id.toString()),
            propertycomparablecomid,
            0,
            comparableSurveyDate,
            propertycomparablemodifydate,
            null,
          ),
        );
      } else {
        widget.list.add({
          'propertycomparable_executive_id': int.parse(widget.id.toString()),
          'propertycomparable_com_id': propertycomparablecomid,
          'propertycomparable_status': 0,
          'propertycomparable_created_by': propertycomparablecreatedby,
          'propertycomparable_modify_date': propertycomparablemodifydate,
          'remember_token': null,
        });
        lb.add(
          Map_executive(
            int.parse(widget.id.toString()),
            propertycomparablecomid,
            0,
            comparableSurveyDate,
            propertycomparablemodifydate,
            null,
          ),
        );
      }
    });
  }

  List listisSelected = [];
  List<Selected> lbTable = [Selected(0, false)];
  void selectedMain() {
    listisSelected.add({
      'comparable_id': propertycomparablecomid,
      'select': isSelected,
    });
    lbTable.add(
      Selected(0, false),
    );
  }

  List _pg = [];
  String? onTAP_MAP;
  double? lat_verbal;
  double? log_verbal;
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
        print('marker');
      },
      onTap: () {
        // AwesomeDialog(
        //   context: context,
        //   title: 'Property',
        //   desc: 'Which One?',
        //   btnOkText: 'Search',
        //   btnOkColor: Color.fromARGB(255, 17, 9, 123),
        //   btnCancelText: 'Comparable',
        //   btnCancelColor: Color.fromARGB(255, 57, 121, 12),
        //   btnOkOnPress: () {
        //     setState(() {
        //       _marker.clear();
        //       _addMarker(latLng);
        //     });
        //   },
        // ).show();
      },
    );

    setState(() {
      _marker.add(newMarker);
      lat_verbal = latLng.latitude;
      log_verbal = latLng.longitude;
      Find_by_piont(latLng.latitude, latLng.longitude);
      log_verbal;
      lat_verbal;
      widget.y_lat(latLng.latitude.toString());
      widget.y_log(latLng.longitude.toString());
      print('Pointer');
      // print('lat = ${lat_verbal} and log =${log_verbal}');
      // add the new marker to the list of markers
    });
  }

  List _list_comparablecode = [];
  Future<void> save_cpmaparablle() async {
    print(comparablecode);
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparablecode_comparable/$comparablecode'));
    if (response.statusCode == 200) {
      final markerData = jsonDecode(response.body);
      setState(() {
        _list_comparablecode = markerData;

        if (_list_comparablecode != null && switchs == 'marker') {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return List_search0(
                list: _list_comparablecode,
                comparable_code: comparablecode,
              );
            },
          ));
        } else {}
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to fetch markers',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  String? propertyTypeName;
  String? provincesName;
  String? districtName;
  String? communeName;
  int? comparableId;
  String? comparableSurveyDate;
  int? comparablePropertyId;
  String? comparableLandLength;
  String? comparableLandWidth;
  String? comparableLandTotal;
  String? comparableSoldLength;
  String? comparableSoldWidth;
  String? comparableSoldTotal;
  String? comparableAddingPrice;
  String? comparableAddingTotal;
  String? comparableSoldPrice;
  String? comparablePhone;
  String? comparableSoldTotalPrice;
  String? comparableConditionId;
  String? comparableYear;
  String? comparableAddress;
  int? comparableProvinceId;
  int? comparableDistrictId;
  int? comparableCommuneId;
  String? comparableRemark;
  String? comparableaddprice;
  String? comparableaddpricetotal;
  String? comparableboughtprice;
  String? comparableAmount;
  double? latlongLog;
  double? latlongLa;
  int? comparablUser;
  int? comparableCon;
  String? comparableboughtpricetotal;
  int? compareBankId;
  int? compareBankBranchId;
  String? comBankofficer;
  String? comBankofficerContact;
  String? comparableRoad;
  double? distance;
  List list_comparable = [];
  List list_com = [];
  String? comparable_id;
  String count = '';
  List<Map_Comparable> cm = [
    Map_Comparable(
      0,
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    )
  ];

  late GoogleMapController _mapController;
  Set<Marker> markers = {};
  List<int> selectedMarkers = [];
  bool awaitvalue = false;
  Future<void> waitSearch() async {
    awaitvalue = true;
    await Future.wait([
      Get_data_Comparable(),
    ]);
    setState(() {
      awaitvalue = false;
    });
  }

  Future<void> Get_data_Comparable() async {
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_comparables/11.519050/104.916166?start=2020-1-1&end=2024-1-1&count=30'));
    // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_comparables/$lat_verbal/$log_verbal?start=${start}&end=${end}&count=$count'));
    if (response.statusCode == 200) {
      final markerData = jsonDecode(response.body);
      setState(() {
        dataOfVerbal = markerData;

        _addMarkers(dataOfVerbal);
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to fetch markers',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  List? _comparable_filter = [];
  Future<void> Get_comparable_filter_id() async {
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_by_comparable_filter?compare_status=1'));
    if (response.statusCode == 200) {
      final markerData = jsonDecode(response.body);
      setState(() {
        _comparable_filter = markerData;
        var sum = _comparable_filter![0]['comparable_filter_id'] + 1;
        comparable_filter_id = sum.toString();
        comparable_filter_id;
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to fetch markers',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void showToast(int markerId) {
    Fluttertoast.showToast(
      msg: 'Marker $markerId clicked',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  List? list_marker_id = [];
  bool isSelected = false;

  String? switchs;

  String? comparablecode;
  String? comparable_filter_id;
  List last_id = [];
  Future<void> Last_id_comparable() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable/list_filter?compare_status=1'));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        setState(() {
          last_id = jsonBody;
          print(last_id.toString());
          var sum = int.parse(last_id[0]['comparablecode'].toString()) + 1;
          comparablecode = sum.toString();
          widget.comparablecode(comparablecode);
          // var sum = int.parse(last_id[0]['comparablecode'].toString());
          // comparablecode = sum.toString();
        });
      } else {
        print('Error Last_id_comparable');
      }
    } catch (e) {
      print('Error Last_id_comparable $e');
    }
  }

  String comparable_choose = 'N/A';
  var formatter = NumberFormat("##,###,###,##0.00", "en_US");

  String? start, end;
  int? number_for_count_verbal;
  List data_of_verbal = [];
  List data_of_price = [];
  var size = SizedBox(
    height: 10,
  );
  bool point = false;
  String? bedhroom_dropdown = '';

  List listAdd = [];
  String comparable_id_markert = '';
  List dataOfVerbal = [];
  void _addMarkers(List list) async {
    for (int i = 0; i < list.length; i++) {
      MarkerId markerId = MarkerId(i.toString());
      if (list[i]['comparable_property_id'] == 15) {
        markerMap(i, 'l.png', list);
      } else if (list[i]['comparable_property_id'] == 10) {
        markerMap(i, 'f.png', list);
      } else if (list[i]['comparable_property_id'] == 33) {
        markerMap(i, 'v.png', list);
      } else if (list[i]['comparable_property_id'] == 14) {
        markerMap(i, 'h.png', list);
      } else if (list[i]['comparable_property_id'] == 4) {
        markerMap(i, 'b.png', list);
      } else if (list[i]['comparable_property_id'] == 29) {
        markerMap(i, 'v.png', list);
      } else {
        markerMap(i, 'a.png', list);
      }
    }
  }

  void markerMap(int i, String image, List listMap) async {
    Marker newMarker = Marker(
      markerId: MarkerId(i.toString()),
      position: LatLng(
        double.parse(listMap[i]['latlong_log'].toString()),
        double.parse(listMap[i]['latlong_la'].toString()),
      ),
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(50, 50)), 'assets/icons/$image'),
      onTap: () {
        setState(() {
          clickButtn(i, listMap);
        });
      },
      infoWindow: InfoWindow(
        title:
            '${listMap[i]['comparable_id']}   (${listMap[i]['property_type_name']})',
        snippet:
            "Address: ${(listMap[i]['provinces_name'].toString() == 'null') ? "" : listMap[i]['provinces_name']}",
        onTap: () {},
      ),
    );
    setState(() {
      _marker.add(newMarker);
    });
  }

  int indexPDF = 0;
  List listPDF = [];
  void clickButtn(int i, List listMap) {
    print('onTap ===============> $i');
    setState(() {
      indexPDF = i;
      listPDF = listMap;
      print(indexPDF.toString());
    });
    point = false;
    isSelected = false;

    propertycomparablecomid = int.parse(listMap[i]['comparable_id'].toString());
    ////////////
    propertyTypeName = listMap[i]['property_type_name'].toString();
    provincesName = listMap[i]['provinces_name'].toString();
    districtName = listMap[i]['district_name'].toString();
    communeName = listMap[i]['commune_name'].toString();
    comparableId = int.parse(listMap[i]['comparable_id'].toString());
    comparableSurveyDate = listMap[i]['comparable_survey_date'].toString();
    comparablePropertyId =
        int.parse(listMap[i]['comparable_property_id'].toString());

    comparableLandLength = listMap[i]['comparable_land_length'].toString();
    comparableLandWidth = listMap[i]['comparable_land_width'].toString();
    comparableLandTotal = listMap[i]['comparable_land_total'].toString();
    comparableSoldLength = listMap[i]['comparable_sold_length'].toString();
    comparableSoldWidth = listMap[i]['comparable_sold_width'].toString();
    comparableSoldTotal = listMap[i]['comparable_sold_total'].toString();
    comparableAddingPrice = listMap[i]['comparable_adding_price'].toString();
    comparableAddingTotal = listMap[i]['comparable_adding_total'].toString();

    comparableSoldPrice = listMap[i]['comparable_sold_price'].toString();
    comparablePhone = listMap[i]['comparable_phone'].toString();
    comparableSoldTotalPrice =
        listMap[i]['comparable_sold_total_price'].toString();
    comparableConditionId = listMap[i]['comparable_condition_id'].toString();
    comparableYear = listMap[i]['comparable_year'].toString();
    comparableAddress = listMap[i]['comparable_address'].toString();
    comparableProvinceId =
        int.parse(listMap[i]['comparable_province_id'].toString());
    comparableDistrictId =
        int.parse(listMap[i]['comparable_district_id'].toString());

    comparableCommuneId =
        int.parse(listMap[i]['comparable_commune_id'].toString());
    comparableRemark = listMap[i]['comparable_remark'].toString();
    comparableaddprice = listMap[i]['comparableaddprice'].toString();
    comparableaddpricetotal = listMap[i]['comparableboughtprice'].toString();
    comparableboughtprice = listMap[i]['comparableaddpricetotal'].toString();
    comparableAmount = listMap[i]['comparableAmount'].toString();
    latlongLog = double.parse(listMap[i]['latlong_log'].toString());
    latlongLa = double.parse(listMap[i]['latlong_la'].toString());

    comparablUser = int.parse(listMap[i]['comparabl_user'].toString());
    comparableCon = int.parse(listMap[i]['comparable_con'].toString());

    comparableSurveyDate = listMap[i]['comparable_survey_date'].toString();
    comparableboughtpricetotal =
        listMap[i]['comparableboughtpricetotal'].toString();

    compareBankId = int.parse(listMap[i]['compare_bank_id'].toString());
    compareBankBranchId =
        int.parse(listMap[i]['compare_bank_branch_id'].toString());

    comBankofficer = listMap[i]['com_bankofficer'].toString();
    comBankofficerContact = listMap[i]['com_bankofficer_contact'].toString();

    comparableRoad = listMap[i]['comparable_road'].toString();
    distance = double.parse(listMap[i]['distance'].toString());
    for (int j = 0; j < widget.list.length; j++) {
      if (widget.list[j]['propertycomparable_com_id'] ==
          listMap[i]['comparable_id']) {
        point = true;
        print('onTap ===============>s True');
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  int num = 0;
  double h = 0;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 24.0);
  Set<Marker> markersList = {};
  late GoogleMapController googleMapController;
  int id = 1;
  Set<Polyline> _polylines = Set<Polyline>();
  List<MapType> style_map = [
    MapType.hybrid,
    MapType.normal,
  ];
  String? choose_2;
  TextEditingController Tcon = new TextEditingController();
  int index = 0;
  String? name_of_place;
  GlobalKey<FormState> check = GlobalKey<FormState>();
  var input;
  double? wth;
  double? wth2;
  bool save = false;
  ScrollController? controller = ScrollController();
  bool Back = false;
  @override
  Widget build(BuildContext context) {
    var sizefont = TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.015,
        fontWeight: FontWeight.bold);
    double _h = MediaQuery.of(context).size.height * 0.07;
    double _w = MediaQuery.of(context).size.width * 0.18;
    var w = MediaQuery.of(context).size.width;
    if (w < 600) {
      wth = w * 0.8;
      wth2 = w * 0.5;
    } else {
      wth = w * 0.5;
      wth2 = w * 0.3;
    }
    if (index_map != null) {
      _Find_polygons.add(
        Polygon(
          visible: false,
          polygonId: PolygonId("${index_map! - 1}"),
          points: _pg.elementAt(index_map! - 1),
          fillColor: FillColors.elementAt(index_map! - 1),
          strokeWidth: 2,
          strokeColor: Color.fromARGB(160, 190, 30, 30),
        ),
      );
    }
    if (point == true) {
      isSelected = true;
    }
    if (save == true) {
      for (int d = 0; d < listisSelected.length; d++) {
        if (listisSelected[d]['select'] == false) {
          // listisSelected.removeWhere((item) =>
          //     item['comparable_id'] ==
          //     widget.list[d]['comparable_id']);
          listTable.removeWhere((item) =>
              item['comparable_id'] == listisSelected[d]['comparable_id']);
          widget.list.removeWhere((item) =>
              item['propertycomparable_com_id'] ==
              listisSelected[d]['comparable_id']);
          listisSelected.removeWhere((item) =>
              item['comparable_id'] == listisSelected[d]['comparable_id']);
          print('====================');
          print(listisSelected);
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple[900],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
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
                              get_name_search(value);
                            });
                          },
                          textInputAction: TextInputAction.search,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: "Search",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 2),
                            hintStyle: TextStyle(
                              color: Colors.grey[850],
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 0.04,
                            ),
                          ),
                        ),
                      ),
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
                          icon: const Icon(
                            Icons.search,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _getCurrentLocation();
                            });
                          },
                          icon: Icon(Icons.person_pin_circle_outlined)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // title: Text(widget.id.toString()),
        actions: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  for (int d = 0; d < listisSelected.length; d++) {
                    if (listisSelected[d]['select'] == false) {
                      listTable.removeWhere((item) =>
                          item['comparable_id'] ==
                          listisSelected[d]['comparable_id']);
                      widget.list.removeWhere((item) =>
                          item['propertycomparable_com_id'] ==
                          listisSelected[d]['comparable_id']);
                      listisSelected.removeWhere((item) =>
                          item['comparable_id'] ==
                          listisSelected[d]['comparable_id']);
                      print('Can not back');
                      // print('widget.list ==> ${widget.list.length}');
                      // print('listTable ==> ${listTable.length}');
                      // print('listisSelected ==> ${listisSelected.length}');
                      // print(listisSelected);
                    } else {
                      print('Go Back');
                      widget.listTable(listTable);
                      widget.widgetList(widget.list);
                      widget.listisSelected(listisSelected);
                      Back = true;
                    }
                  }
                  if (Back == true)
                    Navigator.pop(context);
                  else
                    print('Can not Go');
                });
              },
              child: Row(
                children: [
                  Icon(Icons.download),
                  Text('Save'),
                ],
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: latLng, zoom: 12),
                      polygons: _Find_polygons,
                      // markers: Set.from(_marker),
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      markers: _marker.map((e) => e).toSet(),
                      // markers: _markers,

                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                      },
                      onCameraMove: (CameraPosition cameraPositiona) {
                        cameraPosition = cameraPositiona; //when map is dragging
                      },
                      mapType: style_map[index],
                      onTap: (argument) {
                        setState(() {
                          _marker.clear();
                          lat_verbal = argument.latitude;
                          log_verbal = argument.longitude;
                          widget.get_lat(argument.latitude.toString());
                          widget.get_log(argument.longitude.toString());
                          _addMarker(argument);
                        });
                      },
                    )),
                SizedBox(height: 5),
                deTail(),
                SizedBox(height: 20),
                // tableValue(),
                Container(
                  height: 280,
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: Colors.grey)),
                  width: double.infinity,
                  child: ListView(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: MyDataTable(
                              list: listTable, listBool: listisSelected),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple[900],
        onPressed: () {
          setState(() {
            if (index < 1) {
              index = index + 1;
            } else {
              index = 0;
            }
          });
        },
        child: Icon(Icons.map),
      ),
    );
  }

  Widget deTail() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(8)),
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      child: awaitvalue
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(
                  right: 30, left: 30, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' ${(comparableId == null) ? "" : comparableId}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        ' ${(propertyTypeName == null) ? "" : propertyTypeName}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                          'Address : ${(provincesName.toString() == 'null') ? "" : provincesName}, ${(districtName.toString() == 'null') ? "" : districtName}, ${(communeName.toString() == 'null') ? "" : communeName}'),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          PrinterPDF(index: indexPDF.toString(), list: listPDF),
                          SizedBox(width: 5),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 17, 140, 9))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Executive_List(),
                                    ));
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                  ),
                                  Text('Edit'),
                                ],
                              )),
                          SizedBox(width: 5),
                          Switch(
                            splashRadius: 30,
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                isSelected = value;

                                if (value == true) {
                                  addItemToList();
                                  // print('list 1 => ${widget.list}');
                                  addItemToListTable();
                                  // print('Table 2 => $listTable');
                                  selectedMain();
                                  // print('TableAdd 3 => $listisSelected');
                                } else {
                                  print('else');
                                  point = false;
                                  isSelected = false;

                                  widget.list.removeWhere((item) =>
                                      item['propertycomparable_com_id'] ==
                                      propertycomparablecomid);
                                  listTable.removeWhere((item) =>
                                      item['comparable_id'] ==
                                      propertycomparablecomid);
                                  listisSelected.removeWhere((item) =>
                                      item['comparable_id'] ==
                                      propertycomparablecomid);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          children: [
                            Data_FromEnd(
                              lable: 'From Date*',
                              valueDate: (value) {
                                setState(() {
                                  start = value;
                                });
                              },
                            ),
                            SizedBox(width: 10),
                            Data_FromEnd(
                              lable: 'To Date*',
                              valueDate: (value) {
                                end = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 130,
                            child: Row(
                              children: [
                                Input_text(
                                  required: true,
                                  valueBack: (value) {
                                    setState(() {
                                      count = value;
                                      print(value);
                                    });
                                  },
                                  typeRead: false,
                                  lable: 'Count*',
                                  type: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 3, 85, 106))),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    waitSearch();
                                  }
                                });
                              },
                              child: Text('Show Surronding')),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  int? index_map;
  Future<void> Find_by_piont(double la, double lo) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${la},${lo}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));

    if (response.statusCode == 200) {
      // Successful response
      var jsonResponse = json.decode(response.body);
      var location = jsonResponse['results'][0]['geometry']['location'];
      var lati = location['lat'];
      var longi = location['lng'];
      lat_verbal = double.parse(lati.toString());
      log_verbal = double.parse(longi.toString());
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
        _marker.clear();
        Find_by_piont(lati, longi);
        _marker.add(newMarker);
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
        _marker.clear();
        Find_by_piont(lati, longi);
        _marker.add(newMarker);
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

  var commune, district;

  final Set<Marker> marker = Set(); //163
  List ln = [];
  List lg = [];
  Future<void> get_name_search(var name) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=${name}&radius=1000&language=km&region=KH&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8&libraries=places';
    final response = await http.get(Uri.parse(url));
    final jsonResponse = json.decode(response.body);
    List ls = jsonResponse['results'];
    List ac;
    for (int j = 0; j < ls.length; j++) {
      // ac = ls[j]['formatted_address'];

      var name = ls[j]['name'].toString();
      var data_lnlg = jsonResponse['results'][j]['geometry']['location'];
      if (h == 0 || h < 250) {
        h += 40;
      }
      lg.add(data_lnlg["lat"]);
      ln.add(data_lnlg["lng"]);
      setState(() {
        name_place.add(name);
      });
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
      _marker.clear();
      lat_verbal = latLng.latitude;
      log_verbal = latLng.longitude;
      _marker.add(newMarker);
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
