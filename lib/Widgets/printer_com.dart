import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;

class PrinterCom extends StatefulWidget {
  PrinterCom({super.key, required this.item});
  var item;
  @override
  State<PrinterCom> createState() => _PrinterComState();
}

class _PrinterComState extends State<PrinterCom> {
  @override
  void initState() {
    super.initState();
    loadStringList();
  }

  Future<void> loadStringList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listimagelogo = prefs.getStringList('logoImage') ?? [];
      listimage = listimagelogo
          .map((item) => json.decode(item))
          .cast<Map<String, dynamic>>()
          .toList();
    });

    if (listimagelogo.isEmpty) {
      pdfimage();
    }
  }

  Future<void> pdfimage() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get/pdf/15'));

    if (rs.statusCode == 200) {
      setState(() {
        listimage = jsonDecode(rs.body);

        if (listimage.isNotEmpty) {
          listimagelogo = listimage.map((item) => json.encode(item)).toList();
          imagelogoByes(listimagelogo);
        }
      });
    }
  }

  List listimage = [];
  List<String> listimagelogo = [];
  imagelogoByes(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('logoImage', list);
    setState(() {
      listimagelogo = list;
      listimage = list
          .map((item) => json.decode(item))
          .cast<Map<String, dynamic>>()
          .toList();
    });
  }

  Uint8List? getbytes;
  Future<void> getimageMap(double lat, double log) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${(log > lat) ? "$lat,$log" : "$log,$lat"}&zoom=15&size=1080x920&maptype=normal&markers=color:red%7C%7C${(log > lat) ? "$lat,$log" : "$log,$lat"}&key=AIzaSyCYY4ONLxyCkQkueOWSlu4TjuyCH3QNkQ8'));
      getbytes = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () async {
          await getimageMap(
              widget.item['latlong_la'], widget.item['latlong_log']);
          Printing.layoutPdf(
            onLayout: (format) => _generatePdf(format, widget.item),
            format: PdfPageFormat.a4,
          );
        },
        child: const Icon(Icons.local_printshop_outlined,
            color: Color.fromARGB(255, 4, 107, 186)),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, item) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    final now = DateTime.now();
    final formatter = DateFormat('dd/MM/yyyy hh:mm a');
    final formattedDate = formatter.format(now);
    Uint8List? bytesLogo;
    if (listimage.isNotEmpty) {
      bytesLogo = base64Decode(listimage[0]['image']);
    }
    // double totallandBuidlig = double.parse(
    //     "${widget.item['comparable_adding_price'] ?? 0 + widget.item['comparable_sold_price'] ?? 0}");

    pdf.addPage(pw.MultiPage(build: (context) {
      return [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(formattedDate.toString(),
                style: const pw.TextStyle(fontSize: 13)),
            pw.SizedBox(height: 10),
            pw.Row(children: [
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    color: PdfColor.fromInt(
                        const Color.fromRGBO(22, 72, 130, 1).value),
                    width: 100,
                    height: 70,
                    child: pw.Image(
                        pw.MemoryImage(
                          bytesLogo!,
                        ),
                        fit: pw.BoxFit.fitWidth),
                  ),
                ],
              ),
              pw.SizedBox(width: 20),
              pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Row(children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          txt("Comparable ID"),
                          txt("Date of inspection"),
                          txt("Address"),
                          txt("Owner"),
                          txt("Inspectors"),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          txt(" : ${widget.item['comparable_id']}"),
                          txt(" : ${widget.item['comparableDate'] ?? ""}"),
                          txt(" : ${widget.item['comparable_phone'] ?? ""}"),
                          txt(" : ${widget.item['commune'] ?? ""} ${widget.item['district'] ?? ""} ${widget.item['province'] ?? ""}"),
                          txt(" : ${widget.item['agenttype_name'] ?? ""}"),
                        ],
                      ),
                    ])
                  ])
            ]),
            pw.SizedBox(height: 10),
            pw.Container(
              height: 300,
              width: 480,
              child: pw.Image(
                  pw.MemoryImage(
                    getbytes!,
                  ),
                  fit: pw.BoxFit.fitWidth),
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    txtbold("Property Compare"),
                    txtSimple("Date"),
                    txtSimple("LS"),
                    txtSimple("BS"),
                    txtSimple("Asking Price"),
                    txtSimple("Offered Price"),
                    txtSimple("Offered Price"),
                    txtSimple("Sold Out Price"),
                    txtSimple("Total"),
                    txtSimple("Tel"),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    txtSimple(""),
                    txtSimple(" : ${widget.item['comparable_id']}"),
                    txtSimple(" : ${widget.item['comparableDate'] ?? ""}"),
                    txtSimple(
                        " : ${widget.item['comparable_land_length'] ?? ""} x ${widget.item['comparable_land_width'] ?? ""} = ${widget.item['comparable_land_total'] ?? ""} sqm"),
                    txtSimple(
                        " : ${widget.item['comparable_sold_length'] ?? ""} x ${widget.item['comparable_sold_width'] ?? ""} = ${widget.item['comparable_sold_total'] ?? ""} sqm"),
                    txtSimple(
                        " : \$${widget.item['comparable_adding_price'] ?? ""}"),
                    txtSimple(
                        " : \$${widget.item['comparableaddprice'] ?? ""}"),
                    txtSimple(
                        " : \$${widget.item['comparableboughtprice'] ?? ""}"),
                    txtSimple(
                        " : \$${widget.item['comparable_sold_price'] ?? ""}"),
                    txtSimple(" : \$${widget.item['comparableAmount'] ?? ""}"),
                    txtSimple(" : ${widget.item['comparable_phone'] ?? ""}"),
                  ],
                ),
              ],
            )
          ],
        ),
      ];
    }));

    return pdf.save();
  }

  pw.Widget txt(title) {
    return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 2),
        child: pw.Text(title,
            style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: const PdfColor.fromInt(0x29465B))));
  }

  pw.Widget txtbold(title) {
    return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 3),
        child: pw.Text(title,
            style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
                color: const PdfColor.fromInt(0x000000))));
  }

  pw.Widget txtSimple(title) {
    return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 3),
        child: pw.Text(title,
            style: const pw.TextStyle(
                fontSize: 11, color: PdfColor.fromInt(0x000000))));
  }
}
