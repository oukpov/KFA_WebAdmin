import 'dart:convert';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../Profile/components/Drop_down.dart';
import '../../../getx/component/logo.dart';
import '../../../getx/verbal/verbal_agent.dart';
import 'package:http/http.dart' as http;

class PDFVerbal extends StatefulWidget {
  const PDFVerbal(
      {super.key,
      required this.listVerbal,
      required this.listLandbuilding,
      required this.i,
      required this.type,
      required this.listUser,
      required this.check,
      required this.imageLogo,
      required this.verbalCode});
  final String imageLogo;
  final List listVerbal;
  final List listLandbuilding;
  final int i;
  final OnChangeCallback type;
  final List listUser;
  final bool check;
  final String verbalCode;
  @override
  State<PDFVerbal> createState() => _PDFVerbalState();
}

class _PDFVerbalState extends State<PDFVerbal> {
  @override
  void initState() {
    super.initState();
  }

  Uint8List? getbytes;
  Future<void> getimageMap(double lat, double log) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${(log > lat) ? "$lat,$log" : "$log,$lat"}&zoom=17&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${(log > lat) ? "$lat,$log" : "$log,$lat"}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));
      getbytes = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  VerbalAgents verbalAgents = VerbalAgents(iduser: "");
  @override
  Widget build(BuildContext context) {
    return GFButton(
        onPressed: () async {
          if (widget.check == true) {
            await verbalAgents.fetchVerbalAll(widget.verbalCode);
            setState(() {
              listVerbal = verbalAgents.fetchVerbalBYCode;
              listVerbalLand = verbalAgents.fetchVerbalLandBYCode;
            });
          }

          await totalSQM();
          await getimageMap(
              double.parse(listVerbal[widget.i]['latlong_la'].toString()),
              double.parse(listVerbal[widget.i]['latlong_log'].toString()));
          widget.type(true);
          await Printing.layoutPdf(
            onLayout: (format) => _generatePdf(format),
            format: PdfPageFormat.a4,
          );
        },
        text: "Save PDF",
        color: const Color.fromARGB(255, 4, 14, 151),
        icon: Image.asset(
          'assets/images/icon_pdf.png',
          height: 25,
        ));
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final logoImageKFA = Get.put(LogoImageKFA());
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    try {
      // final image = pw.MemoryImage(
      //   (await rootBundle.load('assets/images/p2.png')).buffer.asUint8List(),
      // );

      pdf.addPage(
        pw.Page(
          pageFormat: format,
          build: (context) {
            return pw.Container(
                width: format.width,
                height: format.height,
                decoration: pw.BoxDecoration(
                  image: pw.DecorationImage(
                    fit: pw.BoxFit.fitWidth,
                    image: pw.MemoryImage(
                      base64Decode(logoImageKFA.imagePDFKFA.value),
                    ),
                  ),
                ),
                child: pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 16),
                  child: pw.Column(
                    children: [
                      pw.Row(
                        children: [
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                height: 50,
                                width: 90,
                                // color: PdfColor.fromInt(
                                //     Color.fromARGB(255, 255, 255, 255).value),
                                child: pw.Image(
                                    pw.MemoryImage(
                                      base64Decode(widget.imageLogo.toString()),
                                    ),
                                    fit: pw.BoxFit.fitWidth),
                              ),
                              pw.SizedBox(height: 5),
                              flexText(
                                  "Reference N° : ${listVerbal[widget.i]['referrenceN'] ?? "N/A"}",
                                  11),
                              flexText(
                                  "Date : ${DateFormat('MMMM dd, yyyy').format(DateTime.parse("${listVerbal[widget.i]['verbal_date']}"))}",
                                  11),
                            ],
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          flexText("CERTIFICATE OF PROPERTY APPRAISAL", 12),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      pw.SizedBox(
                        width: double.infinity,
                        child: pw.Row(
                          children: [
                            flexTitle(
                                "Under Property Rights : ${listVerbal[widget.i]['under_property_right'] ?? "N/A"}",
                                fontsize),
                          ],
                        ),
                      ),
                      pw.SizedBox(
                        width: double.infinity,
                        child: pw.Row(
                          children: [
                            flexTitle(
                                "Address : ${listVerbal[widget.i]['verbal_address'] ?? "N/A"}",
                                fontsize),
                          ],
                        ),
                      ),
                      pw.SizedBox(
                        width: double.infinity,
                        child: pw.Row(
                          children: [
                            flexTitle("Title Deed N°", fontsize),
                            flexTitle(
                                "${listVerbal[widget.i]['title_deedN'] ?? "N/A"}",
                                fontsize),
                            flexTitle("Issued Date", fontsize),
                            flexTitle(
                                (listVerbal[widget.i]['issued_date'] != null)
                                    ? DateFormat('MMMM dd, yyyy').format(
                                        DateTime.parse(
                                            "${listVerbal[widget.i]['issued_date']}"))
                                    : "N/A",
                                fontsize),
                          ],
                        ),
                      ),
                      pw.SizedBox(
                        width: double.infinity,
                        child: pw.Row(
                          children: [
                            flexTitle("Land Size", fontsize),
                            txtFormatNumber('land_size', 0, listVerbal),
                            flexTitle("Building", fontsize),
                            txtFormatNumber('building_size', 0, listVerbal),
                          ],
                        ),
                      ),
                      pw.SizedBox(
                        width: double.infinity,
                        child: pw.Row(
                          children: [
                            flexTitle("Latitude", fontsize),
                            flexTitle(
                                "${listVerbal[widget.i]['latlong_la'] ?? "N/A"}",
                                fontsize),
                            flexTitle("Longitude", fontsize),
                            flexTitle(
                                "${listVerbal[widget.i]['latlong_log'] ?? "N/A"}",
                                fontsize),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        children: [
                          if (listVerbal[widget.i]['verbal_image'].toString() !=
                              "No")
                            pw.Expanded(
                                fit: pw.FlexFit.tight,
                                child: pw.Container(
                                    height: 180,
                                    decoration: pw.BoxDecoration(
                                        image: pw.DecorationImage(
                                      fit: pw.BoxFit.cover,
                                      image: pw.MemoryImage(base64Decode(
                                          listVerbal[widget.i]
                                              ['verbal_image'])),
                                    )))),
                          pw.SizedBox(width: 5),
                          pw.Expanded(
                            fit: pw.FlexFit.tight,
                            child: pw.Container(
                              height: 180,
                              child: pw.Image(
                                  pw.MemoryImage(
                                    getbytes!,
                                  ),
                                  fit: pw.BoxFit.cover),
                            ),
                          )
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          flexText("Property Appraisals Table", 10),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.SizedBox(
                        width: double.infinity,
                        child: pw.Row(
                          children: [
                            flexTitle("Property Type", fontsizes),
                            flexTitle("Title Deed N°", fontsizes),
                            flexTitle("Size In SQMs", fontsizes),
                            flexTitle("USD/sqms", fontsizes),
                            flexTitle("Total(USD)", fontsizes),
                          ],
                        ),
                      ),
                      for (int i = 0; i < listVerbalLand.length; i++)
                        pw.SizedBox(
                          width: double.infinity,
                          child: pw.Column(
                            children: [
                              pw.Row(
                                children: [
                                  flexTitle(
                                      "${listVerbalLand[i]['verbal_land_type'] ?? "N/A"}",
                                      fontsizes),
                                  flexTitle(
                                      "${listVerbal[widget.i]['title_deedN'] ?? "N/A"}",
                                      fontsize),
                                  txtFormatNumber(
                                      'size_sqms', i, listVerbalLand),
                                  txtFormatNumber(
                                      'usd_sqms', i, listVerbalLand),
                                  flexTitle(
                                      //formatNumber
                                      "USD ${formatNumber(double.parse("${double.parse("${listVerbalLand[i]['size_sqms'] ?? 0}") * double.parse("${listVerbalLand[i]['usd_sqms'] ?? 0}")}"))}.00",
                                      fontsize),
                                ],
                              ),
                            ],
                          ),
                        ),
                      pw.SizedBox(
                        width: double.infinity,
                        child: pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 4,
                              child: pw.Container(
                                padding: const pw.EdgeInsets.all(2),
                                alignment: pw.Alignment.center,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(width: 0.7)),
                                height: 20,
                                child: pw.Text("Grand Total",
                                    style: pw.TextStyle(
                                      fontSize: fontsizes,
                                      fontWeight: pw.FontWeight.bold,
                                    )),
                              ),
                            ),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                padding: const pw.EdgeInsets.all(2),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(width: 0.7)),
                                height: 20,
                                child: pw.Text(
                                    "  USD ${formatNumber(totalUSD)}.00",
                                    style: pw.TextStyle(
                                      fontSize: fontsize,
                                      fontWeight: pw.FontWeight.bold,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(
                        width: double.infinity,
                        child: pw.Row(
                          children: [
                            flexTitle(
                                "In words: Nine Million Ninety Three Thousand and Six Hundred US Dollars Only.",
                                fontsizes),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        children: [
                          pw.Spacer(),
                          pw.Column(
                            children: [
                              flexText(
                                  "Phnom Penh Date : ${DateFormat('MMMM dd, yyyy').format(DateTime.parse("${listVerbal[widget.i]['verbal_date']}"))}",
                                  fontsizes),
                              pw.SizedBox(height: 3),
                              flexText("Chaiman/CEO", fontsizes),
                              pw.SizedBox(height: 3),
                              flexText("Cerified Appraiser", fontsizes),
                              pw.SizedBox(height: 3),
                              flexText("N° : V-15-165-01", fontsizes)
                            ],
                          ),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.SizedBox(width: 60),
                          pw.Column(
                            children: [
                              flexText("Property Location", 9),
                              pw.SizedBox(height: 3),
                              pw.BarcodeWidget(
                                barcode: Barcode.qrCode(
                                  errorCorrectLevel:
                                      BarcodeQRCorrectionLevel.high,
                                ),
                                data:
                                    "https://www.google.com/maps?q=${listVerbal[widget.i]['latlong_la']},${listVerbal[widget.i]['latlong_log']}",
                                width: 70,
                                height: 70,
                              ),
                            ],
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                          "*Note : Our Company will not responsible for any fake ducuments, information or fraud. Our Property Valuation is applied to only the land.",
                          style: pw.TextStyle(
                            fontStyle: pw.FontStyle.italic,
                            color: PdfColor.fromInt(
                                const Color.fromARGB(255, 126, 124, 124).value),
                            fontSize: 9,
                          )),
                    ],
                  ),
                ));
          },
        ),
      );

      return pdf.save();
    } catch (e) {
      // print('Error loading image: $e');
      return Uint8List(0);
    }
  }

  var formatter = NumberFormat("##,###,###,###", "en_US");
  String formatNumber(double number) {
    final formatter = NumberFormat('##,###,###,###');
    String formattedNumber =
        formatter.format(double.parse(number.toStringAsFixed(2)));
    return formattedNumber;
  }

  double fontsize = 9;
  double fontsizes = 10;
  pw.Widget txtFormatNumber(String key, int index, List list) {
    return pw.Expanded(
      flex: 1,
      child: pw.Container(
        padding: const pw.EdgeInsets.all(2),
        alignment: pw.Alignment.centerRight,
        decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.7)),
        height: 20,
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Text(
                "  ${(list[index][key].toString() != "null") ? "${formatNumber(double.parse("${list[index][key] ?? "0"}"))} sqm" : "N/A"}",
                style: pw.TextStyle(
                  fontSize: fontsize,
                  fontWeight: pw.FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  List listVerbal = [];
  List listVerbalLand = [];
  double totalUSD = 0;
  Future<void> totalSQM() async {
    if (widget.check != true) {
      setState(() {
        listVerbal = widget.listVerbal;
        listVerbalLand = widget.listLandbuilding;
      });
    } else {
      setState(() {
        listVerbal = verbalAgents.fetchVerbalBYCode;
        listVerbalLand = verbalAgents.fetchVerbalLandBYCode;
      });
    }
    for (int i = 0; i < listVerbalLand.length; i++) {
      totalUSD += (double.parse("${listVerbalLand[i]['usd_sqms'] ?? 0}")) *
          double.parse("${listVerbalLand[i]['size_sqms'] ?? 0}");
    }
  }

  pw.Widget flexTitle(String t1, double fontsize) {
    return pw.Expanded(
      flex: 1,
      child: pw.Container(
        padding: const pw.EdgeInsets.all(2),
        alignment: pw.Alignment.centerRight,
        decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.7)),
        height: 20,
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Text("  $t1",
                style: pw.TextStyle(
                  fontSize: fontsize,
                  fontWeight: pw.FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  pw.Widget flexText(String t1, double fontsize) {
    return pw.Text(
      t1,
      style: pw.TextStyle(
        fontSize: fontsize,
        fontWeight: pw.FontWeight.bold,
      ),
    );
  }
}
