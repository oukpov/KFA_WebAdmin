// // ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_brace_in_string_interps, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, avoid_print, unnecessary_new, prefer_collection_literals, unused_field, unused_element, unused_local_variable, prefer_is_empty, use_build_context_synchronously, must_be_immutable, unnecessary_null_comparison

// import 'dart:async';
// import 'dart:collection';
// import 'dart:convert';
// import 'package:admin_web_kfa/interface/navigate_home/Valuation/componen/textInput.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// import '../../../../models/executive/comparable_list.dart';
// import '../../../../models/executive/map_comparable_ex.dart';
// import '../../comparable/search_screen/list_markert.dart';

// import '../Model/model_.dart';
// import '../component/date.dart';

// typedef OnChangeCallback = void Function(dynamic value);

// const kGoogleApiKey = 'AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8';
// final homeScaffoldKey = GlobalKey<ScaffoldState>();

// class Map_Search_Comparable_ extends StatefulWidget {
//   Map_Search_Comparable_(
//       {this.end,
//       required this.delect_first_time,
//       required this.back_f_value,
//       required this.executive_map_table,
//       required this.executive_map_table_comback,
//       required this.list_CP,
//       required this.list,
//       this.start,
//       required this.y_lat,
//       required this.y_log,
//       this.id,
//       required this.list_comparable,
//       required this.listback,
//       required this.hh_,
//       required this.get_province,
//       required this.get_district,
//       required this.get_commune,
//       required this.get_log,
//       required this.get_lat,
//       required this.get_min1,
//       required this.get_max1,
//       required this.get_min2,
//       required this.get_max2,
//       required this.comparablecode});
//   final OnChangeCallback get_province;
//   final OnChangeCallback get_district;
//   final OnChangeCallback comparablecode;
//   final OnChangeCallback get_commune;
//   final OnChangeCallback get_log;
//   final OnChangeCallback get_lat;
//   final OnChangeCallback get_min1;
//   final OnChangeCallback get_max1;
//   final OnChangeCallback get_min2;
//   final OnChangeCallback get_max2;
//   final OnChangeCallback y_lat;
//   final OnChangeCallback listback;
//   final OnChangeCallback y_log;
//   final OnChangeCallback list_comparable;
//   final OnChangeCallback delect_first_time;
//   //
//   final OnChangeCallback executive_map_table;
//   List executive_map_table_comback;
//   List list_CP = [];
//   String? start;
//   String? lat;
//   String? log;
//   String? end;
//   String? hh_;
//   String? id;
//   final OnChangeCallback back_f_value;
//   final List list;

//   @override
//   State<Map_Search_Comparable_> createState() => _SearchPlacesScreenState();
// }

// class _SearchPlacesScreenState extends State<Map_Search_Comparable_> {
//   @override
//   void initState() {
//     hh = double.parse(widget.hh_.toString());
//     super.initState();
//     Last_id_comparable();
//     Get_comparable_filter_id();
//   }

//   bool switchValue = false;
//   String sendAddrress = '';

//   final Set<Marker> _marker = new Set();
//   var _selectedValue;
//   List<String> option = [
//     'Residencial',
//     'Commercial',
//     'Agricultural',
//   ];
//   List totally = [
//     {
//       'numer_id': 1,
//       'type': 'Open',
//     },
//     {
//       'numer_id': 2,
//       'type': 'off',
//     }
//   ];
//   GoogleMapController? mapController;
//   double hh = 0;
//   String? _currentAddress;
//   Position? _currentPosition;

//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services'),
//         ),
//       );
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }

//   double? lat1;
//   double? log1;

//   Future<void> _getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     setState(() {
//       mapController!.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(position.latitude, position.longitude),
//           zoom: 16.0,
//         ),
//       ));
//       lat1 = position.latitude;
//       log1 = position.longitude;
//       latLng = LatLng(lat1!, log1!);
//       _addMarker(latLng);
//     });
//   }

