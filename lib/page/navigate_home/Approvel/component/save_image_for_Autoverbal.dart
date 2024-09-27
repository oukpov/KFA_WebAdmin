import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:math';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../Profile/components/Drop_down.dart';
import '../../../../components/colors.dart';

// ignore: camel_case_types
class save_image_after_add_verbal extends StatefulWidget {
  final String verbalId;
  final List list;
  final int i;
  final OnChangeCallback type;
  // final List listUser;
  final bool check;
  save_image_after_add_verbal(
      {super.key,
      required this.verbalId,
      required this.type,
      // required this.listUser,
      required this.list,
      required this.i,
      required this.check});
  @override
  State<save_image_after_add_verbal> createState() =>
      _save_image_after_add_verbalState();
}

final GlobalKey _globalKeyScreenShot = GlobalKey();

class _save_image_after_add_verbalState
    extends State<save_image_after_add_verbal> {
  List list = [];
  ScreenshotController screenshotController = ScreenshotController();

  var formatter = NumberFormat("##,###,###,###", "en_US");
  String formatNumber(double number) {
    final formatter = NumberFormat('##,###,###,###');
    String formattedNumber =
        formatter.format(double.parse(number.toStringAsFixed(2)));
    return formattedNumber;
  }

  Uint8List? get_bytes;
//postimageqr

  Random random = new Random();
  Uint8List? _byesData;
  var image_m;
  bool ch = false;
  double? totalMIN = 0;
  double? total_MAX = 0;

  List land = [];
  double? fsvM, fsvN, fx, fn;
  Future<void> landBuilding() async {
    double x = 0, n = 0;
    var rs = await http.get(Uri.parse(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_land?verbal_landid=${(widget.list[widget.i]['type_value'] == "T") ? widget.list[widget.i]['protectID'] : widget.list[widget.i]['verbal_id']}',
    ));
    if (rs.statusCode == 200) {
      land = jsonDecode(rs.body);
      land.sort((a, b) {
        if (a['verbal_land_des'] == 'LS' && b['verbal_land_des'] != 'LS') {
          return -1; // Move 'LS' to the top
        } else if (a['verbal_land_des'] != 'LS' &&
            b['verbal_land_des'] == 'LS') {
          return 1; // Keep non-'LS' items below
        } else {
          return 0; // Maintain original order if types are the same
        }
      });
      if (land.isNotEmpty) {
        for (int i = 0; i < land.length; i++) {
          totalMIN = totalMIN! +
              double.parse(land[i]["verbal_land_minvalue"].toStringAsFixed(2));
          total_MAX = total_MAX! +
              double.parse(land[i]["verbal_land_maxvalue"].toStringAsFixed(2));
          // address = land[i]["address"];
          String x1 = land[i]["verbal_land_minsqm"].toStringAsFixed(2);
          String n1 = land[i]["verbal_land_maxsqm"].toStringAsFixed(2);
          x = x + double.parse(x1);
          n = n + double.parse(n1);
        }
        setState(() {
          fsvM = (total_MAX! *
                  double.parse(
                      (widget.list[widget.i]["verbal_con"] ?? 0).toString())) /
              100;
          fsvN = (totalMIN! *
                  double.parse(
                      (widget.list[widget.i]["verbal_con"] ?? 0).toString())) /
              100;

          if (land.isEmpty) {
            totalMIN = 0;
            total_MAX = 0;
          } else {
            fx = x *
                (double.parse(
                        (widget.list[widget.i]["verbal_con"] ?? 0).toString()) /
                    100);
            fn = n *
                (double.parse(
                        (widget.list[widget.i]["verbal_con"] ?? 0).toString()) /
                    100);
          }
          for (int i = 0; i < land.length - 1; i++) {
            for (int j = i + 1; j < land.length; j++) {
              if (land[i]['verbal_land_type'] == 'LS') {
                var t = land[i];
                land[i] = land[j];
                land[j] = t;
              }
            }
          }
        });
      }
    }
  }

  int i = 0;
  var item;
  @override
  void initState() {
    item = widget.list[widget.i];
    waitiFunction();
    super.initState();
  }

  String bytes2 = "No";
  List listImage = [];
  Future<void> getimage() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/images?protectID=${(item['type_value'] == "T") ? item['protectID'] : item['verbal_id']}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      listImage = jsonDecode(json.encode(response.data));
      setState(() {
        if (listImage.isNotEmpty) {
          bytes2 = listImage[0]['verbalImage'].toString();
        } else {
          bytes2 = "No";
        }
      });
    }
  }

  final uint8List = Uint8List;
  bool waitvalue = false;
  Future<void> waitiFunction() async {
    waitvalue = true;
    await Future.wait([
      landBuilding(),
      getimage(),
    ]);
    setState(() {
      waitvalue = false;
    });
  }

  Future<void> _downloadImage(GlobalKey globalKey, context) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      WebImageDownloader.downloadImageFromUInt8List(
        uInt8List: pngBytes,
        imageType: ImageType.png,
        name: 'Check Verbal Image',
      );
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: waitvalue
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Center(
                    child: RepaintBoundary(
                  key: _globalKeyScreenShot,
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(30),
                    width: 595.276,
                    height: 841.890,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image: AssetImage(''),
                      // ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          height: 70,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 75,
                                height: 50,
                              ),
                              const Text("Estimate Property",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  )),
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          BarcodeWidget(
                                            barcode: Barcode.qrCode(
                                              errorCorrectLevel:
                                                  BarcodeQRCorrectionLevel.high,
                                            ),
                                            data:
                                                'https://www.latlong.net/c/?lat=${(item['latlong_la'] < item['latlong_log']) ? item['latlong_la'] : item['latlong_log']}&long=${(item['latlong_la'] < item['latlong_log']) ? item['latlong_log'] : item['latlong_la']}',
                                            width: 50,
                                            height: 50,
                                          ),
                                          // Container(
                                          //   color: Colors.white,
                                          //   width: 10,
                                          //   height: 10,
                                          //   child: Image.asset(
                                          //     'assets/images/New_KFA_Logo.png',
                                          //     fit: BoxFit.fill,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      const Text(
                                        'location map',
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Column(children: [
                          Row(children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.4),
                                    color:
                                        const Color.fromRGBO(22, 72, 130, 1)),
                                height: 20,
                                //color: Colors.red,
                                child: Text(
                                    "DATE: ${item['verbal_date'] ?? "N/A"}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                //color: Colors.white,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.4),
                                    color:
                                        const Color.fromRGBO(22, 72, 130, 1)),
                                height: 20,
                                child: Text(
                                    "CODE: ${(item['type_value'] == "T") ? item['protectID'].toString() : item['verbal_id'].toString()}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                //color: Colors.yellow,
                              ),
                            ),
                          ])
                        ]),
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.4)),
                                  child: Text("Latitude: ${item['latlong_la']}",
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.4)),
                                  child: Text(
                                      "Longtitude: ${item['latlong_log']}",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 12,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.4)),
                                  child: Text(
                                      " ${item['verbal_address'] ?? ""}.${item['verbal_khan'] ?? ""}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),

                        SizedBox(
                          height: 240,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: 240,
                                  height: 150,
                                  child: Image.network(
                                    "https://maps.googleapis.com/maps/api/staticmap?center=${(item["latlong_log"] > item["latlong_la"]) ? "${item["latlong_la"]},${item["latlong_log"]}" : "${item["latlong_log"]},${item["latlong_la"]}"}&zoom=18&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(item["latlong_log"] > item["latlong_la"]) ? "${item["latlong_la"]},${item["latlong_log"]}" : "${item["latlong_log"]},${item["latlong_la"]}"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (bytes2 != "No") const SizedBox(width: 5),
                              if (bytes2 != "No")
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: 240,
                                    height: 150,
                                    child: Image.memory(
                                      base64Decode(bytes2),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 5),
                        Row(children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.4),
                                    color:
                                        const Color.fromRGBO(22, 72, 130, 1)),
                                height: 20,
                                child: const Text("DESCRIPTION ",
                                    style: TextStyle(
                                        fontSize: 11,
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              )),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.4),
                                  color: const Color.fromRGBO(22, 72, 130, 1)),
                              height: 20,
                              child: const Text("AREA/sqm ",
                                  style: TextStyle(
                                      fontSize: 11,
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.4),
                                  color: const Color.fromRGBO(22, 72, 130, 1)),
                              height: 20,
                              child: const Text("MIN/sqm ",
                                  style: TextStyle(
                                      fontSize: 11,
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.4),
                                  color: const Color.fromRGBO(22, 72, 130, 1)),
                              height: 20,
                              child: const Text("MAX/sqm ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    //fontWeight: FontWeight.bold,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.4),
                                  color: const Color.fromRGBO(22, 72, 130, 1)),
                              height: 20,
                              child: const Text("MIN-VALUE ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    //fontWeight: FontWeight.bold,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.center, height: 20,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.4),
                                  color: const Color.fromRGBO(22, 72, 130, 1)),
                              child: const Text("MAX-VALUE ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    //fontWeight: FontWeight.bold,
                                  )),

                              //color: Colors.blue,
                            ),
                          ),
                        ]),

                        // //Don't see value
                        if (land.isNotEmpty)
                          for (int index = 0; index < land.length; index++)
                            SizedBox(
                              height: 20,
                              child: Row(children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.4)),
                                    height: 20,
                                    child: Text(
                                        land[index]["verbal_land_des"] ?? "N/A",
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    //color: Colors.blue,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.4)),
                                    height: 20,
                                    child: Text(
                                        '${double.parse(land[index]["verbal_land_area"].toString())}/sqm',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9,
                                        )),
                                    //color: Colors.blue,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.4)),
                                    height: 20,
                                    child: Text(
                                        'USD ${formatNumber(double.parse("${land[index]["verbal_land_minsqm"] ?? 0}"))}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9,
                                        )),
                                    //color: Colors.blue,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.4)),
                                    height: 20,
                                    child: Text(
                                        'USD ${formatNumber(double.parse("${land[index]["verbal_land_maxsqm"] ?? 0}"))}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9)),
                                    //color: Colors.blue,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.4)),
                                    height: 20,
                                    child: Text(
                                        'USD ${formatNumber(double.parse("${land[index]["verbal_land_minvalue"] ?? 0}"))}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9,
                                        )),
                                    //color: Colors.blue,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.4)),
                                    height: 20,
                                    child: Text(
                                        'USD ${formatNumber(double.parse("${land[index]["verbal_land_maxvalue"] ?? 0}"))}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9,
                                        )),
                                    //color: Colors.blue,
                                  ),
                                ),
                              ]),
                            ),
                        SizedBox(
                          child: Row(children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.4)),
                                height: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text("Property Value(Estimate) ",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.4)),
                                height: 20,
                                child: Text(
                                    // 'USD ${formatter.format(double.parse(totalMIN.toString()))}',
                                    'USD ${formatNumber(totalMIN!)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                    )),
                                //color: Colors.blue,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.4)),
                                height: 20,
                                child: Text('USD ${formatNumber(total_MAX!)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                    )),
                                //color: Colors.blue,
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                )),
                Positioned(
                    right: 10,
                    bottom: 0,
                    child: SizedBox(
                      height: 100,
                      width: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FloatingActionButton.small(
                            backgroundColor: kwhite_new,
                            onPressed: () async {
                              Navigator.pop(context);
                              if (widget.check == true) {
                                Navigator.pop(context);
                              }
                            },
                            child: const Icon(Icons.exit_to_app),
                          ),
                          FloatingActionButton.small(
                            backgroundColor: kwhite_new,
                            onPressed: () async {
                              await _downloadImage(
                                  _globalKeyScreenShot, context);
                            },
                            child: const Icon(Icons.screenshot),
                          )
                        ],
                      ),
                    ))
              ],
            ),
    );
  }
}
