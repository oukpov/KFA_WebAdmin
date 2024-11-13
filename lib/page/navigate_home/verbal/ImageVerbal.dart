import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:web_admin/components/colors.dart';
import '../../../Profile/components/Drop_down.dart';
import '../../../components/waiting.dart';

class SaveImageVerbalAgent extends StatefulWidget {
  final List listVerbal;
  final List listLandbuilding;
  final int i;
  final OnChangeCallback type;
  final List listUser;
  final bool check;
  const SaveImageVerbalAgent(
      {super.key,
      required this.type,
      required this.listUser,
      required this.listVerbal,
      required this.i,
      required this.check,
      required this.listLandbuilding});
  @override
  State<SaveImageVerbalAgent> createState() => _SaveImageVerbalAgentState();
}

final GlobalKey _globalKeyScreenShot = GlobalKey();

class _SaveImageVerbalAgentState extends State<SaveImageVerbalAgent> {
  List list = [];
  ScreenshotController screenshotController = ScreenshotController();

  var formatter = NumberFormat("##,###,###,###", "en_US");
  String formatNumber(double number) {
    final formatter = NumberFormat('##,###,###,###');
    String formattedNumber =
        formatter.format(double.parse(number.toStringAsFixed(2)));
    return formattedNumber;
  }

  @override
  void initState() {
    totalSQM();

    super.initState();
  }

  final uint8List = Uint8List;
  bool waitvalue = false;

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

  double totalUSD = 0;
  void totalSQM() {
    for (int i = 0; i < widget.listLandbuilding.length; i++) {
      totalUSD +=
          (double.parse("${widget.listLandbuilding[i]['usd_sqms'] ?? 0}")) *
              double.parse("${widget.listLandbuilding[i]['size_sqms'] ?? 0}");
    }
  }

  double fontsize = 9;
  double fontsizes = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: waitvalue
          ? const WaitingFunction()
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
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
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/p2.png'),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/New_KFA_Logo.png",
                                        height: 50,
                                        width: 90,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      flexText(
                                          "Reference N° : ${widget.listVerbal[widget.i]['referrenceN'] ?? "N/A"}",
                                          11),
                                      flexText(
                                          "Date : ${DateFormat('MMMM dd, yyyy').format(DateTime.parse("${widget.listVerbal[widget.i]['verbal_date']}"))}",
                                          11),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  flexText(
                                      "CERTIFICATE OF PROPERTY APPRAISAL", 12),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    flexTitle(
                                        "Under Property Rights : ${widget.listVerbal[widget.i]['under_property_right'] ?? "N/A"}",
                                        fontsize),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    flexTitle(
                                        "Address : ${widget.listVerbal[widget.i]['verbal_address'] ?? "N/A"}",
                                        fontsize),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    flexTitle("Title Deed N°", fontsize),
                                    flexTitle(
                                        "${widget.listVerbal[widget.i]['title_deedN'] ?? "N/A"}",
                                        fontsize),
                                    flexTitle("Issued Date", fontsize),
                                    flexTitle(
                                        (widget.listVerbal[widget.i]
                                                    ['issued_date'] !=
                                                null)
                                            ? DateFormat('MMMM dd, yyyy')
                                                .format(DateTime.parse(
                                                    "${widget.listVerbal[widget.i]['issued_date']}"))
                                            : "N/A",
                                        fontsize),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    flexTitle("Land Size", fontsize),
                                    txtFormatNumber(
                                        'land_size', 0, widget.listVerbal),
                                    flexTitle("Building", fontsize),
                                    txtFormatNumber(
                                        'building_size', 0, widget.listVerbal),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    flexTitle("Latitude", fontsize),
                                    flexTitle(
                                        "${widget.listVerbal[widget.i]['latlong_la'] ?? "N/A"}",
                                        fontsize),
                                    flexTitle("Longitude", fontsize),
                                    flexTitle(
                                        "${widget.listVerbal[widget.i]['latlong_log'] ?? "N/A"}",
                                        fontsize),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  if (widget.listVerbal[widget.i]
                                              ['verbal_image']
                                          .toString() !=
                                      "No")
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                          height: 180,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: MemoryImage(
                                                      base64Decode(widget
                                                                  .listVerbal[
                                                              widget.i]
                                                          ['verbal_image']))))),
                                    ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        height: 180,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://maps.googleapis.com/maps/api/staticmap?center=${widget.listVerbal[widget.i]['latlong_la']},${widget.listVerbal[widget.i]['latlong_log']}&zoom=17&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${widget.listVerbal[widget.i]['latlong_la']},${widget.listVerbal[widget.i]['latlong_log']}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8")))),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  flexText("Property Appraisals Table", 10),
                                ],
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    flexTitle("Property Type", fontsizes),
                                    flexTitle("Title Deed N°", fontsizes),
                                    flexTitle("Size In SQMs", fontsizes),
                                    flexTitle("USD/sqms", fontsizes),
                                    flexTitle("Total(USD)", fontsizes),
                                  ],
                                ),
                              ),
                              for (int i = 0;
                                  i < widget.listLandbuilding.length;
                                  i++)
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          flexTitle(
                                              "${widget.listLandbuilding[i]['verbal_land_type'] ?? "N/A"}",
                                              fontsizes),
                                          flexTitle(
                                              "${widget.listVerbal[widget.i]['title_deedN'] ?? "N/A"}",
                                              fontsize),
                                          txtFormatNumber('size_sqms', i,
                                              widget.listLandbuilding),
                                          txtFormatNumber('usd_sqms', i,
                                              widget.listLandbuilding),
                                          flexTitle(
                                              //formatNumber
                                              "USD ${formatNumber(double.parse("${double.parse("${widget.listLandbuilding[i]['size_sqms'] ?? 0}") * double.parse("${widget.listLandbuilding[i]['usd_sqms'] ?? 0}")}"))}.00",
                                              fontsize),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 0.7)),
                                        height: 20,
                                        child: Text("Grand Total",
                                            style: TextStyle(
                                              fontSize: fontsizes,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 0.7)),
                                        height: 20,
                                        child: Text(
                                            "  USD ${formatNumber(totalUSD)}.00",
                                            style: TextStyle(
                                              fontSize: fontsize,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    flexTitle(
                                        "In words: Nine Million Ninety Three Thousand and Six Hundred US Dollars Only.",
                                        fontsizes),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Spacer(),
                                  Column(
                                    children: [
                                      flexText(
                                          "Phnom Penh Date : ${DateFormat('MMMM dd, yyyy').format(DateTime.parse("${widget.listVerbal[widget.i]['verbal_date']}"))}",
                                          fontsizes),
                                      const SizedBox(height: 3),
                                      flexText("Chaiman/CEO", fontsizes),
                                      const SizedBox(height: 3),
                                      flexText("Cerified Appraiser", fontsizes),
                                      const SizedBox(height: 3),
                                      flexText("N° : V-15-165-01", fontsizes)
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 60),
                                  Column(
                                    children: [
                                      flexText("Property Location", 9),
                                      const SizedBox(height: 3),
                                      BarcodeWidget(
                                        barcode: Barcode.qrCode(
                                          errorCorrectLevel:
                                              BarcodeQRCorrectionLevel.high,
                                        ),
                                        data:
                                            "https://www.google.com/maps?q=${widget.listVerbal[widget.i]['latlong_la']},${widget.listVerbal[widget.i]['latlong_log']}",
                                        width: 70,
                                        height: 70,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                  "*Note : Our Company will not responsible for any fake ducuments, information or fraud. Our Property Valuation is applied to only the land.",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: ui.Color.fromARGB(255, 94, 92, 92),
                                    fontSize: 9,
                                  )),
                            ],
                          ),
                        ),
                      )),
                    ],
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
                              setState(() {
                                if (widget.check == false) {
                                  widget.type(false);
                                } else {
                                  Navigator.pop(context);
                                }
                              });
                            },
                            child: const Icon(Icons.arrow_forward),
                          ),
                          FloatingActionButton.small(
                            backgroundColor: kwhite_new,
                            onPressed: () async {
                              await _downloadImage(
                                  _globalKeyScreenShot, context);
                            },
                            child: const Icon(Icons.download),
                          )
                        ],
                      ),
                    ))
              ],
            ),
    );
  }

  Widget txtFormatNumber(String key, int index, List list) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(2),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(border: Border.all(width: 0.7)),
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                "  ${(list[index][key].toString() != "null") ? "${formatNumber(double.parse("${list[index][key] ?? "0"}"))} sqm" : "N/A"}",
                style: TextStyle(
                  fontSize: fontsize,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  Widget flexTitle(String t1, double fontsize) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(2),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(border: Border.all(width: 0.7)),
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("  $t1",
                style: TextStyle(
                  fontSize: fontsize,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  Widget flexText(String t1, double fontsize) {
    return Text(t1,
        style: TextStyle(
          fontSize: fontsize,
          fontWeight: FontWeight.bold,
        ));
  }
}