//   List list = [];
//   List listTable = [];
//   double? lat;
//   double? log;
//   Set<Polygon> _Find_polygons = HashSet<Polygon>();
//   List<Color> FillColors = [
//     Color.fromARGB(24, 252, 189, 0),
//     Color.fromARGB(22, 155, 252, 0),
//     Color.fromARGB(20, 0, 252, 42),
//     Color.fromARGB(31, 0, 252, 218),
//     Color.fromARGB(22, 181, 0, 252),
//     Color.fromARGB(28, 252, 0, 55),
//     Color.fromARGB(14, 160, 0, 252),
//     Color.fromARGB(17, 21, 252, 0),
//     Color.fromARGB(14, 252, 143, 0),
//     Color.fromARGB(19, 252, 189, 0),
//     Color.fromARGB(20, 0, 17, 252),
//     Color.fromARGB(20, 252, 0, 0),
//   ];
//   List<String> Title = [
//     "Khan Chamkar Mon",
//     "Khan Daun Penh",
//     "Khan 7 Makara",
//     "Khan Tuol Kouk",
//     "Khan Mean Chey",
//     "Khan Chbar Ampov",
//     "Khan Chroy Changvar",
//     "Khan Sensok",
//     "Khan Russey Keo",
//     "Khan Dangkor",
//     "Khan Pou Senchey",
//     "Khan Preaek Pnov",
//   ];
//   int propertycomparableexecutiveid = 0;
//   int propertycomparablecomid = 0;
//   int propertycomparablestatus = 0;
//   String propertycomparablecreatedby = '';
//   String propertycomparablemodifydate = '';
//   String remembertoken = '';
//   List<Map_executive> lb = [Map_executive(0, 0, 0, '', '', '')];
//   List<ModelTable> lbs = [
//     ModelTable(
//       '',
//       '',
//       '',
//       '',
//       0,
//       '',
//       0,
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       0,
//       0,
//       0,
//       '',
//       '',
//       '',
//       '',
//       '',
//       0,
//       0,
//       0,
//       0,
//       '',
//       0,
//       0,
//       '',
//       '',
//       '',
//       0,
//     )
//   ];
//   void addItemToListTable() {
//     // print('Comparable Id =========> $propertycomparablecomid');
//     setState(() {
//       listTable.add({
//         'property_type_name': propertyTypeName,
//         'provinces_name': provincesName,
//         'district_name': districtName,
//         'commune_name': communeName,
//         'comparable_id': comparableId,
//         'comparable_survey_date': comparableSurveyDate,
//         'comparable_property_id': comparablePropertyId,
//         'comparable_land_length': comparableLandLength,
//         'comparable_land_width': comparableLandWidth,
//         'comparable_land_total': comparableLandTotal,
//         'comparable_sold_length': comparableSoldLength,
//         'comparable_sold_width': comparableSoldWidth,
//         'comparable_sold_total': comparableSoldTotal,
//         'comparable_adding_price': comparableAddingPrice,
//         'comparable_adding_total': comparableAddingTotal,
//         'comparable_sold_price': comparableSoldPrice,
//         'comparable_phone': comparablePhone,
//         'comparable_sold_total_price': comparableSoldTotalPrice,
//         'comparable_condition_id': comparableConditionId,
//         'comparable_year': comparableYear,
//         'comparable_address': comparableAddress,
//         'comparable_province_id': comparableProvinceId,
//         'comparable_district_id': comparableDistrictId,
//         'comparable_commune_id': comparableCommuneId,
//         'comparable_remark': comparableRemark,
//         'comparableaddprice': comparableaddprice,
//         'comparableaddpricetotal': comparableaddpricetotal,
//         'comparableboughtprice': comparableboughtprice,
//         'comparableAmount': comparableAmount,
//         'latlong_log': latlongLog,
//         'latlong_la': latlongLa,
//         'comparabl_user': comparablUser,
//         'comparable_con': comparableCon,
//         'comparableboughtpricetotal': comparableboughtpricetotal,
//         'compare_bank_id': compareBankId,
//         'compare_bank_branch_id': compareBankBranchId,
//         'com_bankofficer': comBankofficer,
//         'com_bankofficer_contact': comBankofficerContact,
//         'comparable_road': comparableRoad,
//         'distance': distance,
//       });
//       lbs.add(
//         ModelTable(
//           propertyTypeName,
//           provincesName,
//           districtName,
//           communeName,
//           comparableId!,
//           comparableSurveyDate!,
//           comparablePropertyId!,
//           comparableLandLength,
//           comparableLandWidth,
//           comparableLandTotal,
//           comparableSoldLength,
//           comparableSoldWidth,
//           comparableSoldTotal,
//           comparableAddingPrice,
//           comparableAddingTotal,
//           comparableSoldPrice,
//           comparablePhone,
//           comparableSoldTotalPrice,
//           comparableConditionId,
//           comparableYear,
//           comparableAddress,
//           comparableProvinceId!,
//           comparableDistrictId!,
//           comparableCommuneId!,
//           comparableRemark,
//           comparableaddprice,
//           comparableaddpricetotal,
//           comparableboughtprice,
//           comparableAmount,
//           latlongLog!,
//           latlongLa!,
//           comparablUser!,
//           comparableCon!,
//           comparableboughtpricetotal,
//           compareBankId!,
//           compareBankBranchId!,
//           comBankofficer,
//           comBankofficerContact,
//           comparableRoad,
//           distance!,
//         ),
//       );
//     });
//   }

//   void addItemToList() {
//     // print('Comparable Id =========> $propertycomparablecomid');
//     setState(() {
//       if (widget.list == []) {
//         list.add({
//           'propertycomparable_executive_id': int.parse(widget.id.toString()),
//           'propertycomparable_com_id': propertycomparablecomid,
//           'propertycomparable_status': 0,
//           'propertycomparable_created_by': propertycomparablecreatedby,
//           'propertycomparable_modify_date': propertycomparablemodifydate,
//           'remember_token': null,
//         });
//         lb.add(
//           Map_executive(
//             int.parse(widget.id.toString()),
//             propertycomparablecomid,
//             0,
//             propertycomparablecreatedby,
//             propertycomparablemodifydate,
//             null,
//           ),
//         );
//       } else {
//         widget.list.add({
//           'propertycomparable_executive_id': int.parse(widget.id.toString()),
//           'propertycomparable_com_id': propertycomparablecomid,
//           'propertycomparable_status': 0,
//           'propertycomparable_created_by': propertycomparablecreatedby,
//           'propertycomparable_modify_date': propertycomparablemodifydate,
//           'remember_token': null,
//         });
//         lb.add(
//           Map_executive(
//             int.parse(widget.id.toString()),
//             propertycomparablecomid,
//             0,
//             propertycomparablecreatedby,
//             propertycomparablemodifydate,
//             null,
//           ),
//         );
//       }
//     });
//   }

//   List _pg = [];
//   String? onTAP_MAP;
//   double? lat_verbal;
//   double? log_verbal;
//   Uint8List? _imageFile;
//   LatLng latLng = const LatLng(11.519037, 104.915120);
//   CameraPosition? cameraPosition;

//   Future<void> _addMarker(LatLng latLng) async {
//     Marker newMarker = Marker(
//       draggable: true,
//       markerId: MarkerId(latLng.toString()),
//       position: latLng,
//       onDragEnd: (value) {
//         latLng = value;
//         Find_by_piont(value.latitude, value.longitude);
//         print('marker');
//       },
//       onTap: () {
//         // AwesomeDialog(
//         //   context: context,
//         //   title: 'Property',
//         //   desc: 'Which One?',
//         //   btnOkText: 'Search',
//         //   btnOkColor: Color.fromARGB(255, 17, 9, 123),
//         //   btnCancelText: 'Comparable',
//         //   btnCancelColor: Color.fromARGB(255, 57, 121, 12),
//         //   btnOkOnPress: () {
//         //     setState(() {
//         //       _marker.clear();
//         //       _addMarker(latLng);
//         //     });
//         //   },
//         // ).show();
//       },
//     );

//     setState(() {
//       _marker.add(newMarker);
//       lat_verbal = latLng.latitude;
//       log_verbal = latLng.longitude;
//       Find_by_piont(latLng.latitude, latLng.longitude);
//       log_verbal;
//       lat_verbal;
//       widget.y_lat(latLng.latitude.toString());
//       widget.y_log(latLng.longitude.toString());
//       print('Pointer');
//       // print('lat = ${lat_verbal} and log =${log_verbal}');
//       // add the new marker to the list of markers
//     });
//   }

//   List _list_comparablecode = [];
//   Future<void> save_cpmaparablle() async {
//     print(comparablecode);
//     final response = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparablecode_comparable/$comparablecode'));
//     if (response.statusCode == 200) {
//       final markerData = jsonDecode(response.body);
//       setState(() {
//         _list_comparablecode = markerData;

