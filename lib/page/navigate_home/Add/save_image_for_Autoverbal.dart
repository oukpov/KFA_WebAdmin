import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:barcode_widget/barcode_widget.dart';

import 'Detail_Autoverbal.dart';

Uint8List? get_bytes1;

// ignore: camel_case_types
class save_image_after_add_verbal extends StatefulWidget {
  final String? verbalId;

  // final String? telNum;
  var list;
  var i;
  final String set_data_verbal;
  save_image_after_add_verbal({
    super.key,
    this.verbalId,
    required this.set_data_verbal,
    this.list,
    this.i,
  });
  @override
  State<save_image_after_add_verbal> createState() =>
      _save_image_after_add_verbalState();
}

save_image_after_add_verbal saveimage = save_image_after_add_verbal(
  set_data_verbal: '',
);
detail_verbal data_pdf = detail_verbal(
  set_data_verbal: '',
);

// ignore: camel_case_types
class _save_image_after_add_verbalState
    extends State<save_image_after_add_verbal> {
  List list = [];
  ScreenshotController screenshotController = ScreenshotController();

  var image_i, image_iqr, get_image = [], get_imageqr = [];
  Future<void> getimage() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_image/${widget.verbalId}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        get_image = jsonData;
        image_i = get_image[0]['url'];
      });
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

