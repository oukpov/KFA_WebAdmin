// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/animation/gf_animation.dart';
import 'package:getwidget/types/gf_animation_type.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../components/ApprovebyAndVerifyby.dart';
import '../../../../components/LandBuilding.dart';
import '../../../../components/bank.dart';
import '../../../../components/property.dart';
import '../../../../components/slideUp.dart';
import '../../../../customs/form.dart';
import '../../../Customs/Contants.dart';
import '../../../Customs/formTwinN.dart';
import '../../../api/api_service.dart';
import '../../../components/comment.dart';
import '../../../components/forceSale.dart';
import '../../../models/autoVerbal.dart';
import '../../../models/land_building.dart';

class Add extends StatefulWidget {
  const Add({super.key, required this.id, required this.id_control_user});
  final String id;
  final String id_control_user;
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String fromValue = 'Bank';
  String genderValue = 'Female';
  int opt = 0;
  double asking_price = 1;
  String address = '';
  String propertyType = '', propertyTypeValue = '';
  var code = 0;
  TextEditingController dateinput = TextEditingController();
  late AutoVerbalRequestModel requestModelAuto;
  var from = [
    'Bank',
    'Private',
    'Other',
  ];
  var gender = [
    'Female',
    'Male',
    'Other',
  ];

  var district;
  double? lat1;
  double? log2;
  double? lat;
  double? log;
  late List<dynamic> list_Khan;

  int id_khan = 0;

  var a;

  var opt_type_id = '0';
  List list = [];
  List<L_B> lb = [L_B('', '', '', '', '', 0, 0, 0, 0, 0)];
  void deleteItemToList(int Id) {
    setState(() {
      lb.removeAt(Id);
    });
  }

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

  Future<void> _getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // The user denied the request for location permission.
        // You can show a dialog or message to inform the user and guide them to enable location services.
        print('Location permission denied by the user.');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // The user denied the request for location permission permanently.
      // You can open the device settings to guide the user to enable location services.
      print('Location permission permanently denied by the user.');
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude;
      log = position.longitude;

