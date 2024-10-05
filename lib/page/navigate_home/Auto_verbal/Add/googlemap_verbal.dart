import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../../models/search_model.dart';
import '../../../../../../models/verbalModel/verbal_model.dart';
import '../../../../Customs/CustromTwinForm.dart';
import '../../../../Customs/ProgressHUD.dart';
import '../../../../Customs/formnum.dart';
import '../../../../Profile/components/Drop_down.dart';
import '../../../../components/autoVerbalType_search.dart';
import '../../../../components/colors.dart';
import '../../../../components/numDisplay.dart';
import '../../../../components/property35.dart';
import '../../../../components/property35_search.dart';
import '../../../../components/raod_type.dart';
import '../../../../getx/Auth/Auth_agent.dart';
import '../../../../getx/agent_credit/credit_agent.dart';
import '../../../../getx/dropdown_local/GoogMap.dart';
import '../../../../getx/verbal/verbal.dart';
import '../../../../getx/verbal/verbal_list.dart';
import '../../../../models/LandBuilding/landmodel.dart';
import '../../../../screen/Property/FirstProperty/component/Colors/appbar.dart';
import 'Add.dart';
import '../listPropertyCheck.dart';

class VerbalAdmin extends StatefulWidget {
  const VerbalAdmin(
      {super.key,
      required this.type,
      required this.listUser,
      required this.addNew});

  final OnChangeCallback type;
  final OnChangeCallback addNew;

