// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'package:web_admin/page/navigate_home/Approvel/component/save_image_for_Autoverbal.dart';
import '../../../../Profile/components/Drop_down.dart';
import '../../../../components/colors.dart';
import '../../../../getx/notfication/notification.dart';
import '../../../../getx/submit_agent/agent.dart';
import '../../../../models/autoVerbal.dart';
import 'allow_successfuly.dart';

class PDfButton extends StatefulWidget {
  PDfButton(
      {super.key,
      required this.check,
      required this.title,
      required this.list,
      // required this.url,
      required this.i,
      required this.imagelogo,
      required this.type,
      required this.listUser,
      required this.iconpdfcolor,
      required this.position,
      this.verbalID});
  final List list;
  final int i;
  final String imagelogo;
  final OnChangeCallback check;
  final String title;
  // final String url;
  final Color iconpdfcolor;
  final OnChangeCallback type;
  final bool position;
  final List listUser;
  String? verbalID;

  @override
  State<PDfButton> createState() => _PDfButtonState();
}

class _PDfButtonState extends State<PDfButton> {
  Future<void> mainwaiting(id) async {
    await Printing.layoutPdf(
      onLayout: (format) => _generatePdf(format, id),
      format: PdfPageFormat.a4,
    );
    setState(() {
      click = false;
    });
  }

  NotificatonAPI notificatonAPI = NotificatonAPI(ids: "");
  ListAgent listAgent = ListAgent(ids: 0);

  DateTime now = DateTime.now();

  // var formatter = NumberFormat("##,###,###,###", "en_US");
  double totalMIN = 0;
  double totalMAX = 0;
  List<AutoVerbal_List> dataPdf = [];
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
        print("No 1 ==========>");
        for (int i = 0; i < land.length; i++) {
          totalMIN = totalMIN +
              double.parse(land[i]["verbal_land_minvalue"].toStringAsFixed(2));
          totalMAX = totalMAX +
              double.parse(land[i]["verbal_land_maxvalue"].toStringAsFixed(2));
          // address = land[i]["address"];
          String x1 = land[i]["verbal_land_minsqm"].toStringAsFixed(2);
          String n1 = land[i]["verbal_land_maxsqm"].toStringAsFixed(2);
          x = x + double.parse(x1);
          n = n + double.parse(n1);
        }
        setState(() {
          fsvM = (totalMAX *
                  double.parse(
                      (widget.list[widget.i]["verbal_con"] ?? 0).toString())) /
              100;
          fsvN = (totalMIN *
                  double.parse(
                      (widget.list[widget.i]["verbal_con"] ?? 0).toString())) /
              100;

          if (land.isEmpty) {
            totalMIN = 0;
            totalMAX = 0;
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
      } else {
        print("No 2 ==========>");
      }
    }
  }

  String formatNumber(double number) {
    final formatter = NumberFormat('##,###,###,###');
    String formattedNumber =
        formatter.format(double.parse(number.toStringAsFixed(2)));
    return formattedNumber;
  }

  Uint8List? getbytes1;
  bool checkimage = false;
  String? bytes2;
  List listImage = [];