//postimageqr
  Future<void> uploadImage() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/postimageqr'));
    //request.fields['cid'] = code.toString();
    if (get_bytes != null) {
      request.files.add(await http.MultipartFile.fromBytes('image', get_bytes!,
          filename: '${random.nextInt(99)}.jpg'));
    } else {
      request.files.add(await http.MultipartFile.fromBytes('image', _byesData!,
          filename: '${random.nextInt(99)}.jpg'));
    }
    var res = await request.send();
  }

  Random random = new Random();
  Uint8List? _byesData;
  var image_m;
  bool ch = false;
  double? total_MIN = 0;
  double? total_MAX = 0;
  Uint8List? get_bytes;
  var formatter = NumberFormat("##,###,###,###", "en_US");
  List land = [];
  double? fsvM, fsvN, fx, fn;
  Future<void> Land_building() async {
    double x = 0, n = 0;
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_land?verbal_landid=${widget.verbalId.toString()}'));
    if (rs.statusCode == 200) {
      land = jsonDecode(rs.body);
      for (int i = 0; i < land.length; i++) {
        total_MIN = total_MIN! +
            double.parse(land[i]["verbal_land_minvalue"].toString());
        total_MAX = total_MAX! +
            double.parse(land[i]["verbal_land_maxvalue"].toString());
        // address = land[i]["address"];
        x = x + double.parse(land[i]["verbal_land_maxsqm"].toString());
        n = n + double.parse(land[i]["verbal_land_minsqm"].toString());
      }
      setState(() {
        double c1 =
            (total_MAX! * double.parse(listValue[i]["verbal_con"].toString())) /
                100;
        fsvM = (total_MAX! - c1);
        double c2 =
            (total_MIN! * double.parse(listValue[i]["verbal_con"].toString())) /
                100;
        fsvN = (total_MIN! - c2);

        if (land.isEmpty) {
          total_MIN = 0;
          total_MAX = 0;
        } else {
          fx = x * (double.parse(listValue[i]["verbal_con"].toString()) / 100);
          fn = n * (double.parse(listValue[i]["verbal_con"].toString()) / 100);
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
  List listValue = [];
  Future<Uint8List?> _compressImage(
      Uint8List imageBytes, double targetWidth, double targetHeight) async {
    final compressedImageBytes = await FlutterImageCompress.compressWithList(
      imageBytes,
      minHeight: targetHeight.toInt(),
      minWidth: targetWidth.toInt(),
      format: CompressFormat.png,
    );
    return compressedImageBytes;
  }

  bool _wait = false;
  @override
  void initState() {
    get();
    uploadImage();
    Land_building();
    getimage();

    super.initState();
  }

  Future<void> await() async {
    _wait = true;
    await Future.wait([
      getUser(),
    ]);
    image_m =
        'https://maps.googleapis.com/maps/api/staticmap?center=${listValue[i]['latlong_log']},${listValue[i]['latlong_la']}&zoom=18&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${listValue[i]['latlong_log']},${listValue[i]['latlong_la']}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
    setState(() {
      _wait = false;
    });
  }

  void get() {
    if (widget.set_data_verbal != '') {
      await();
      i = 0;
    } else {
      i = int.parse(widget.i.toString());
      listValue = widget.list;
      image_m =
          'https://maps.googleapis.com/maps/api/staticmap?center=${listValue[i]['latlong_log']},${listValue[i]['latlong_la']}&zoom=18&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${listValue[i]['latlong_log']},${listValue[i]['latlong_la']}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
    }
  }

  Future<List> getUser() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_id=${widget.verbalId}',
      options: Options(
        method: 'GET',
      ),
    );
    if (response.statusCode == 200) {
      var listValues = jsonDecode(json.encode(response.data));
      setState(() {
        listValue = listValues;
        i = 0;
      });
    } else {
      print(response.statusMessage);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        leading: IconButton(
            onPressed: () {
              if (widget.set_data_verbal != '') {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                print(
                    '=================================> Back2<============================');
              } else {
                Navigator.pop(context);
                print(
                    '=================================> Back1<============================');
              }
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
        title: const Text("Get Photo like this"),
      ),
      body: _wait
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Screenshot(
                controller: screenshotController,
                child: SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(30),
                    width:
                        595.276, // A4 paper width in points (72 points per inch)
                    height:
                        841.890, // A4 paper height in points (72 points per inch)
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage('assets/images/Letter En-Kh.png'))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: 75,
                                  height: 50,
                                  child: Image.asset(
                                      'assets/images/New_KFA_Logo_pdf.png')),
                              const Text("VERBAL CHECK",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  )),
                              Row(
                                children: [
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
                                                "https://www.oneclickonedollar.com/#/${widget.verbalId.toString()}",
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
                                        'image',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  ),
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
                                                'https://www.latlong.net/c/?lat=${listValue[i]['latlong_la']}&long=${listValue[i]['latlong_log']}',
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
                                          fontSize: 10,
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
                                height: 18,
                                //color: Colors.red,
                                child:
                                    Text("DATE: ${listValue[i]['verbal_date']}",
                                        style: const TextStyle(
                                            fontSize: 10,
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
                                height: 18,
                                child: Text("CODE: ${widget.verbalId}",
                                    style: const TextStyle(
                                        fontSize: 10,
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
                                flex: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.4)),
                                  height: 18,
                                  child: Text(
                                      "Requested Date :${listValue[i]["verbal_date"]} ",
                                      style: const TextStyle(
                                        fontSize: 10,
                                      )),
                                  //color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          alignment: Alignment.topLeft,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.4)),
                          height: 17,
                          child: Text(
                              "Referring to your request letter for verbal check by ${listValue[i]["bank_name"]} ${(listValue[i]["bank_branch_name"] != 'null') ? listValue[i]["bank_branch_name"] : ''}, we estimated the value of property as below.",
                              overflow: TextOverflow.clip,
                              style: const TextStyle(fontSize: 10)),
                          //color: Colors.blue,
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.4)),
                                  height: 18,
                                  child: const Text("Property Information: ",
                                      style: TextStyle(
                                        fontSize: 10,
                                      )),
                                  //color: Colors.blue,
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.4)),
                                  height: 18,
                                  child: Text(
                                      "${listValue[i]['property_type_name']}",
                                      style: const TextStyle(
                                        fontSize: 10,
                                      )),
                                  //color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.4)),
                                  child: const Text("Address : ",
                                      style: TextStyle(
                                        fontSize: 10,
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.4)),
                                  child: Text(
                                      " ${listValue[i]['verbal_address'] ?? ""}.${listValue[i]['verbal_khan'] ?? ""}",
                                      style: const TextStyle(
                                        fontSize: 10,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.4)),
                                  child: const Text("Owner Name ",
                                      style: TextStyle(
                                        fontSize: 10,
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.4)),
                                  height: 18,
                                  child: Text(
                                      " ${listValue[i]['verbal_owner'] ?? ""}",
                                      style: const TextStyle(
                                        fontSize: 10,
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
                                  height: 18,
                                  // name rest with api
                                  child: Text(
                                      "Contact No : ${listValue[i]['verbal_contact'] ?? ""}",
                                      style: const TextStyle(
                                        fontSize: 10,
                                      )),
                                  //color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.4)),
                                  height: 30,
                                  child: const Text("Bank Officer ",
                                      style: TextStyle(
                                        fontSize: 10,
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
                                  height: 30,
                                  child: Text(
                                      " ${listValue[i]['bank_name'] ?? ""}",
                                      style: const TextStyle(
                                        fontSize: 10,
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
                                  height: 30,
                                  child: Text(
                                      "Contact No : ${listValue[i]['verbal_bank_officer'] ?? ""}",
                                      style: const TextStyle(
                                        fontSize: 10,
                                      )),
                                  //color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.4)),
                                  child: Text(
                                      "Latitude: ${listValue[i]['latlong_la']}",
                                      style: const TextStyle(
                                        fontSize: 10,
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.4)),
                                  child: Text(
                                      "Longtitude: ${listValue[i]['latlong_log']}",
                                      style: const TextStyle(fontSize: 10)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                            "ESTIMATED VALUE OF THE VERBAL CHECK PROPERTY",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 9,
                            )),
                        const SizedBox(height: 10),

                        if (image_i != null)
                          SizedBox(
                            height: 130,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    placeholderFit: BoxFit.fill,
                                    placeholder: 'assets/earth.gif',
                                    image: image_i.toString(),
                                  ),
                                ),
                                const Expanded(
                                    flex: 1, child: SizedBox(height: 20)),
                                Expanded(
                                  flex: 9,
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    placeholderFit: BoxFit.fill,
                                    placeholder: 'assets/earth.gif',
                                    image: image_m.toString(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (image_i == null)
                          SizedBox(
                            height: 130,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholderFit: BoxFit.fill,
                              placeholder: 'assets/earth.gif',
                              image: image_m.toString(),
                            ),
                          ),
                        const SizedBox(height: 10),
                        Row(children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.4),
                                    color:
                                        const Color.fromRGBO(22, 72, 130, 1)),
                                height: 18,
                                child: const Text("DESCRIPTION ",
                                    style: TextStyle(
                                        fontSize: 10,
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
                              height: 18,
                              child: const Text("AREA/sqm ",
                                  style: TextStyle(
                                      fontSize: 10,
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
                              height: 18,
                              child: const Text("MIN/sqm ",
                                  style: TextStyle(
                                      fontSize: 10,
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
                              height: 18,
                              child: const Text("MAX/sqm ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
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
                              height: 18,
                              child: const Text("MIN-VALUE ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    //fontWeight: FontWeight.bold,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.center, height: 18,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.4),
                                  color: const Color.fromRGBO(22, 72, 130, 1)),
                              child: const Text("MAX-VALUE ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    //fontWeight: FontWeight.bold,
                                  )),

                              //color: Colors.blue,
                            ),
                          ),
                        ]),

                        //Don't see value
                        if (land.isNotEmpty)
                          for (int index = land.length - 1; index >= 0; index--)
                            SizedBox(
                              height: 18,
                              child: Row(children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.4)),
                                    height: 18,
                                    child: Text(
                                        land[index]["verbal_land_type"] ?? "",
                                        style: const TextStyle(
                                          fontSize: 10,
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
                                    height: 18,
                                    child: Text(
                                        '${formatter.format(double.parse(land[index]["verbal_land_area"].toString()))}/sqm',
                                        style: const TextStyle(
                                          fontSize: 10,
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
                                    height: 18,
                                    child: Text(
                                        'USD ${formatter.format(double.parse(land[index]["verbal_land_minsqm"].toString()))}',
                                        style: const TextStyle(
                                          fontSize: 10,
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
                                    height: 18,
                                    child: Text(
                                        'USD ${formatter.format(double.parse(land[index]["verbal_land_maxsqm"].toString()))}',
                                        style: const TextStyle(fontSize: 10)),
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
                                    height: 18,
                                    child: Text(
                                        'USD ${formatter.format(double.parse(land[index]["verbal_land_minvalue"].toString()))}',
                                        style: const TextStyle(
                                          fontSize: 10,
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
                                    height: 18,
                                    child: Text(
                                        'USD ${formatter.format(double.parse(land[index]["verbal_land_maxvalue"].toString()))}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                        )),
                                  ),
                                ),
                              ]),
                            ),
                        Row(children: [
                          Expanded(
                            flex: 9,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerRight,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              child: const Text("Property Value(Estimate) ",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              child: Text(
                                  'USD ${formatter.format(double.parse(total_MIN.toString()))}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              child: Text(
                                  'USD ${formatter.format(double.parse(total_MAX.toString()))}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 9,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.4)),
                              height: 18,
                              // ទាយយក forceSale from  ForceSaleAndValuation
                              child: Text(
                                  "Force Sale Value ${listValue[i]["verbal_con"] ?? ''}% ",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  )),
                              //color: Colors.blue,
                            ),
                          ),
                        ]),
                        Container(
                          child: Row(children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.4)),
                                height: 18,
                                child: Text(
                                    "USD ${formatter.format(fsvN ?? double.parse('0.00'))}",
                                    style: const TextStyle(
                                      fontSize: 10,
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
                                height: 18,
                                child: Text(
                                    'USD ${formatter.format(fsvM ?? double.parse('0.00'))}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                    )),
                                //color: Colors.blue,
                              ),
                            ),
                          ]),
                        ),
                        //  ដកចេញសិន
                        // Container(
                        //   child: Row(children: [
                        //     Expanded(
                        //       flex: 10,
                        //       child: Container(
                        //         padding: const EdgeInsets.all(2),
                        //         alignment: Alignment.centerLeft,
                        //         decoration: BoxDecoration(border: Border.all( width:0.4)),
                        //         child: Text("Force Sale Value: ",
                        //             style: TextStyle(
                        //               fontSize: 10,
                        //               ,
                        //               fontWeight: FontWeight.bold,
                        //             )),
                        //         height: 18,
                        //         //color: Colors.blue,
                        //       ),
                        //     ),
                        //     Expanded(
                        //       flex: 2,
                        //       child: Container(
                        //         padding: const EdgeInsets.all(2),
                        //         alignment: Alignment.centerLeft,
                        //         decoration: BoxDecoration(border: Border.all( width:0.4)),
                        //         child: Text("${fn ?? '0.00'}",
                        //             style: TextStyle(fontSize: 10, )),
                        //         height: 18,
                        //         //color: Colors.blue,
                        //       ),
                        //     ),
                        //     Expanded(
                        //       flex: 2,
                        //       child: Container(
                        //         padding: const EdgeInsets.all(2),
                        //         alignment: Alignment.centerLeft,
                        //         decoration: BoxDecoration(border: Border.all( width:0.4)),
                        //         child: Text("${fx ?? '0.00'}",
                        //             style: TextStyle(fontSize: 10, )),
                        //         height: 18,
                        //         //color: Colors.blue,
                        //       ),
                        //     ),
                        //     Expanded(
                        //       flex: 4,
                        //       child: Container(
                        //         padding: EdgeInsets.all(2),
                        //         alignment: Alignment.centerLeft,
                        //         decoration: BoxDecoration(border: Border.all( width:0.4)),
                        //         height: 18,
                        //         //color: Colors.blue,
                        //       ),
                        //     ),
                        //   ]),
                        // ),
                        Container(
                          child: Row(children: [
                            Expanded(
                              flex: 10,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.4)),
                                height: 18,
                                child: const Text("COMMENT: ",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    )),
                                //color: Colors.blue,
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          alignment: Alignment.centerLeft,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.4)),
                          height: 18,
                          child: const Text("Valuation fee : ",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              )),
                          //color: Colors.blue,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                            '*Note: It is only first price which you took from this verbal check data. The accurate value of property when we have the actual site property inspection.We are not responsible for this case when you provided the wrong land and building size or any fraud.',
                            style: TextStyle(
                              fontSize: 8,
                            )),
                        const SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Column(
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         Text(
                            //             'Verbal Check Replied By:${list[i]["username"]} ',
                            //             style: const TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               fontSize: 10,
                            //             ),
                            //             textAlign: TextAlign.right),
                            //         const SizedBox(height: 4),
                            //         Text(' ${list[i]["tel_num"]}',
                            //             style: const TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               fontSize: 10,
                            //             ),
                            //             textAlign: TextAlign.center),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text('KHMER FOUNDATION APPRAISALS Co.,Ltd',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      )),
                                ]),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Hotline: 099 283 388',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          )),
                                      Row(children: const [
                                        Text(
                                            'H/P : (+855)23 988 855/(+855)23 999 761',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            )),
                                      ]),
                                      Row(children: const [
                                        Text('Email : info@kfa.com.kh',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            )),
                                      ]),
                                      Row(children: const [
                                        Text('Website: www.kfa.com.kh',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            )),
                                      ]),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                          'Villa #36A, Street No4, (Borey Peng Hout The Star',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          )),
                                      Text(
                                          'Natural 371) Sangkat Chak Angrae Leu,',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          )),
                                      Text(
                                          'Khan Mean Chey, Phnom Penh City, Cambodia,',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          )),
                                    ],
                                  ),
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
            ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          uploadImage();
          print('save');
          final double a4WidthInPixels = 8.27 * window.devicePixelRatio * 72;
          final double a4HeightInPixels = 11.69 * window.devicePixelRatio * 72;
          await screenshotController
              .capture(delay: const Duration(milliseconds: 10), pixelRatio: 5.0)
              .then((capturedImage) {
            final blob = Blob([capturedImage], 'image/png');
            final url = Url.createObjectUrlFromBlob(blob);
            final anchor = AnchorElement()
              ..href = url
              ..download = 'screenshot.png';
            anchor.click();
            Url.revokeObjectUrl(url);
            showDialog(
                context: context,
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Image.memory(
                          image_iqr = capturedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      GFButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: "Close",
                        icon: const Icon(Icons.clear_rounded,
                            color: Colors.white),
                        shape: GFButtonShape.pills,
                      ),
                    ],
                  );
                });
            // await _saved(capturedImage, context);
            // ignore: use_build_context_synchronously
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             HomePage1(id: list[0]['id'].toString())));
          }).catchError((onError) {
            print(onError);
          });
        },
        child: const Icon(Icons.screenshot),
      ),
    );
  }
  // void get_all_autoverbal_by_id() async {
  //   var rs = await http.get(Uri.parse(
  //       'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_id=${widget.set_data_verbal.toString()}'));

  //   if (rs.statusCode == 200) {
  //     setState(() {
  //       list = jsonDecode(rs.body);
  //       image_m =
  //           'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_log"]},${list[0]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_log"]},${list[0]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
  //       getimage();
  //       getimage_m1();
  //     });
  //   }
  // }
}