  final List listUser;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<VerbalAdmin> {
  final CreditAgent creditAgent = Get.put(CreditAgent());
  double _panelHeightOpen = 0;
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  final Set<Marker> listMarkerIds = {};
  double latitude = 11.5489; //latitude
  double longitude = 104.9214;
  LatLng latLng = const LatLng(11.5489, 104.9214);
  String address = "";
  List<Marker> markers = [];
  List list = [];
  double adding_price = 0;
  double addingPriceVerbal = 0;
  double addingPriceSimple = 0;
  String sendAddrress = '';
  List data = [];
  double add_min = 20.0, add_max = 20.0;
  // ignore: prefer_typing_uninitialized_variables
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

  VerbalAdd verbalAdd = VerbalAdd();
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

  bool checkFunction = false;
  Future<void> waitingFuction() async {
    setState(() {
      checkFunction = true;
    });
    await Future.wait([
      _loadStringList(),
    ]);
    setState(() {
      checkFunction = false;
    });
  }

  ControllerMap controller = ControllerMap();
  Authentication authentication = Authentication();
  Future<void> _loadStringList() async {
    controller.mainAPI();
    controller.roadAPI();
    controller.checkPriceListRAPI();
    controller.checkPriceListCAPI();
    controller.khanAPI();
    controller.songkatAPI();
    controller.optionAPI();
    controller.comparaCRAPI();
    verbalAdd.verbalIdRadom(widget.listUser[0]['agency']);
  }

  late String autoverbalType;

  final TextEditingController priceController = TextEditingController();
  TextEditingController searchraod = TextEditingController();
  TextEditingController searchlatlog = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController controllerDrop = TextEditingController();
  final TextEditingController controllerDS = TextEditingController();
  final TextEditingController controllerArea = TextEditingController();
  @override
  void dispose() {
    controllerDrop.dispose();
    searchlatlog.dispose();
    searchraod.dispose();
    searchMap.dispose();
    priceController.dispose();
    super.dispose();
    distanceController.dispose();
    controllerDS.dispose();
  }

  var intValue = Random().nextInt(10);

  @override
  void initState() {
    _handleLocationPermission();
    waitingFuction();

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
    // creditAgent.creditAgent(widget.listUser[0]['agency']);
    creditAgent.creditAgentV(widget.listUser[0]['agency']);

    autoverbalType = "";
    super.initState();
    listOptin = listRaodNBorey;
  }

  List listOptin = [];
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      color: const Color.fromARGB(255, 0, 49, 212),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: _uiSteup(context),
    );
  }

  Widget _uiSteup(BuildContext context) {
    _panelHeightOpen = (groupValue == 0)
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
  bool isChecked_all = false;
  var id_route;

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

  Timer? _debounce;
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

  void onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      mainsearch();
    });
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

  List listassetImage = [
    {"image": "assets/icons/Approved.png"},
    {"image": "assets/icons/house.png"},
    {"image": "assets/icons/Comparable.png"},
    {"image": "assets/icons/land.png"},
    {"image": "assets/icons/area.png"},
    {"image": "assets/icons/condo.png"},
    {"image": "assets/icons/Appraiser.png"},
    {"image": "assets/icons/locations.png"},
  ];
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
      route = "";
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
      route = "";
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

  String lable = "Road Name";
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

  late VerbalData verbalData;
  Future<void> mainlist() async {
    verbalData = Get.isRegistered<VerbalData>()
        ? Get.find<VerbalData>()
        : Get.put(VerbalData());
  }

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
        route = "";
        clickMap == false;
      });
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

  int indexland = 0;
  VerbalModels verbalModels = VerbalModels();
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
  int pointCredit = 0;
  String checkdropdown = '';
  // List listBuilding = [];
  bool boreybutton = false;
  bool clickdone = false;
  List<LandbuildingModel> landbuildingModel = [];
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

  bool watingList = false;

  bool fullScreen = false;
  bool checkdelete = false;

  Widget mapShow() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Obx(
              () => fullScreen
                  ? ListAuto(
                      checkcolor: true,
                      device: 'm',
                      id_control_user: widget.listUser[0]['agency'].toString(),
                      listUser: widget.listUser,
                      type: (value) {
                        setState(() {
                          fullScreen = value;
                        });
                      },
                    )
                  : Column(
                      children: [
                        const SizedBox(height: 10),
                        Card(
                          elevation: 10,
                          child: Container(
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      const Color.fromARGB(255, 245, 243, 243),
                                  border: Border.all(
                                      width: 0.3,
                                      color: const Color.fromARGB(
                                          255, 159, 157, 157))),
                              child: (groupValue == 0)
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20, top: 10),
                                      child: Wrap(
                                        alignment: WrapAlignment.start,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              widget.type(100);
                                            },
                                            icon: const Icon(
                                              Icons.arrow_back,
                                              color: Color.fromARGB(
                                                  255, 52, 50, 50),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            width: 350,
                                            child: CustomTwinForm(
                                              Label1: '$add_min% for min',
                                              Label2: '$add_max% for max',
                                              icon1: const Icon(Icons.remove),
                                              icon2: const Icon(Icons.remove),
                                              onSaved1: (String? newValue) {
                                                setState(() {
                                                  add_min = double.parse(
                                                      newValue.toString());
                                                  // print("Price : $add_min");
                                                });
                                              },
                                              onSaved2: (String? newValue) {
                                                setState(() {
                                                  add_max = double.parse(
                                                      newValue.toString());
                                                  // print("Price : $add_min");
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            width: 90,
                                            child: TextFormField(
                                              controller: distanceController,
                                              decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                    Icons
                                                        .photo_size_select_small,
                                                    size: 18),
                                                fillColor: kwhite,
                                                filled: true,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 0),
                                                labelStyle: const TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 12),
                                                labelText: "Distance Km",
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: kPrimaryColor,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 1,
                                                      color: kPrimaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Borey",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: greyColor,
                                                fontSize: 14),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  waitingCheck = true;
                                                  boreybutton = !boreybutton;
                                                  if (boreybutton) {
                                                    checkborey = 1;
                                                    listOptin = listRaodBorey;
                                                  } else {
                                                    checkborey = 0;
                                                    listOptin = listRaodNBorey;
                                                  }
                                                  _timer = Timer.periodic(
                                                      const Duration(
                                                          seconds: 1),
                                                      (Timer timer) async {
                                                    setState(() {
                                                      count++;
                                                    });

                                                    if (count >= 1) {
                                                      _timer.cancel();
                                                      waitingCheck = false;
                                                    }
                                                  });
                                                });
                                              },
                                              icon: Icon(boreybutton
                                                  ? Icons.check_box_outlined
                                                  : Icons
                                                      .check_box_outline_blank)),
                                          const SizedBox(width: 10),
                                          waitingCheck
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : OptionRoadNew(
                                                  hight: 35,
                                                  pwidth: 250,
                                                  list: listOptin,
                                                  valueId: "road_id",
                                                  valueName: "road_name",
                                                  lable: "Road Name",
                                                  onbackValue: (value) {
                                                    setState(() {
                                                      List<String> parts =
                                                          value!.split(',');

                                                      id_route = parts[0];
                                                      // print("id_route : $id_route");

                                                      lable = parts[1];
                                                    });
                                                  },
                                                ),
                                          const SizedBox(width: 10),
                                          //         const SizedBox(width: 10),
                                          if (route == "Unnamed Road" &&
                                              checkborey == 0)
                                            Text(
                                              "Specail Zone",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: greyColor,
                                                  fontSize: 14),
                                            ),
                                          const SizedBox(width: 5),
                                          if (route == "Unnamed Road" &&
                                              checkborey == 0)
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    doneORudone = !doneORudone;
                                                    haveValue = !haveValue;
                                                  });
                                                },
                                                icon: !doneORudone
                                                    ? Icon(
                                                        Icons
                                                            .check_box_outline_blank,
                                                        color: greyColorNolots,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .check_box_outlined,
                                                        color: greyColor,
                                                      )),
                                          // const Spacer(),
                                          // InkWell(
                                          //   onTap: () {
                                          //     getCurrentLocation();
                                          //   },
                                          //   child: Container(
                                          //     height: 35,
                                          //     width: 130,
                                          //     decoration: BoxDecoration(
                                          //         borderRadius: BorderRadius.circular(5),
                                          //         border: Border.all(
                                          //             width: 0.5, color: greyColor)),
                                          //     child: Row(
                                          //       mainAxisAlignment: MainAxisAlignment.center,
                                          //       children: [
                                          //         Icon(
                                          //           Icons.location_history_outlined,
                                          //           color: blackColor,
                                          //           size: 25,
                                          //         ),
                                          //         const SizedBox(width: 5),
                                          //         Text('My location',
                                          //             style: TextStyle(
                                          //                 fontSize: 12,
                                          //                 fontWeight: FontWeight.bold,
                                          //                 color: blackColor)),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          //         // const SizedBox(width: 10),

                                          for (int i = 0;
                                              i < listMarkers.length;
                                              i++)
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  checktypeMarker =
                                                      !checktypeMarker;
                                                  selectindexs =
                                                      (selectindexs == i)
                                                          ? -1
                                                          : i;
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Container(
                                                  height: 35,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          width:
                                                              (selectindexs ==
                                                                      i)
                                                                  ? 2
                                                                  : 1,
                                                          color: (selectindexs ==
                                                                  i)
                                                              ? redColors
                                                              : blackColor)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (i == 0)
                                                        const Icon(Icons
                                                            .location_on_outlined)
                                                      else
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          child: Image.asset(
                                                            "assets/images/mutiple.png",
                                                            width: 50,
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          InkWell(
                                            onTap: () {
                                              clearMarkers();
                                              setState(() {
                                                clearmarker = false;
                                              });
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    width: (clearmarker == true)
                                                        ? 2
                                                        : 1,
                                                    color: (clearmarker == true)
                                                        ? Colors.red
                                                        : greyColor,
                                                  )),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Clear  ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: greyColor),
                                                  ),
                                                  Icon(
                                                      Icons
                                                          .location_off_outlined,
                                                      color:
                                                          (clearmarker == true)
                                                              ? Colors.red
                                                              : greyColor,
                                                      size: 20)
                                                ],
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 40),
                                          InkWell(
                                            onTap: () {
                                              searchComparable();
                                            },
                                            child: Card(
                                              elevation: 20,
                                              child: Container(
                                                height: 35,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: const Color.fromARGB(
                                                        255, 143, 187, 223),
                                                    border: Border.all(
                                                        width: 0.5,
                                                        color: greyColor)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Search Price',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: greyColor,
                                                          fontSize: 12),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Icon(Icons.search,
                                                        color: greyColor,
                                                        size: 20)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (adding_price != 0) {
                                                showDailogs();
                                              } else {
                                                getxsnackbar(
                                                    "Please Check Price", "");
                                              }

                                              // if (list.isNotEmpty) {
                                              //   if (groupValue == 0) {
                                              //     Dialog(context);
                                              //   } else {
                                              //     for_market_price();
                                              //   }
                                              // } else {
                                              //   aloadMenu();
                                              // }
                                            },
                                            child: Image.asset(
                                              "assets/icons/papersib.png",
                                              height: 35,
                                              width: 50,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          clickdone
                                              ? Text('Only Price',
                                                  style: TextStyle(
                                                      color: colorsRed))
                                              : Text('Location Price',
                                                  style: TextStyle(
                                                      color: colorsRed)),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  clickdone = !clickdone;
                                                });
                                              },
                                              icon: Icon(!clickdone
                                                  ? Icons
                                                      .check_box_outline_blank
                                                  : Icons.check_box_outlined)),
                                        ],
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              widget.type(100);
                                            },
                                            icon: Icon(
                                              Icons.arrow_back,
                                              color: greyColor,
                                              size: 25,
                                            ))
                                      ],
                                    )),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              color: appback,
                              height: MediaQuery.of(context).size.height * 0.84,
                              width: 500,
                              child: SingleChildScrollView(
                                  child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 30, left: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            if (creditAgent
                                                .listCreditV.isNotEmpty)
                                              if (creditAgent.listCreditV[0]
                                                      ['No'] <
                                                  10)
                                                Image.asset(
                                                  'assets/icons/${icontop[creditAgent.listCreditV[0]['No'] - 1]['icon']}',
                                                  height: 80,
                                                  fit: BoxFit.fitHeight,
                                                )
                                              else if (creditAgent
                                                  .listCreditV.isNotEmpty)
                                                CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor:
                                                      greyColorNolots,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Text(
                                                      creditAgent.listCreditV[0]
                                                              ['No']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17,
                                                          color: blackColor),
                                                    ),
                                                  ),
                                                ),
                                            const SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (widget.listUser.isNotEmpty)
                                                  Text(
                                                    "${widget.listUser[0]['username'] ?? ""}",
                                                    style: TextStyle(
                                                        color: colorsRed,
                                                        fontSize: 17),
                                                  ),
                                                const SizedBox(height: 5),
                                                if (creditAgent
                                                    .listCreditV.isNotEmpty)
                                                  Text(
                                                    creditAgent.listCreditV[0]
                                                            ['credit']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: colorsRed,
                                                        fontSize: 17),
                                                  ),
                                              ],
                                            ),
                                            const Spacer(),
                                            watingList
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : IconButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        checkdelete =
                                                            !checkdelete;
                                                      });
                                                      await mainlist();
                                                    },
                                                    icon: const Icon(
                                                      Icons.change_circle,
                                                      color: Color.fromARGB(
                                                          255, 77, 230, 82),
                                                      size: 30,
                                                    ))
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Search by Latitude and Longitude",
                                          style: TextStyle(
                                              color: whiteColor, fontSize: 15),
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
                                                    // width: 170,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: whiteColor,
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color: blackColor)),
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      // controller: searchlatlog,
                                                      onFieldSubmitted:
                                                          (value) {
                                                        setState(() {
                                                          if (j == 0) {
                                                            // lat = double.parse(value);
                                                            requestModel.lat =
                                                                value
                                                                    .toString();
                                                          } else {
                                                            // log = double.parse(value);
                                                            requestModel.lng =
                                                                value
                                                                    .toString();
                                                          }
                                                        });
                                                      },
                                                      onChanged: (value) {
                                                        setState(() {
                                                          if (j == 0) {
                                                            // lat = double.parse(value);
                                                            requestModel.lat =
                                                                value
                                                                    .toString();
                                                          } else {
                                                            // log = double.parse(value);
                                                            requestModel.lng =
                                                                value
                                                                    .toString();
                                                          }
                                                        });
                                                      },
                                                      //,
                                                      textInputAction:
                                                          TextInputAction
                                                              .search,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                      decoration:
                                                          InputDecoration(
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
                                                                        double.parse(requestModel
                                                                            .lat),
                                                                        double.parse(
                                                                            requestModel.lng)));
                                                                    // findlocation(LatLng(
                                                                    //     11.499263, 104.874885));
                                                                    findByPiont(
                                                                        double.parse(requestModel
                                                                            .lat),
                                                                        double.parse(
                                                                            requestModel.lng));
                                                                    getAddress(LatLng(
                                                                        double.parse(requestModel
                                                                            .lat),
                                                                        double.parse(
                                                                            requestModel.lng)));
                                                                  });
                                                                },
                                                                icon: Icon(
                                                                  Icons.search,
                                                                  color:
                                                                      greyColor,
                                                                )),

                                                        fillColor: Colors.white,
                                                        hintText: listlatlog[j]
                                                                ['title']
                                                            .toString(),
                                                        border:
                                                            InputBorder.none,
                                                        // contentPadding:
                                                        //     const EdgeInsets.symmetric(
                                                        //         vertical: 8, horizontal: 5),
                                                        hintStyle:
                                                            const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        118,
                                                                        116,
                                                                        116),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: whiteColor,
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: blackColor)),
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            controller: searchMap,
                                            onFieldSubmitted: (value) {
                                              setState(() {
                                                onSearchChanged();
                                              });
                                            },
                                            onChanged: (value) {
                                              onSearchChanged();
                                            },
                                            textInputAction:
                                                TextInputAction.search,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            decoration: InputDecoration(
                                              suffixIcon: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      onSearchChanged();
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
                                                    color: greyColorNolot,
                                                  )),
                                              fillColor: Colors.white,
                                              hintText: "  Search",
                                              border: InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 10),
                                              hintStyle: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 118, 116, 116),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Divider(
                                            height: 3, color: greyColorNolots),
                                        const SizedBox(height: 10),
                                        if (comparedropdown2 != "")
                                          Text('Specail Option',
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 12)),
                                        if (comparedropdown2 != "")
                                          const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            if (comparedropdown2 != "")
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: SizedBox(
                                                    height: 35,
                                                    child:
                                                        DropdownButtonFormField<
                                                            String>(
                                                      //value: genderValue,

                                                      value: searchlatlog
                                                              .text.isNotEmpty
                                                          ? searchlatlog.text
                                                          : null,
                                                      isExpanded: true,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          clearmarker = true;
                                                          searchlatlog.text =
                                                              newValue ?? "";
                                                          if (newValue == 'N') {
                                                            comparedropdown =
                                                                '';
                                                          } else {
                                                            comparedropdown =
                                                                newValue!;
                                                            comparedropdown2 =
                                                                'P';
                                                          }
                                                          checkdropdown =
                                                              comparedropdown;

                                                          // print(
                                                          //     '==> $comparedropdown');
                                                        });
                                                      },

                                                      items: controller
                                                          .listdropdown
                                                          .map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                            (value) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                              value: value[
                                                                      "type"]
                                                                  .toString(),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            7),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(right: 5),
                                                                          child: SizedBox(
                                                                              height: 70,
                                                                              // radius: 15,
                                                                              // backgroundColor: Colors.white,
                                                                              child: (value['id'] == 1)
                                                                                  ? Image.asset(
                                                                                      listassetImage[0]['image'].toString(),
                                                                                    )
                                                                                  : (value['id'] == 2)
                                                                                      ? Image.asset(listassetImage[1]['image'].toString())
                                                                                      : (value['id'] == 3)
                                                                                          ? Image.asset(listassetImage[2]['image'].toString())
                                                                                          : (value['id'] == 4)
                                                                                              ? Image.asset(listassetImage[3]['image'].toString())
                                                                                              : (value['id'] == 5)
                                                                                                  ? Image.asset(listassetImage[4]['image'].toString())
                                                                                                  : (value['id'] == 6)
                                                                                                      ? Image.asset(listassetImage[5]['image'].toString())
                                                                                                      : (value['id'] == 7)
                                                                                                          ? Image.asset(listassetImage[6]['image'].toString())
                                                                                                          : Image.asset(listassetImage[7]['image'].toString())),
                                                                        )),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child: Text(
                                                                          value["title"]
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 14)),
                                                                    ),
                                                                    Expanded(
                                                                        flex: 4,
                                                                        child: Text(
                                                                            value[
                                                                                "name"],
                                                                            style:
                                                                                const TextStyle(fontSize: 12))),
                                                                  ],
                                                                ),
                                                              ),
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
                                                                vertical: 0,
                                                                horizontal: 0),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        labelText:
                                                            'Special Option',
                                                        hintText: 'Select one',
                                                        prefixIcon: const Icon(
                                                          Icons.home_outlined,
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
                                                                      10.0),
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
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            // Expanded(
                                            //   flex: 1,
                                            //   child: SizedBox(
                                            //     height: 35,
                                            //     child: DropdownButtonFormField<String>(
                                            //       isExpanded: true,

                                            //       onChanged: (newValue) {
                                            //         setState(() {
                                            //           if (newValue == "2024") {
                                            //             id_route = null;
                                            //           } else {
                                            //             roadType = true;
                                            //             id_route = newValue;
                                            //           }
                                            //           print("===> $id_route");
                                            //         });
                                            //       },

                                            //       items: controller.listRaod
                                            //           .map<DropdownMenuItem<String>>(
                                            //             (value) =>
                                            //                 DropdownMenuItem<String>(
                                            //               value: value["road_id"]
                                            //                   .toString(),
                                            //               child: Text(value["road_name"]
                                            //                   .toString()),
                                            //               // child: Text(
                                            //               //   value["name"],

                                            //               //   style: TextStyle(
                                            //               //       fontWeight: FontWeight.bold,
                                            //               //       color: Colors.red),
                                            //               // ),
                                            //             ),
                                            //           )
                                            //           .toList(),
                                            //       // add extra sugar..
                                            //       icon: const Icon(
                                            //         Icons.arrow_drop_down,
                                            //         color: kImageColor,
                                            //       ),

                                            //       decoration: InputDecoration(
                                            //         contentPadding:
                                            //             const EdgeInsets.symmetric(
                                            //                 vertical: 0, horizontal: 0),
                                            //         fillColor: Colors.white,
                                            //         filled: true,
                                            //         labelText: (searchraod.text == "")
                                            //             ? 'Road'
                                            //             : searchraod.text,
                                            //         hintStyle: TextStyle(
                                            //             color: blackColor,
                                            //             fontWeight: FontWeight.bold,
                                            //             fontSize: 15),
                                            //         hintText: 'Select one',
                                            //         prefixIcon: const Icon(
                                            //           Icons.edit_road_outlined,
                                            //           color: kImageColor,
                                            //         ),
                                            //         focusedBorder: OutlineInputBorder(
                                            //           borderSide: const BorderSide(
                                            //               color: kPrimaryColor,
                                            //               width: 2.0),
                                            //           borderRadius:
                                            //               BorderRadius.circular(5),
                                            //         ),
                                            //         enabledBorder: OutlineInputBorder(
                                            //           borderSide: const BorderSide(
                                            //             width: 1,
                                            //             color: kPrimaryColor,
                                            //           ),
                                            //           borderRadius:
                                            //               BorderRadius.circular(5),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: Row(
                                                children: [
                                                  GFRadio(
                                                    type: GFRadioType.square,
                                                    size: 25,
                                                    value: 0,
                                                    groupValue: groupValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        groupValue = int.parse(
                                                            value.toString());
                                                      });
                                                    },
                                                    inactiveIcon: null,
                                                    activeBorderColor:
                                                        const Color.fromARGB(
                                                            255, 39, 39, 39),
                                                    radioColor:
                                                        GFColors.PRIMARY,
                                                  ),
                                                  Text(
                                                    "  By Compareble",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: whiteColor),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Container(
                                              // width: MediaQuery.of(context).size.width * 0.15,
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GFRadio(
                                                    type: GFRadioType.square,
                                                    size: 25,
                                                    value: 1,
                                                    groupValue: groupValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        groupValue = int.parse(
                                                            value.toString());
                                                      });
                                                    },
                                                    inactiveIcon: null,
                                                    activeBorderColor:
                                                        const Color.fromARGB(
                                                            255, 39, 39, 39),
                                                    radioColor:
                                                        GFColors.PRIMARY,
                                                  ),
                                                  Text(
                                                    "  By Market price",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: whiteColor),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: NumDisplay(
                                                  onSaved: (newValue) =>
                                                      setState(() {
                                                        requestModel.num =
                                                            newValue!;
                                                      })),
                                            ),
                                            const SizedBox(width: 10),
                                            if (groupValue == 0)
                                              Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  // width: double.infinity,
                                                  child: PropertySearch(
                                                    // pro: "Land",
                                                    name: (value) {
                                                      // propertyType = value;
                                                    },
                                                    checkOnclick: (value) {
                                                      setState(() {
                                                        isChecked = value;
                                                        isChecked_all = false;
                                                      });
                                                    },
                                                    id: (value) {
                                                      setState(() {
                                                        if (value == '37') {
                                                          pty = null;
                                                          showAll = true;
                                                        } else {
                                                          pty = value;
                                                          showAll = true;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Divider(height: 3, color: whiteColor),
                                        const SizedBox(height: 10),
                                        if (widget.listUser.isNotEmpty &&
                                            checkdelete)
                                          TextButton(
                                              onPressed: () {},
                                              child: Row(
                                                children: [
                                                  const Spacer(),
                                                  Text(
                                                    'Full  ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: whiteColor,
                                                        fontSize: 15),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          fullScreen = true;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .screen_search_desktop_outlined,
                                                        size: 30,
                                                        color: whiteColor,
                                                      ))
                                                ],
                                              )),
                                        if (widget.listUser.isNotEmpty &&
                                            checkdelete &&
                                            !verbalData.isverbalfirst.value)
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: whiteColor,
                                                    width: 2)),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ListAuto(
                                                  checkcolor: false,
                                                  device: 'm',
                                                  id_control_user: widget
                                                      .listUser[0]['agency']
                                                      .toString(),
                                                  listUser: widget.listUser,
                                                  type: (value) {},
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (adding_price != 0 &&
                                            groupValue == 0 &&
                                            !checkdelete)
                                          addLandBuilding()
                                        else if (groupValue == 1 &&
                                            !checkdelete)
                                          markertPrice()
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 160,
                                    child: (listMap.isEmpty)
                                        ? const SizedBox()
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: Container(
                                              height: 350,
                                              width: 450,
                                              color: whiteColor,
                                              child: ListView.builder(
                                                itemCount: listMap.length,
                                                itemBuilder: (context, index) =>
                                                    InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      var location =
                                                          listMap[index]
                                                                  ['geometry']
                                                              ['location'];
                                                      LatLng lat = LatLng(
                                                          double.parse(
                                                              location['lat']
                                                                  .toString()),
                                                          double.parse(
                                                              location['lng']
                                                                  .toString()));
                                                      findlocation(lat);
                                                    });
                                                  },
                                                  child: Container(
                                                    color: whiteColor,
                                                    height: 30,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          color: greyColorNolot,
                                                          size: 20,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          listMap[index]['name']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                              flex: 6,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.84,
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
                                    setState(() {
                                      mapController = controller;
                                    });
                                  },
                                  onLongPress: (argument) {
                                    if (list.isNotEmpty) {
                                      if (groupValue == 0) {
                                        Dialog(context);
                                      }
                                    } else {
                                      aloadMenu();
                                    }
                                  },
                                  onTap: (argument) {
                                    setState(() {
                                      latLng = argument;
                                      requestModel.lat =
                                          latLng.latitude.toString();
                                      requestModel.lng =
                                          latLng.longitude.toString();
                                      if (groupValue == 0) {
                                        if (checktypeMarker == false) {
                                          if (comparedropdown2 != "") {
                                            typedrawerSe == false;
                                          }

                                          typedrawer = true;

                                          if (comparedropdown2 == "") {
                                            addMarkers(argument);
                                            findByPiont(
                                                double.parse(requestModel.lat),
                                                double.parse(requestModel.lng));
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
                                          }
                                        }
                                      } else {
                                        addMarkers(argument);
                                        findByPiont(
                                            double.parse(requestModel.lat),
                                            double.parse(requestModel.lng));
                                      }
                                    });
                                  },
                                  onCameraMove:
                                      (CameraPosition cameraPositiona) {
                                    cameraPosition =
                                        cameraPositiona; //when map is dragging
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            if (typedrawer == true && comparedropdown2 == '') optionSearch()
          ],
        ),
      ),
    );
  }

  bool checkHlandbuilding = false;
  bool checkImage = false;
  String testback = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkmap = true;
  late String autoverbalTypeValue = '';
  String opionTypeID = '0';
  int optionValue = 0;
  String dep = "0";
  double hL = 0, lL = 0;
  double? minSqm, maxSqm, totalMin, totalMax, totalArea;
  String? des;
  Widget markertPrice() {
    return Container(
      decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(width: 2, color: blueColor),
          borderRadius: BorderRadius.circular(5)),
      height: 300,
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: (minSqm1 != null && maxSqm1 != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Check price by KFA',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const Spacer(),
                        Image.asset(
                          'assets/icons/mylocation.png',
                          height: 40,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Residential",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: greyColorNolot),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 60,
                      width: double.infinity,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Avg = ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                  "${((formatter.format(R_avg)) == 'null') ? 0 : formatter.format(R_avg)}\$",
                                  //"${formatter.format(R_avg)}\$",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 242, 11, 134)))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Text("Min = ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "${formatter.format(double.parse(minSqm1))}\$",
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
                                  Text(
                                      "${formatter.format(double.parse(maxSqm1))}\$",
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
                    const SizedBox(height: 10),
                    const Text(
                      "Commercial",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 60,
                      width: double.infinity,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Avg = ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                  "${((formatter.format(C_avg)) == 'null') ? 0 : formatter.format(C_avg)}\$",
                                  //"${formatter.format(C_avg)}\$",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 242, 11, 134)))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Text("Min = ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "${formatter.format(double.parse(minSqm2))}\$",
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
                                  Text(
                                      "${formatter.format(double.parse(maxSqm2))}\$",
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
                      "$commune /  $district  Route : ${route.toString()}",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              : const SizedBox()),
    );
  }

  Widget addLandBuilding() {
    return Obx(
      () => Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(right: 5, top: 10, left: 10, bottom: 10),
            child: Row(
              children: [
                Text("Verbal Add",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                        fontSize: 17))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: whiteColor),
                  borderRadius: BorderRadius.circular(5)),
              height: 242,
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Land / Building',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: whiteColor),
                          ),
                          !checkmap
                              ? const Text(
                                  '   Please Find Price on Map',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 240, 24, 9)),
                                )
                              : const SizedBox(),
                          const Spacer(),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (validateAndSave()) {
                                    if (adding_price > 0) {
                                      if (checkHlandbuilding == false) {
                                        hscreen = hscreen + 280;
                                      }
                                      checkMap = true;
                                      if (autoverbalTypeValue == '100') {
                                        calLs();
                                      } else {
                                        calElse(areas, autoverbalTypeValue);
                                      }
                                      checkHlandbuilding = true;
                                      checkmap = true;
                                    } else {
                                      checkmap = false;
                                    }
                                  }
                                });
                              },
                              child: const Text("Calculator price",
                                  style: TextStyle(fontSize: 12))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 35,
                              width: double.infinity,
                              child: ApprovebyAndVerifybySearch(
                                name: (value) {
                                  setState(() {
                                    controllerDS.text = value;
                                  });
                                },
                                id: (value) {
                                  setState(() {
                                    autoverbalTypeValue = value;
                                  });
                                },
                                defaultValue: const {
                                  'type': 'LS',
                                  'autoverbal_id': '100'
                                },
                              ),
                            ),
                          ),
                          if (autoverbalTypeValue != "100")
                            const SizedBox(width: 10),
                          if (autoverbalTypeValue != "100")
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 35,
                                child: FormN(
                                  label: "Floors",
                                  iconname: const Icon(
                                      Icons.calendar_month_outlined,
                                      color: kImageColor),
                                  onSaved: (newValue) {
                                    setState(() {
                                      dep = newValue!;

                                      if (totalArea != null) {
                                        totalArea =
                                            totalArea! * double.parse(dep);
                                      }
                                      totalArea;
                                      areas = totalArea!;
                                    });
                                  },
                                ),
                              ),
                            )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 35,
                              child: FormN(
                                label: "Head",
                                iconname: const Icon(
                                    Icons.h_plus_mobiledata_outlined,
                                    color: kImageColor),
                                onSaved: (newValue) {
                                  setState(() {
                                    if (newValue == "") {
                                      controllerArea.clear();
                                    }
                                    h = double.parse(newValue!);
                                    if (lL != 0) {
                                      totalArea = h * lL;
                                      areas = totalArea!;
                                    } else {
                                      totalArea = h;
                                    }
                                    controllerArea.text = areas.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 35,
                              child: FormN(
                                label: "Length",
                                iconname: const Icon(Icons.blur_linear_outlined,
                                    color: kImageColor),
                                onSaved: (newValue) {
                                  setState(() {
                                    if (newValue == "") {
                                      controllerArea.clear();
                                    }
                                    lL = double.parse(newValue!);

                                    if (h != 0) {
                                      totalArea = h * lL;
                                      areas = totalArea!;
                                    } else {
                                      totalArea = lL;
                                    }
                                    controllerArea.text = areas.toString();
                                    // controllerArea.text = totalArea!.toString();
                                    // if (controllerArea == null ||
                                    //     controllerArea.text == "") {
                                    //   controllerArea.clear();
                                    // }
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      // if (autoverbalTypeValue != '100')
                      // SizedBox(
                      //   height: 35,
                      //   child: FormN(
                      //     label: "Depreciation(Age)",
                      //     iconname: const Icon(Icons.calendar_month_outlined,
                      //         color: kImageColor),
                      //     onSaved: (newValue) {
                      //       setState(() {
                      //         dep = newValue!;
                      //       });
                      //     },
                      //   ),
                      // ),
                      // const SizedBox(height: 10),

                      SizedBox(
                          height: 35,
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: controllerArea,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    areas = double.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  filled: true,
                                  labelText: "Area (m\u00B2)",
                                  prefixIcon: const Icon(Icons.layers,
                                      color: kImageColor),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(0, 126, 250, 1),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(0, 126, 250, 1)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 249, 0, 0),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 249, 0, 0),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  errorStyle: const TextStyle(
                                      height: 0), // Hide error text
                                ),
                                validator: (input) {
                                  if (input == null || input.isEmpty) {
                                    return ''; // Return empty string to trigger error state
                                  }
                                  return null;
                                },
                              )),
                              // Expanded(
                              //   flex: 1,
                              //   child: FormValidateN(
                              //       // label: "Area",
                              //       label: ((totalArea != 0)
                              //           ? "Area (m\u00B2): ${formatter.format(totalArea ?? 0)}"
                              //           : "Area"),
                              //       iconname:
                              //           const Icon(Icons.layers, color: kImageColor),
                              //       onSaved: (newValue) {
                              //         setState(() {
                              //           areas = double.parse(newValue!);
                              //         });
                              //       }),
                              // ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 35,
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        opionTypeID =
                                            newValue!.split(" ")[0].toString();
                                        optionValue = int.parse(
                                            newValue.split(" ")[1].toString());
                                      });
                                    },
                                    items: controller.listOption
                                        .map<DropdownMenuItem<String>>(
                                          (value) => DropdownMenuItem<String>(
                                            value:
                                                "${value["opt_value"]} ${value["opt_id"]}",
                                            child: Text(value["opt_des"]),
                                            onTap: () {
                                              setState(() {
                                                opionTypeID = value["opt_value"]
                                                    .toString();
                                              });
                                            },
                                          ),
                                        )
                                        .toList(),
                                    icon: const Icon(Icons.arrow_drop_down,
                                        color: kImageColor),
                                    decoration: InputDecoration(
                                      fillColor: kwhite,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8),
                                      labelText: 'OptionType',
                                      hintText: 'Select one',
                                      prefixIcon: const Icon(
                                          Icons.my_library_books_rounded,
                                          color: kImageColor),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: kPrimaryColor, width: 2.0),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: kPrimaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 1,
                              //   child: CommentAndOption(
                              //     value: (value) {
                              //       setState(() {
                              //         // opt = int.parse(value);
                              //       });
                              //     },
                              //     comment1: (opt != null) ? opt.toString() : null,
                              //     id: (value) {
                              //       setState(() {
                              //         optionValue = int.parse(value.toString());
                              //       });
                              //     },
                              //     comment: (newValue) {
                              //       setState(() {
                              //         // comment = newValue!.toString();
                              //       });
                              //     },
                              //     opt_type_id: (value) {
                              //       setState(() {
                              //         opionTypeID = value.toString();
                              //       });
                              //     },
                              //   ),
                              // ),
                            ],
                          )),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          readOnly: true,
                          controller: controllerDS,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: kwhite,
                            filled: true,
                            labelText: "Description",
                            labelStyle: const TextStyle(fontSize: 14),
                            prefixIcon: const Icon(
                              Icons.description,
                              color: kImageColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: kPrimaryColor, width: 2.0),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Add(
              creditPoint: creditAgent.listCreditV[0]['credit'],
              creditAgent: (value) {
                setState(() {
                  creditAgent.listCreditV[0]['credit'] =
                      int.parse(value.toString());
                });
              },
              option: int.parse(opionTypeID),
              checkMap: checkMap,
              addressController: addressController,
              lat: (requestModel.lat == "") ? "" : requestModel.lat,
              lng: (requestModel.lng == "") ? "" : requestModel.lng,
              verbalID: verbalAdd.verbalID.value,
              hscreen: hscreen,
              listLandBuilding: landbuildingModel,
              backvalue: (value) {
                setState(() {
                  widget.type(100);
                  if (value == 100) {
                    widget.addNew(31);
                  }
                });
              },
              email: widget.listUser[0]['email'].toString(),
              listUser: widget.listUser,
              device: "m")
        ],
      ),
    );
  }

  double caculateCom(double p) {
    double avgCaculate =
        (((addingPriceSimple * p) + addingPriceVerbal) / 5 + (R_avg + C_avg)) /
            2;
    return avgCaculate;
  }

  double caculateRen(double p) {
    double avgCaculate = ((addingPriceSimple * p) + addingPriceVerbal) / 5;
    return avgCaculate;
  }

  late Timer _timer;
  int count = 0;
  bool checkMap = false;
  double hscreen = 890;
  void calLs() {
    setState(() {
      if (haveValue == true) {
        if (areas <= 300) {
          double avgmin = caculateCom(0.85);
          double avgmax = caculateCom(0.80);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        } else if (areas > 301 && areas <= 1000) {
          double avgmin = caculateCom(0.8);
          double avgmax = caculateCom(0.75);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        } else if (areas > 1001 && areas <= 3000) {
          double avgmin = caculateCom(0.75);
          double avgmax = caculateCom(0.7);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        } else if (areas > 3000) {
          double avgmin = caculateCom(0.7);
          double avgmax = caculateCom(0.65);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        }
      } else {
        if (areas <= 300) {
          double avgmin = caculateRen(0.85);
          double avgmax = caculateRen(0.80);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        } else if (areas > 301 && areas <= 1000) {
          double avgmin = caculateRen(0.8);
          double avgmax = caculateRen(0.75);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        } else if (areas > 1001 && areas <= 3000) {
          double avgmin = caculateRen(0.75);
          double avgmax = caculateRen(0.7);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        } else if (areas > 3000) {
          double avgmin = caculateRen(0.7);
          double avgmax = caculateRen(0.65);
          minSqm = avgmin + (avgmin * double.parse(opionTypeID) / 100);
          maxSqm = avgmax + (avgmax * double.parse(opionTypeID) / 100);
        }
      }
      totalMin = (minSqm! * areas);
      totalMax = (maxSqm! * areas);
      addItemToList();
    });
  }

  Future<void> calElse(double area, String autoverbalTypeValue) async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/type?autoverbal_id=$autoverbalTypeValue'));

    setState(() {
      var jsonData = jsonDecode(rs.body);

      maxSqm = double.parse(jsonData[0]['max'].toString());
      minSqm = double.parse(jsonData[0]['min'].toString());
      // ignore: unnecessary_null_comparison
      if (opionTypeID != null) {
        totalMin =
            ((minSqm! * area) + (double.parse(opionTypeID.toString()) / 100)) +
                (minSqm! * area);
        totalMax =
            ((maxSqm! * area) + (double.parse(opionTypeID.toString()) / 100)) +
                (maxSqm! * area);

        addItemToList();
      } else {
        totalMin = minSqm! * area;
        totalMax = maxSqm! * area;
        addItemToList();
      }
    });
    //  }
  }

  void addItemToList() {
    setState(() {
      landbuildingModel.add(LandbuildingModel(
          verbalLandType: autoverbalType,
          verbalLandDes: controllerDS.text,
          verbalLandDp: dep.toString(),
          verbalLandArea: areas.toString(),
          verbalLandMinsqm: minSqm!.toStringAsFixed(0),
          verbalLandMaxsqm: maxSqm!.toStringAsFixed(0),
          verbalLandMinvalue: totalMin!.toStringAsFixed(0),
          verbalLandMaxvalue: totalMax!.toStringAsFixed(0),
          address: '$commune / $district',
          verbalLandid: verbalID));
    });
  }

  String verbalID = '';
  List verbal = [];
  bool doneORudone = false;
  String area = '';
  double areas = 0;
  int i = 0;
  double? askingPrice;
  int idkhan = 0;
  Future<void> blocComparable(id) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"comparable_id": id});
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/blockGoogleMap',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      Navigator.pop(context);
    } else {
      print(response.statusMessage);
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
  Widget optionSearch() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(height: 50),
              Container(
                height: 600,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  typedrawer = false;
                                  typedrawerSe = false;
                                  if (comparedropdown != '') {
                                    comparedropdown2 = "P";
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                size: 30,
                              ))
                        ],
                      ),
                      Image.asset('assets/images/searchMan.png', height: 300),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              (route == "Unnamed Road" && checkborey == 0)
                                  ? "Specail Zone"
                                  : "Select Property Category",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 55, 52, 52),
                                  fontSize: 20)),
                          (route == "Unnamed Road" && checkborey == 0)
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      doneORudone = !doneORudone;
                                      haveValue = !haveValue;
                                    });
                                  },
                                  icon: !doneORudone
                                      ? Icon(
                                          Icons.check_box_outline_blank,
                                          size: 35,
                                          color: greyColorNolots,
                                        )
                                      : Icon(
                                          Icons.check_box_outlined,
                                          size: 35,
                                          color: greyColor,
                                        ))
                              : const SizedBox()
                        ],
                      ),
                      const SizedBox(height: 20),
                      (route == "Unnamed Road" || checkborey == 1)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Borey",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: greyColor,
                                      fontSize: 14),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        waitingCheck = true;
                                        boreybutton = !boreybutton;
                                        if (boreybutton) {
                                          checkborey = 1;
                                          listOptin = listRaodBorey;
                                        } else {
                                          checkborey = 0;
                                          listOptin = listRaodNBorey;
                                        }
                                        _timer = Timer.periodic(
                                            const Duration(seconds: 1),
                                            (Timer timer) async {
                                          setState(() {
                                            count++;
                                          });

                                          if (count >= 1) {
                                            _timer.cancel();
                                            waitingCheck = false;
                                          }
                                        });
                                      });
                                    },
                                    icon: Icon(boreybutton
                                        ? Icons.check_box_outlined
                                        : Icons.check_box_outline_blank)),
                                const SizedBox(width: 10),
                                waitingCheck
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : OptionRoadNew(
                                        hight: 35,
                                        pwidth: 250,
                                        list: listOptin,
                                        valueId: "road_id",
                                        valueName: "road_name",
                                        lable: "Road Name",
                                        onbackValue: (value) {
                                          setState(() {
                                            List<String> parts =
                                                value!.split(',');

                                            id_route = parts[0];

                                            lable = parts[1];
                                          });
                                        },
                                      ),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      (route == "Unnamed Road" || checkborey == 1)
                          ? const SizedBox()
                          : Container(
                              height: 55,
                              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: DropdownButtonFormField<String>(
                                //value: genderValue,
                                value: searchlatlog.text.isNotEmpty
                                    ? searchlatlog.text
                                    : null,
                                isExpanded: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    searchlatlog.text = newValue ?? "";
                                    if (newValue == 'N') {
                                      comparedropdown = '';
                                      valuedropdown = '';
                                    } else {
                                      comparedropdown = newValue!;
                                      for (int j = 0;
                                          j < controller.listdropdown.length;
                                          j++) {
                                        if (controller.listdropdown[j]['type']
                                                .toString() ==
                                            newValue) {
                                          valuedropdown = controller
                                              .listdropdown[j]['title']
                                              .toString();
                                        }
                                      }
                                    }
                                    checkdropdown = comparedropdown;
                                    print('==> $comparedropdown');
                                  });
                                },
                                items: controller.listdropdown
                                    .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem<String>(
                                        value: value["type"].toString(),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 7),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: SizedBox(
                                                      height: 70,
                                                      child: (value['id'] == 1)
                                                          ? Image.asset(
                                                              listassetImage[0]
                                                                      ['image']
                                                                  .toString(),
                                                            )
                                                          : (value['id'] == 2)
                                                              ? Image.asset(
                                                                  listassetImage[1]
                                                                          [
                                                                          'image']
                                                                      .toString())
                                                              : (value['id'] ==
                                                                      3)
                                                                  ? Image.asset(
                                                                      listassetImage[2]
                                                                              [
                                                                              'image']
                                                                          .toString())
                                                                  : (value['id'] ==
                                                                          4)
                                                                      ? Image.asset(
                                                                          listassetImage[3]['image']
                                                                              .toString())
                                                                      : (value['id'] ==
                                                                              5)
                                                                          ? Image.asset(
                                                                              listassetImage[4]['image'].toString())
                                                                          : (value['id'] == 6)
                                                                              ? Image.asset(listassetImage[5]['image'].toString())
                                                                              : (value['id'] == 7)
                                                                                  ? Image.asset(listassetImage[6]['image'].toString())
                                                                                  : Image.asset(listassetImage[7]['image'].toString()))),
                                              Expanded(
                                                child: Text(
                                                  value["title"].toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                child: Text(
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                  value["name"].toString(),
                                                  maxLines: 30,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
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
                                  labelText: 'Special Option',
                                  hintText: 'Select one',
                                  prefixIcon: const Icon(
                                    Icons.edit_road_outlined,
                                    color: kImageColor,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: kPrimaryColor, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: kPrimaryColor),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 35,
                            width: 150,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 20, 23, 167)),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (comparedropdown != '') {
                                      comparedropdown2 = "P";
                                      typedrawerSe = true;
                                    }
                                    typedrawer = false;
                                    getAddress(latLng);
                                    Show(requestModel);
                                  });
                                },
                                child: const Text('Search')),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
      onTap: () {
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

  Future<void> updatePrice(comparableID, price) async {
    // print("updateraod => $updateraod");
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "comparable_id": comparableID,
      "comparable_adding_price": price,
      "comparable_property_id": updateproperty,
      "comparable_road": updateraod,
      "borey": checkborey
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update/priceCM',
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
            break; // Assuming comparable_id is unique, exit the loop after update
          }
        }
        print('Update succesfuly');
        Navigator.pop(context);
      });
    } else {
      print(response.statusMessage);
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
  int checkborey = 0;

  Future<void> Show(SearchRequestModel requestModel) async {
    if (controller.listMainRoute.isNotEmpty &&
        controller.listRaod.isNotEmpty &&
        controller.listPriceR.isNotEmpty &&
        controller.listPriceC.isNotEmpty &&
        controller.listKhanP.isNotEmpty &&
        controller.listsang.isNotEmpty &&
        controller.listOption.isNotEmpty &&
        controller.listdropdown.isNotEmpty) {
      try {
        setState(() {
          isApiCallProcess = true;
        });

        if (route != null) {
          for (int i = 0; i < controller.listMainRoute.length; i++) {
            if (route.toString().contains(
                    controller.listMainRoute[i]['name_road'].toString()) ||
                comparedropdown == "C") {
              haveValue = true;
              break;
            }
          }
        }
        setState(() {
          pty;
          if (checkborey == 0) {
            if (haveValue == true) {
              id_route = '1';
            } else {
              id_route = '2';
            }
          }
        });
        var headers = {'Content-Type': 'application/json'};
        var data = json.encode({
          "distance": distanceController.text,
          "property_type_id": (pty == null) ? null : pty,
          "type": (comparedropdown == "") ? "" : comparedropdown,
          "road": id_route,
          "num": requestModel.num,
          "lat": requestModel.lat,
          "lng": requestModel.lng,
          "borey": checkborey,
        });
        print("id_route ===> $id_route");
        print("requestModel.num ===> ${requestModel.num}");
        print("requestModel.num ===> ${requestModel.lat}");
        print("requestModel.num ===> ${requestModel.lng}");
        var dio = Dio();
        var response = await dio.request(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/mapNew/map_action',
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
            print("list ===> ${list.length}");
            if (list.length >= 5) {
              if (comparedropdown2 == "" && haveValue == true) {
                searchraod.text = controller.listRaod.first['road_name']!;
                searchlatlog.text = controller.listdropdown.first['type']!;
              } else if (comparedropdown2 == "" && haveValue == false) {
                searchraod.text = controller.listRaod[1]['road_name']!;
                searchlatlog.text = controller.listdropdown[1]['type']!;
              }
            }
          });
        }
        addingPriceSimple = 0;
        addingPriceVerbal = 0;
        if (list.length >= 5) {
          List<dynamic> filteredList = filterDuplicates(
              list, "comparable_adding_price", "latlong_la", "latlong_log");

          setState(() {
            isApiCallProcess = false;
            map = filteredList.asMap();
          });

          setState(() {
            for (var i = 0; i < map!.length; i++) {
              if (checkborey == 1) {
                if (map![i]['borey'] == 1) {
                  if (map![i]['type_value'] == "V") {
                    if (map![i]['comparable_adding_price'] == '') {
                      map![i]['comparable_adding_price'] = '0';
                      addingPriceVerbal +=
                          double.parse(map![i]['comparable_adding_price']);
                    } else if (map![i]['comparable_adding_price']
                        .contains(',')) {
                      addingPriceVerbal += double.parse(map![i]
                              ['comparable_adding_price']
                          .replaceAll(",", ""));
                    } else {
                      addingPriceVerbal +=
                          (double.parse(map![i]['comparable_adding_price']));
                    }
                  } else {
                    {
                      if (map![i]['comparable_adding_price'] == '') {
                        map![i]['comparable_adding_price'] = '0';
                        addingPriceSimple +=
                            double.parse(map![i]['comparable_adding_price']);
                      } else if (map![i]['comparable_adding_price']
                          .contains(',')) {
                        addingPriceSimple += double.parse(map![i]
                                ['comparable_adding_price']
                            .replaceAll(",", ""));
                      } else {
                        addingPriceSimple +=
                            (double.parse(map![i]['comparable_adding_price']));
                      }
                    }
                  }
                  setState(() {
                    data_adding_correct.add(map![i]);
                  });
                }
              } else {
                if (map![i]['type_value'] == "V") {
                  if (map![i]['comparable_adding_price'] == '') {
                    map![i]['comparable_adding_price'] = '0';
                    addingPriceVerbal +=
                        double.parse(map![i]['comparable_adding_price']);
                  } else if (map![i]['comparable_adding_price'].contains(',')) {
                    addingPriceVerbal += double.parse(
                        map![i]['comparable_adding_price'].replaceAll(",", ""));
                  } else {
                    addingPriceVerbal +=
                        (double.parse(map![i]['comparable_adding_price']));
                  }
                } else {
                  {
                    if (map![i]['comparable_adding_price'] == '') {
                      map![i]['comparable_adding_price'] = '0';
                      addingPriceSimple +=
                          double.parse(map![i]['comparable_adding_price']);
                    } else if (map![i]['comparable_adding_price']
                        .contains(',')) {
                      addingPriceSimple += double.parse(map![i]
                              ['comparable_adding_price']
                          .replaceAll(",", ""));
                    } else {
                      addingPriceSimple +=
                          (double.parse(map![i]['comparable_adding_price']));
                    }
                  }
                }
                setState(() {
                  data_adding_correct.add(map![i]);
                });
              }
            }
          });
          // print("No.1 addingPriceVerbal : $addingPriceVerbal");
          // print("No.2 addingPriceSimple : $addingPriceSimple");
          if (!clickdone) {
            if (data_adding_correct.isNotEmpty) {
              for (int i = 0; i < data_adding_correct.length; i++) {
                // print(
                //     "No.${data_adding_correct[i]['comparable_id']} : ${data_adding_correct[i]['comparable_property_id']}\n");
                if (data_adding_correct[i]['comparable_property_id']
                        .toString() ==
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
          }

          if (data_adding_correct.isNotEmpty) {
            if (data_adding_correct.length < 5) {
              setState(() {
                pty = null;
                comparedropdown = '';
              });

              // await Show(requestModel);
            } else {
              await Dialog(context);
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
    } else {
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

      if (list.length == 5 ||
          (!seenPriceAndLatLog.contains(priceAndLatLogKey) &&
              !seenLatLog.contains(latLogKey))) {
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
      // ignore: use_build_context_synchronously
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
        return Padding(
          padding: const EdgeInsets.only(top: 90, left: 80),
          child: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor),
                  height: 500,
                  width: 330,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
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
                              ElevatedButton(
                                  onPressed: () {
                                    updatePrice(
                                        data_adding_correct[i]['comparable_id']
                                            .toString(),
                                        priceController.text);
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

                              items: controller.listRaod
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
                                      '  :   '
                                      "${data_adding_correct[i]['comparable_land_width'] ?? ""}",
                                      style: TextStyle(fontSize: fontsizeD)),
                                  const SizedBox(height: 10),
                                  Text(
                                      '  :   '
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
  Future showDailogs() {
    return showDialog(
      context: context,
      builder: (context) => Column(
        children: [
          AlertDialog(
            backgroundColor: Colors.transparent,
            // backgroundColor: Colors.red,
            content: Container(
              height: 650,
              width: 500,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("images/paper1.jpg"),
                  fit: BoxFit.fitWidth,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 60, right: 20, top: 10, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/papersib.png",
                          height: 35,
                          width: 50,
                          fit: BoxFit.fitHeight,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                typedrawer = false;
                                typedrawerSe = false;
                              });
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline_outlined,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    const SizedBox(height: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (haveValue == true)
                          Card(
                            elevation: 10,
                            child: Container(
                              height: heightModel,
                              decoration: BoxDecoration(
                                color: colorbackground,
                                boxShadow: const [
                                  BoxShadow(blurRadius: 1, color: Colors.grey)
                                ],
                                border: Border.all(width: 0.2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      textb("Avg = "),
                                      textPriceb(
                                          "${formatter.format(adding_price)}\$"),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          text("Min = "),
                                          textPrice(
                                              "${formatter.format(adding_price - (0.01 * adding_price))}\$"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          text("Max = "),
                                          textPrice(
                                              "${formatter.format(adding_price + (0.01 * adding_price))}\$"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          Card(
                            elevation: 10,
                            child: Container(
                              height: 110,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 242, 242, 244),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset(2, 5),
                                      color: Color.fromARGB(255, 0, 89, 255))
                                ],
                                border: Border.all(
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textb("Avg = "),
                                        textPriceb(
                                            "${formatter.format(adding_price)}\$")
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                text("Min = "),
                                                textPrice(
                                                    "${formatter.format(adding_price - (0.01 * adding_price))}\$")
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                              children: [
                                                text(
                                                    "Min after - $add_min% = "),
                                                textPrice(
                                                    "${formatter.format((adding_price - (0.01 * adding_price)) - ((add_min / 100) * (adding_price - (0.01 * adding_price))))}\$")
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                text("Max = "),
                                                textPrice(
                                                    "${formatter.format(adding_price + (0.01 * adding_price))}\$")
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                              children: [
                                                text(
                                                    "Max after - $add_max% = "),
                                                textPrice(
                                                    "${formatter.format((adding_price + (0.01 * adding_price)) - ((add_max / 100) * (adding_price + (0.01 * adding_price))))}\$")
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 5),
                            Text("Residential",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontsizes)),
                            const SizedBox(height: 2),
                            Card(
                              elevation: 10,
                              child: Container(
                                height: heightModel,
                                decoration: BoxDecoration(
                                  color: colorbackground,
                                  boxShadow: const [
                                    BoxShadow(blurRadius: 1, color: Colors.grey)
                                  ],
                                  border: Border.all(width: 0.2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textb("Avg = "),
                                        textPriceb(
                                            "${formatter.format(R_avg)}\$")
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            text("Min = "),
                                            textPrice(
                                                "${formatter.format(double.parse(minSqm1))}\$")
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            text("Max = "),
                                            textPrice(
                                                "${formatter.format(double.parse(maxSqm1))}\$")
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("Commercial",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontsizes)),
                            const SizedBox(height: 5),
                            Card(
                              elevation: 10,
                              child: Container(
                                height: heightModel,
                                decoration: BoxDecoration(
                                  color: colorbackground,
                                  boxShadow: const [
                                    BoxShadow(blurRadius: 1, color: Colors.grey)
                                  ],
                                  border: Border.all(width: 0.2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textb("Avg = "),
                                        textPriceb(
                                            "${formatter.format(C_avg)}\$")
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            text("Min = "),
                                            textPrice(
                                                "${formatter.format(double.parse(minSqm2))}\$")
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            text("Max = "),
                                            textPrice(
                                                "${formatter.format(double.parse(maxSqm2))}\$")
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (haveValue == true)
                              Text("Calculator Compareble and Land_price",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontsizes)),
                            if (haveValue == true) const SizedBox(height: 10),
                            if (haveValue == true)
                              Card(
                                elevation: 10,
                                child: Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: colorbackground,
                                    border: Border.all(
                                      width: 0.2,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 5,
                                          offset: Offset(2, 5),
                                          color:
                                              Color.fromARGB(255, 0, 89, 255))
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          textb("Avg = "),
                                          textPriceb(
                                              "${formatter.format(avg)}\$")
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  text("Min = "),
                                                  textPrice(
                                                      "${formatter.format(min)}\$")
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  textb(
                                                      "Min after - $add_min% = "),
                                                  textPriceb(
                                                      "${formatter.format(min! - ((add_min / 100) * min!))}\$")
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  text("Max = "),
                                                  textPrice(
                                                      "${formatter.format(max)}\$")
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  textb(
                                                      "Min after - $add_min% = "),
                                                  textPriceb(
                                                      "${formatter.format(max! - ((add_max / 100) * max!))}\$")
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (haveValue == false)
                          if (data_adding_correct.length >= 5)
                            if (haveValue == false)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    for (int i = 0;
                                        i < data_adding_correct.length;
                                        i++)
                                      TextSpan(
                                          style: TextStyle(
                                            fontSize: fontsize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          text:
                                              '${(i < data_adding_correct.length - 1) ? '${data_adding_correct[i]['comparable_adding_price']} + ' : data_adding_correct[i]['comparable_adding_price']}'),
                                    TextSpan(
                                        text:
                                            ' / ${data_adding_correct.length} = ${formatter.format(adding_price)}\$',
                                        style: TextStyle(
                                            fontSize: fontsize,
                                            fontWeight: FontWeight.bold,
                                            color: colorsPrice)),
                                  ],
                                ),
                              ),
                        const SizedBox(height: 5),
                        Text(
                          "$commune /  $district / Route : ${route.toString()}",
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (haveValue == true)
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: fontsize,
                                fontWeight: FontWeight.bold,
                              ),
                              text:
                                  '\n(${formatter.format(adding_price)}\$ + ${formatter.format(R_avg)}\$ + ${formatter.format(C_avg)}\$) /2 = ', // default text style
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${formatter.format(avg)}\$',
                                    style: TextStyle(
                                        fontSize: fontsize,
                                        fontWeight: FontWeight.bold,
                                        color: colorsPrice)),
                              ],
                            ),
                          ),
                        const SizedBox(height: 5),
                        if (haveValue == true)
                          Card(
                            elevation: 10,
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 242, 242, 244),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset(2, 5),
                                      color: Color.fromARGB(255, 0, 89, 255))
                                ],
                                border: Border.all(
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (int i = 0;
                                            i < data_adding_correct.length;
                                            i++)
                                          Text(
                                              "${(i < data_adding_correct.length - 1) ? '${data_adding_correct[i]['comparable_adding_price']} + ' : data_adding_correct[i]['comparable_adding_price']}",
                                              style: TextStyle(
                                                  fontSize: fontsize,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        textPriceb(" Avg = "),
                                        textPriceb(
                                            "${formatter.format(adding_price)}\$"),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                textb(
                                                    "Min after - $add_min% = "),
                                                textPriceb(
                                                    "${formatter.format(adding_price - (0.01 * adding_price) - ((adding_price - (0.01 * adding_price)) * add_min) / 100)}\$"),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                text("Min = "),
                                                textPrice(
                                                    "${formatter.format(adding_price - (0.01 * adding_price))}\$"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                textb(
                                                    "Max after - $add_min% = "),
                                                textPrice(
                                                    "${formatter.format(adding_price + (0.01 * adding_price) - ((adding_price + (0.01 * adding_price)) * add_min) / 100)}\$"),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                text("Max = "),
                                                textPrice(
                                                    "${formatter.format(adding_price + (0.01 * adding_price))}\$"),
                                              ],
                                            ),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
  Future? Dialog(BuildContext context) {
    if (haveValue == true) {
      setState(() {
        // print("addingPriceSimple : $addingPriceSimple");
        // print("addingPriceVerbal : $addingPriceVerbal");
        var numberPrice = 0.0;
        for (int i = 0; i < data_adding_correct.length; i++) {
          numberPrice += double.parse(
              data_adding_correct[i]['comparable_adding_price'].toString());
        }
        adding_price = numberPrice;
        adding_price /= int.parse(data_adding_correct.length.toString());
        var price = (adding_price + (R_avg + C_avg)) / 2;
        min = price - (0.03 * price);
        max = price + (0.02 * price);
        avg = price;
        priceCm = price.toString();
      });
      return (!clickdone) ? showDailogs() : null;
    } else {
      setState(() {
        var numberPrice = 0.0;
        for (int i = 0; i < data_adding_correct.length; i++) {
          numberPrice += double.parse(
              data_adding_correct[i]['comparable_adding_price'].toString());
        }
        adding_price = numberPrice;
        adding_price /= int.parse(data_adding_correct.length.toString());
        // var price = (adding_price + R_avg) / 2;
        min = adding_price - (0.2 * adding_price);
        max = adding_price + (0.2 * adding_price);
        avg = adding_price;
      });
      return (!clickdone) ? showDailogs() : null;
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

  var maxSqm1, minSqm1;
  var maxSqm2, minSqm2;
  var commune, district, province;
  var route;
  dynamic R_avg, C_avg;
  Future<void> findByPiont(double la, double lo) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$la,$lo&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));

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
                district = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                checkSk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_1") {
              province = (jsonResponse['results'][j]['address_components'][i]
                  ['short_name']);
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
                route = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
              });
            }
          }
        }
      }

      addressController.text =
          "${(district == "null") ? "" : district}, ${(commune == "null") ? "" : commune}";
      if (checkFunction == false) {
        await checkKhatIDSangID(district, commune);
      }
    }
  }

  bool waitngOne = false;
  int khanID = 0;
  int sangkatID = 0;
  Future<void> checkKhatIDSangID(district, commune) async {
    setState(() {
      for (int i = 0; i < controller.listKhanP.length; i++) {
        for (int j = 0; j < controller.listsang.length; j++) {
          if (controller.listKhanP[i]['Khan_Name'] == district &&
              controller.listsang[j]['Sangkat_Name'] == commune) {
            khanID = controller.listKhanP[i]['Khan_ID'];
            sangkatID = controller.listsang[j]['Sangkat_ID'];
          }
        }
      }
      for (int r = 0; r < controller.listPriceR.length; r++) {
        if (controller.listPriceR[r]['Sangkat_ID'] == sangkatID &&
            controller.listPriceR[r]['Khan_ID'] == khanID) {
          setState(() {
            maxSqm1 = controller.listPriceR[r]['Max_Value'].toString();
            minSqm1 = controller.listPriceR[r]['Min_Value'].toString();
          });
        }
      }
      for (int c = 0; c < controller.listPriceC.length; c++) {
        if (controller.listPriceC[c]['Sangkat_ID'] == sangkatID &&
            controller.listPriceC[c]['Khan_ID'] == khanID) {
          setState(() {
            maxSqm2 = controller.listPriceC[c]['Max_Value'].toString();
            minSqm2 = controller.listPriceC[c]['Min_Value'].toString();
          });
        }
      }

      R_avg = (double.parse(maxSqm1.toString()) +
              double.parse(minSqm1.toString())) /
          2;
      C_avg = (double.parse(maxSqm2.toString()) +
              double.parse(minSqm2.toString())) /
          2;
      // print('No.3 R_avg : $R_avg || C_avg : $C_avg');
    });
  }
}