  Future<void> getimage() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/images?protectID=${widget.list[widget.i]['protectID']}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      listImage = jsonDecode(json.encode(response.data));
      setState(() {
        if (listImage[0]['verbalImage'].toString() != "No") {
          bytes2 = listImage[0]['verbalImage'].toString();
        } else {
          bytes2 = "No";
        }
      });
    }
  }

  Future<void> getimageMap(double lat, double log) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${(log > lat) ? "$lat,$log" : "$log,$lat"}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(log > lat) ? "$lat,$log" : "$log,$lat"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));
      getbytes1 = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return click
        ? const Center(child: CircularProgressIndicator())
        : InkWell(
            onTap: () async {
              setState(() {
                click = true;

                // print((widget.list[widget.i]['type_value'] == "T")
                //     ? "protectID : ${widget.list[widget.i]['protectID']} || ${widget.list[widget.i]['verbal_id']}"
                //     : "verbal_id : ${widget.list[widget.i]['verbal_id']}|| ${widget.list[widget.i]['verbal_id']}");
              });

              if (widget.list[widget.i]['type_value'] == "T") {
                await getimage();
              }
              await getimageMap(widget.list[widget.i]['latlong_la'],
                  widget.list[widget.i]['latlong_log']);
              await landBuilding();
              await mainwaiting((widget.list[widget.i]['type_value'] == "T")
                  ? widget.list[widget.i]['protectID'].toString()
                  : widget.list[widget.i]['verbal_id'].toString());
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(255, 171, 11, 19),
              ),
              width: 100,
              height: 35,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset('assets/images/icon_pdf.png',
                        height: 25, fit: BoxFit.fitHeight),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const Text(
                    " Get PDF ---",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ));
  }

  bool click = false;
  Future<Uint8List> _generatePdf(PdfPageFormat format, id) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    String formattedDate = DateFormat('yyyy-MM-dd ').format(now);
    // final pageTheme = await _myPageTheme(format);
    pdf.addPage(pw.MultiPage(build: (context) {
      return [
        pw.Column(
          children: [
            pw.Column(
              children: [
                pw.Container(
                  height: 70,
                  margin: const pw.EdgeInsets.only(bottom: 5),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Estimate Property",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          )),
                      pw.Row(
                        children: [
                          // pw.Column(
                          //   mainAxisAlignment: pw.MainAxisAlignment.center,
                          //   children: [
                          //     pw.Stack(
                          //       alignment: pw.Alignment.center,
                          //       children: [
                          //         pw.BarcodeWidget(
                          //           barcode: pw.Barcode.qrCode(
                          //             errorCorrectLevel:
                          //                 pw.BarcodeQRCorrectionLevel.high,
                          //           ),
                          //           data:
                          //               "https://oneclickonedollar.com/#/KFA_Security_PDF/$id",
                          //           width: 50,
                          //           height: 50,
                          //         ),
                          //         if (bytesLogo != null)
                          //           pw.Container(
                          //             color: PdfColors.white,
                          //             width: 10,
                          //             height: 10,
                          //             child: pw.Image(
                          //                 pw.MemoryImage(
                          //                   bytesLogo,
                          //                   // bytes1,
                          //                 ),
                          //                 fit: pw.BoxFit.fill),
                          //           ),
                          //       ],
                          //     ),
                          //     pw.Text(
                          //       'Verify Pdf',
                          //       style: const pw.TextStyle(fontSize: 10),
                          //     )
                          //   ],
                          // ),
                          pw.SizedBox(width: 30),
                          pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Stack(
                                alignment: pw.Alignment.center,
                                children: [
                                  pw.BarcodeWidget(
                                    barcode: pw.Barcode.qrCode(
                                      errorCorrectLevel:
                                          pw.BarcodeQRCorrectionLevel.high,
                                    ),
                                    data:
                                        "https://www.latlong.net/c/?lat=${(widget.list[widget.i]['latlong_la'] < widget.list[widget.i]['latlong_log']) ? widget.list[widget.i]['latlong_la'] : widget.list[widget.i]['latlong_log']}&long=${(widget.list[widget.i]['latlong_la'] < widget.list[widget.i]['latlong_log']) ? widget.list[widget.i]['latlong_log'] : widget.list[widget.i]['latlong_la']}",
                                    width: 50,
                                    height: 50,
                                  ),
                                ],
                              ),
                              pw.Text(
                                'location map',
                                style: const pw.TextStyle(fontSize: 11),
                              )
                            ],
                          )
                          // pw.Column(
                          //   mainAxisAlignment: pw.MainAxisAlignment.center,
                          //   children: [
                          //     pw.Stack(
                          //       alignment: pw.Alignment.center,
                          //       children: [
                          //         pw.BarcodeWidget(
                          //           barcode: pw.Barcode.qrCode(
                          //             errorCorrectLevel:
                          //                 pw.BarcodeQRCorrectionLevel.high,
                          //           ),
                          //           data:
                          //               "https://www.latlong.net/c/?lat=${widget.list[widget.i]['latlong_log']}&long=${widget.list[widget.i]['latlong_la']}",
                          //           width: 50,
                          //           height: 50,
                          //         ),
                          //         if (bytesLogo != null)
                          //           pw.Container(
                          //             color: PdfColors.white,
                          //             width: 10,
                          //             height: 10,
                          //             child: pw.Image(
                          //                 pw.MemoryImage(
                          //                   bytesLogo,
                          //                   // bytes1,
                          //                 ),
                          //                 fit: pw.BoxFit.fill),
                          //           ),
                          //       ],
                          //     ),
                          //     pw.Text(
                          //       'Location Map',
                          //       style: const pw.TextStyle(fontSize: 10),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  child: pw.Column(children: [
                    pw.Column(children: [
                      pw.Container(
                          child: pw.Row(children: [
                        pw.Expanded(
                          flex: 4,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(),
                                color: PdfColor.fromInt(
                                    const Color.fromRGBO(22, 72, 130, 1)
                                        .value)),
                            //color: Colors.red,
                            child: pw.Text(
                              "DATE: ${widget.list[widget.i]['verbal_created_date'] ?? formattedDate}",
                              style: const pw.TextStyle(
                                  fontSize: 11,
                                  //fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white),
                            ),
                            height: 20,
                            //color: Colors.white,
                          ),
                        ),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(),
                                color: PdfColor.fromInt(
                                    const Color.fromRGBO(22, 72, 130, 1)
                                        .value)),
                            child: pw.Text("CODE: $id",
                                style: const pw.TextStyle(
                                    fontSize: 11,
                                    //fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.white)),
                            height: 20,
                            //color: Colors.yellow,
                          ),
                        ),
                      ]))
                    ])
                  ]),
                ),
                pw.SizedBox(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text(
                              "Latitude: ${widget.list[widget.i]['latlong_la'].toString()}",
                              style: const pw.TextStyle(
                                fontSize: 11,
                              )),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text(
                              "Longtitude: ${widget.list[widget.i]['latlong_log'].toString()}",
                              style: const pw.TextStyle(
                                fontSize: 11,
                              )),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                //Error
                pw.SizedBox(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 12,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(width: 0.4)),
                          child: pw.Text(
                              " ${widget.list[widget.i]['verbal_address'] ?? ""}",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 11,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 5),
                if (bytes2.toString() != "No" &&
                    widget.list[widget.i]['type_value'] == "T")
                  pw.Row(
                    children: [
                      pw.Container(
                        height: 150,
                        width: 240,
                        child: pw.Image(
                            pw.MemoryImage(
                              getbytes1!,
                            ),
                            fit: pw.BoxFit.cover),
                      ),
                      pw.SizedBox(width: 2),
                      pw.Container(
                        width: 240,
                        height: 150,
                        child: pw.Image(
                            pw.MemoryImage(
                              base64Decode(bytes2.toString()),
                            ),
                            fit: pw.BoxFit.cover),
                      ),
                    ],
                  )
                else
                  // pw.Text("No 2 : $bytes2"),
                  pw.Row(children: [
                    pw.Container(
                      height: 150,
                      width: 480,
                      child: pw.Image(
                          pw.MemoryImage(
                            getbytes1!,
                          ),
                          fit: pw.BoxFit.cover),
                    ),
                  ]),
                pw.SizedBox(height: 5),
                pw.Container(
                    child: pw.Column(children: [
                  pw.Container(
                      child: pw.Row(children: [
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                              color: PdfColor.fromInt(
                                  const Color.fromRGBO(22, 72, 130, 1).value)),
                          child: pw.Text("DESCRIPTION ",
                              style: const pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 11,
                                //fontWeight: pw.FontWeight.bold,
                              )),
                          height: 20,
                        )),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                            color: PdfColor.fromInt(
                                const Color.fromRGBO(22, 72, 130, 1).value)),
                        child: pw.Text("AREA/sqm ",
                            style: const pw.TextStyle(
                                fontSize: 11,
                                // fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white)),
                        height: 20,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                            color: PdfColor.fromInt(
                                const Color.fromRGBO(22, 72, 130, 1).value)),
                        child: pw.Text("MIN/sqm ",
                            style: const pw.TextStyle(
                                fontSize: 11,
                                //fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white)),
                        height: 20,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                            color: PdfColor.fromInt(
                                const Color.fromRGBO(22, 72, 130, 1).value)),
                        child: pw.Text("MAX/sqm ",
                            style: const pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 11,
                              //fontWeight: pw.FontWeight.bold,
                            )),
                        height: 20,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                            color: PdfColor.fromInt(
                                const Color.fromRGBO(22, 72, 130, 1).value)),
                        child: pw.Text("MIN-VALUE ",
                            style: const pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 11,
                              //fontWeight: pw.FontWeight.bold,
                            )),
                        height: 20,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                            color: PdfColor.fromInt(
                                const Color.fromRGBO(22, 72, 130, 1).value)),
                        child: pw.Text("MAX-VALUE ",
                            style: const pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 11,
                              // fontWeight: pw.FontWeight.bold,
                            )),
                        height: 20,
                        //color: Colors.blue,
                      ),
                    ),
                  ])),
                  if (land.isNotEmpty)
                    for (int index = 0; index < land.length; index++)
                      pw.Row(children: [
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child:
                                pw.Text(land[index]["verbal_land_des"] ?? "N/A",

                                    // "NNNNNN",
                                    style: const pw.TextStyle(fontSize: 9)),
                            height: 20,
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                '${double.parse(land[index]["verbal_land_area"].toString())}/sqm',
                                style: const pw.TextStyle(fontSize: 9)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                // 'USD ${formatter.format(double.parse(land[index]["verbal_land_minsqm"].toString()))}',
                                '${formatNumber(double.parse("${land[index]["verbal_land_minsqm"] ?? 0}"))} USD',
                                style: const pw.TextStyle(fontSize: 9)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                // 'USD ${formatter.format(double.parse(land[index]["verbal_land_maxsqm"].toString()))}',
                                '${formatNumber(double.parse("${land[index]["verbal_land_maxsqm"] ?? 0}"))} USD',
                                style: const pw.TextStyle(fontSize: 9)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                // 'USD ${formatter.format(double.parse(land[index]["verbal_land_minvalue"].toString()))}',
                                '${formatNumber(double.parse("${land[index]["verbal_land_minvalue"] ?? 0}"))} USD',
                                style: const pw.TextStyle(fontSize: 9)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                                '${formatNumber(double.parse("${land[index]["verbal_land_maxvalue"] ?? 0}"))} USD',
                                // 'USD ${formatter.format(double.parse(land[index]["verbal_land_maxvalue"].toString()))}',
                                style: const pw.TextStyle(fontSize: 9)),
                            height: 20,
                            //color: Colors.blue,
                          ),
                        ),
                      ]),
                  pw.Container(
                    child: pw.Row(children: [
                      pw.Expanded(
                        flex: 8,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerRight,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "Property Value(Estimate) ",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ]),

                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text('USD ${formatNumber(totalMIN)}',
                              style: const pw.TextStyle(fontSize: 9)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text(
                              // 'USD ${formatter.format(double.parse(totalMAX.toString()))}',
                              'USD ${formatNumber(totalMAX)}',
                              style: const pw.TextStyle(fontSize: 9)),
                          height: 20,
                          //color: Colors.blue,
                        ),
                      ),
                    ]),
                  ),
                ])),
              ],
            ),
            pw.SizedBox(height: 30),
          ],
        ),
      ];
    }));

    return pdf.save();
  }
}