      requestModelAuto.lat = lat.toString();
      requestModelAuto.lng = log.toString();
    });
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));

    if (response.statusCode == 200) {
      // Successful response
      var jsonResponse = json.decode(response.body);

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
                Load_khan(district.toString());
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                check_sk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
                Load_sangkat(commune.toString());
                print(commune.toString());
              });
            }
          }
        }
      }
    }
  }

  var formatter = NumberFormat("##,###,###,###.00", "en_US");
  var chars = "abcdefghijklmnopqrstuvwxyz0123456789";

  String RandomString(int strlen) {
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < strlen; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

  var verbal_id;
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> offsetAnimation;
  @override
  void initState() {
    _getCurrentPosition();
    verbal_id = widget.id_control_user.toString() + RandomString(9);
    controller = AnimationController(
        duration: const Duration(milliseconds: 645), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.repeat();
    offsetAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: const Offset(0, -0.3),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));
    lb;

    super.initState();

    requestModelAuto = AutoVerbalRequestModel(
      property_type_id: '',
      lat: "",
      lng: "",
      address: '',
      approve_id: "",
      agent: "",
      bank_branch_id: "",
      bank_contact: "",
      bank_id: "",
      bank_officer: "",
      code: "",
      comment: "",
      contact: "",
      date: "",
      image: "",
      option: "",
      owner: "",
      user: "10",
      verbal_com: '',
      verbal_con: "30",
      verbal: [],
      verbal_id: '0',
      verbal_khan: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(235, 7, 9, 145),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              print('Verbal ID =========> $verbal_id');
              List<Map<String, dynamic>> jsonList =
                  lb.map((item) => item.toJson()).toList();
              print('$jsonList');
              requestModelAuto.user = widget.id;
              requestModelAuto.verbal_id = verbal_id;
              requestModelAuto.verbal_khan = '${commune}.${district}';
              requestModelAuto.verbal = jsonList;
              APIservice apIservice = APIservice();
              apIservice.saveAutoVerbal(requestModelAuto).then(
                (value) async {
                  if (requestModelAuto.verbal.isEmpty) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      headerAnimationLoop: false,
                      title: 'Error',
                      desc: "Please add Land/Building at least 1!",
                      btnOkOnPress: () {},
                      btnOkIcon: Icons.cancel,
                      btnOkColor: Colors.red,
                    ).show();
                  } else {
                    if (value.message == "Save Successfully") {
                      if (_file != null) {
                        uploadt_image(_file!);
                        print('file != null');
                      }
                      uploadt_image_map();
                      print('file == null');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        headerAnimationLoop: false,
                        title: 'Successfully',
                        desc: value.message,
                        btnOkOnPress: () {
                          Navigator.pop(context);
                        },
                        btnOkIcon: Icons.done,
                        btnOkColor: Colors.green,
                      ).show();
                      // const snackBar = SnackBar(
                      //   content: Text('processing payment...'),
                      //   duration: Duration(seconds: 7),
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        headerAnimationLoop: false,
                        title: 'Error',
                        desc: value.message,
                        btnOkOnPress: () {},
                        btnOkIcon: Icons.cancel,
                        btnOkColor: Colors.red,
                      ).show();
                    }
                  }
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 5, top: 15, bottom: 15, right: 4),
              decoration: BoxDecoration(
                color: Colors.lightGreen[700],
                boxShadow: [BoxShadow(color: Colors.green, blurRadius: 5)],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                  bottomLeft: Radius.circular(80),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Submit"),
                  Icon(Icons.save_alt_outlined),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 10,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                    alignment: Alignment.topRight,
                  )
                ],
              ),
            ),
          ),
        ],
        title: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText('Auto Verbalss',
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 20)),
            ],
            pause: const Duration(milliseconds: 900),
            isRepeatingAnimation: true,
            repeatForever: true,
            onTap: () {},
          ),
        ),
        toolbarHeight: 80,
      ),
      backgroundColor: Color.fromARGB(235, 7, 9, 145),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: addVerbal(context),
        ),
      ),
    );
  }

  Widget addVerbal(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            SizedBox(width: 40),
            Icon(
              Icons.qr_code,
              color: kImageColor,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              verbal_id,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            )
          ],
        ),
        if (lat != null && lat1 == null)
          InkWell(
            onTap: () async {
              await SlideUp(context);
            },
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 1,
              margin: EdgeInsets.only(top: 15, right: 13, left: 15),
              child: FadeInImage.assetNetwork(
                placeholderCacheHeight: 120,
                placeholderCacheWidth: 120,
                fit: BoxFit.cover,
                placeholderFit: BoxFit.fill,
                placeholder: 'assets/earth.gif',
                image:
                    'https://maps.googleapis.com/maps/api/staticmap?center=${lat},${log}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
              ),
            ),
          )
        else if (lat1 != null)
          InkWell(
            onTap: () async {
              await SlideUp(context);
            },
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 1,
              margin: EdgeInsets.only(top: 15, right: 13, left: 15),
              child: FadeInImage.assetNetwork(
                placeholderCacheHeight: 50,
                placeholderCacheWidth: 50,
                placeholderFit: BoxFit.cover,
                placeholder: 'assets/earth.gif',
                image:
                    'https://maps.googleapis.com/maps/api/staticmap?center=${lat1},${log2}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat1},${log2}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
              ),
            ),
          )
        else
          SizedBox(),
        SingleChildScrollView(
            child: Column(children: [
          _file != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.file(
                      File(_file!.path),
                    ),
                  ),
                )
              : SizedBox(),
          _file == null
              ? TextButton(
                  onPressed: () async {
                    await openImage(ImageSource.gallery);
                    setState(() {
                      _file;
                    });
                  },
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 30, right: 30),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Icon(
                                  Icons.image_outlined,
                                  color: kImageColor,
                                ),
                                SizedBox(width: 10),
                                Text((imagepath == "")
                                    ? 'Choose Photo'
                                    : 'choosed Photo'),
                              ],
                            )),
                      ),
                    ),
                  ),
                )
              : SizedBox()
        ])),
        SizedBox(
          height: 10,
        ),
        CommentAndOption(
          value: (value) {
            setState(() {
              opt = int.parse(value);
            });
          },
          comment1: (opt != null) ? opt.toString() : null,
          id: (value) {
            setState(() {
              requestModelAuto.option = value;
            });
          },
          comment: (newValue) {
            setState(() {
              requestModelAuto.comment = newValue!.toString();
            });
          },
          opt_type_id: (value) {
            setState(() {
              opt_type_id = value.toString();
            });
          },
        ),

        if (id_khan != 0)
          InkWell(
            onTap: () {
              _asyncInputDialog(context);
              ++i;
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 40,
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent[700],
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Horizon',
                        fontWeight: FontWeight.bold,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText('land'),
                          RotateAnimatedText('Building'),
                        ],
                        pause: const Duration(milliseconds: 100),
                        repeatForever: true,
                      ),
                    ),
                  ),
                  GFAnimation(
                    controller: controller,
                    slidePosition: offsetAnimation,
                    type: GFAnimationType.slideTransition,
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 30,
                      shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (i >= 0)
          Container(
            width: 500,
            height: (lb.length > 1) ? 280 : 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 1; i < lb.length; i++)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        width: 290,
                        //height: 210,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${lb[i].verbal_land_type} ',
                                        style: NameProperty(),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              deleteItemToList(i);
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${lb[i].address} ',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Depreciation",
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      "Floor",
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      "Area",
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Min Value/Sqm',
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Max Value/Sqm',
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Min Value',
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Min Value',
                                      style: Label(),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 15),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4),
                                    Text(
                                      ':   ' + lb[i].verbal_land_dp,
                                      style: Name(),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ':   ' + lb[i].verbal_land_des,
                                      style: Name(),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ':   ' +
                                          (formatter.format(lb[i]
                                                  .verbal_land_area
                                                  .toInt()))
                                              .toString() +
                                          'm' +
                                          '\u00B2',
                                      style: Name(),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ':   ' +
                                          (lb[i].verbal_land_minsqm)
                                              .toString() +
                                          '\$',
                                      style: Name(),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ':   ' +
                                          (lb[i].verbal_land_maxsqm)
                                              .toString() +
                                          '\$',
                                      style: Name(),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ':   ' +
                                          (formatter.format(
                                                  lb[i].verbal_land_minvalue))
                                              .toString() +
                                          '\$',
                                      style: Name(),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      ':   ' +
                                          (formatter
                                                  .format(lb[i]
                                                      .verbal_land_maxvalue)
                                                  .toString() +
                                              '\$'),
                                      style: Name(),
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
            ),
          ),
        SizedBox(
          height: 10.0,
        ),
        PropertyDropdown(
          name: (value) {
            propertyType = value;
          },
          id: (value) {
            requestModelAuto.property_type_id = value;
          },
        ),
        SizedBox(
          height: 5.0,
        ),
        BankDropdown(
          bank: (value) {
            requestModelAuto.bank_id = value;
          },
          bankbranch: (value) {
            requestModelAuto.bank_branch_id = value;
          },
        ),
        SizedBox(
          height: 5.0,
        ),
        FormTwinN(
          Label1: 'Owner',
          Label2: 'Contact',
          onSaved1: (input) {
            requestModelAuto.owner = input!;
          },
          onSaved2: (input) {
            requestModelAuto.contact = input!;
          },
          icon1: Icon(
            Icons.person,
            color: kImageColor,
          ),
          icon2: Icon(
            Icons.phone,
            color: kImageColor,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        // DateComponents(
        //   date: (value) {
        //     requestModelAuto.date = value;
        //   },
        // ),
        SizedBox(
          height: 5.0,
        ),
        FormTwinN(
          Label1: 'Bank Officer',
          Label2: 'Contact',
          onSaved1: (input) {
            requestModelAuto.bank_officer = input!;
          },
          onSaved2: (input) {
            requestModelAuto.bank_contact = input!;
          },
          icon1: Icon(
            Icons.work,
            color: kImageColor,
          ),
          icon2: Icon(
            Icons.phone,
            color: kImageColor,
          ),
        ),

        SizedBox(
          height: 5,
        ),
        ForceSaleAndValuation(
          value: (value) {
            requestModelAuto.verbal_con = value;
          },
        ),

        SizedBox(
          height: 10,
        ),
        ApprovebyAndVerifyby(
          approve: (value) {
            requestModelAuto.approve_id = value;
          },
          verify: (value) {
            requestModelAuto.agent = value;
          },
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: FormS(
            label: 'Phum optional',
            onSaved: (input) {
              requestModelAuto.address = input!;
            },
            iconname: Icon(
              Icons.location_on_rounded,
              color: kImageColor,
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),

        // TextButton(
        //   onPressed: () {
        //     SlideUp(context);
        //   },
        //   child: FractionallySizedBox(
        //     widthFactor: 1,
        //     child: Padding(
        //       padding: const EdgeInsets.only(left: 22, right: 22),
        //       child: Container(
        //         height: 60,
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             width: 1,
        //             color: kPrimaryColor,
        //           ),
        //           borderRadius: BorderRadius.all(
        //             Radius.circular(10),
        //           ),
        //         ),
        //         // padding: EdgeInsets.only(left: 30, right: 30),
        //         child: Align(
        //             alignment: Alignment.centerLeft,
        //             child: Row(
        //               // ignore: prefer_const_literals_to_create_immutables
        //               children: [
        //                 SizedBox(width: 10),
        //                 Icon(
        //                   Icons.map_sharp,
        //                   color: kImageColor,
        //                 ),
        //                 SizedBox(width: 10),
        //                 Text((asking_price == 1)
        //                     ? 'Choose Location'
        //                     : 'Choosed Location'),
        //               ],
        //             )),
        //       ),
        //     ),
        //   ),
        // ),

        // FileOpen(),
        // SizedBox(
        //   height: 5,
        // ),

        // ImageController(),
        // ImageOpen(
        //   set_Image: (value) {
        //     requestModelAuto.image = value;
        //   },
        // ),
      ],
    );
  }

  var dropdown;
  String? options;
  String? commune;
  //MAP
  Future<void> SlideUp(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => map_cross_verbal(
          get_max1: (value) {},
          get_min1: (value) {},
          get_min2: (value) {},
          get_max2: (value) {},
          get_commune: (value) {
            setState(() {
              commune = value;
              Load_sangkat(value);
            });
          },
          get_district: (value) {
            setState(() {
              district = value;
              Load_khan(district);
            });
          },
          get_lat: (value) {
            setState(() {
              lat1 = double.parse(value.toString());
              requestModelAuto.lat = value;
            });
          },
          get_log: (value) {
            setState(() {
              log2 = double.parse(value.toString());
              requestModelAuto.lng = value;
            });
          },
          get_province: (value) {},
          asking_price: (value) {
            setState(() {
              asking_price = double.parse(value.toString());
            });
          },
        ),
      ),
    );
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => HomePage(
    //             c_id: code.toString(),
    //             district: (value) {
    //               setState(() {
    //                 district = value;
    //                 Load_khan(district);
    //               });
    //             },
    //             commune: (value) {
    //               setState(() {
    //                 commune = value;
    //                 Load_sangkat(value);
    //               });
    //             },
    //             lat: (value) {
    //               setState(() {
    //                 lat1 = double.parse(value);
    //                 requestModelAuto.lat = value;
    //               });
    //             },
    //             log: (value) {
    //               setState(() {
    //                 log2 = double.parse(value);
    //                 requestModelAuto.lng = value;
    //               });
    //             },
    //             province: (value) {},
    //           )),
    // );
    setState(() {
      requestModelAuto.image = code.toString();
    });
    if (!mounted) return;
    // asking_price = result[0]['adding_price'];
    // address = result[0]['address'];
    // requestModelAuto.lat = result[0]['lat'];
    // requestModelAuto.lng = result[0]['lng'];
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //===================== Upload Image to MySql Server
  late File _image;
  final picker = ImagePicker();
  late String base64string;
  XFile? _file;
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  dynamic openImage(ImageSource source) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(source: source);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        CroppedFile? cropFile = await ImageCropper()
            .cropImage(sourcePath: pickedFile.path, aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio16x9,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.square,
        ], uiSettings: [
          AndroidUiSettings(
              lockAspectRatio: false,
              backgroundColor: Colors.black,
              initAspectRatio: CropAspectRatioPreset.original)
        ]);
        _file = XFile(cropFile!.path);
        imagepath = pickedFile.path;
        // _file = imagefile;
        // XFile? imagefile;

        //output /data/user/0/com.example.testapp/cache/image_picker7973898508152261600.jpg
        File? imagefile = File(imagepath); //convert Path to File
        // saveAutoVerbal(imagefile);
        Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
        String base64string =
            base64.encode(imagebytes); //convert bytes to base64 string
        Uint8List decodedbytes = base64.decode(base64string);
        //decode base64 stirng to bytes
        setState(() async {
          _file = imagefile as XFile;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  Future<dynamic> uploadt_image(XFile _image) async {
    var request = await http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image"));
    Map<String, String> headers = {
      "content-type": "application/json",
      "Connection": "keep-alive",
      "Accept-Encoding": " gzip"
    };
    request.headers.addAll(headers);
    // request.files.add(picture);
    request.fields['cid'] = verbal_id.toString();
    request.files.add(
      await http.MultipartFile.fromPath(
        "image",
        _image.path,
      ),
    );
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
  }

  Random random = new Random();
  Future<dynamic> uploadt_image_map() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/set_image_map'));
    request.fields['cid'] = verbal_id.toString();
    if (lat1 == null) {
      final response1 = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${lat},${log}&zoom=20&size=720x720&maptype=hybrid&markers=color:red%7C%7C${lat},${log}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));
      final byte = response1.bodyBytes;
      Uint8List get_image_byte1 = Uint8List.fromList(byte);
      request.files.add(await http.MultipartFile.fromBytes(
          'image', get_image_byte1,
          filename: 'k${random.nextInt(999)}f${random.nextInt(99)}a.png'));
    } else {
      final response2 = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${lat1},${log2}&zoom=20&size=720x720&maptype=hybrid&markers=color:red%7C%7C${lat1},${log2}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));
      final byte = response2.bodyBytes;
      Uint8List get_image_byte2 = Uint8List.fromList(byte);
      request.files.add(await http.MultipartFile.fromBytes(
          'image', get_image_byte2,
          filename: 'k${random.nextInt(999)}f${random.nextInt(99)}a.png'));
    }

    var res = await request.send();
  }

  //get khan
  void Load_khan(String district) async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/khan?Khan_Name=${district}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list_Khan = jsonData;
        id_khan = int.parse(list_Khan[0]['Khan_ID'].toString());
      });
    }
  }

  var id_Sangkat;
  List<dynamic> list_sangkat = [];
  void Load_sangkat(String id) async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/sangkat?Sangkat_Name=${id}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list_sangkat = jsonData;
        id_Sangkat = int.parse(list_sangkat[0]['Sangkat_ID']);
      });
    }
  }

  int i = 0;
  Future _asyncInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 10),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.height * 0.8,
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                child: LandBuilding(
                  ID_khan: id_khan.toString(),
                  // asking_price: asking_price,
                  opt: (opt != null) ? opt : 0,
                  address: '${commune} / ${district}',
                  list: (value) {
                    setState(() {
                      requestModelAuto.verbal = value;
                    });
                  },
                  landId: verbal_id.toString(),
                  Avt: (value) {
                    a = value;
                    setState(() {});
                  },
                  opt_type_id: opt_type_id.toString(),
                  check_property: 1,
                  list_lb: (value) {
                    setState(() {
                      lb.addAll(value!);
                    });
                  },
                  ID_sangkat: id_Sangkat.toString(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 13);
  }

  TextStyle Name() {
    return TextStyle(
        color: kImageColor, fontSize: 14, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return TextStyle(
        color: kImageColor, fontSize: 11, fontWeight: FontWeight.bold);
  }
}
