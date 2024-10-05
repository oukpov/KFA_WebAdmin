// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'dart:html' as html;
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../components/building.dart';
import '../../../../../components/colors.dart';
import '../../../Getx_api/vetbal_controller.dart';
import '../../../Map/map_in_add_verbal.dart';
import '../../../Model/Autho_verbal.dart';

// ignore: must_be_immutable
class AddProperty extends StatefulWidget {
  const AddProperty({super.key, required this.idUserController});

  final String idUserController;
  @override
  State<AddProperty> createState() => _Add_verbal_saleState();
}

class _Add_verbal_saleState extends State<AddProperty> {
  late AutoVerbal_property_a requestAutoVerbal_property;
  final List<String> _items_2 = [
    'For Sale',
    'For Rent',
  ];
  int? index_Sale;
  int? index_Rent;
  late String branchvalue;
  bool _isLoading = true;
  var _items = [];
  var last_verbal_id;
  @override
  void initState() {
    _initData();
    _getCurrentPosition();
    super.initState();
  }

  int? hometype_api_index;
  bool? index12 = true;
  var khan;
  var songkat;
  var provice_map;
  Future<void> _initData() async {
    await Future.wait([
      controller_verbal.verbal_last_ID(),
      controller_verbal.verbal_Hometype(),
      controller_verbal.verbal_Commune_25_all(),
    ]);

    setState(() {
      _isLoading = false;
    });
  }

