import 'dart:convert';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:html' as html;

import '../../../api/contants.dart';
import '../../../components/readonly.dart';
import '../../../models/autoVerbal.dart';

class detail_verbal extends StatefulWidget {
  const detail_verbal({super.key, required this.set_data_verbal});
  final String set_data_verbal;
  @override
  State<detail_verbal> createState() => _detail_searchingState();
}

class _detail_searchingState extends State<detail_verbal> {
  List list = [];

  void get_all_autoverbal_by_id() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_new?verbal_id=${widget.set_data_verbal.toString()}'));

    if (rs.statusCode == 200) {
      setState(() {
        list = jsonDecode(rs.body);
        image_m =
            'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_log"]},${list[0]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_log"]},${list[0]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI';
        getimage();
        getimage_m1();
      });
    }
  }

  var image_i, get_image = [];
  Future<void> getimage() async {
    // var id;

    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_image/${widget.set_data_verbal.toString()}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        get_image = jsonData;
        image_i = get_image[0]['url'];
        getimage_m();
      });
    }
  }

  var formatter = NumberFormat("##,###,###,###", "en_US");
  var image_m;

  int? total_MIN = 0;
  int? total_MAX = 0;
  List<AutoVerbal_List> data_pdf = [];
  List land = [];
  double? fsvM, fsvN, fx, fn;
  Future<void> Land_building() async {
    double x = 0, n = 0;
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_land?verbal_landid=${widget.set_data_verbal.toString()}'));
    if (rs.statusCode == 200) {
      land = jsonDecode(rs.body);
      for (int i = 0; i < land.length; i++) {
        total_MIN =
            total_MIN! + int.parse(land[i]["verbal_land_minvalue"].toString());
        total_MAX =
            total_MAX! + int.parse(land[i]["verbal_land_maxvalue"].toString());
        // address = land[i]["address"];
        x = x + int.parse(land[i]["verbal_land_maxsqm"].toString());
        n = n + int.parse(land[i]["verbal_land_minsqm"].toString());
      }
      setState(() {
        fsvM =
            (total_MAX! * double.parse(list[0]["verbal_con"].toString())) / 100;
        fsvN =
            (total_MIN! * double.parse(list[0]["verbal_con"].toString())) / 100;

        if (land.length < 1) {
          total_MIN = 0;
          total_MAX = 0;
        } else {
          fx = x * (double.parse(list[0]["verbal_con"].toString()) / 100);
          fn = n * (double.parse(list[0]["verbal_con"].toString()) / 100);
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

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    get_all_autoverbal_by_id();
    Land_building();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var wth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: (list.length > 0)
          ? SafeArea(
              child: ListView(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.chevron_left_outlined,
                          size: 35,
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 5, color: Colors.purple)
                          ],
                        )),
                  ),
                  Container(
                    height: 1480,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        if (image_i != null)
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 200,
                                  width: wth / 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_log"]},${list[0]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_log"]},${list[0]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  width: wth / 2,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          NetworkImage('${image_i.toString()}'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            height: 200,
                            width: wth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_log"]},${list[0]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_log"]},${list[0]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        Box(
                          label: "ID Auto Verbal",
                          iconname: const Icon(
                            Icons.code,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_id"] ?? "N/A",
                        ),
                        Box(
                          label: "Property",
                          iconname: const Icon(
                            Icons.business_outlined,
                            color: kImageColor,
                          ),
                          value: list[0]["property_type_name"] ?? "N/A",
                        ),
                        Box(
                          label: "Bank",
                          iconname: const Icon(
                            Icons.home_work,
                            color: kImageColor,
                          ),
                          value: list[0]["bank_name"] ?? "N/A",
                        ),
                        Box(
                          label: "Branch",
                          iconname: const Icon(
                            Icons.account_tree_rounded,
                            color: kImageColor,
                          ),
                          value: list[0]["bank_name"] ?? "N/A",
                        ),
                        Box(
                          label: "Owner",
                          iconname: const Icon(
                            Icons.person,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_owner"] ?? "N/A",
                        ),
                        Box(
                          label: "Contact",
                          iconname: const Icon(
                            Icons.phone,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_contact"] ?? "N/A",
                        ),
                        Box(
                          label: "Date",
                          iconname: const Icon(
                            Icons.calendar_today,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_created_date"].split(" ")[0] ??
                              "N/A",
                        ),
                        Box(
                          label: "Bank Officer",
                          iconname: const Icon(
                            Icons.work,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_bank_officer"] ?? "N/A",
                        ),
                        Box(
                          label: "Contact",
                          iconname: const Icon(
                            Icons.phone,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_bank_contact"] ?? "N/A",
                        ),
                        Box(
                          label: "Comment",
                          iconname: const Icon(
                            Icons.comment_sharp,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_comment"] ?? "N/A",
                        ),
                        Box(
                          label: "Verify by",
                          iconname: const Icon(
                            Icons.person_sharp,
                            color: kImageColor,
                          ),
                          value: list[0]["agenttype_name"] ?? "N/A",
                        ),
                        Box(
                          label: "Approve by",
                          iconname: const Icon(
                            Icons.person_outlined,
                            color: kImageColor,
                          ),
                          value: list[0]["approve_name"] ?? "N/A",
                        ),
                        Box(
                          label: "Address",
                          iconname: const Icon(
                            Icons.location_on_rounded,
                            color: kImageColor,
                          ),
                          value: list[0]["verbal_address"] ?? "N/A",
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 290,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            child: Row(
                              children: [
                                for (int i = 0; i < land.length; i++)
                                  Container(
                                    width: 270,
                                    height: 280,
                                    padding: const EdgeInsets.all(7),
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 2,
                                            color: Colors.black45)
                                      ],
                                      border: Border.all(
                                          width: 1, color: kPrimaryColor),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 10),
                                          child: Text.rich(
                                            TextSpan(
                                              children: <InlineSpan>[
                                                const WidgetSpan(
                                                    child: Icon(
                                                  Icons.location_on_sharp,
                                                  color: kPrimaryColor,
                                                  size: 14,
                                                )),
                                                TextSpan(
                                                    text:
                                                        "${land[i]['address']} "),
                                              ],
                                            ),
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        const Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: kPrimaryColor,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            land[i]['verbal_land_type'],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Depreciation",
                                                  style: Label(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  "Floor",
                                                  style: Label(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  "Area",
                                                  style: Label(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  'Min Value/Sqm',
                                                  style: Label(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  'Max Value/Sqm',
                                                  style: Label(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  'Min Value',
                                                  style: Label(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  'Min Value',
                                                  style: Label(),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ':   ${land[i]['verbal_land_dp'].toString()}',
                                                  style: Name(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  ':   ${land[i]['verbal_land_des'].toString()}',
                                                  style: Name(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  ':   ${formatter.format(land[i]['verbal_land_area']).toString()}'
                                                          ' m' +
                                                      '\u00B2',
                                                  style: Name(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  ':   ${formatter.format(land[i]['verbal_land_minsqm']).toString()}' +
                                                      '\$',
                                                  style: Name(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  ':   ${formatter.format(land[i]['verbal_land_maxsqm']).toString()}' +
                                                      '\$',
                                                  style: Name(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  ':   ${formatter.format(land[i]['verbal_land_minvalue']).toString()}' +
                                                      '\$',
                                                  style: Name(),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  ':   ${formatter.format(land[i]['verbal_land_maxvalue']).toString()}\$',
                                                  style: Name(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextLiquidFill(
                    boxHeight: 70,
                    boxWidth: MediaQuery.of(context).size.width * 1,
                    boxBackgroundColor: const Color.fromARGB(0, 0, 0, 0),
                    text: widget.set_data_verbal.toString(),
                    waveColor: Colors.blueAccent,
                    loadDuration: const Duration(seconds: 20),
                    loadUntil: 1,
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.deepOrange,
        elevation: 12,
        onPressed: () async {
          if (image_i != null) {
            await getimage_m();
            await getimage_m1();
            await Printing.layoutPdf(
              onLayout: (format) => _generatePdf(format),
              format: PdfPageFormat.a4,
            );
          } else {
            await getimage_m1();
            await Printing.layoutPdf(
              onLayout: (format) => _generatePdf(format),
              format: PdfPageFormat.a4,
            );
          }
        },
        child: const Icon(Icons.print_outlined),
      ),
    );
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 13);
  }

  TextStyle Name() {
    return TextStyle(
        color: kImageColor, fontSize: 13, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return TextStyle(
        color: kImageColor, fontSize: 11, fontWeight: FontWeight.bold);
  }

  Uint8List? get_bytes;
  Uint8List? get_bytes1;

  Future<void> getimage_m() async {
    try {
      http.Response response = await http.get(Uri.parse(image_i));
      get_bytes = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  Future<void> getimage_m1() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${list[0]["latlong_log"]},${list[0]["latlong_la"]}&zoom=20&size=1080x920&maptype=hybrid&markers=color:red%7C%7C${list[0]["latlong_log"]},${list[0]["latlong_la"]}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));
      get_bytes1 = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  Future go_print(BuildContext context) {
    return Printing.layoutPdf(
      onLayout: (format) => _generatePdf(format),
      format: PdfPageFormat.a4,
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    final ByteData bytes_image =
        await rootBundle.load('assets/images/New_KFA_Logo_pdf.png');
    final Uint8List byteList_image = bytes_image.buffer.asUint8List();
    final pageTheme = await _myPageTheme(format);
    pdf.addPage(pw.MultiPage(
        pageTheme: pageTheme,
        build: (context) {
          return [
            pw.Column(
              children: [
                pw.Column(
                  children: [
                    pw.Container(
                      height: 70,
                      margin: pw.EdgeInsets.only(bottom: 5),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Container(
                            width: 75,
                            height: 50,
                            child: pw.Image(
                                pw.MemoryImage(
                                  byteList_image,
                                  // bytes1,
                                ),
                                fit: pw.BoxFit.fill),
                          ),
                          pw.Text("VERBAL CHECK",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 12,
                              )),
                          pw.Row(
                            children: [
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
                                            "https://www.oneclickonedollar.com/#/${widget.set_data_verbal.toString()}",
                                        width: 50,
                                        height: 50,
                                      ),
                                      pw.Container(
                                        color: PdfColors.white,
                                        width: 10,
                                        height: 10,
                                        child: pw.Image(
                                            pw.MemoryImage(
                                              byteList_image,
                                              // bytes1,
                                            ),
                                            fit: pw.BoxFit.fill),
                                      ),
                                    ],
                                  ),
                                  pw.Text(
                                    'Verify Pdf',
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  )
                                ],
                              ),
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
                                            "https://www.latlong.net/c/?lat=${list[0]['latlong_log']}&long=${list[0]['latlong_la']}",
                                        width: 50,
                                        height: 50,
                                      ),
                                      pw.Container(
                                        color: PdfColors.white,
                                        width: 10,
                                        height: 10,
                                        child: pw.Image(
                                            pw.MemoryImage(
                                              byteList_image,
                                              // bytes1,
                                            ),
                                            fit: pw.BoxFit.fill),
                                      ),
                                    ],
                                  ),
                                  pw.Text(
                                    'Location Map',
                                    style: pw.TextStyle(
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
                    pw.Container(
                      child: pw.Column(children: [
                        pw.Column(children: [
                          pw.Container(
                              child: pw.Row(children: [
                            pw.Expanded(
                              flex: 4,
                              child: pw.Container(
                                padding: pw.EdgeInsets.all(2),
                                alignment: pw.Alignment.centerLeft,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(),
                                    color: PdfColor.fromInt(
                                        Color.fromRGBO(22, 72, 130, 1).value)),
                                //color: Colors.red,
                                child: pw.Text(
                                  "DATE: ${list[0]['verbal_created_date'].toString()}",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                    //fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.white,
                                  ),
                                ),
                                height: 20,
                                //color: Colors.white,
                              ),
                            ),
                            pw.Expanded(
                              flex: 4,
                              child: pw.Container(
                                padding: pw.EdgeInsets.all(2),
                                alignment: pw.Alignment.centerLeft,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(),
                                    color: PdfColor.fromInt(
                                        Color.fromRGBO(22, 72, 130, 1).value)),
                                child: pw.Text(
                                    "CODE: ${list[0]['verbal_id'].toString()}",
                                    style: pw.TextStyle(
                                      fontSize: 11,
                                      //fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.white,
                                    )),
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
                            flex: 11,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  "Requested Date :${list[0]['verbal_created_date'].toString()} ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                      decoration: pw.BoxDecoration(border: pw.Border.all()),
                      child: pw.Text(
                          "Referring to your request letter for verbal check by ${list[0]['bank_name'].toString()} ${list[0]['bank_branch_name'] ?? ""}, we estimated the value of property as below.",
                          overflow: pw.TextOverflow.clip,
                          style: pw.TextStyle(fontSize: 11)),
                      height: 34,
                      //color: Colors.blue,
                    ),
                    pw.SizedBox(
                      child: pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text("Property Information: ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 6,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  " ${list[0]['property_type_name'] ?? ''}",
                                  style: pw.TextStyle(
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
                            flex: 2,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text("Address : ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 6,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  " ${list[0]['verbal_address'] ?? ""}.${list[0]['verbal_khan'] ?? ""}",
                                  style: pw.TextStyle(
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
                            flex: 2,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text("Owner Name ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child:
                                  // name rest with api
                                  pw.Text("${list[0]['verbal_owner'] ?? ""}",
                                      style: pw.TextStyle(
                                        fontSize: 11,
                                      )),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              // name rest with api
                              child: pw.Text(
                                  "Contact No : ${list[0]['verbal_contact'] ?? ""}",
                                  style: pw.TextStyle(
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
                            flex: 2,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text("Bank Officer ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )),
                              height: 30,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(" ${list[0]['bank_name'] ?? ""}",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )),
                              height: 30,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  "Contact No : ${list[0]['bankcontact'] ?? ""}",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )),
                              height: 30,
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
                            flex: 2,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.center,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  "Latitude: ${list[0]['latlong_log'].toString()}",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.center,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  "Longtitude: ${list[0]['latlong_la'].toString()}",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text("ESTIMATED VALUE OF THE VERBAL CHECK PROPERTY",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 11,
                        )),
                    pw.SizedBox(height: 5),
                    if (get_bytes != null)
                      pw.Container(
                        height: 110,
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Container(
                              width: 240,
                              child: pw.Image(
                                  pw.MemoryImage(
                                    get_bytes!,
                                  ),
                                  fit: pw.BoxFit.fitWidth),
                            ),
                            pw.SizedBox(width: 0.1),
                            pw.Container(
                              width: 240,
                              child: pw.Image(
                                  pw.MemoryImage(
                                    get_bytes1!,
                                  ),
                                  fit: pw.BoxFit.fitWidth),
                            ),
                          ],
                        ),
                      ),
                    if (get_bytes == null)
                      pw.Container(
                        width: 240,
                        height: 110,
                        alignment: pw.Alignment.center,
                        child: pw.Image(
                            pw.MemoryImage(
                              get_bytes1!,
                            ),
                            fit: pw.BoxFit.fitWidth),
                      ),
                    pw.SizedBox(height: 5),
                    pw.Container(
                        child: pw.Column(children: [
                      pw.Container(
                          child: pw.Row(children: [
                        pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.center,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(),
                                  color: PdfColor.fromInt(
                                      Color.fromRGBO(22, 72, 130, 1).value)),
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
                                    Color.fromRGBO(22, 72, 130, 1).value)),
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
                                    Color.fromRGBO(22, 72, 130, 1).value)),
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
                                    Color.fromRGBO(22, 72, 130, 1).value)),
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
                                    Color.fromRGBO(22, 72, 130, 1).value)),
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
                                    Color.fromRGBO(22, 72, 130, 1).value)),
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
                              flex: 3,
                              child: pw.Container(
                                padding: pw.EdgeInsets.all(2),
                                alignment: pw.Alignment.centerLeft,
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                child: pw.Text(
                                    land[index]["verbal_land_type"] ?? "",
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
                                padding: pw.EdgeInsets.all(2),
                                alignment: pw.Alignment.centerLeft,
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                child: pw.Text(
                                    'USD ${formatter.format(double.parse(land[index]["verbal_land_minsqm"].toString()))}',
                                    style: pw.TextStyle(fontSize: 9)),
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
                                padding: pw.EdgeInsets.all(2),
                                alignment: pw.Alignment.centerLeft,
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                child: pw.Text(
                                    'USD ${formatter.format(double.parse(land[index]["verbal_land_minvalue"].toString()))}',
                                    style: pw.TextStyle(fontSize: 9)),
                                height: 20,
                                //color: Colors.blue,
                              ),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                padding: pw.EdgeInsets.all(2),
                                alignment: pw.Alignment.centerLeft,
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                child: pw.Text(
                                    'USD ${formatter.format(double.parse(land[index]["verbal_land_maxvalue"].toString()))}',
                                    style: pw.TextStyle(fontSize: 9)),
                                height: 20,
                                //color: Colors.blue,
                              ),
                            ),
                          ]),
                      pw.Container(
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 9,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerRight,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text("Property Value(Estimate) ",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  'USD ${formatter.format(double.parse(total_MIN.toString()))}',
                                  style: pw.TextStyle(fontSize: 9)),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  'USD ${formatter.format(double.parse(total_MAX.toString()))}',
                                  style: pw.TextStyle(fontSize: 9)),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                        ]),
                      ),
                      pw.Container(
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 9,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              // ទាយយក forceSale from  ForceSaleAndValuation
                              child: pw.Text(
                                  "Force Sale Value ${list[0]['verbal_con'] ?? ''}% ",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                              // child: pw.Text(
                              //   "Force Sale Value ${list[0].verbal_con ?? ''}% ",
                              //   style: pw.TextStyle(
                              //     fontSize: 10,
                              //     fontWeight: pw.FontWeight.bold,
                              //   )),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  "USD ${formatter.format(fsvN ?? double.parse('0.00'))}",
                                  style: pw.TextStyle(fontSize: 10)),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  'USD ${formatter.format(fsvM ?? double.parse('0.00'))}',
                                  style: pw.TextStyle(fontSize: 10)),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                        ]),
                      ),
                      //  ដកចេញសិន
                      // pw.Container(
                      //   child: pw.Row(children: [
                      //     pw.Expanded(
                      //       flex: 5,
                      //       child: pw.Container(
                      //         padding: const pw.EdgeInsets.all(2),
                      //         alignment: pw.Alignment.centerLeft,
                      //         decoration: pw.BoxDecoration(border: pw.Border.all()),
                      //         child: pw.Text("Force Sale Value: ",
                      //             style: pw.TextStyle(
                      //               fontSize: 11,
                      //               ,
                      //               fontWeight: pw.FontWeight.bold,
                      //             )),
                      //         height: 20,
                      //         //color: Colors.blue,
                      //       ),
                      //     ),
                      //     pw.Expanded(
                      //       flex: 2,
                      //       child: pw.Container(
                      //         padding: const pw.EdgeInsets.all(2),
                      //         alignment: pw.Alignment.centerLeft,
                      //         decoration: pw.BoxDecoration(border: pw.Border.all()),
                      //         child: pw.Text("${fn ?? '0.00'}",
                      //             style: pw.TextStyle(fontSize: 11, )),
                      //         height: 20,
                      //         //color: Colors.blue,
                      //       ),
                      //     ),
                      //     pw.Expanded(
                      //       flex: 2,
                      //       child: pw.Container(
                      //         padding: const pw.EdgeInsets.all(2),
                      //         alignment: pw.Alignment.centerLeft,
                      //         decoration: pw.BoxDecoration(border: pw.Border.all()),
                      //         child: pw.Text("${fx ?? '0.00'}",
                      //             style: pw.TextStyle(fontSize: 11, )),
                      //         height: 20,
                      //         //color: Colors.blue,
                      //       ),
                      //     ),
                      //     pw.Expanded(
                      //       flex: 4,
                      //       child: pw.Container(
                      //         padding: pw.EdgeInsets.all(2),
                      //         alignment: pw.Alignment.centerLeft,
                      //         decoration: pw.BoxDecoration(border: pw.Border.all()),
                      //         height: 20,
                      //         //color: Colors.blue,
                      //       ),
                      //     ),
                      //   ]),
                      // ),
                      pw.Container(
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 11,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(2),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                  "COMMENT: ${list[0]['verbal_comment'] ?? ''}",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                              height: 20,
                              //color: Colors.blue,
                            ),
                          ),
                        ]),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("Valuation fee : ",
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        height: 20,
                        //color: Colors.blue,
                      ),
                    ])),
                    pw.SizedBox(height: 5),
                    pw.Text(
                        '*Note: It is only first price which you took from this verbal check data. The accurate value of property when we have the actual site property inspection.We are not responsible for this case when you provided the wrong land and building size or any fraud.',
                        style: pw.TextStyle(
                          fontSize: 6,
                        )),
                  ],
                ),
                pw.SizedBox(height: 30),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Text(
                                'Verbal Check Replied By:${list[0]['username'].toString()} ',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 7,
                                ),
                                textAlign: pw.TextAlign.right),
                            pw.SizedBox(height: 4),
                            pw.Text(' ${list[0]['tel_num'].toString()}',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 11,
                                ),
                                textAlign: pw.TextAlign.center),
                          ],
                        ),
                      ],
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text('KHMER FOUNDATION APPRAISALS Co.,Ltd',
                              style: pw.TextStyle(
                                color: PdfColors.blue,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 11,
                              )),
                        ]),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('Hotline: 099 283 388',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 7,
                                  )),
                              pw.Row(children: [
                                pw.Text(
                                    'H/P : (+855)23 988 855/(+855)23 999 761',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 7,
                                    )),
                              ]),
                              pw.Row(children: [
                                pw.Text('Email : info@kfa.com.kh',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 7,
                                    )),
                              ]),
                              pw.Row(children: [
                                pw.Text('Website: www.kfa.com.kh',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 7,
                                    )),
                              ]),
                            ],
                          ),
                        ),
                        pw.SizedBox(width: 10),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                  'Villa #36A, Street No4, (Borey Peng Hout The Star',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 7,
                                  )),
                              pw.Text('Natural 371) Sangkat Chak Angrae Leu,',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 7,
                                  )),
                              pw.Text(
                                  'Khan Mean Chey, Phnom Penh City, Cambodia,',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 7,
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
          ];
        }));

    return pdf.save();
  }
}

void _showSharedToast(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Document shared successfully'),
    ),
  );
}

Future<void> _saveAsFile(
  BuildContext context,
  LayoutCallback build,
  PdfPageFormat pageFormat,
) async {
  final bytes = await build(pageFormat);

  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/document.pdf');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/images/Letter En-Kh.svg');

  format = format.applyMargin(
      left: 0.1 * PdfPageFormat.cm,
      top: 0.2 * PdfPageFormat.cm,
      right: 0.1 * PdfPageFormat.cm,
      bottom: 0.2 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.tinosRegular(),
      bold: await PdfGoogleFonts.tinosBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.SvgImage(svg: bgShape),
      );
    },
  );
}