//         if (_list_comparablecode != null && switchs == 'marker') {
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) {
//               return List_search0(
//                 list: _list_comparablecode,
//                 comparable_code: comparablecode,
//               );
//             },
//           ));
//         } else {}
//       });
//     } else {
//       Fluttertoast.showToast(
//         msg: 'Failed to fetch markers',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//       );
//     }
//   }

//   String? propertyTypeName;
//   String? provincesName;
//   String? districtName;
//   String? communeName;
//   int? comparableId;
//   String? comparableSurveyDate;
//   int? comparablePropertyId;
//   String? comparableLandLength;
//   String? comparableLandWidth;
//   String? comparableLandTotal;
//   String? comparableSoldLength;
//   String? comparableSoldWidth;
//   String? comparableSoldTotal;
//   String? comparableAddingPrice;
//   String? comparableAddingTotal;
//   String? comparableSoldPrice;
//   String? comparablePhone;
//   String? comparableSoldTotalPrice;
//   String? comparableConditionId;
//   String? comparableYear;
//   String? comparableAddress;
//   int? comparableProvinceId;
//   int? comparableDistrictId;
//   int? comparableCommuneId;
//   String? comparableRemark;
//   String? comparableaddprice;
//   String? comparableaddpricetotal;
//   String? comparableboughtprice;
//   String? comparableAmount;
//   double? latlongLog;
//   double? latlongLa;
//   int? comparablUser;
//   int? comparableCon;
//   String? comparableboughtpricetotal;
//   int? compareBankId;
//   int? compareBankBranchId;
//   String? comBankofficer;
//   String? comBankofficerContact;
//   String? comparableRoad;
//   double? distance;
//   List list_comparable = [];
//   List list_com = [];
//   String? comparable_id;
//   String count = '';
//   List<Map_Comparable> cm = [
//     Map_Comparable(
//       0,
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//       '',
//     )
//   ];

//   late GoogleMapController _mapController;
//   Set<Marker> markers = {};
//   List<int> selectedMarkers = [];
//   bool awaitvalue = false;
//   Future<void> waitSearch() async {
//     awaitvalue = true;
//     await Future.wait([
//       Get_data_Comparable(),
//     ]);
//     setState(() {
//       awaitvalue = false;
//     });
//   }

//   Future<void> Get_data_Comparable() async {
//     print('Click');
//     final response = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_comparables/11.519407/104.917086?start=2022-1-1&end=2023-1-1&count=30'));
//     // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_comparables/$lat_verbal/$log_verbal?start=${widget.start}&end=${widget.end}&count=$count'));
//     if (response.statusCode == 200) {
//       final markerData = jsonDecode(response.body);
//       setState(() {
//         dataOfVerbal = markerData;
//         // print(dataOfVerbal.toString());

//         for (int i = 0; i < dataOfVerbal.length; i++) {
//           List<MarkerData> markerDataList = [
//             MarkerData(
//               latLng: LatLng(
//                   double.parse(dataOfVerbal[i]['latlong_log'].toString()),
//                   double.parse(dataOfVerbal[i]['latlong_la'].toString())),
//               comparableId: dataOfVerbal[i]['comparable_id'].toString(),
//               listWidgets: dataOfVerbal,
//             ),
//           ];

//           _addMarkers(markerDataList, i, dataOfVerbal);
//         }
//       });
//     } else {
//       Fluttertoast.showToast(
//         msg: 'Failed to fetch markers',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//       );
//     }
//   }

//   List? _comparable_filter = [];
//   Future<void> Get_comparable_filter_id() async {
//     final response = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_by_comparable_filter?compare_status=1'));
//     if (response.statusCode == 200) {
//       final markerData = jsonDecode(response.body);
//       setState(() {
//         _comparable_filter = markerData;
//         var sum = _comparable_filter![0]['comparable_filter_id'] + 1;
//         comparable_filter_id = sum.toString();
//         comparable_filter_id;
//       });
//     } else {
//       Fluttertoast.showToast(
//         msg: 'Failed to fetch markers',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//       );
//     }
//   }

//   void showToast(int markerId) {
//     Fluttertoast.showToast(
//       msg: 'Marker $markerId clicked',
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//     );
//   }

//   List? list_marker_id = [];
//   bool isSelected = false;

//   String? switchs;

//   Comparable_select_marker(
//     String propertycomparable_executive_id,
//     String propertycomparable_com_id,
//     String propertycomparable_status,
//     String propertycomparable_created_by,
//     String propertycomparable_modify_date,
//     String remember_token,
//   ) async {
//     String? address;

//     try {
//       Map<String, dynamic> payload = {
//         'propertycomparable_executive_id':
//             int.parse(propertycomparable_executive_id.toString()),
//         'propertycomparable_com_id':
//             int.parse(propertycomparable_com_id.toString()),
//         'propertycomparable_status': 1,
//         'propertycomparable_created_by': null,
//         'propertycomparable_modify_date': null,
//         'remember_token': remember_token
//       };

//       final url = Uri.parse(
//           'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/add_comparable');
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode == 200) {
//         print('Success Executive');
//         Get_comparable_filter_id();
//         switchs = 'marker';
//         // AwesomeDialog(
//         //     context: context,
//         //     animType: AnimType.leftSlide,
//         //     headerAnimationLoop: false,
//         //     dialogType: DialogType.success,
//         //     showCloseIcon: false,
//         //     title: 'Save Successfully',
//         //     autoHide: Duration(seconds: 3),
//         //     onDismissCallback: (type) {
//         //       setState(() {});
//         //       Navigator.pop(context);
//         //     }).show();
//       } else {
//         print('Error 1: ${response.reasonPhrase}');
//       }
//     } catch (error) {
//       print('Error: $error');
//     }
//   }

//   String? comparablecode;
//   String? comparable_filter_id;
//   List last_id = [];
//   Future<void> Last_id_comparable() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable/list_filter?compare_status=1'));
//       if (response.statusCode == 200) {
//         var jsonBody = jsonDecode(response.body);
//         setState(() {
//           last_id = jsonBody;
//           print(last_id.toString());
//           var sum = int.parse(last_id[0]['comparablecode'].toString()) + 1;
//           comparablecode = sum.toString();
//           widget.comparablecode(comparablecode);
//           // var sum = int.parse(last_id[0]['comparablecode'].toString());
//           // comparablecode = sum.toString();
//         });
//       } else {
//         print('Error Last_id_comparable');
//       }
//     } catch (e) {
//       print('Error Last_id_comparable $e');
//     }
//   }

//   String comparable_choose = 'N/A';
//   var formatter = NumberFormat("##,###,###,##0.00", "en_US");

//   String? start, end;
//   int? number_for_count_verbal;
//   List data_of_verbal = [];
//   List data_of_price = [];
//   var size = SizedBox(
//     height: 10,
//   );
//   bool point = false;
//   String? bedhroom_dropdown = '';
//   int inDex = 0;
//   List listAdd = [];
//   String comparable_id_markert = '';
//   List dataOfVerbal = [];
//   void _addMarkers(List<MarkerData> markerDataList, int i, List list) async {
//     for (var markerData in markerDataList) {
//       Marker newMarker = Marker(
//         // draggable: true,
//         markerId: MarkerId(markerData.latLng.toString()),
//         position: markerData.latLng,
//         icon: await BitmapDescriptor.fromAssetImage(
//             ImageConfiguration(size: Size(50, 50)), 'assets/images/pin.png'),
//         onTap: () {
//           setState(() {
//             point = false;
//             isSelected = false;
//             propertycomparablecomid =
//                 int.parse(list[i]['comparable_id'].toString());
//             ////////////
//             propertyTypeName = list[i]['property_type_name'].toString();
//             provincesName = list[i]['provinces_name'].toString();
//             districtName = list[i]['district_name'].toString();
//             communeName = list[i]['commune_name'].toString();
//             comparableId = int.parse(list[i]['comparable_id'].toString());
//             comparableSurveyDate = list[i]['comparable_survey_date'].toString();
//             comparablePropertyId =
//                 int.parse(list[i]['comparable_property_id'].toString());

//             comparableLandLength = list[i]['comparable_land_length'].toString();
//             comparableLandWidth = list[i]['comparable_land_width'].toString();
//             comparableLandTotal = list[i]['comparable_land_total'].toString();
//             comparableSoldLength = list[i]['comparable_sold_length'].toString();
//             comparableSoldWidth = list[i]['comparable_sold_width'].toString();
//             comparableSoldTotal = list[i]['comparable_sold_total'].toString();
//             comparableAddingPrice =
//                 list[i]['comparable_adding_price'].toString();
//             comparableAddingTotal =
//                 list[i]['comparable_adding_total'].toString();

//             comparableSoldPrice = list[i]['comparable_sold_price'].toString();
//             comparablePhone = list[i]['comparable_phone'].toString();
//             comparableSoldTotalPrice =
//                 list[i]['comparable_sold_total_price'].toString();
//             comparableConditionId =
//                 list[i]['comparable_condition_id'].toString();
//             comparableYear = list[i]['comparable_year'].toString();
//             comparableAddress = list[i]['comparable_address'].toString();
//             comparableProvinceId =
//                 int.parse(list[i]['comparable_province_id'].toString());
//             comparableDistrictId =
//                 int.parse(list[i]['comparable_district_id'].toString());

//             comparableCommuneId =
//                 int.parse(list[i]['comparable_commune_id'].toString());
//             comparableRemark = list[i]['comparable_remark'].toString();
//             comparableaddprice = list[i]['comparableaddprice'].toString();
//             comparableaddpricetotal =
//                 list[i]['comparableboughtprice'].toString();
//             comparableboughtprice =
//                 list[i]['comparableaddpricetotal'].toString();
//             comparableAmount = list[i]['comparableAmount'].toString();
//             latlongLog = double.parse(list[i]['latlong_log'].toString());
//             latlongLa = double.parse(list[i]['latlong_la'].toString());

//             comparablUser = int.parse(list[i]['comparabl_user'].toString());
//             comparableCon = int.parse(list[i]['comparable_con'].toString());

//             comparableCon =
//                 int.parse(list[i]['comparable_survey_date'].toString());
//             comparableboughtpricetotal =
//                 list[i]['comparableboughtpricetotal'].toString();

//             compareBankId = int.parse(list[i]['compare_bank_id'].toString());
//             compareBankBranchId =
//                 int.parse(list[i]['compare_bank_branch_id'].toString());

//             comBankofficer = list[i]['com_bankofficer'].toString();
//             comBankofficerContact =
//                 list[i]['com_bankofficer_contact'].toString();

//             comparableRoad = list[i]['comparable_road'].toString();
//             distance = double.parse(list[i]['distance'].toString());

//             inDex = i;
//             listAdd = list;
//             for (int j = 0; j < widget.list.length; j++) {
//               if (widget.list[j]['propertycomparable_com_id'] ==
//                   list[i]['comparable_id']) {
//                 point = true;
//                 print('True');
//               }
//             }
//           });
//         },
//         infoWindow: InfoWindow(
//           snippet: "Comparable ID : ${markerData.comparableId}",
//           onTap: () {
//             setState(() {
//               // print('OnTap');
//               // point_forlooking(list[i]['comparable_id'].toString());
//               // showConfirmationBottomSheet(context, list, i);
//             });
//           },
//           title: markerData.comparableId,
//         ),
//       );
//       setState(() {
//         _marker.add(newMarker);
//       });
//     }
//   }

//   int num = 0;
//   double h = 0;
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//   static const CameraPosition initialCameraPosition =
//       CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 24.0);
//   Set<Marker> markersList = {};
//   late GoogleMapController googleMapController;
//   int id = 1;
//   Set<Polyline> _polylines = Set<Polyline>();
//   List<MapType> style_map = [
//     MapType.hybrid,
//     MapType.normal,
//   ];
//   String? choose_2;
//   TextEditingController Tcon = new TextEditingController();
//   int index = 0;
//   String? name_of_place;
//   GlobalKey<FormState> check = GlobalKey<FormState>();
//   var input;
//   double? wth;
//   double? wth2;

//   ScrollController? controller = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     var sizefont = TextStyle(
//         fontSize: MediaQuery.of(context).size.height * 0.015,
//         fontWeight: FontWeight.bold);
//     double _h = MediaQuery.of(context).size.height * 0.07;
//     double _w = MediaQuery.of(context).size.width * 0.18;
//     var w = MediaQuery.of(context).size.width;
//     if (w < 600) {
//       wth = w * 0.8;
//       wth2 = w * 0.5;
//     } else {
//       wth = w * 0.5;
//       wth2 = w * 0.3;
//     }
//     if (index_map != null) {
//       _Find_polygons.add(
//         Polygon(
//           visible: false,
//           polygonId: PolygonId("${index_map! - 1}"),
//           points: _pg.elementAt(index_map! - 1),
//           fillColor: FillColors.elementAt(index_map! - 1),
//           strokeWidth: 2,
//           strokeColor: Color.fromARGB(160, 190, 30, 30),
//         ),
//       );
//     }
//     if (point == true) {
//       isSelected = true;
//     }

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple[900],

//         title: Padding(
//           padding: const EdgeInsets.only(bottom: 10),
//           child: Row(
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 margin: EdgeInsets.only(
//                   top: 10,
//                 ),
//                 padding: EdgeInsets.only(left: 10),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Form(
//                   key: check,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       SizedBox(
//                         width: wth2,
//                         child: TextFormField(
//                           keyboardType: TextInputType.text,
//                           controller: Tcon,
//                           onFieldSubmitted: (value) {
//                             setState(() {
//                               h = 0;
//                               input = value;
//                               if (num == 0) {
//                                 Find_Lat_log(value);
//                               }
//                             });
//                           },
//                           onChanged: (value) {
//                             // name_place.clear();
//                             setState(() {
//                               input = value;
//                               name_place.clear();
//                               lg.clear();
//                               ln.clear();
//                               h = 0;
//                               num = 0;
//                               get_name_search(value);
//                             });
//                           },
//                           textInputAction: TextInputAction.search,
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                           decoration: InputDecoration(
//                             fillColor: Colors.white,
//                             hintText: "Search",
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.only(top: 2),
//                             hintStyle: TextStyle(
//                               color: Colors.grey[850],
//                               fontSize:
//                                   MediaQuery.of(context).textScaleFactor * 0.04,
//                             ),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                           // splashRadius: 30,
//                           hoverColor: Colors.black,
//                           onPressed: () {
//                             setState(() {
//                               name_place.clear();
//                               lg.clear();
//                               ln.clear();

//                               h = 0;
//                               num = 0;
//                               Find_Lat_log(input);
//                             });
//                           },
//                           icon: const Icon(
//                             Icons.search,
//                             size: 30,
//                           )),
//                       IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _getCurrentLocation();
//                             });
//                           },
//                           icon: Icon(Icons.person_pin_circle_outlined)),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // title: Text(widget.id.toString()),
//         actions: [
//           ElevatedButton(
//               onPressed: () {
//                 setState(() {});
//               },
//               child: Row(
//                 children: [
//                   Icon(Icons.download),
//                   Text('Save'),
//                 ],
//               ))
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.4,
//                   child: GoogleMap(
//                     initialCameraPosition:
//                         CameraPosition(target: latLng, zoom: 12),
//                     polygons: _Find_polygons,
//                     // markers: Set.from(_marker),
//                     zoomGesturesEnabled: true,
//                     zoomControlsEnabled: false,
//                     markers: _marker.map((e) => e).toSet(),
//                     // markers: _markers,

//                     onMapCreated: (GoogleMapController controller) {
//                       mapController = controller;
//                     },
//                     onCameraMove: (CameraPosition cameraPositiona) {
//                       cameraPosition = cameraPositiona; //when map is dragging
//                     },
//                     mapType: style_map[index],
//                     onTap: (argument) {
//                       setState(() {
//                         _marker.clear();
//                         lat_verbal = argument.latitude;
//                         log_verbal = argument.longitude;
//                         widget.get_lat(argument.latitude.toString());
//                         widget.get_log(argument.longitude.toString());
//                         _addMarker(argument);
//                       });
//                     },
//                   )),
//               SizedBox(height: 5),
//               deTail(),
//               SizedBox(height: 10),
//               tableValue()
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.deepPurple[900],
//         onPressed: () {
//           setState(() {
//             if (index < 1) {
//               index = index + 1;
//             } else {
//               index = 0;
//             }
//           });
//         },
//         child: Icon(Icons.map),
//       ),
//     );
//   }

//   List<bool> switchValues = [];
//   String? f = 'one';
//   String? delete = 'delect';
//   Widget _switch(index, list) {
//     return Switch(
//       value: switchValues[index],
//       onChanged: (value) {
//         setState(() {
//           f = 'two';

//           switchValues[index] = value;
//           print(index.toString());

//           // if (f == 'two') {
//           //   // widget.list_map.removeAt(index);
//           // } else {}
//         });
//       },
//     );
//   }

//   List propertyDetails = [];
//   Widget tableValue() {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.7,
//       width: double.infinity,
//       child: ListView(
//         children: [
//           Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.7,
//                 width: double.infinity,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             container('No', 'color'),
//                             container('Action', 'color'),
//                             container('Property Type', 'color'),
//                             container('Land Size', 'color'),
//                             container('Building Size', 'color'),
//                             container('Asking', 'color'),
//                             container('Offered', 'color'),
//                             container('Bought', 'color'),
//                             container('Sold Out', 'color'),
//                             container('Location', 'color'),
//                             container('Survey Date', 'color'),
//                           ],
//                         ),
//                         Text('List => $propertyDetails')

//                         // (widget.list.length > 0)
//                         //     ? Container(
//                         //         height:
//                         //             MediaQuery.of(context).size.height * 0.62,
//                         //         decoration: BoxDecoration(
//                         //             borderRadius: BorderRadius.circular(5),
//                         //             border: Border.all(
//                         //                 width: 1, color: Colors.grey)),
//                         //         width: 30 * 50.0,
//                         //         child: ListView.builder(
//                         //           scrollDirection: Axis.vertical,
//                         //           shrinkWrap: true,
//                         //           physics: NeverScrollableScrollPhysics(),
//                         //           itemCount: propertyDetails.length,
//                         //           itemBuilder: (context, index) {
//                         //             return Padding(
//                         //               padding: const EdgeInsets.all(8.0),
//                         //               child: InkWell(
//                         //                 onTap: () {},
//                         //                 child: Container(
//                         //                   height: MediaQuery.of(context)
//                         //                           .size
//                         //                           .height *
//                         //                       0.07,
//                         //                   width: double.infinity,
//                         //                   child: Row(
//                         //                     children: [
//                         //                       // Text(switchValues[index].toString()),
//                         //                       container(index, 'no_color'),
//                         //                       // _switch(index,
//                         //                       //   ),
//                         //                       container(
//                         //                           propertyDetails[index]
//                         //                                   ['property_type_name']
//                         //                               .toString(),
//                         //                           'no_color'),
//                         //                       container(
//                         //                           propertyDetails[index][
//                         //                                   'comparable_land_total']
//                         //                               .toString(),
//                         //                           'no_color'),
//                         //                       container(
//                         //                           propertyDetails[index][
//                         //                                   'comparable_sold_total']
//                         //                               .toString(),
//                         //                           'no_color'),
//                         //                       container(
//                         //                           propertyDetails[index][
//                         //                                   'comparable_adding_price']
//                         //                               .toString(),
//                         //                           'no_color'),
//                         //                       container(
//                         //                           (propertyDetails[index][
//                         //                                           'comparableaddprice']
//                         //                                       .toString() ==
//                         //                                   'null'
//                         //                               ? ''
//                         //                               : propertyDetails[index][
//                         //                                       'comparableaddprice']
//                         //                                   .toString()),
//                         //                           'no_color'),
//                         //                       container(
//                         //                           (propertyDetails[index][
//                         //                                           'comparableboughtprice']
//                         //                                       .toString() ==
//                         //                                   'null'
//                         //                               ? ''
//                         //                               : propertyDetails[index][
//                         //                                       'comparableboughtprice']
//                         //                                   .toString()),
//                         //                           'no_color'),
//                         //                       container(
//                         //                           propertyDetails[index][
//                         //                                   'comparable_sold_price']
//                         //                               .toString(),
//                         //                           'no_color'),
//                         //                       container(
//                         //                           '${(propertyDetails[index]['provinces_name'].toString() == 'null' ? '' : propertyDetails[index]['provinces_name'].toString())} ${(propertyDetails[index]['district_name'].toString() == 'null' ? '' : propertyDetails[index]['district_name'].toString())} ${(propertyDetails[index]['commune_name'].toString() == 'null' ? '' : propertyDetails[index]['commune_name'].toString())}',
//                         //                           'no_color'),
//                         //                       container(
//                         //                           '${propertyDetails[index]['comparable_survey_date'].toString()}',
//                         //                           'no_color'),
//                         //                     ],
//                         //                   ),
//                         //                 ),
//                         //               ),
//                         //             );
//                         //           },
//                         //         ),
//                         //       )
//                         //     : SizedBox()
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget container(text, color) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 20),
//       child: Container(
//         alignment: Alignment.center,
//         height: MediaQuery.of(context).size.height * 0.05,
//         width: MediaQuery.of(context).size.height * 0.12,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             border: Border.all(width: 1, color: Colors.grey)),
//         child: Text(
//           '$text',
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: MediaQuery.textScaleFactorOf(context) * 14,
//               color: Color.fromARGB(255, 9, 9, 9)),
//         ),
//       ),
//     );
//   }

//   List listTableGet = [];
//   Widget deTail() {
//     return Container(
//       decoration: BoxDecoration(
//           border: Border.all(width: 1, color: Colors.grey),
//           borderRadius: BorderRadius.circular(8)),
//       height: MediaQuery.of(context).size.height * 0.17,
//       width: double.infinity,
//       child: awaitvalue
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Padding(
//               padding: const EdgeInsets.only(
//                   right: 30, left: 30, top: 10, bottom: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         ' ${(propertyTypeName == null) ? "" : propertyTypeName}',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                           'Address : ${(provincesName == null) ? "" : provincesName}, ${(districtName == null) ? "" : districtName}, ${(communeName == null) ? "" : communeName}'),
//                       Row(
//                         children: [
//                           ElevatedButton(
//                               style: ButtonStyle(
//                                   backgroundColor: MaterialStatePropertyAll(
//                                       Color.fromARGB(255, 16, 189, 204))),
//                               onPressed: () {},
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.print),
//                                   Text('Print'),
//                                 ],
//                               )),
//                           SizedBox(width: 5),
//                           ElevatedButton(
//                               style: ButtonStyle(
//                                   backgroundColor: MaterialStatePropertyAll(
//                                       Color.fromARGB(255, 17, 140, 9))),
//                               onPressed: () {},
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.edit,
//                                   ),
//                                   Text('Edit'),
//                                 ],
//                               )),
//                           SizedBox(width: 5),
//                           Switch(
//                             splashRadius: 30,
//                             value: isSelected,
//                             onChanged: (value) {
//                               setState(() {
//                                 isSelected = value;

//                                 if (value == true) {
//                                   addItemToList();
//                                   // addItemToListTable();

//                                   // for (int i = 0; i < widget.list.length; i++) {
//                                   //   for (int j = 0;
//                                   //       j < dataOfVerbal.length;
//                                   //       j++) {
//                                   //     if (widget.list[i]
//                                   //             ['propertycomparable_com_id'] ==
//                                   //         dataOfVerbal[j]['comparable_id']) {
//                                   //       print('=====================');

//                                   //       propertyDetails = dataOfVerbal[j];
//                                   //       print(
//                                   //           '======================${propertyDetails}');
//                                   //     }
//                                   //   }
//                                   // }
//                                 } else {
//                                   print('else');
//                                   point = false;
//                                   isSelected = false;

//                                   widget.list.removeWhere((item) =>
//                                       item['propertycomparable_com_id'] ==
//                                       propertycomparablecomid);
//                                 }
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             print('List ==============> ${widget.list}');
//                           },
//                           child: Text('Get'))
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.5,
//                         child: Row(
//                           children: [
//                             Data_FromEnd(
//                               lable: 'From Date*',
//                               valueDate: (value) {
//                                 setState(() {
//                                   start = value;
//                                 });
//                               },
//                             ),
//                             SizedBox(width: 10),
//                             Data_FromEnd(
//                               lable: 'To Date*',
//                               valueDate: (value) {
//                                 print(value.toString());
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 130,
//                             child: Row(
//                               children: [
//                                 Input_text(
//                                   valueBack: (value) {
//                                     setState(() {
//                                       count = value;
//                                     });
//                                   },
//                                   typeRead: false,
//                                   lable: 'Count*',
//                                   type: true,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           ElevatedButton(
//                               style: ButtonStyle(
//                                   backgroundColor: MaterialStatePropertyAll(
//                                       Color.fromARGB(255, 3, 85, 106))),
//                               onPressed: () {
//                                 setState(() {
//                                   waitSearch();
//                                 });
//                               },
//                               child: Text('Show Surronding')),
//                         ],
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   int? index_map;
//   Future<void> Find_by_piont(double la, double lo) async {
//     final response = await http.get(Uri.parse(
//         'https://maps.googleapis.com/maps/api/geocode/json?latlng=${la},${lo}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));

//     if (response.statusCode == 200) {
//       // Successful response
//       var jsonResponse = json.decode(response.body);
//       var location = jsonResponse['results'][0]['geometry']['location'];
//       var lati = location['lat'];
//       var longi = location['lng'];
//       lat_verbal = double.parse(lati.toString());
//       log_verbal = double.parse(longi.toString());
//       widget.get_lat(lati.toString());
//       widget.get_log(longi.toString());
//       List ls = jsonResponse['results'];
//       List ac;
//       bool check_sk = false, check_kn = false;
//       for (int j = 0; j < ls.length; j++) {
//         ac = jsonResponse['results'][j]['address_components'];
//         for (int i = 0; i < ac.length; i++) {
//           if (check_kn == false || check_sk == false) {
//             if (jsonResponse['results'][j]['address_components'][i]['types']
//                     [0] ==
//                 "political") {
//               setState(() {
//                 check_kn = true;
//                 district = (jsonResponse['results'][j]['address_components'][i]
//                     ['short_name']);
//                 // Load_khan(district);

//                 widget.get_district(jsonResponse['results'][j]
//                     ['address_components'][i]['short_name']);
//               });
//             }
//             if (jsonResponse['results'][j]['address_components'][i]['types']
//                     [0] ==
//                 "administrative_area_level_3") {
//               setState(() {
//                 check_sk = true;
//                 commune = (jsonResponse['results'][j]['address_components'][i]
//                     ['short_name']);
//                 // Load_sangkat(commune);
//                 widget.get_commune(jsonResponse['results'][j]
//                     ['address_components'][i]['short_name']);
//               });
//             }
//           }
//         }
//       }
//     } else {
//       // Error or invalid response
//       print(response.statusCode);
//     }
//   }

//   List name_place = [];
//   Future<void> Find_Lat_log(var place) async {
//     var check_charetor = place.split(',');
//     if (check_charetor.length == 1) {
//       String url =
//           'https://maps.googleapis.com/maps/api/geocode/json?address=${check_charetor[0]}&region=kh&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8';
//       final response = await http.get(Uri.parse(url));
//       final jsonResponse = json.decode(response.body);
//       var location = jsonResponse['results'][0]['geometry']['location'];
//       var lati = location['lat'];
//       var longi = location['lng'];
//       // widget.lat(lati.toString());
//       // widget.log(longi.toString());
//       latLng = LatLng(lati, longi);
//       Marker newMarker = Marker(
//         draggable: true,
//         markerId: MarkerId(latLng.toString()),
//         position: latLng,
//         onDragEnd: (value) {
//           latLng = value;
//           Find_by_piont(value.latitude, value.longitude);
//         },
//         infoWindow: InfoWindow(title: 'KFA\'s Developer'),
//       );
//       setState(() {
//         _marker.clear();
//         Find_by_piont(lati, longi);
//         _marker.add(newMarker);
//       });

//       // print('------------------- $latitude');
//       // print('------------------- $longitude');

//       mapController?.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(target: latLng, zoom: 13)));
//       List ls = jsonResponse['results'];
//       List ac;
//       for (int j = 0; j < ls.length; j++) {
//         ac = jsonResponse['results'][j]['address_components'];
//         for (int i = 0; i < ac.length; i++) {
//           if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
//               "administrative_area_level_3") {
//             setState(() {
//               // widget.commune(jsonResponse['results'][j]['address_components'][i]
//               //     ['short_name']);
//               print('Value ');
//             });
//           }
//           if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
//               "administrative_area_level_2") {
//             setState(() {
//               // widget.district(jsonResponse['results'][j]['address_components']
//               //     [i]['short_name']);
//             });
//           }
//         }
//       }
//     } else {
//       final response = await http.get(Uri.parse(
//           'https://maps.googleapis.com/maps/api/geocode/json?latlng=${check_charetor[0]},${check_charetor[1]}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));

//       // Successful response
//       var jsonResponse = json.decode(response.body);
//       var location = jsonResponse['results'][0]['geometry']['location'];
//       var lati = location['lat'];
//       var longi = location['lng'];
//       // widget.lat(lati.toString());
//       // widget.log(longi.toString());
//       latLng = LatLng(lati, longi);
//       Marker newMarker = Marker(
//         draggable: true,
//         markerId: MarkerId(latLng.toString()),
//         position: latLng,
//         onDragEnd: (value) {
//           latLng = value;
//           Find_by_piont(value.latitude, value.longitude);
//         },
//         infoWindow: InfoWindow(title: 'KFA\'s Developer'),
//       );
//       setState(() {
//         _marker.clear();
//         Find_by_piont(lati, longi);
//         _marker.add(newMarker);
//       });

//       // print('------------------- $latitude');
//       // print('------------------- $longitude');

//       mapController?.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(target: latLng, zoom: 13)));
//       List ls = jsonResponse['results'];
//       List ac;
//       for (int j = 0; j < ls.length; j++) {
//         ac = jsonResponse['results'][j]['address_components'];
//         for (int i = 0; i < ac.length; i++) {
//           if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
//               "administrative_area_level_3") {
//             setState(() {
//               // widget.commune(jsonResponse['results'][j]['address_components'][i]
//               //     ['short_name']);
//             });
//           }
//           if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
//               "administrative_area_level_2") {
//             setState(() {
//               // widget.district(jsonResponse['results'][j]['address_components']
//               //     [i]['short_name']);
//             });
//           }
//         }
//       }
//     }
//   }

//   var commune, district;

//   final Set<Marker> marker = Set(); //163
//   List ln = [];
//   List lg = [];
//   Future<void> get_name_search(var name) async {
//     String url =
//         'https://maps.googleapis.com/maps/api/place/textsearch/json?query=${name}&radius=1000&language=km&region=KH&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8&libraries=places';
//     final response = await http.get(Uri.parse(url));
//     final jsonResponse = json.decode(response.body);
//     List ls = jsonResponse['results'];
//     List ac;
//     for (int j = 0; j < ls.length; j++) {
//       // ac = ls[j]['formatted_address'];

//       var name = ls[j]['name'].toString();
//       var data_lnlg = jsonResponse['results'][j]['geometry']['location'];
//       if (h == 0 || h < 250) {
//         h += 40;
//       }
//       lg.add(data_lnlg["lat"]);
//       ln.add(data_lnlg["lng"]);
//       setState(() {
//         name_place.add(name);
//       });
//     }
//   }

//   Future<void> poin_map_by_search(var ln, var lg) async {
//     final response = await http.get(Uri.parse(
//         'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lg},${ln}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));
//     var jsonResponse = json.decode(response.body);
//     latLng = LatLng(double.parse(lg), double.parse(ln));
//     Marker newMarker = Marker(
//       draggable: true,
//       markerId: MarkerId(latLng.toString()),
//       position: latLng,
//       onDragEnd: (value) {
//         latLng = value;
//         Find_by_piont(value.latitude, value.longitude);
//       },
//       infoWindow: InfoWindow(title: 'KFA\'s Developer'),
//     );
//     setState(() {
//       _marker.clear();
//       lat_verbal = latLng.latitude;
//       log_verbal = latLng.longitude;
//       _marker.add(newMarker);
//     });
//     mapController?.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(target: latLng, zoom: 13)));
//     List ls = jsonResponse['results'];
//     List ac;
//     for (int j = 0; j < ls.length; j++) {
//       ac = jsonResponse['results'][j]['address_components'];
//       for (int i = 0; i < ac.length; i++) {
//         if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
//             "administrative_area_level_3") {
//           setState(() {});
//         }
//         if (jsonResponse['results'][j]['address_components'][i]['types'][0] ==
//             "administrative_area_level_2") {
//           setState(() {});
//         }
//       }
//     }
//   }

//   Future<Uint8List> _generatePdf(
//       PdfPageFormat format, List items, int index) async {
//     // Create a new PDF document
//     double sizefont = MediaQuery.of(context).size.height * 0.013;
//     final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
//     final font = await PdfGoogleFonts.nunitoExtraLight();
//     final ByteData bytes =
//         await rootBundle.load('assets/images/New_KFA_Logo.png');
//     final Uint8List byteList = bytes.buffer.asUint8List();
//     Uint8List image_latlog = (await NetworkAssetBundle(Uri.parse(
//                 'https://maps.googleapis.com/maps/api/staticmap?center=${items[index]['latlong_log']},${items[index]['latlong_la']}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${items[index]['latlong_log']},${items[index]['latlong_la'].toString()}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'))
//             .load(
//                 'https://maps.googleapis.com/maps/api/staticmap?center=${items[index]['latlong_log']},${items[index]['latlong_la']}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${items[index]['latlong_log']},${items[index]['latlong_la'].toString()}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'))
//         .buffer
//         .asUint8List();
//     pdf.addPage(pw.MultiPage(
//       // orientation: pw.PageOrientation.landscape,
//       build: (context) {
//         return [
//           pw.Padding(
//             padding: pw.EdgeInsets.only(top: 0, bottom: 10),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Container(
//                   height: 70,
//                   margin: pw.EdgeInsets.only(bottom: 5),
//                   child: pw.Row(
//                     children: [
//                       pw.Container(
//                         width: 80,
//                         height: 50,
//                         child: pw.Image(
//                             pw.MemoryImage(
//                               byteList,
//                               // bytes1,
//                             ),
//                             fit: pw.BoxFit.fill),
//                       ),
//                       pw.SizedBox(width: 50),
//                       pw.Text("KMER FOUNDATION APPAISAL",
//                           style: pw.TextStyle(
//                               fontWeight: pw.FontWeight.bold, fontSize: 20)),
//                     ],
//                   ),
//                 ),
//                 pw.Text(
//                     'Kfanhrm.cc/KFACRM/content/comparable_form/comparable_print.php?comparable_id=${items[index]['comparable_id'].toString()}',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text(
//                     'Date of inspection : ${items[index]['comparable_survey_date'].toString()}',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text(
//                     'Address : ${items[index]['commune_name'].toString()}  ${items[index]['district_name'].toString()}  ${items[index]['provinces_name'].toString()}',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text('Owner : ${items[index]['comparable_con'].toString()}',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text('Inspectors : Null',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Padding(
//                   padding: pw.EdgeInsets.only(left: 30, right: 30),
//                   child: pw.Container(
//                     height: 200,
//                     width: double.infinity,
//                     child: pw.Image(pw.MemoryImage(image_latlog),
//                         fit: pw.BoxFit.cover),
//                   ),
//                 ),
//                 pw.SizedBox(height: 10),
//                 // pw.Text('Property Compare',
//                 //     style: pw.TextStyle(
//                 //         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text(
//                     '${items[index]['property_type_name'].toString()} (${items[index]['comparable_id'].toString()})',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text('${items[index]['comparable_survey_date'].toString()}',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text(
//                     'LS : ${items[index]['comparable_land_length'].toString()} x ${items[index]['comparable_land_width'].toString()} = ${items[index]['comparable_land_total'].toString()} sqm',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text(
//                     'BS : ${items[index]['comparable_sold_length'].toString()} x ${items[index]['comparable_sold_width'].toString()} = ${items[index]['comparable_sold_total'].toString()} sqm',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text(
//                     'Asking Price : ${items[index]['comparable_adding_price'].toString()}\$',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text(
//                     'Offered Price : ${items[index]['comparableaddprice'].toString()}\$',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text(
//                     'Sold Of Price : ${items[index]['comparable_sold_price'].toString()}\$',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text('Tel: ${items[index]['comparable_phone'].toString()}',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 /////////////////
//                 pw.Text('lat: ${items[index]['latlong_la'].toString()}',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//                 pw.Text('log: ${items[index]['latlong_log'].toString()}',
//                     style: pw.TextStyle(
//                         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
//               ],
//             ),
//           )
//         ];
//       },
//     ));
//     bool isprint = false;
//     final Color_Test = Color.fromARGB(255, 131, 18, 10);
//     // Get the bytes of the PDF document
//     final pdfBytes = pdf.save();

//     // Print the PDF document to the default printer
//     await Printing.layoutPdf(
//         onLayout: (PdfPageFormat format) async => pdfBytes);
//     return pdf.save();
//   }
// }

// class MarkerData {
//   final LatLng latLng;
//   final String comparableId;
//   final List listWidgets;

//   MarkerData({
//     required this.latLng,
//     required this.comparableId,
//     required this.listWidgets,
//   });
// }
