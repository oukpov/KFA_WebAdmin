// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable, unused_local_variable, unused_element, unnecessary_null_comparison, unused_field
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class List_search_marker extends StatefulWidget {
  List_search_marker({super.key, required this.comparable_code});

  String? comparable_code;

  @override
  State<List_search_marker> createState() => _List_searchState();
}

class _List_searchState extends State<List_search_marker> {
  String? latlog0;
  String? latlog1;
  String? latlog2;
  String? latlog3;
  String? latlog4;
  String? latlog5;
  String? latlog6;
  String? latlog7;
  String? latlog8;
  String? latlog9;
  String? latlog10;
  String? latlog11;
  String? latlog12;
  String? latlog13;
  String? latlog14;
  String? latlog15;
  String? latlog;
  String? url;
  String? url0;
  var _latlog;
  int i = 0;
  bool _await = false;
  @override
  void initState() {
    super.initState();
    _com();
  }

  Future<void> _com() async {
    _await = true;
    await Future.wait([
      get_comparable_filter(),
    ]);
    setState(() {
      _await = false;
    });
  }

  List list = [];
  Future<void> get_comparable_filter() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparablecode_comparable/${widget.comparable_code}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list = jsonData;
        // print('ok');
        marker();
        i = list.length;
      });
    }
  }
  // List list_marker = [
  //   for (int i = 0; i < 4; i++)
  //     {
  //       'marker': '&markers=color:red%7C$i',
  //     }
  // ];

  Future<void> marker() async {
    setState(() {
      for (int i = 0; i <= list.length; i++) {
        if (i != 0 && list[0]['latlong_log'].toString() == null) {
          latlog0 = '';
        } else {
          latlog0 =
              '&markers=color:red%7C${list[0]['latlong_log'].toString()},${list[0]['latlong_la'].toString()}';
        }
        if (i != 1 && list[1]['latlong_log'].toString() == null) {
          latlog1 = '';
        } else {
          latlog1 =
              '${'&markers=color:red%7C${list[1]['latlong_log'].toString()},${list[1]['latlong_la'].toString()}'}';
        }
        if (i != 2 && list[2]['latlong_log'].toString() == null) {
          latlog2 = '';
        } else {
          latlog2 =
              '${'&markers=color:red%7C${list[2]['latlong_log'].toString()},${list[2]['latlong_la'].toString()}'}';
        }
        if (i != 3 && list[3]['latlong_log'].toString() == null) {
          latlog3 = '';
        } else {
          latlog3 =
              '${'&markers=color:red%7C${list[3]['latlong_log'].toString()},${list[3]['latlong_la'].toString()}'}';
        }
        if (i != 4 && list[4]['latlong_log'].toString() == null) {
          latlog4 = '';
        } else {
          latlog4 =
              '${'&markers=color:red%7C${list[4]['latlong_log'].toString()},${list[4]['latlong_la'].toString()},'}';
        }
        if (i != 5 && list[5]['latlong_log'].toString() == null) {
          latlog5 = '';
        } else {
          latlog5 =
              '${'&markers=color:red%7C${list[5]['latlong_log'].toString()},${list[5]['latlong_la'].toString()},'}';
        }
        if (i != 6 && list[6]['latlong_log'].toString() == null) {
          latlog6 = '';
        } else {
          latlog6 =
              '${'&markers=color:red%7C${list[6]['latlong_log'].toString()},${list[6]['latlong_la'].toString()}'}';
        }
        if (i != 7 && list[7]['latlong_log'].toString() == null) {
          latlog7 = '';
        } else {
          latlog7 =
              '${'&markers=color:red%7C${list[7]['latlong_log'].toString()},${list[7]['latlong_la'].toString()}'}';
        }
        if (i != 8 && list[8]['latlong_log'].toString() == null) {
          latlog8 = '';
        } else {
          latlog8 =
              '&markers=color:red%7C${list[8]['latlong_log'].toString()},${list[8]['latlong_la'].toString()}';
        }
        if (i != 9 && list[9]['latlong_log'].toString() == null) {
          latlog9 = '';
        } else {
          latlog9 =
              '${'&markers=color:red%7C${list[9]['latlong_log'].toString()},${list[9]['latlong_la'].toString()}'}';
        }
        if (i != 10 && list[9]['latlong_log'].toString() == null) {
          latlog10 = '';
        } else {
          latlog10 =
              '${'&markers=color:red%7C${list[10]['latlong_log'].toString()},${list[10]['latlong_la'].toString()}'}';
        }
      }
    });
  }

  void delete_Comparable() async {
    final response = await http.delete(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/delete/comparableMap/${widget.comparable_code}'));
    if (response.statusCode == 200) {
      setState(() {});
      Navigator.pop(context);
      Navigator.pop(context);
      // Navigator.push(context, MaterialPageRoute(
      //   builder: (context) {
      //     return ComparableList(
      //       name: '',
      //     );
      //   },
      // ));
    } else {
      throw Exception('Delete error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    var sizeb = SizedBox(height: 10);
    var front = TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.015,
        fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
          actions: [
            GFButton(
              elevation: 10,
              color: Color.fromARGB(255, 137, 10, 35),
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  title: 'Confirmation',
                  desc: 'Are you sure you want to delete this item?',
                  btnOkText: 'Yes',
                  btnOkColor: Color.fromARGB(255, 72, 157, 11),
                  btnCancelText: 'No',
                  btnCancelColor: Color.fromARGB(255, 133, 8, 8),
                  btnOkOnPress: () async {
                    delete_Comparable();
                  },
                  btnCancelOnPress: () {},
                ).show();
              },
              text: "Delete",
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              shape: GFButtonShape.pills,
            ),
          ],
          backgroundColor: Colors.deepPurple[900],
          centerTitle: true,
          title: Text('${widget.comparable_code}'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back))),
      body: _await
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 2)),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      // width: double.infinity,                                                                                                                                                               ${'&markers=color:red%7C${widget.list[0]['latlong_log'].toString()},${widget.list[0]['latlong_la'].toString()}'}
                      child: Image.network(
                        'https://maps.googleapis.com/maps/api/staticmap?center=&markers=color:red%7C${list[i - 1]['latlong_log'].toString()},${list[i - 1]['latlong_la'].toString()}&zoom=15&size=720x720&maptype=normal$latlog0$latlog1$latlog2$latlog3$latlog4$latlog5$latlog6$latlog7$latlog8$latlog9$latlog10&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: double.infinity,
                      child: GridView.builder(
                        itemCount: list.length,
                        // itemCount: 12,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.4,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration:
                                BoxDecoration(border: Border.all(width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Property Type : (${list[index]['comparable_id'].toString()})',
                                    style: front,
                                  ),
                                  sizeb,
                                  Text(
                                    'Survey Date : ${list[index]['comparable_survey_date'].toString()}',
                                    style: front,
                                  ),
                                  sizeb,
                                  Text(
                                    'LS : ${list[index]['comparable_land_length'].toString()} x ${list[index]['comparable_land_width'].toString()} : ${list[index]['comparable_land_total'].toString()} sqm',
                                    style: front,
                                  ),
                                  sizeb,
                                  Text(
                                    'BS : ${list[index]['comparable_sold_length'].toString()} x ${list[index]['comparable_sold_width'].toString()} : ${list[index]['comparable_sold_total'].toString()} sqm',
                                    style: front,
                                  ),
                                  sizeb,
                                  Text(
                                    'Asking Price : ${list[index]['comparable_adding_price'].toString()} \$/sqm',
                                    style: front,
                                  ),
                                  sizeb,
                                  Text(
                                    'Offered Price : ${list[index]['comparable_sold_price'].toString()}  \$/sqm',
                                    style: front,
                                  ),
                                  sizeb,
                                  Text(
                                    'Sold Out Price : ${list[index]['comparable_sold_price'].toString()}  \$/sqm',
                                    style: front,
                                  ),
                                  sizeb,
                                  Text(
                                    'Remark : ${list[index]['comparable_remark'].toString()}',
                                    style: front,
                                  ),
                                  sizeb,
                                  Text(
                                    'Tel  : ${list[index]['comparable_phone'].toString()}',
                                    style: front,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 21, 16, 179),
        onPressed: () async {
          await Printing.layoutPdf(
              onLayout: (format) => _generatePdf(format, list));
        },
        child: Icon(Icons.print),
      ),
    );
  }

  Future<Uint8List> _generatePdf(
    PdfPageFormat format,
    List items,
  ) async {
    // Create a new PDF document
    double sizefont = MediaQuery.of(context).size.height * 0.010;
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final ByteData bytes =
        await rootBundle.load('assets/images/New_KFA_Logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    Uint8List image_latlog = (await NetworkAssetBundle(Uri.parse(
                'https://maps.googleapis.com/maps/api/staticmap?center=&markers=color:red%7C${list[i - 1]['latlong_log'].toString()},${list[i - 1]['latlong_la'].toString()}&zoom=16&size=720x720&maptype=normal$latlog0$latlog1$latlog2$latlog3$latlog4$latlog5$latlog6$latlog7$latlog8$latlog9$latlog10&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'))
            .load(
                'https://maps.googleapis.com/maps/api/staticmap?center=&markers=color:red%7C${list[i - 1]['latlong_log'].toString()},${list[i - 1]['latlong_la'].toString()}&zoom=16&size=720x720&maptype=normal$latlog0$latlog1$latlog2$latlog3$latlog4$latlog5$latlog6$latlog7$latlog8$latlog9$latlog10&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'))
        .buffer
        .asUint8List();
    final data = List<String>.generate(20, (index) => 'Item ${index + 1}');

    pdf.addPage(pw.MultiPage(
      // orientation: pw.PageOrientation.landscape,
      build: (context) {
        return [
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Container(
                  width: 80,
                  height: 50,
                  child: pw.Image(
                      pw.MemoryImage(
                        byteList,
                        // bytes1,
                      ),
                      fit: pw.BoxFit.fill),
                ),
                pw.Column(children: [
                  pw.Text(
                      'Kfanhrm.cc/KFACRM/content/comparable_form/comparable_print.php?comparablecode=${widget.comparable_code.toString()}',
                      style: pw.TextStyle(
                          fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                  pw.Text(
                      'Date of : ${items[0]['comparable_survey_date'].toString()}',
                      style: pw.TextStyle(
                          fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                  pw.Text(
                      'Address : ${items[0]['comparable_address'].toString()}',
                      style: pw.TextStyle(
                          fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Agent Name : N/A',
                      style: pw.TextStyle(
                          fontSize: sizefont, fontWeight: pw.FontWeight.bold)),
                ])
              ]),
          pw.Padding(
            padding: pw.EdgeInsets.only(top: 10, right: 10, left: 10),
            child: pw.Container(
              height: 250,
              width: double.infinity,
              child: pw.Image(
                  pw.MemoryImage(
                    image_latlog,
                    // bytes1,
                  ),
                  fit: pw.BoxFit.fill),
            ),
          ),
          pw.Padding(
              padding: pw.EdgeInsets.only(left: 10, right: 10, top: 10),
              child: pw.GridView(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 4, // Number of columns
                childAspectRatio: 2,
                children: List<pw.Widget>.generate(
                  list.length,
                  (index) {
                    // final item = data[index];
                    return pw.Padding(
                        padding: pw.EdgeInsets.only(top: 20),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                  'Property Type : ${items[index]['comparable_id'].toString()}',
                                  style: pw.TextStyle(
                                      fontSize: sizefont,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                  'Survey Date : ${(items[index]['comparable_survey_date'] == null) ? '' : items[index]['comparable_survey_date'].toString()}',
                                  style: pw.TextStyle(
                                      fontSize: sizefont,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                  'LS : ${(items[index]['comparable_land_length'] == null) ? '' : items[index]['comparable_land_length'].toString()}} x ${items[index]['comparable_land_width'].toString()} : ${items[index]['comparable_land_total'].toString()} sqm',
                                  style: pw.TextStyle(
                                      fontSize: sizefont,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                  'BS : ${items[index]['comparable_sold_length'].toString()} x ${items[index]['comparable_sold_width'].toString()} : ${items[index]['comparable_sold_total'].toString()} sqm',
                                  style: pw.TextStyle(
                                      fontSize: sizefont,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                  'Asking Price : ${items[index]['comparable_adding_price'].toString()} \$/sqm',
                                  style: pw.TextStyle(
                                      fontSize: sizefont,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                  'Offered Price : ${items[index]['comparableboughtprice'].toString()} \$/sqm',
                                  style: pw.TextStyle(
                                      fontSize: sizefont,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                  'Sold Out Price : ${items[index]['comparable_sold_total'].toString()} \$/sqm',
                                  style: pw.TextStyle(
                                      fontSize: sizefont,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                  'Remark : ${items[index]['comparable_remark'].toString()}',
                                  style: pw.TextStyle(
                                      fontSize: sizefont,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                  'Tel : ${items[index]['comparable_phone'].toString()}',
                                  style: pw.TextStyle(
                                      fontSize: sizefont,
                                      fontWeight: pw.FontWeight.bold)),
                            ]));
                  },
                ),
              ))
        ];
      },
    ));
    bool isprint = false;
    final Color_Test = Color.fromARGB(255, 131, 18, 10);
    // Get the bytes of the PDF document
    final pdfBytes = pdf.save();

    // Print the PDF document to the default printer
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfBytes);
    return pdf.save();
  }
}
// https://maps.googleapis.com/maps/api/staticmap?center=11.521079,104.928533&zoom=14&size=720x720&maptype=hybrid&markers=color:red%7C11.521079,104.928533&markers=color:red%7C11.517547,104.932438&markers=color:red%7C11.514961,&markers=color:red%7C11.514961,104.928830&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI
// 'https://maps.googleapis.com/maps/api/staticmap?center=${'${widget.list[0]['latlong_log'].toString()},${widget.list[0]['latlong_la'].toString()}'}&zoom=15&size=720x720&maptype=hybrid${'&markers=color:red%7C${widget.list[0]['latlong_log'].toString()},${widget.list[0]['latlong_la'].toString()}'}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI',