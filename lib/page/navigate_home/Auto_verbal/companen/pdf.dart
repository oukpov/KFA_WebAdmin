import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFButton extends StatefulWidget {
  const PDFButton(
      {super.key,
      required this.list,
      required this.i,
      required this.verbalId,
      required this.iconpdfcolor,
      required this.imagelogo});
  final List list;
  final int i;
  final String verbalId;
  final String imagelogo;
  final Color iconpdfcolor;
  @override
  State<PDFButton> createState() => _PDFButtonState();
}

class _PDFButtonState extends State<PDFButton> {
  bool waitvalue = false;

  bool checkimage = false;
  @override
  Widget build(BuildContext context) {
    return click
        ? const Center(child: CircularProgressIndicator())
        : GFButton(
            onPressed: () async {
              setState(() {
                click = true;
              });
              // print(widget.list[widget.i]["protectID"].toString());
              await getImage();

              await getimageMap(widget.list[widget.i]['latlong_la'],
                  widget.list[widget.i]['latlong_log']);
              checkimage = true;

              await landBuilding(widget.list[widget.i]['protectID'].toString());
              if (checkimage == true) {
                await mainwaiting(
                    widget.list[widget.i]['verbal_id'].toString());
              }
            },
            text: "PDF",
            color: widget.iconpdfcolor,
            icon: const Icon(Icons.picture_as_pdf,
                color: Colors.white,
                shadows: [
                  Shadow(
                      color: Colors.black,
                      blurRadius: 5,
                      offset: Offset(1, 0.5))
                ],
                size: 20),
          );
  }

  double totalMIN = 0;
  double totalMAX = 0;
  List listImage = [];
  String? imageI;
  Future<void> getImage() async {
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
          imageI = listImage[0]['verbalImage'];
        }
      });
    } else {
      // print(response.statusMessage);
    }
  }

  Uint8List? getbytes1;
  Future<void> getimageMap(double lat, double log) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${(log > lat) ? "$lat,$log" : "$log,$lat"}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(log > lat) ? "$lat,$log" : "$log,$lat"}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));
      getbytes1 = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  List land = [];
  double? fsvM, fsvN, fx, fn;
  Future<void> landBuilding(id) async {
    double x = 0, n = 0;
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/listland?verbal_landid=$id'));
    if (rs.statusCode == 200) {
      land = jsonDecode(rs.body);
      for (int i = 0; i < land.length; i++) {
        totalMIN =
            totalMIN + double.parse(land[i]["verbal_land_minvalue"].toString());
        totalMAX =
            totalMAX + double.parse(land[i]["verbal_land_maxvalue"].toString());
        x = x + double.parse(land[i]["verbal_land_maxsqm"].toString());
        n = n + double.parse(land[i]["verbal_land_minsqm"].toString());
      }
      setState(() {
        fsvM = (totalMAX * 70) / 100;
        fsvN = (totalMAX * 70) / 100;
        if (land.isEmpty) {
          totalMIN = 0;
          totalMAX = 0;
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
      });
    }
  }

  Future<void> mainwaiting(id) async {
    await Printing.layoutPdf(
      onLayout: (format) => generatePdf(format, id),
      format: PdfPageFormat.a4,
    );
    setState(() {
      click = false;
    });
  }

  var formatter = NumberFormat("##,###,###,###", "en_US");
  bool click = false;

  Future<Uint8List> generatePdf(PdfPageFormat format, id) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);

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
                                        "https://www.latlong.net/c/?lat=${widget.list[widget.i]['latlong_log']}&long=${widget.list[widget.i]['latlong_la']}",
                                    width: 50,
                                    height: 50,
                                  ),
                                ],
                              ),
                              pw.Text(
                                'location map',
                                style: const pw.TextStyle(
                                  fontSize: 11,
                                ),
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
                              "DATE: ${widget.list[widget.i]['verbal_created_date'].toString()}",
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
                            child: pw.Text(
                                "CODE: ${widget.list[widget.i]['verbal_id'].toString()}",
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
                              " ${widget.list[widget.i]['verbal_address'] ?? ""}.${widget.list[widget.i]['verbal_khan'] ?? ""}",
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
                if (imageI.toString() != "No" && imageI != null)
                  // pw.Text('bytes2 != null')
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
                              base64Decode(imageI.toString()),
                            ),
                            fit: pw.BoxFit.cover),
                      ),
                    ],
                  )
                else
                  // pw.Text('bytes2 == null'),
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
                  if (land.length >= 1)
                    for (int index = land.length - 1; index >= 0; index--)
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
                                '${formatter.format(double.parse(land[index]["verbal_land_area"].toString()))}/sqm',
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
                                'USD ${formatter.format(double.parse(land[index]["verbal_land_minsqm"].toString()))}',
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
                                'USD ${formatter.format(double.parse(land[index]["verbal_land_maxsqm"].toString()))}',
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
                                'USD ${formatter.format(double.parse(land[index]["verbal_land_minvalue"].toString()))}',
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
                                'USD ${formatter.format(double.parse(land[index]["verbal_land_maxvalue"].toString()))}',
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
                          child: pw.Text(
                              'USD ${formatter.format(double.parse(totalMIN.toString()))}',
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
                              'USD ${formatter.format(double.parse(totalMAX.toString()))}',
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
