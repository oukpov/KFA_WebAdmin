import 'dart:math';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class PrinterPDF extends StatefulWidget {
  PrinterPDF({super.key, required this.index, required this.list});
  late String index;
  List list = [];

  @override
  State<PrinterPDF> createState() => _PrintState();
}

class _PrintState extends State<PrinterPDF> {
  int index = 0;
  @override
  void initState() {
    index = int.parse(widget.index.toString());
    super.initState();
    listExecutive();
    print(widget.list.toString());
  }

  int hour = 0;
  int minute = 0;
  int second = 0;
  int day = 0;
  int month = 0;
  int year = 0;
  late String period;
  Future<void> listExecutive() async {
    DateTime now = DateTime.now();

    // Extract components
    hour = now.hour;
    minute = now.minute;
    second = now.second;
    day = now.day;
    month = now.month;
    year = now.year;
    period = (hour < 12) ? 'AM' : 'PM';
  }

  Uint8List? getBytes;
  Future<void> getImageMap(index, List list) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/staticmap?center=${list[index]['latlong_log']},${list[index]['latlong_la']}&zoom=16&size=1080x920&maptype=normal&markers=color:red%7C%7C${list[index]['latlong_log']},${list[index]['latlong_la']}&key=AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI'));
      getBytes = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 16, 189, 204))),
        onPressed: () async {
          index = int.parse(widget.index);
          await getImageMap(index, widget.list);
          if (getBytes != null) {
            await Printing.layoutPdf(
                onLayout: (format) => geneRatePDF(format, index, widget.list),
                format: PdfPageFormat.a4);
          }
        },
        child: Row(
          children: const [
            Icon(Icons.print),
            Text('Print'),
          ],
        ));
  }

  Future<Uint8List> geneRatePDF(
      PdfPageFormat format, int index, List list) async {
    //////
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: false);
    ByteData bytesImage = await rootBundle.load('assets/images/kfaLogo.png');
    final Uint8List byteListImage = bytesImage.buffer.asUint8List();
    double sizeFont = MediaQuery.textScaleFactorOf(context) * 9;
    double SizeFont = MediaQuery.textScaleFactorOf(context) * 8;
    var sizeBox3 = pw.SizedBox(height: 3);

    pdf.addPage(pw.MultiPage(
        //pageTheme: pageTheme,
        pageTheme: pw.PageTheme(
          //clip: 5,
          pageFormat: PdfPageFormat.a4.portrait,
        ),
        build: (context) {
          return [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(children: [
                    pw.Text('$day/$month/$year, $hour:$minute $period',
                        style: pw.TextStyle(
                            fontSize: sizeFont,
                            fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 20),
                    pw.Text(
                        'Kfanhrm.cc/KFACRM/content/comparable_form/comparable_print.php?comparable_id=${list[index]['comparable_id'].toString()}',
                        style: pw.TextStyle(fontSize: sizeFont))
                  ]),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Container(
                      width: 90,
                      height: 55,
                      child: pw.Image(
                          pw.MemoryImage(
                            byteListImage,
                          ),
                          fit: pw.BoxFit.fill),
                    ),
                    pw.SizedBox(width: 50),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                              'Date of inspection : ${list[index]['comparable_survey_date']}',
                              style: pw.TextStyle(
                                  fontSize: SizeFont,
                                  color: PdfColors.blueGrey900)),
                          sizeBox3,
                          pw.Text(
                              'Address : ${(list[index]['commune_name'].toString() == 'null' ? "" : '${list[index]['commune_name'].toString()},')} ${(list[index]['district_name'].toString() == 'null' ? "" : '${list[index]['district_name'].toString()},')} ${(list[index]['provinces_name'].toString() == 'null' ? "" : '${list[index]['provinces_name'].toString()},')}',
                              style: pw.TextStyle(
                                  fontSize: SizeFont,
                                  color: PdfColors.blueGrey900)),
                          sizeBox3,
                          pw.Text('Owner :',
                              style: pw.TextStyle(
                                  fontSize: SizeFont,
                                  color: PdfColors.blueGrey900)),
                          sizeBox3,
                          pw.Text(
                              'Inspectors : ${(list[index]['agenttype_name'].toString() == 'null' ? "" : '${list[index]['agenttype_name'].toString()}')}',
                              style: pw.TextStyle(
                                  fontSize: SizeFont,
                                  color: PdfColors.blueGrey900)),
                        ])
                  ]),
                  pw.SizedBox(height: 10),
                  if (getBytes != null)
                    pw.Container(
                      width: double.infinity,
                      height: 250,
                      child: pw.Image(
                          pw.MemoryImage(
                            getBytes!,
                          ),
                          fit: pw.BoxFit.cover),
                    )
                  else
                    pw.SizedBox(),
                  pw.SizedBox(height: 10),
                  pw.Text(
                      '${list[index]['property_type_name'].toString()} (${list[index]['comparable_id'].toString()})',
                      style: pw.TextStyle(fontSize: SizeFont)),
                  sizeBox3,
                  pw.Text('${list[index]['comparable_survey_date']}',
                      style: pw.TextStyle(fontSize: SizeFont)),
                  sizeBox3,
                  pw.Text(
                      'LS : ${list[index]['comparable_land_length'].toString()} x ${list[index]['comparable_land_width'].toString()} = ${list[index]['comparable_land_total'].toString()} sqm',
                      style: pw.TextStyle(fontSize: SizeFont)),
                  sizeBox3,
                  pw.Text(
                      'BS : ${list[index]['comparable_sold_length'].toString()} x ${list[index]['comparable_sold_width'].toString()} = ${list[index]['comparable_sold_total'].toString()} sqm',
                      style: pw.TextStyle(fontSize: SizeFont)),
                  sizeBox3,
                  pw.Text(
                      'Asking Price : ${list[index]['comparable_adding_price'].toString()} \$',
                      style: pw.TextStyle(fontSize: SizeFont)),
                  sizeBox3,
                  pw.Text(
                      'Offered Price : ${list[index]['comparableaddprice'].toString()} \$',
                      style: pw.TextStyle(fontSize: SizeFont)),
                  sizeBox3,
                  pw.Text(
                      'Sold Of Price : ${list[index]['comparable_sold_price'].toString()} \$',
                      style: pw.TextStyle(fontSize: SizeFont)),
                  sizeBox3,
                  pw.Text('Tel: ${list[index]['comparable_phone'].toString()}',
                      style: pw.TextStyle(fontSize: SizeFont)),
                ]),
          ];
        }));
    return pdf.save();
  }

  Future<pw.PageTheme> myPageTheme(PdfPageFormat format) async {
    final bgShape = await rootBundle.loadString('assets/resume.svg');

    format = format.applyMargin(
        left: 1.5 * PdfPageFormat.cm,
        top: 1.5 * PdfPageFormat.cm,
        right: 1.5 * PdfPageFormat.cm,
        bottom: 6.5 * PdfPageFormat.cm);
    return pw.PageTheme(
      pageFormat: format,
      theme: pw.ThemeData.withFont(
        base: await PdfGoogleFonts.openSansRegular(),
        bold: await PdfGoogleFonts.openSansBold(),
        icons: await PdfGoogleFonts.materialIcons(),
      ),
      buildBackground: (pw.Context context) {
        return pw.FullPage(
          ignoreMargins: true,
          child: pw.Stack(
            children: [
              pw.Positioned(
                child: pw.SvgImage(svg: bgShape),
                left: 0,
                top: 0,
              ),
              pw.Positioned(
                child: pw.Transform.rotate(
                    angle: pi, child: pw.SvgImage(svg: bgShape)),
                right: 0,
                bottom: 0,
              ),
            ],
          ),
        );
      },
    );
  }
}
