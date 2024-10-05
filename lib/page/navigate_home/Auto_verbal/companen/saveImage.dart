import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:math';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader_web/image_downloader_web.dart';

import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../Profile/components/Drop_down.dart';
import '../../../../components/colors.dart';

class SaveImageVerbal extends StatefulWidget {
  final String verbalId;
  final List list;
  final int i;
  final OnChangeCallback type;
  final List listUser;
  final String landbuildigID;
  const SaveImageVerbal({
    super.key,
    required this.verbalId,
    required this.type,
    required this.listUser,
    required this.list,
    required this.i,
    required this.landbuildigID,
  });
  @override
  State<SaveImageVerbal> createState() => _SaveImageVerbalState();
}

final GlobalKey _globalKeyScreenShot = GlobalKey();

// ignore: camel_case_types
class _SaveImageVerbalState extends State<SaveImageVerbal> {
  List list = [];
  ScreenshotController screenshotController = ScreenshotController();

  var image_i, image_iqr, get_image = [], get_imageqr = [];
  List listImage = [];
  Future<void> getImage() async {
    print("widget.verbalId : ${widget.verbalId}");
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/imageBase64/auto/${widget.verbalId}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      listImage = jsonDecode(json.encode(response.data));

      setState(() {
        if (listImage.isNotEmpty) {
          image_i = listImage[0]['verbalImage'];
        }
      });
    } else {
      // print(response.statusMessage);
    }
  }

  //getqrimage
  Future<void> getimageqr() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_imageqr/${widget.verbalId}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        get_imageqr = jsonData;
        image_iqr = get_imageqr[0]['url'];
      });
    }
  }

  var formatter = NumberFormat("##,###,###,###", "en_US");

//postimageqr

  var image_m;
  bool ch = false;
  double? total_MIN = 0;
  double? total_MAX = 0;

  List land = [];
  double? fsvM, fsvN, fx, fn;
  Future<void> landbuilding() async {
    print("widget.landbuildigID : ${widget.landbuildigID}");
    double x = 0, n = 0;
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/listland?verbal_landid=${widget.landbuildigID}'));
    if (rs.statusCode == 200) {
      land = jsonDecode(rs.body);
      for (int i = 0; i < land.length; i++) {
        total_MIN = total_MIN! +
            double.parse(land[i]["verbal_land_minvalue"].toString());
        total_MAX = total_MAX! +
            double.parse(land[i]["verbal_land_maxvalue"].toString());
        x = x + double.parse(land[i]["verbal_land_maxsqm"].toString());
        n = n + double.parse(land[i]["verbal_land_minsqm"].toString());
      }
      setState(() {
        fsvM = (total_MAX! * 70) / 100;
        fsvN = (total_MIN! * 70) / 100;
        if (land.isEmpty) {
          total_MIN = 0;
          total_MAX = 0;
        } else {
          fx = x * (70 / 100);
          fn = n * (70 / 100);
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
        ch = true;
      });
    }
  }

  // var listGet;
  int i = 0;

  Future<Uint8List?> compressImage(
      Uint8List imageBytes, double targetWidth, double targetHeight) async {
    final compressedImageBytes = await FlutterImageCompress.compressWithList(
      imageBytes,
      minHeight: targetHeight.toInt(),
      minWidth: targetWidth.toInt(),
      format: CompressFormat.png,
    );
    return compressedImageBytes;
  }

  var item;

  @override
  void initState() {
    item = widget.list[widget.i];
    waitiFunction();
    super.initState();
  }

  final uint8List = Uint8List;
  bool waitvalue = false;
  Future<void> waitiFunction() async {
    waitvalue = true;
    await Future.wait([
      landbuilding(),
      awaiting(),
      getImage(),
    ]);
    setState(() {
      waitvalue = false;
    });
  }

  Future<void> _shareImage(GlobalKey globalKey, context) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = File('${(await getTemporaryDirectory()).path}/share.png');
      imgFile.writeAsBytesSync(pngBytes);
      final RenderBox box = context.findRenderObject() as RenderBox;
      Share.shareXFiles([XFile('assets/hello.txt')], text: 'Great picture');
    } catch (e) {
      // print(e);
    }
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

  Future<void> awaiting() async {
    image_m =
        'https://maps.googleapis.com/maps/api/staticmap?center=${(item["latlong_log"] > item["latlong_la"]) ? "${item["latlong_la"]},${item["latlong_log"]}" : "${item["latlong_log"]},${item["latlong_la"]}"}&zoom=18&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(item["latlong_log"] > item["latlong_la"]) ? "${item["latlong_la"]},${item["latlong_log"]}" : "${item["latlong_log"]},${item["latlong_la"]}"}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8';
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
                RepaintBoundary(
                  key: _globalKeyScreenShot,
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(30),
                    width: 595.276,
                    height: 841.890,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // image: DecorationImage(
                      //     fit: BoxFit.cover, image: AssetImage('')),
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
                                                'https://www.latlong.net/c/?lat=${item['latlong_la']}&long=${item['latlong_log']}',
                                            width: 50,
                                            height: 50,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            width: 10,
                                            height: 10,
                                            child: Image.asset(
                                              'assets/images/New_KFA_Logo.png',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
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
                                child: Text("CODE: ${widget.verbalId}",
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
                          height: 180,
                          width: 595.276,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  placeholderFit: BoxFit.fill,
                                  placeholder: 'assets/earth.gif',
                                  image: image_m.toString(),
                                  height: 180,
                                ),
                              ),
                              if (image_i != "No" && image_i != null)
                                const SizedBox(width: 5),
                              if (image_i != "No" && image_i != null)
                                Expanded(
                                  flex: 1,
                                  child: Image.memory(
                                    base64Decode(
                                      image_i,
                                    ),
                                    height: 180,
                                    fit: BoxFit.cover,
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
                          for (int index = land.length - 1; index >= 0; index--)
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
                                        '${formatter.format(double.parse(land[index]["verbal_land_area"].toString()))}/sqm',
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
                                        'USD ${formatter.format(double.parse(land[index]["verbal_land_minsqm"].toString()))}',
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
                                        'USD ${formatter.format(double.parse(land[index]["verbal_land_maxsqm"].toString()))}',
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
                                        'USD ${formatter.format(double.parse(land[index]["verbal_land_minvalue"].toString()))}',
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
                                        'USD ${formatter.format(double.parse(land[index]["verbal_land_minvalue"].toString()))}',
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
                                    'USD ${formatter.format(double.parse(total_MIN.toString()))}',
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
                                    'USD ${formatter.format(double.parse(total_MAX.toString()))}',
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
                ),
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
                              Get.back();
                            },
                            child: const Icon(Icons.exit_to_app),
                          ),
                          FloatingActionButton.small(
                            backgroundColor: kwhite_new,
                            onPressed: () async {
                              await _downloadImage(
                                  _globalKeyScreenShot, context);
                            },
                            child: const Icon(Icons.download_rounded),
                          )
                        ],
                      ),
                    ))
              ],
            ),
    );
  }
}