  Widget _text(text) {
    return Padding(
      padding: const EdgeInsets.only(right: 0, left: 0, bottom: 5),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height * 0.02),
      ),
    );
  }

  var controller_verbal = Controller_verbal();
  bool switchValue = false;
  String _switchValue = 'Switch';
  bool way = false;
  TextEditingController address1 = TextEditingController();

  var id_ptys;
  String urgent = "";
  String? get_re = '202301';
  String? await_functino;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 20, 13, 113),
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          centerTitle: true,
          title: Text(widget.idUserController),
          // title: Text(
          //   '${(controller_verbal.id_last.toString() == 'null') ? "....." : controller_verbal.id_last.toString()}',
          //   style:const TextStyle(
          //     color: Colors.white,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          actions: [
            GFButton(
              textStyle: const TextStyle(color: Colors.white),
              onPressed: () async {
                setState(() {
                  if (khan != null || provice_map != null) {
                    address =
                        '${(khan == null) ? "" : khan} ${(provice_map == null) ? "" : provice_map}';
                  } else {
                    address = "";
                  }
                  type;
                  urgent;
                });
                if (type == 'For Sale' &&
                    _byesData != null &&
                    // _images.length == 2
                    // &&
                    lat != 0) {
                  await_functino = '1';
                  // await _uploadImag_Multiple('mutiple_image_post');
                  _latlog('lat_log_post');
                  ID();
                  Urgent('Urgent_Post');
                  value_property('2_property');
                  await _uploadImage('Image_ptys_post', 'image_name_sale');
                } else if (type == 'For Rent' &&
                    _byesData != null &&
                    // _images.length == 2 &&
                    lat != null) {
                  await_functino = '1';
                  //  await _uploadImag_Multiple('mutiple_imageR_post');
                  _latlog('lat_log_post_rent');
                  ID();
                  Urgent('Urgen_rent');
                  value_property('rent/more');
                  await _uploadImage('rent_post_image', 'image_name_rent');
                }
              },
              text: "Save",
              icon: const Icon(Icons.save_alt_outlined),
              color: Colors.white,
              type: GFButtonType.outline,
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 223, 223, 223),
        body: (await_functino != '1')
            ? body()
            : LiquidLinearProgressIndicator(
                value: 0.25,
                valueColor: const AlwaysStoppedAnimation(
                    Color.fromARGB(255, 53, 33, 207)),
                backgroundColor: Colors.white,
                borderColor: Colors.white,
                borderWidth: 5.0,
                borderRadius: 12.0,
                direction: Axis.vertical,
                center: Text(
                  "Please waiting...!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.025),
                ),
              ));
  }

  String? commune;
  String? district;
  Future<void> _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude;
      log = position.longitude;
    });
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${log}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));

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
              });
            }
            if (jsonResponse['results'][j]['address_components'][i]['types']
                    [0] ==
                "administrative_area_level_3") {
              setState(() {
                check_sk = true;
                commune = (jsonResponse['results'][j]['address_components'][i]
                    ['short_name']);
              });
            }
          }
        }
      }
    }
  }

  var _size_10 = SizedBox(height: 10);
  String property_type_id = '';
  double price = 0.0;
  double sqm = 0.0;
  int bed = 0;
  int bath = 0;
  String type = '';
  double land = 0.0;
  String? address;
  String? Title;
  String? description;
  String hometype = '';
  //proeperty_2
  double Private_Area = 0.0;
  int Livingroom = 0;
  int Parking = 0;
  int size_w = 0;
  int size_l = 0;
  int floor = 0;
  double land_l = 0;
  double land_w = 0;
  double size_house = 0.0;
  double total_area = 0.0;
  double price_sqm = 0.0;
  int aircon = 0;
  double? lat = 0, log = 0;
  File? _compressedImage;
  File? _compressedImages;
  File? _compressedImage_only;
  File? result;
  File? _imageFile;

  double lat_map = 0;
  double log_map = 0;
  var SizedBox_10w = SizedBox(
    width: 10,
  );
  void value_property(_url) async {
    Map<String, dynamic> payload = {
      'id_ptys': controller_verbal.id_last.toString(),
      'userID': widget.idUserController,
      'property_type_id': property_type_id,
      'price': price,
      'sqm': sqm,
      'bed': bed,
      'bath': bath,
      'type': type.toString(),
      'land': land,
      'address': address,
      'Title': Title,
      'description': description,
      'hometype': hometype,
      'property_two': [
        {
          "id_ptys": controller_verbal.id_last.toString(),
          "Private_Area": Private_Area,
          "Livingroom": Livingroom,
          "Parking": Parking,
          "size_w": size_w,
          "Size_l": size_l,
          "floor": floor,
          "land_l": land_l,
          "land_w": land_w,
          "size_house": size_house,
          "total_area": total_area,
          "price_sqm": price_sqm,
          "aircon": aircon,
        }
      ]
    };

    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/$_url');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success value Sale');
    } else {
      print('value_property: ${response.reasonPhrase}');
    }
  }

  Future<void> ID() async {
    Map<String, int> payload = {
      'id_ptys': int.parse(controller_verbal.id_last.toString()),
      'property': 0,
    };

    final url = Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/post_id_sale_last');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('success');
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  void _latlog(_url) async {
    Map<String, dynamic> payload = await {
      'id_ptys': controller_verbal.id_last.toString(),
      'property_type_id': property_type_id,
      'lat': lat.toString(),
      'log': log.toString(),
    };

    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/$_url');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success latlog');
    } else {
      print('Error Latlog: ${response.reasonPhrase}');
    }
  }

  void Urgent(_url) async {
    Map<String, dynamic> payload = await {
      'id_ptys': controller_verbal.id_last.toString(),
      'property_type_id':
          (property_type_id == '') ? null : int.parse(property_type_id),
      'hometype': hometype,
      'urgent': urgent,
    };

    final url = await Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/$_url');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Success urgent_Sale');
    } else {
      print('Urgent: ${response.reasonPhrase}');
    }
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // appbar(),
          _size_10,
          bodyValue(),
          body2_value(),
        ],
      ),
    );
  }

  Widget bodyValue() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60), topRight: Radius.circular(60))),
      child: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _size_10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _text_noFWf('$type (${(urgent == "null") ? "" : urgent})'),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.27,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 208, 208, 211),
                      border: Border.all(
                        width: 0.6,
                        color: const Color.fromARGB(255, 210, 210, 213),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Switch(
                        autofocus: false,
                        activeColor: Colors.white,
                        value: switchValue,
                        onChanged: (value) {
                          setState(() {
                            switchValue = value;
                            if (value == true) {
                              urgent = 'Urgent';
                            } else {
                              urgent = '';
                            }
                            print(switchValue);
                          });
                        },
                      ),
                      Text(
                        urgent,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 100, 100, 100),
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _size_10,
            Padding(
              padding: const EdgeInsets.only(right: 0, left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Map_verbal_address_Sale(
                            get_province: (value) {
                              setState(() {
                                songkat = value.toString();
                              });
                            },
                            get_district: (value) {
                              setState(() {
                                provice_map = value.toString();
                              });
                            },
                            get_commune: (value) {
                              setState(() {
                                khan = value.toString();
                              });
                            },
                            get_log: (value) {
                              setState(() {
                                log = double.parse(value.toString());

                                print('log = ${log.toString()}');
                              });
                            },
                            get_lat: (value) {
                              setState(() {
                                lat = double.parse(value.toString());

                                print('lat_map = ${lat_map.toString()}');
                              });
                            },
                          );
                        },
                      ));
                    },
                    child: (khan != null || songkat != null)
                        ? Container(
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholderFit: BoxFit.contain,
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.4,
                              placeholder: 'assets/earth.gif',
                              image:
                                  "https://maps.googleapis.com/maps/api/staticmap?center=${lat.toString()},${log.toString()}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat.toString()},${log.toString()}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8",
                            ),
                          )
                        : Container(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              child: Stack(children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://maps.googleapis.com/maps/api/staticmap?center=${lat.toString()},${log.toString()}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat.toString()},${log.toString()}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8',
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ]),
                            ),
                          ),
                  ),
                  if (_byesData != null)
                    InkWell(
                      onTap: () {
                        setState(() {
                          OpenImgae();
                        });
                      },
                      child: Column(
                        children: [
                          if (get_bytes == null)
                            Image.memory(
                              _byesData!,
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.4,
                              fit: BoxFit.cover,
                            )
                          else
                            Container(
                              child: Image.memory(
                                get_bytes!,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.4,
                                fit: BoxFit.cover,
                              ),
                            ),
                        ],
                      ),
                    ),
                  (_byesData == null && get_bytes == null)
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              OpenImgae();
                            });
                          },
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              child: Stack(children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/Form_Image/image_select.jpg',
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ]),
                            ),
                          ))
                      : SizedBox(),
                ],
              ),
            ),
            dropdown(hometype, controller_verbal.list_hometype, 'hometype',
                'hometype', 'Hometype'),
            dropdown(property_type_id, controller_verbal.list_cummone,
                'property_type_id', 'Name_cummune', 'Province*'),
            _size_10,
            Row(
              children: [
                text_double(price, 'Price*'),
                SizedBox_10w,
                text_double(sqm, 'Sqm'),
              ],
            ),
            _size_10,
            Row(
              children: [
                text_int(bed, 'Bed'),
                SizedBox_10w,
                text_int(bath, 'Bath'),
              ],
            ),
            _size_10,
            _text('Size Land*'),
            Building(
              type: 'No_Edit',
              l: (value) {
                setState(() {
                  land_l = double.parse(value);
                });
              },
              w: (value) {
                setState(() {
                  land_w = double.parse(value);
                });
              },
              total: (value) {
                setState(() {
                  land = double.parse(value.toString());
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget body2_value() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _text('Size House'),
            Building(
              type: 'No_Edit',
              l: (value) {
                setState(() {
                  size_l = int.parse(value);
                });
              },
              w: (value) {
                setState(() {
                  size_w = int.parse(value);
                });
              },
              total: (value) {
                setState(() {
                  size_house = double.parse(value.toString());
                });
              },
            ),
            _size_10,
            Row(
              children: [
                text_int(floor, 'floor'),
                SizedBox_10w,
                text_int(Parking, 'Parking'),
              ],
            ),
            _size_10,
            Row(
              children: [
                text_double(total_area, 'Total Area'),
                SizedBox_10w,
                text_double(price_sqm, 'Price(sqm)*'),
              ],
            ),
            _size_10,
            Row(
              children: [
                text_int(Livingroom, 'LivingRoom'),
                SizedBox_10w,
                text_int(aircon, 'Aricon'),
              ],
            ),
            _size_10,
            Row(
              children: [
                Type_Property(),
                SizedBox_10w,
                text_double(Private_Area, 'Private Area'),
              ],
            ),
            _size_10,
            // Row(
            //   children: [
            //     text_double(land, 'Land'),
            //   ],
            // ),
            _size_10,
            W_Title(),
            _size_10,
            W_Description()
          ],
        ),
      ),
    );
  }

  Widget Type_Property() {
    return Expanded(
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            onChanged: (newValue) {
              setState(() {
                type = newValue!;
              });
              if (type == 'For Sale') {
                index_Sale = _items_2.indexOf('For Sale');
              } else if (type == 'For Rent') {
                index_Rent = _items_2.indexOf('For Rent');
                // print('$type');
                // print('$index_Rent');
              }
            },
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Please select bank';
              }
              return null;
            },
            items: _items_2
                .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: MediaQuery.textScaleFactorOf(context) * 13,
                          height: 1),
                    ),
                  ),
                )
                .toList(),
            // add extra sugar..
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),

            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              prefixIcon: Icon(
                Icons.type_specimen_outlined,
                color: Colors.grey,
              ),
              hintText: 'Type*',
              fillColor: kwhite,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget W_Title() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            Title = value;
          });
        },
        maxLines: 3,
        decoration: InputDecoration.collapsed(
          hintText: 'Title',
        ),
      ),
    );
  }

  Widget W_Description() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            description = value;
          });
        },
        maxLines: 3,
        decoration: InputDecoration.collapsed(
          hintText: 'Description',
        ),
      ),
    );
  }

  Widget text_double(double _value, text) {
    return Expanded(
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextFormField(
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.015,
              fontWeight: FontWeight.bold,
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _value = double.parse(value.toString());
                if (text == 'Price*') {
                  price = _value;
                } else if (text == 'Sqm') {
                  sqm = _value;
                } else if (text == 'Total Area') {
                  total_area = _value;
                } else if (text == 'Price(sqm)*') {
                  price_sqm = _value;
                } else {
                  Private_Area = _value;
                }
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              prefixIcon: Icon(
                (text == 'Price*')
                    ? Icons.price_change_outlined
                    : (text == 'Sqm')
                        ? Icons.square_foot_rounded
                        : (text == 'Total Area')
                            ? Icons.tornado_outlined
                            : (text == 'Price(sqm)*')
                                ? Icons.price_check_outlined
                                : Icons.privacy_tip_outlined,
                color: Colors.grey,
              ),
              hintText: '$text',
              fillColor: kwhite,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget text_int(int _value, text) {
    return Expanded(
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextFormField(
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.015,
              fontWeight: FontWeight.bold,
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _value = int.parse(value.toString());
                if (text == 'Bed') {
                  bed = _value;
                } else if (text == 'Bed') {
                  bed = _value;
                } else if (text == 'Bath') {
                  bath = _value;
                } else if (text == 'floor') {
                  floor = _value;
                } else if (text == 'Parking') {
                  Parking = _value;
                } else if (text == 'LivingRoom') {
                  Livingroom = _value;
                } else {
                  aircon = _value;
                }
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              prefixIcon: Icon(
                (text == 'Bed')
                    ? Icons.bed_rounded
                    : (text == 'Bath')
                        ? Icons.bathtub_sharp
                        : (text == 'floor')
                            ? Icons.stairs_outlined
                            : (text == 'Parking')
                                ? Icons.local_parking
                                : (text == 'LivingRoom')
                                    ? Icons.living_rounded
                                    : Icons.kitchen_outlined,
                color: Colors.grey,
              ),
              hintText: '$text',
              fillColor: kwhite,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  File? imageFile;
  Uint8List? get_bytes;
  String? _uploadedBlobUrl;
  String? _croppedBlobUrl;
  Widget body1() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 21, 105, 6),
                      // border: Border.all(width: 2),
                    ),
                    height: MediaQuery.of(context).size.width * 0.11,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Text(
                      'Code : ${controller_verbal.id_last.toString()}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.37,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 6, 25, 121),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Switch(
                          autofocus: false,
                          activeColor: const Color.fromARGB(255, 253, 253, 253),
                          value: switchValue,
                          onChanged: (value) {
                            setState(() {
                              switchValue = value;
                              if (value == true) {
                                urgent = 'Urgent';
                              } else {
                                urgent = 'N/A';
                              }
                              print(switchValue);
                            });
                          },
                        ),
                        Text(
                          urgent,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Map_verbal_address_Sale(
                            get_province: (value) {
                              setState(() {
                                songkat = value.toString();
                              });
                            },
                            get_district: (value) {
                              setState(() {
                                provice_map = value.toString();
                              });
                            },
                            get_commune: (value) {
                              setState(() {
                                khan = value.toString();
                              });
                            },
                            get_log: (value) {
                              setState(() {
                                log = double.parse(value.toString());

                                print('log = ${log.toString()}');
                              });
                            },
                            get_lat: (value) {
                              setState(() {
                                lat = double.parse(value.toString());

                                print('lat_map = ${lat_map.toString()}');
                              });
                            },
                          );
                        },
                      ));
                    },
                    child: (khan != null || songkat != null)
                        ? Container(
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholderFit: BoxFit.contain,
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.35,
                              placeholder: 'assets/earth.gif',
                              image:
                                  "https://maps.googleapis.com/maps/api/staticmap?center=${lat.toString()},${log.toString()}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat.toString()},${log.toString()}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8",
                            ),
                          )
                        : Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              child: Stack(children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://maps.googleapis.com/maps/api/staticmap?center=${lat.toString()},${log.toString()}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat.toString()},${log.toString()}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8',
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ]),
                            ),
                          ),
                  ),
                  if (_byesData != null)
                    InkWell(
                      onTap: () {
                        setState(() {
                          OpenImgae();
                        });
                      },
                      child: Column(
                        children: [
                          if (get_bytes == null)
                            Image.memory(
                              _byesData!,
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.35,
                              fit: BoxFit.cover,
                            )
                          else
                            Container(
                              child: Image.memory(
                                get_bytes!,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.35,
                                fit: BoxFit.cover,
                              ),
                            ),
                        ],
                      ),
                    ),
                  (_byesData == null && get_bytes == null)
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              OpenImgae();
                            });
                          },
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              child: Stack(children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/Form_Image/image_select.jpg',
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ]),
                            ),
                          ))
                      : SizedBox(),
                ],
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     setState(() {
            //       OpenImgae();
            //     });
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //         right: 30, left: 30, top: 10, bottom: 10),
            //     child: Container(
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           border: Border.all(width: 1)),
            //       height: MediaQuery.of(context).size.height * 0.2,
            //       width: double.infinity,
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(10.0),
            //           topRight: Radius.circular(10.0),
            //           bottomLeft: Radius.circular(10.0),
            //           bottomRight: Radius.circular(10.0),
            //         ),
            //         child: (get_bytes != null)
            //             ? Image.memory(
            //                 _byesData!,
            //                 height: MediaQuery.of(context).size.height * 0.19,
            //                 width: double.infinity,
            //                 fit: BoxFit.cover,
            //               )
            //             : Stack(children: [
            //                 CachedNetworkImage(
            //                   imageUrl:
            //                       'https://as1.ftcdn.net/v2/jpg/01/80/31/10/1000_F_180311099_Vlj8ufdHvec4onKSDLxxdrNiP6yX4PnP.jpg',
            //                   fit: BoxFit.cover,
            //                   height: MediaQuery.of(context).size.height * 0.19,
            //                   width: double.infinity,
            //                   progressIndicatorBuilder:
            //                       (context, url, downloadProgress) => Center(
            //                     child: CircularProgressIndicator(
            //                         value: downloadProgress.progress),
            //                   ),
            //                   errorWidget: (context, url, error) =>
            //                       Icon(Icons.error),
            //                 ),
            //                 Positioned(
            //                   left: MediaQuery.of(context).size.height * 0.09,
            //                   top: MediaQuery.of(context).size.height * 0.05,
            //                   child: GFShimmer(
            //                     child: Text(
            //                       'Select Image',
            //                       style: TextStyle(
            //                           fontSize: 30,
            //                           fontWeight: FontWeight.w700),
            //                     ),
            //                     showGradient: true,
            //                     gradient: LinearGradient(
            //                       begin: Alignment.bottomRight,
            //                       end: Alignment.centerLeft,
            //                       stops: const <double>[0.2, 0.7, 0.8, 0.9, 1],
            //                       colors: [
            //                         Color.fromARGB(255, 5, 10, 159)
            //                             .withOpacity(0.1),
            //                         Color.fromARGB(255, 5, 9, 114),
            //                         Color.fromARGB(255, 4, 8, 103),
            //                         Color.fromARGB(255, 5, 8, 93),
            //                         Color.fromARGB(255, 4, 6, 82),
            //                       ],
            //                     ),
            //                   ),
            //                 )
            //               ]),
            //       ),
            //     ),
            //   ),
            // ),
            // (_images.length != 0)
            //     ? Padding(
            //         padding: const EdgeInsets.only(left: 10, right: 10),
            //         child: Container(
            //           height: MediaQuery.of(context).size.height * 0.2,
            //           width: double.infinity,
            //           child: GridView.count(
            //             crossAxisCount: 2,
            //             mainAxisSpacing: 5,
            //             crossAxisSpacing: 5,
            //             children: List.generate(_images.length, (index) {
            //               return Image.file(
            //                 _images[index],
            //                 fit: BoxFit.cover,
            //               );
            //             }),
            //           ),
            //         ),
            //       )
            //     : SizedBox(),
            // SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 10, left: 10),
            //   child: InkWell(
            //     onTap: pickImages,
            //     child: Container(
            //       alignment: Alignment.center,
            //       height: 50,
            //       width: double.infinity,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(16),
            //           color: Color.fromARGB(255, 47, 22, 157)),
            //       child: Text(
            //         'Mutiple Image',
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 16,
            //             color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                Get.to(Map_verbal_address_Sale(
                  get_province: (value) {
                    setState(() {
                      songkat = value.toString();
                    });
                  },
                  get_district: (value) {
                    setState(() {
                      provice_map = value.toString();
                    });
                  },
                  get_commune: (value) {
                    setState(() {
                      khan = value.toString();
                    });
                  },
                  get_log: (value) {
                    setState(() {
                      log = double.parse(value);
                    });
                  },
                  get_lat: (value) {
                    lat = double.parse(value);
                  },
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: Container(
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.contain,
                    placeholder: 'assets/earth.gif',
                    image:
                        "https://maps.googleapis.com/maps/api/staticmap?center=${lat.toString()},${log.toString()}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${lat.toString()},${log.toString()}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8",
                  ),
                ),
              ),
            ),
            _size_10,
            Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                onChanged: (newValue) {
                  setState(() {
                    hometype = newValue!;
                  });
                },
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please select bank';
                  }
                  return null;
                },
                items: controller_verbal.list_hometype
                    .map<DropdownMenuItem<String>>(
                      (value) => DropdownMenuItem<String>(
                        value: value["hometype"],
                        child: Text(
                          value['hometype'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 13,
                              height: 1),
                        ),
                      ),
                    )
                    .toList(),
                // add extra sugar..
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: kImageColor,
                ),
                //property_type_id
                decoration: InputDecoration(
                  fillColor: kwhite,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  labelText: 'Hometype',
                  hintText: 'Hometype',
                  prefixIcon: const Icon(
                    Icons.app_registration_sharp,
                    color: kImageColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: kPrimaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                onChanged: (newValue) {
                  setState(() {
                    // property_type_id = newValue;
                  });
                },
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please select bank';
                  }
                  return null;
                },
                items: controller_verbal.list_cummone
                    .map<DropdownMenuItem<String>>(
                      (value) => DropdownMenuItem<String>(
                        value: value["property_type_id"].toString(),
                        child: Text(
                          value["Name_cummune"],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 13,
                              height: 1),
                        ),
                      ),
                    )
                    .toList(),
                // add extra sugar..
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: kImageColor,
                ),
                //property_type_id

                decoration: InputDecoration(
                  fillColor: kwhite,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  labelText: 'Province*',
                  hintText: 'Select',
                  prefixIcon: Icon(
                    Icons.app_registration_sharp,
                    color: kImageColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: kPrimaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            price = double.parse(value.toString());
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          prefixIcon: Icon(
                            Icons.feed_outlined,
                            color: kImageColor,
                          ),
                          hintText: 'Price*',
                          fillColor: kwhite,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            //  sqm =
                            //         double.parse(value).toStringAsFixed(5);
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          prefixIcon: Icon(
                            Icons.feed_outlined,
                            color: kImageColor,
                          ),
                          hintText: 'Sqm',
                          fillColor: kwhite,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            bed = int.parse(value);
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          prefixIcon: Icon(
                            Icons.bed_outlined,
                            color: kImageColor,
                          ),
                          hintText: 'bed',
                          fillColor: kwhite,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            bath = int.parse(value);
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          prefixIcon: Icon(
                            Icons.feed_outlined,
                            color: kImageColor,
                          ),
                          hintText: 'bath',
                          fillColor: kwhite,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _size_10,
            _text('Size Land*'),
            Building(
              l: (value) {
                setState(() {
                  land_l = double.parse(value);
                });
              },
              w: (value) {
                setState(() {
                  land_w = double.parse(value);
                  print(land_w.toString());
                });
              },
              total: (value) {
                setState(() {
                  land = double.parse(value.toString());
                  print(land.toString());
                });
              },
            ),
            SizedBox(height: 10),
            _text('Size House'),
            Building(
              l: (value) {
                setState(() {
                  size_l = int.parse(value);
                });
              },
              w: (value) {
                setState(() {
                  size_w = int.parse(value);
                });
              },
              total: (value) {
                setState(() {
                  size_house = double.parse(value.toString());
                });
              },
            ),
            _size_10,
            Padding(
              padding: EdgeInsets.only(right: 30, left: 30, top: 10),
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        floor = int.parse(value);
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      prefixIcon: Icon(
                        Icons.bed_outlined,
                        color: kImageColor,
                      ),
                      hintText: 'floor',
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        Parking = int.parse(value);
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      prefixIcon: Icon(
                        Icons.feed_outlined,
                        color: kImageColor,
                      ),
                      hintText: 'parking',
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(right: 30, left: 30, top: 10),
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        total_area = double.parse(value);
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      prefixIcon: Icon(
                        Icons.bed_outlined,
                        color: kImageColor,
                      ),
                      hintText: 'Total Area',
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        price_sqm = double.parse(value);
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      prefixIcon: Icon(
                        Icons.feed_outlined,
                        color: kImageColor,
                      ),
                      hintText: 'Price(sqm)*',
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(right: 30, left: 30, top: 10),
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        Livingroom = int.parse(value);
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      prefixIcon: Icon(
                        Icons.bed_outlined,
                        color: kImageColor,
                      ),
                      hintText: 'LivingRoom',
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        aircon = int.parse(value);
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      prefixIcon: Icon(
                        Icons.feed_outlined,
                        color: kImageColor,
                      ),
                      hintText: 'Aricon',
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          Private_Area = double.parse(value);
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        prefixIcon: Icon(
                          Icons.bed_outlined,
                          color: kImageColor,
                        ),
                        hintText: 'Private Area',
                        fillColor: kwhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kPrimaryColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _size_10,
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            type = newValue!;
                          });
                          if (type == 'For Sale') {
                            index_Sale = _items_2.indexOf('For Sale');
                          } else if (type == 'For Rent') {
                            index_Rent = _items_2.indexOf('For Rent');
                            // print('$type');
                            // print('$index_Rent');
                          }
                        },
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please select bank';
                          }
                          return null;
                        },
                        items: _items_2
                            .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: MediaQuery.textScaleFactorOf(
                                              context) *
                                          13,
                                      height: 1),
                                ),
                              ),
                            )
                            .toList(),
                        // add extra sugar..
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: kImageColor,
                        ),

                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          prefixIcon: Icon(
                            Icons.bed_outlined,
                            color: kImageColor,
                          ),
                          hintText: 'Type*',
                          fillColor: kwhite,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            land = double.parse(value);
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          prefixIcon: Icon(
                            Icons.landscape_outlined,
                            color: kImageColor,
                          ),
                          hintText: 'land',
                          fillColor: kwhite,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.only(right: 30, left: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    Title = value;
                  });
                },
                maxLines: 3,
                decoration: InputDecoration.collapsed(
                  hintText: 'Title',
                ),
              ),
            ),
            Container(
              height: 150,
              width: double.infinity,
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    requestAutoVerbal_property.description = value;
                  });
                },
                maxLines: 3,
                decoration: InputDecoration.collapsed(
                  hintText: 'Description',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Random random = new Random();
  Future<void> uploadImage(url, image_name) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/$url'));
    request.fields['id_image'] = controller_verbal.id_last.toString();
    request.fields['hometype'] = hometype.toString();
    request.fields['property_type_id'] = property_type_id.toString();
    if (get_bytes != null) {
      request.files.add(await http.MultipartFile.fromBytes(
          '$image_name', get_bytes!,
          filename: 'Autoverbal\'s Photo :${random.nextInt(99)}.jpg'));
    } else {
      request.files.add(await http.MultipartFile.fromBytes(
          '$image_name', _byesData!,
          filename: 'Autoverbal\'s Photo :${random.nextInt(99)}.jpg'));
    }

    var res = await request.send();
    if (res.statusCode == 200) {
      AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: false,
          title: 'Save Successfully',
          autoHide: Duration(seconds: 3),
          onDismissCallback: (type) {
            Navigator.pop(context);
          }).show();

      print('Image uploaded!');
    } else {
      print('Error uploading image: ${res.reasonPhrase}');
    }
  }

  Widget _text_noFWf(text) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, bottom: 5),
      child: Text(
        text,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.016,
            color: Color.fromARGB(255, 87, 86, 86)),
      ),
    );
  }

  Uint8List? _selectedFile;
  Uint8List? _byesData;

  String imageUrl = '';
  late File croppedFile;
  OpenImgae() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();

    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files!.elementAt(0);
      final reader = html.FileReader();
      WebUiSettings settings;
      reader.onLoadEnd.listen((event) {
        setState(() {
          _byesData =
              Base64Decoder().convert(reader.result.toString().split(',').last);
          _selectedFile = _byesData;
          croppedFile = File.fromRawPath(_byesData!);
          imageUrl = html.Url.createObjectUrlFromBlob(file.slice());
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  //Mutiple Image
  html.File? _selectedImageFile;
  // void selectImage() {
  //   final html.FileUploadInputElement input = html.FileUploadInputElement();
  //   input.accept = 'image/*';
  //   input.click();

  //   input.onChange.listen((e) {
  //     final files = input.files;
  //     if (files != null && files.isNotEmpty) {
  //       setState(() {
  //         _selectedImageFile = files[0];
  //       });
  //     }
  //   });
  // }
  //  Future<Uint8List> imageFileToUint8List(html.File file) async {
  //   final html.FileReader reader = html.FileReader();
  //   reader.readAsArrayBuffer(file);
  //   await reader.onLoad.first;
  //   final Uint8List uint8List = reader.result as Uint8List;
  //   return uint8List;
  // }
  // List<html.File> _selectedImageFiles = [];
  // Future<void> _uploadImageRentMultiple() async {
  //   html.File imageFile = _selectedImageFiles[0];
  //   html.File imageFile1 = _selectedImageFiles[1];
  //   Uint8List imageUint8List = await imageFileToUint8List(imageFile);
  //   Uint8List imageUint8List1 = await imageFileToUint8List(imageFile1);

  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(
  //         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/mutiple_imageR_post'),
  //   );
  //   request.fields['id_ptys'] = controller_verbal.id_last.toString();
  //   request.fields['property_type_id'] = property_id.toString();

  //   if (_selectedImageFiles != null) {
  //     request.files.add(
  //       http.MultipartFile.fromBytes(
  //         'image',
  //         imageUint8List,
  //         filename: 'Autoverbal\'s Photo :${random.nextInt(99)}.jpg',
  //       ),
  //     );
  //     request.files.add(
  //       http.MultipartFile.fromBytes(
  //         'images',
  //         imageUint8List1,
  //         filename: 'Autoverbal\'s Photo :${random.nextInt(99)}.jpg',
  //       ),
  //     );
  //   }

  //   var res = await request.send();
  //   if (res.statusCode == 200) {
  //     print('Image uploaded mutiple!');
  //   } else {
  //     print('Error uploading image: ${res.reasonPhrase}');
  //   }
  // }
  Widget dropdown(value, List list, text1, text2, lable) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        onChanged: (newValue) {
          setState(() {
            if (lable == 'Hometype') {
              hometype = newValue!;
            } else {
              property_type_id = newValue!;
            }
          });
        },
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return 'Please select bank';
          }
          return null;
        },
        items: list
            .map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
                value: value["$text1"].toString(),
                child: Text(
                  value['$text2'],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: MediaQuery.textScaleFactorOf(context) * 11,
                  ),
                ),
              ),
            )
            .toList(),
        // add extra sugar..
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
        //property_type_id
        decoration: InputDecoration(
            fillColor: kwhite,
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            labelText: '$lable',
            labelStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.015,
                color: Colors.grey),
            hintText: '$lable',
            helperStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.015,
                color: Colors.grey),
            prefixIcon: Icon(
              (lable == 'Hometype')
                  ? Icons.home_work_outlined
                  : Icons.edit_location_alt_sharp,
              color: Colors.grey,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 133, 132, 132), width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget Image_select(text) {
    return Container(
      decoration: BoxDecoration(
          // color: Color.fromARGB(255, 158, 20, 20),
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      height: MediaQuery.of(context).size.height * 0.222,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          placeholderFit: BoxFit.contain,
          placeholder: 'assets/earth.gif',
          image: text,
        ),
      ),
    );
  }

  List<File> _images = [];
  Future<void> pickImages() async {
    List<Asset> resultList = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 2,
        enableCamera: true,
      );
    } on Exception catch (e) {
      // Handle exception
    }
    // setState(() {
    //   _images;
    // });

    List<File> files = [];
    for (var asset in resultList) {
      ByteData byteData = await asset.getByteData();
      final tempDir = await getTemporaryDirectory();

      final file = File('${tempDir.path}/${asset.name}');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      files.add(file);
    }

    setState(() {
      _images = files;
    });
  }

  // Future<void> _uploadImageRentMultiple() async {
  //   final url = Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/mutiple_imageR_post');

  //   final request = http.MultipartRequest('POST', url);
  //   request.fields['id_ptys'] = controller_verbal.id_last.toString();
  //   request.fields['property_type_id'] = property_type_id.toString();

  //   if (_images != null) {
  //     final tempDir = await getTemporaryDirectory();
  //     final path = tempDir.path;

  //     List<File> compressedImages = [];

  //     for (int i = 0; i < _images.length; i++) {
  //       var compressedImageFile = await FlutterImageCompress.compressAndGetFile(
  //         _images[i].absolute.path,
  //         '$path/${DateTime.now().millisecondsSinceEpoch}_$i.jpg',
  //         quality: 70,
  //       );

  //       if (compressedImageFile != null) {
  //         compressedImages.add(compressedImageFile);
  //       }
  //     }

  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'image',
  //         compressedImages[0].path,
  //       ),
  //     );
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'images',
  //         compressedImages[1].path,
  //       ),
  //     );
  //   }

  //   final response = await request.send();

  //   if (response.statusCode == 200) {
  //     print('Images uploaded successfully!');
  //     AwesomeDialog(
  //         context: context,
  //         animType: AnimType.leftSlide,
  //         headerAnimationLoop: false,
  //         dialogType: DialogType.success,
  //         showCloseIcon: false,
  //         title: 'Succesfully',
  //         autoHide: Duration(seconds: 3),
  //         onDismissCallback: (type) {
  //           setState(() {
  //             get_re;
  //           });
  //           Navigator.pop(context);
  //         }).show();
  //   } else {
  //     print('Error uploading images: ${response.reasonPhrase}');
  //   }
  // }

  Future<File?> _uploadImage(_url, type_image) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/$_url'));
    request.fields['id_image'] = controller_verbal.id_last.toString();
    request.fields['hometype'] = hometype.toString();
    request.fields['property_type_id'] = property_type_id.toString();
    if (get_bytes != null) {
      request.files.add(await http.MultipartFile.fromBytes(
          '$type_image', get_bytes!,
          filename: 'Autoverbal\'s Photo :${random.nextInt(99)}.jpg'));
    } else {
      request.files.add(await http.MultipartFile.fromBytes(
          '$type_image', _byesData!,
          filename: 'Autoverbal\'s Photo :${random.nextInt(99)}.jpg'));
    }

    var res = await request.send();
    if (res.statusCode == 200) {
      AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: false,
          title: 'Save Successfully',
          autoHide: Duration(seconds: 3),
          onDismissCallback: (type) {
            Navigator.pop(context);
          }).show();
      print('Image uploaded!');
    } else {
      print('Error uploading image: ${res.reasonPhrase}');
    }
  }
}
