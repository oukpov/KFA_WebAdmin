// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_brace_in_string_interps, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, avoid_print, unnecessary_new, prefer_collection_literals, unused_field, unused_element, unused_local_variable, prefer_is_empty, use_build_context_synchronously, must_be_immutable, unnecessary_null_comparison

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../comparable_1/Edit_Comparable.dart';
import 'list_markert.dart';

typedef OnChangeCallback = void Function(dynamic value);

const kGoogleApiKey = 'AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class Map_Search_Comparable extends StatefulWidget {
  Map_Search_Comparable({
    this.Amount,
    this.askingprice,
    this.bank_brand,
    this.bank_contact,
    this.bank_officer,
    this.bankname,
    this.con_user,
    this.condition,
    this.cummune_id,
    this.district_id,
    this.w,
    this.wb,
    this.l,
    this.year,
    this.lb,
    this.property_type,
    this.provice_map,
    this.total,
    this.total_b,
    this.total_price,
    this.sold_price,
    this.songkat,
    this.sqm_total,
    super.key,
    this.id_road,
    this.end,
    this.start,
    this.log,
    this.lat,
    this.officer_price,
    this.officer_price_total,
    required this.hh_,
    required this.get_province,
    required this.get_district,
    required this.get_commune,
    required this.get_log,
    required this.get_lat,
    required this.get_min1,
    required this.get_max1,
    required this.get_min2,
    required this.get_max2,
  });
  final OnChangeCallback get_province;
  final OnChangeCallback get_district;
  final OnChangeCallback get_commune;
  final OnChangeCallback get_log;
  final OnChangeCallback get_lat;
  final OnChangeCallback get_min1;
  final OnChangeCallback get_max1;
  final OnChangeCallback get_min2;
  final OnChangeCallback get_max2;
  String? start;
  String? lat;
  String? log;
  String? end;
  String? hh_;

  ////// Bank search
  String? bankname = '';
  String? bank_brand = '';
  String? bank_officer = '';
  String? bank_contact = '';
  String? property_type = '';
  String? id_road = '';
  String? l = '';
  String? w = '';
  String? total = '';
  String? askingprice = '';
  String? sqm_total = '';
  String? Amount = '';
  String? songkat = '';
  String? provice_map = '';
  String? khan = '';

  String? provnce_id = '';
  String? district_id = '';
  String? cummune_id = '';
  String? lb = '';
  String? wb = '';
  String? total_b = '';
  String? officer_price = '';
  String? officer_price_total = '';
  String? sold_price = '';
  String? total_price = '';
  String? condition = '';
  String? year = '';
  String? remak = '';
  String? con_user = '';
  @override
  State<Map_Search_Comparable> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<Map_Search_Comparable> {
  @override
  void initState() {
    hh = double.parse(widget.hh_.toString());
    super.initState();
    Last_id_comparable();
    Get_comparable_filter_id();
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
  Set<Marker> _markers = {};
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

  bool _marker0 = false;
  Future<void> _await_marker() async {
    _marker0 = true;
    Future.wait([
      Get_data_Comparable(),
    ]);
    setState(() {
      _marker0 = false;
    });
  }

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

  List _pg = [];
  String? onTAP_MAP;
  double? lat_verbal;
  double? log_verbal;
  Uint8List? _imageFile;
  LatLng latLng = const LatLng(11.519037, 104.915120);
  CameraPosition? cameraPosition;
  String? marker_bool = 'false';
  String? marker_if = 'if_else_marker';
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

  late GoogleMapController _mapController;
  Set<Marker> markers = {};
  List<int> selectedMarkers = [];
// ${(int.parse(widget.lb.toString()) != 0) ? widget.lb : ''}${(int.parse(widget.total_b.toString()) != 0) ? widget.total_b : ''}
  List? _list = [];
  Future<void> Get_data_Comparable() async {
    final response = await http.get(Uri.parse(
        // 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_comparable/$lat_verbal/$log_verbal?start=${widget.start}&end=${widget.end}${widget.Amount}${widget.askingprice}${widget.bank_brand}${widget.bank_contact}${widget.bank_officer}${widget.bankname}${widget.con_user}${widget.condition}${widget.cummune_id}${widget.district_id}${widget.w}${widget.l}${widget.lb}${widget.property_type}${widget.provice_map}${widget.total}${widget.total_b}${widget.total_price}${widget.sold_price}${widget.songkat}${widget.sqm_total}'));
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_comparable/$lat_verbal/$log_verbal?start=${widget.start}&end=${widget.end}${widget.provice_map}${widget.district_id}${widget.cummune_id}${widget.wb.toString() != '&comparable_sold_width=0' ? widget.wb : ''}${widget.lb.toString() != '&comparable_sold_length=0' ? widget.lb : ''}${widget.total_b.toString() != '&comparable_sold_total=0' ? widget.total_b : ''}${widget.l.toString() != '&comparable_land_length=0' ? widget.l : ''}${widget.w.toString() != '&comparable_land_width=0' ? widget.w : ''}${widget.l.toString() != '&comparable_land_total=0' ? widget.l : ''}${widget.sold_price == '&comparableaddprice=' ? '' : widget.sold_price}${widget.total_price == null ? '' : widget.total_price}${widget.officer_price == '&comparable_sold_price=' ? '' : widget.officer_price}${widget.officer_price_total == null ? '' : widget.officer_price_total}${widget.askingprice == '&comparable_adding_price=' ? '' : widget.askingprice}${widget.sqm_total == null ? '' : widget.sqm_total}${widget.Amount == '&comparableAmount=' ? '' : widget.Amount}${widget.con_user.toString() != '&comparable_phone=' ? widget.con_user : ''}${widget.year.toString() != '&comparable_year=' ? widget.year : ''}${widget.condition.toString() != null ? widget.condition : ''}${widget.bankname.toString() != null ? widget.bankname : ''}${widget.bank_brand.toString() != null ? widget.bank_brand : ''}${widget.bank_officer.toString() != '&com_bankofficer=' ? widget.bank_officer : ''}${widget.bank_officer.toString() != '&com_bankofficer_contact=' ? widget.bank_officer : ''}${widget.property_type.toString() != null ? widget.property_type : ''}${widget.id_road.toString() != null ? widget.id_road : ''}'));
    if (response.statusCode == 200) {
      final markerData = jsonDecode(response.body);
      setState(() {
        dataOfVerbal = markerData;
        print(dataOfVerbal.toString());
        print(widget.provice_map.toString());

        for (int i = 0; i < dataOfVerbal.length; i++) {
          List<MarkerData> markerDataList = [
            MarkerData(
              latLng: LatLng(
                  double.parse(dataOfVerbal[i]['latlong_log'].toString()),
                  double.parse(dataOfVerbal[i]['latlong_la'].toString())),
              comparableId: dataOfVerbal[i]['comparable_id'].toString(),
              listWidgets: dataOfVerbal, // Add your widgets here
            ),
          ];
          _addMarkers(markerDataList, i, dataOfVerbal);
        }
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
  var isSelected;
  void showConfirmationBottomSheet(
      int i,
      List list,
      comparable_filter_ids,
      int markerId,
      Province,
      comparablecode,
      District,
      Commune,
      comparablUser,
      compare_status) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        isSelected = selectedMarkers.contains(markerId);

        return Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${list[i]['property_type_name'].toString()} (${list[i]['comparable_id'].toString()})',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.018),
                ),
                SizedBox(height: 10),
                Text(
                  'Address : ${list[i]['provinces_name'].toString()}  ${list[i]['district_name'].toString()}  ${list[i]['commune_name'].toString()}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.018),
                ),
                SizedBox(height: 10),
                Text(
                  'Land : ${list[i]['comparable_land_length'].toString()} x ${list[i]['comparable_land_width'].toString()} = ${list[i]['comparable_land_total'].toString()}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.018),
                ),
                SizedBox(height: 10),
                Text(
                  'Asking Price : ${list[i]['comparable_adding_price'].toString()}\$',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.018),
                ),

                // Text('Marker ID: $markerId /$comparablecode'),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GFButton(
                      onPressed: () {
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Detail_Screen(
                                  list: list, index: i.toString());
                            },
                          ));
                        });
                      },
                      text: "Edit Screen",
                      color: Color.fromARGB(255, 11, 121, 15),
                      icon: Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                      type: GFButtonType.outline2x,
                    ),
                    IconButton(
                        onPressed: () async {
                          await Printing.layoutPdf(
                              onLayout: (format) =>
                                  _generatePdf(format, list, i));
                        },
                        icon: Icon(
                          Icons.print,
                          color: Color.fromARGB(255, 20, 25, 169),
                          size: MediaQuery.of(context).size.height * 0.06,
                        )),
                    SizedBox(width: 8),
                    Switch(
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          if (value) {
                            Comparable_select_marker(
                                comparable_filter_id.toString(),
                                markerId.toString(),
                                '${comparablecode.toString()}',
                                '$Province',
                                '${District.toString()}',
                                '${Commune.toString()}',
                                '$comparablUser',
                                '1');
                            selectedMarkers.add(markerId);
                            Navigator.pop(context);
                            showConfirmationBottomSheet(
                                i,
                                dataOfVerbal,
                                comparable_filter_id.toString(),
                                markerId,
                                Province.toString(),
                                comparablecode.toString(),
                                District.toString(),
                                Commune.toString(),
                                comparablUser.toString(),
                                '1');
                          } else {
                            selectedMarkers.remove(markerId);
                            Navigator.pop(context);
                            _delete_open(markerId);
                            showConfirmationBottomSheet(
                                i,
                                dataOfVerbal,
                                comparable_filter_id.toString(),
                                markerId,
                                Province.toString(),
                                comparablecode.toString(),
                                District.toString(),
                                Commune.toString(),
                                comparablUser.toString(),
                                '1');
                          }
                        });
                        showToast(markerId);
                        // print('Switch toggled for marker $markerId: $value');

                        // Make an HTTP POST request to send the data to the server
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? switchs;
  void _delete_open(id) async {
    final response = await http.delete(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Comparable_marker_delete/$id'));
    if (response.statusCode == 200) {
      setState(() {
        var sum = int.parse(comparable_filter_id.toString()) - 1;
        comparable_filter_id = sum.toString();
      });
    } else {
      throw Exception('Delete error occured!');
    }
    setState(() {
      print('Success Deleted');
    });
  }

  Comparable_select_marker(
    String comparable_filter_id,
    String compare_id,
    String comparablecode,
    String Province,
    String District,
    String Commune,
    String comparablUser,
    String compare_status,
  ) async {
    String? address;

    try {
      Map<String, dynamic> payload = {
        'comparable_filter_id': int.parse(comparable_filter_id.toString()),
        'compare_id': int.parse(compare_id.toString()),
        'comparablecode': comparablecode.toString(),
        'Province': int.parse(Province.toString()),
        'District': int.parse(District.toString()),
        'comparablUser': int.parse(comparablUser.toString()),
        'compare_status': 1,
      };

      final url = Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Comparable_marker');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        print('Success Comparable');
        Get_comparable_filter_id();
        switchs = 'marker';
        // AwesomeDialog(
        //     context: context,
        //     animType: AnimType.leftSlide,
        //     headerAnimationLoop: false,
        //     dialogType: DialogType.success,
        //     showCloseIcon: false,
        //     title: 'Save Successfully',
        //     autoHide: Duration(seconds: 3),
        //     onDismissCallback: (type) {
        //       setState(() {});
        //       Navigator.pop(context);
        //     }).show();
      } else {
        print('Error 1: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

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

  String? bool_get;
  String? comparable_idp;
  List last_point_forlooking = [];

  String comparable_choose = 'N/A';
  var formatter = NumberFormat("##,###,###,##0.00", "en_US");
  var _color = TextStyle(
      color: Color.fromARGB(255, 5, 128, 28), fontWeight: FontWeight.bold);
  var _colortext = TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  String? start, end;
  int? number_for_count_verbal;
  List data_of_verbal = [];
  List data_of_price = [];
  var size = SizedBox(
    height: 10,
  );

  String? bedhroom_dropdown = '';

  String comparable_id_markert = '';
  List dataOfVerbal = [];
  void _addMarkers(List<MarkerData> markerDataList, int i, List list) async {
    for (var markerData in markerDataList) {
      Marker newMarker = Marker(
        draggable: true,
        markerId: MarkerId(markerData.latLng.toString()),
        position: markerData.latLng,
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(50, 50)), 'assets/images/pin.png'),
        onTap: () {
          showConfirmationBottomSheet(
            i,
            list,
            '21',
            list[i]['comparable_id'],
            list[i]['comparable_province_id'].toString(),
            comparablecode,
            list[i]['comparable_district_id'].toString(),
            list[i]['comparable_commune_id'].toString(),
            '22',
            '1',
          );
        },
        infoWindow: InfoWindow(
          snippet: "${markerData.comparableId}",
          onTap: () {
            setState(() {
              // point_forlooking(list[i]['comparable_id'].toString());
              // showConfirmationBottomSheet(context, list, i);
            });
          },
          title: markerData.comparableId,
        ),
      );
      setState(() {
        _marker.add(newMarker);
      });
    }
  }

  List data_of_verbal_rent = [];

  var maxSqm1, minSqm1;
  var maxSqm2, minSqm2;

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
  ScrollController? controller = ScrollController();
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

    return Scaffold(
      appBar: (hh != 0)
          ? AppBar(
              centerTitle: true,
              backgroundColor: Colors.deepPurple[900],
              // title: Text('$comparablecode'),
              title: Text(
                '${comparablecode}',
              ),
              actions: [
                InkWell(
                  onTap: () {
                    setState(() {
                      save_cpmaparablle();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 31, 175, 9),
                        borderRadius: BorderRadius.circular(10)),
                    height: _h,
                    width: _w,
                    child: Text(
                      'Save',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            )
          : null,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            SizedBox(
                child: GoogleMap(
              initialCameraPosition: CameraPosition(target: latLng, zoom: 12),
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
            Row(
              children: [
                Container(
                  width: wth,
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
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
                                    MediaQuery.of(context).textScaleFactor *
                                        0.04,
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
                (hh != 0)
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            Get_data_Comparable();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 20, 7, 169),
                              borderRadius: BorderRadius.circular(10)),
                          height: _h,
                          width: _w,
                          child: Text(
                            'Search',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
            if (name_place.length >= 1)
              Container(
                height: h,
                color: Colors.white,
                margin: EdgeInsets.only(left: 10, right: 55, top: 60),
                child: ListView.builder(
                  itemCount: name_place.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: InkWell(
                        onTap: () {
                          Tcon;
                          print(name_place[index]);
                          h = 0;
                          Tcon;
                          num = 1; // use num for when user click on list search
                          name_of_place != name_place[index].toString();
                          poin_map_by_search(
                              ln[index].toString(), lg[index].toString());
                        },
                        child: Text(
                          name_place[index],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                ),
              ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 200,
                      child: ListView.builder(
                        itemCount: data_of_verbal.length,
                        itemBuilder: (context, index) {
                          return Text(
                            'id =${data_of_verbal[index]['latlong_log']}  ||  ${data_of_verbal[index]['latlong_la']}',
                            style: TextStyle(color: Colors.white),
                          );
                        },
                      ),
                    )
                    // ToFromDate_p(
                    //   fromDate: (value) {
                    //     setState(() {
                    //       start = value.toString();
                    //       start;
                    //     });
                    //   },
                    //   toDate: (value) {
                    //     setState(() {
                    //       end = value.toString();
                    //       end;
                    //     });
                    //   },
                    // ),
                  ],
                ),
              ),
            )
          ],
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

  int? index_map;
  Future<void> Find_by_piont(double la, double lo) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${la},${lo}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

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
          'https://maps.googleapis.com/maps/api/geocode/json?address=${check_charetor[0]}&region=kh&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
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
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${check_charetor[0]},${check_charetor[1]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

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

  List list = [];

  final Set<Marker> marker = Set(); //163
  List ln = [];
  List lg = [];
  Future<void> get_name_search(var name) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=${name}&radius=1000&language=km&region=KH&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI&libraries=places';
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
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lg},${ln}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));
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

  Future<dynamic> maker_of_verbal_in_map(
      List data_latlog, List values_min, List values_max) async {
    for (int i = 0; i < data_latlog.length; i++) {
      Marker newMarker = Marker(
        draggable: true,
        markerId: MarkerId(i.toString()),
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(80, 80)), 'assets/images/pin.png'),
        position:
            LatLng(data_latlog[i]['latlong_log'], data_latlog[i]['latlong_la']),
        infoWindow: InfoWindow(
            title:
                '${values_min[i].toString()}\$ ~ ${values_max[i].toString()}\$'),
      );
      setState(() {
        _marker.add(newMarker);
      });
    }
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, List items, int index) async {
    // Create a new PDF document
    double sizefont = MediaQuery.of(context).size.height * 0.013;
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final ByteData bytes =
        await rootBundle.load('assets/images/New_KFA_Logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    Uint8List image_latlog = (await NetworkAssetBundle(Uri.parse(
                'https://maps.googleapis.com/maps/api/staticmap?center=${items[index]['latlong_log']},${items[index]['latlong_la']}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${items[index]['latlong_log']},${items[index]['latlong_la'].toString()}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'))
            .load(
                'https://maps.googleapis.com/maps/api/staticmap?center=${items[index]['latlong_log']},${items[index]['latlong_la']}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${items[index]['latlong_log']},${items[index]['latlong_la'].toString()}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'))
        .buffer
        .asUint8List();
    pdf.addPage(pw.MultiPage(
      // orientation: pw.PageOrientation.landscape,
      build: (context) {
        return [
          pw.Padding(
            padding: pw.EdgeInsets.only(top: 0, bottom: 10),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  height: 70,
                  margin: pw.EdgeInsets.only(bottom: 5),
                  child: pw.Row(
                    children: [
                      pw.Container(
                        width: 80,
                        height: 50,
                        child: pw.Image(
                            pw.MemoryImage(
                              byteList,
                              // bytes1,
                            ),
                            fit: pw.BoxFit.fill),
                      ),
                      pw.SizedBox(width: 50),
                      pw.Text("KMER FOUNDATION APPAISAL",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                ),
                pw.Text(
                    'Kfanhrm.cc/KFACRM/content/comparable_form/comparable_print.php?comparable_id=${items[index]['comparable_id'].toString()}',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(
                    'Date of inspection : ${items[index]['comparable_survey_date'].toString()}',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(
                    'Address : ${items[index]['commune_name'].toString()}  ${items[index]['district_name'].toString()}  ${items[index]['provinces_name'].toString()}',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text('Owner : ${items[index]['comparable_con'].toString()}',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text('Inspectors : Null',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 30, right: 30),
                  child: pw.Container(
                    height: 200,
                    width: double.infinity,
                    child: pw.Image(pw.MemoryImage(image_latlog),
                        fit: pw.BoxFit.cover),
                  ),
                ),
                pw.SizedBox(height: 10),
                // pw.Text('Property Compare',
                //     style: pw.TextStyle(
                //         fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(
                    '${items[index]['property_type_name'].toString()} (${items[index]['comparable_id'].toString()})',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text('${items[index]['comparable_survey_date'].toString()}',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(
                    'LS : ${items[index]['comparable_land_length'].toString()} x ${items[index]['comparable_land_width'].toString()} = ${items[index]['comparable_land_total'].toString()} sqm',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(
                    'BS : ${items[index]['comparable_sold_length'].toString()} x ${items[index]['comparable_sold_width'].toString()} = ${items[index]['comparable_sold_total'].toString()} sqm',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(
                    'Asking Price : ${items[index]['comparable_adding_price'].toString()}\$',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(
                    'Offered Price : ${items[index]['comparableaddprice'].toString()}\$',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(
                    'Sold Of Price : ${items[index]['comparable_sold_price'].toString()}\$',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text('Tel: ${items[index]['comparable_phone'].toString()}',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                /////////////////
                pw.Text('lat: ${items[index]['latlong_la'].toString()}',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                pw.Text('log: ${items[index]['latlong_log'].toString()}',
                    style: pw.TextStyle(
                        fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          )
        ];
      },
    ));
    bool isprint = false;
    final Color_Test = Color.fromARGB(255, 131, 18, 10);
    // Get the bytes of the PDF document
    final pdfBytes = pdf.save();

    // Print the PDF document to the default printer
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfBytes);
    return pdf.save();
  }
}

class MarkerData {
  final LatLng latLng;
  final String comparableId;
  final List listWidgets;

  MarkerData({
    required this.latLng,
    required this.comparableId,
    required this.listWidgets,
  });
}
//  Container(
//                     width: MediaQuery.of(context).size.height * 0.12,
//                     padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                     child: DropdownButtonFormField<String>(
//                       //value: genderValue,
//                       isExpanded: true,
//                       onChanged: (newValue) {
//                         setState(() {
//                           print(newValue);
//                           // widget.total_type(newValue);
//                         });
//                       },
//                       items: totally
//                           .map<DropdownMenuItem<String>>(
//                             (value) => DropdownMenuItem<String>(
//                               value: value["numer_id"].toString(),
//                               child: Text(value["type"]),
//                               onTap: () {
//                                 setState(() {});
//                               },
//                             ),
//                           )
//                           .toList(),
//                       // add extra sugar..
//                       icon: Icon(
//                         Icons.arrow_drop_down,
//                         color: kImageColor,
//                       ),
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.symmetric(vertical: 8),
//                         fillColor: kwhite,
//                         filled: true,
//                         labelText: 'Option',
//                         hintText: 'Option',
//                         // prefixIcon: Icon(
//                         //   Icons.discount_outlined,
//                         //   color: kImageColor,
//                         // ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: kPrimaryColor, width: 2.0),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             width: 1,
//                             color: kPrimaryColor,
//                           ),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                     ),
//                   ),
