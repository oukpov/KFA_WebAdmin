// ignore_for_file: prefer_const_constructors, unused_element, unused_local_variable, non_constant_identifier_names, camel_case_types, must_be_immutable, use_build_context_synchronously, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class Print_screen extends StatefulWidget {
  Print_screen(
      {super.key,
      required this.list,
      required this.verbal_ID,
      required this.index});
  List list = [];
  String? verbal_ID;
  String? index;

  @override
  State<Print_screen> createState() => _Print_screenState();
}

class _Print_screenState extends State<Print_screen> {
  int index = 0;
  int? myMatch;

  @override
  void initState() {
    super.initState();
    index = int.parse(widget.index.toString());

    // print(myMatch);
  }

  Uint8List? get_bytes;
  Uint8List? get_bytes2;
  Uint8List? get_bytes3;
  Future<void> getimage_m(url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      get_bytes = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  Future<void> getimage_m2(url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      get_bytes2 = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  Future<void> getimage_m3(url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      get_bytes3 = response.bodyBytes;
    } catch (e) {
      throw Exception("Error getting bytes from URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await getimage_m(widget.list[index]['url'].toString());
          await getimage_m3(widget.list[index]['url_1'].toString());
          await getimage_m2(widget.list[index]['url_2'].toString());
          await Printing.layoutPdf(
              onLayout: (format) => generatePDF(
                  format, int.parse(widget.index.toString()), widget.list),
              format: PdfPageFormat.a4);
        },
        icon: Icon(
          Icons.print_outlined,
          size: 50,
        ));
  }

  Future<Uint8List> generatePDF(
      PdfPageFormat format, int index, List list) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: false);
    final ByteData bytes_image =
        await rootBundle.load('assets/images/kfaLogo.png');
    final Uint8List byteList_image = bytes_image.buffer.asUint8List();
    PdfDocument document = PdfDocument();
    final ByteData ice_b = await rootBundle.load('assets/icons/ice.png');
    final Uint8List icon = ice_b.buffer.asUint8List();
    final ByteData Size_b = await rootBundle.load('assets/icons/Size.png');
    final Uint8List Size = Size_b.buffer.asUint8List();
    final ByteData livingroom_b =
        await rootBundle.load('assets/icons/living_room.png');
    final Uint8List livingroom = livingroom_b.buffer.asUint8List();
    final ByteData house_type_b =
        await rootBundle.load('assets/icons/house.png');
    final Uint8List house_type = house_type_b.buffer.asUint8List();
    final ByteData area_b = await rootBundle.load('assets/icons/area.png');
    final Uint8List area = area_b.buffer.asUint8List();
    final ByteData total_area_b =
        await rootBundle.load('assets/icons/total_area.png');
    final Uint8List total_area = total_area_b.buffer.asUint8List();
    final ByteData Size_house_b =
        await rootBundle.load('assets/icons/size_house.png');
    final Uint8List Size_house = Size_house_b.buffer.asUint8List();
    final ByteData floor_b = await rootBundle.load('assets/icons/floor.png');
    final Uint8List floor = floor_b.buffer.asUint8List();
    final ByteData parking_b =
        await rootBundle.load('assets/icons/parking.png');
    final Uint8List parking = parking_b.buffer.asUint8List();
    final ByteData lot_b = await rootBundle.load('assets/icons/lot.png');
    final Uint8List lot = lot_b.buffer.asUint8List();
    final ByteData price_sqm_b = await rootBundle.load('assets/icons/Size.png');
    final Uint8List price_sqm = price_sqm_b.buffer.asUint8List();
    final ByteData bath_b = await rootBundle.load('assets/icons/bath.png');
    final Uint8List bath = bath_b.buffer.asUint8List();
    final ByteData bed_b = await rootBundle.load('assets/icons/bed.png');
    final Uint8List bed = bed_b.buffer.asUint8List();
    final ByteData web_b = await rootBundle.load('assets/icons/web_icons.png');
    final Uint8List web = web_b.buffer.asUint8List();
    final ByteData gmail_b =
        await rootBundle.load('assets/icons/gmail_icon.png');
    final Uint8List gmail = gmail_b.buffer.asUint8List();
    final ByteData arrow_b =
        await rootBundle.load('assets/icons/arrow_icons.png');
    final Uint8List arrow = arrow_b.buffer.asUint8List();
    final ByteData phone_b =
        await rootBundle.load('assets/icons/phone_icon.png');
    final Uint8List phone = phone_b.buffer.asUint8List();
    final ByteData aircon_type_b =
        await rootBundle.load('assets/icons/ice.png');
    final Uint8List aircon_type = aircon_type_b.buffer.asUint8List();
    //****************************************************************** */
    // //ICons

    final pageThemes = await _myPageTheme(format);
    ///////////
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(DateTime.now());
    var styp_text = pw.TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.013,
        color: PdfColors.grey600);
    var styp_text_ = pw.TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.007,
        color: PdfColors.grey900);
    var styp_address = pw.TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.01,
        color: PdfColors.grey900);
    var color_text = pw.TextStyle(
        color: PdfColors.grey800,
        fontSize: MediaQuery.of(context).size.height * 0.01);
    var Sizebox_2 = pw.SizedBox(height: 2);
    var Sizebox_2w = pw.SizedBox(width: 2);
    var Sizebox_10w = pw.SizedBox(width: 10);
    var Sizebox_5 = pw.SizedBox(height: 5);
    var Sizebox_10 = pw.SizedBox(height: 10);
    var font_ds = pw.TextStyle(
        color: PdfColors.grey800,
        fontSize: MediaQuery.of(context).size.height * 0.007);
    var items = list[index];
    pw.Widget icon_ds(icon, value) {
      return pw.Row(children: [
        pw.Container(
          width: 10,
          height: 9,
          child: pw.Image(
              pw.MemoryImage(
                // ${items![index]['price'].toString()}
                icon,
              ),
              fit: pw.BoxFit.cover),
        ),
        Sizebox_2w,
        pw.Text('$value', style: font_ds),
      ]);
    }

    pw.Widget icon_text(icon, text, value) {
      return pw.Container(
        child: pw.Row(
          children: [
            pw.Container(
              child: pw.Image(
                  width: 25,
                  height: 25,
                  pw.MemoryImage(
                    // ${items![index]['price'].toString()}
                    icon,
                  ),
                  fit: pw.BoxFit.cover),
            ),
            Sizebox_2w,
            pw.Container(
              alignment: pw.Alignment.center,
              width: 25,
              height: 30,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('$text',
                      style: pw.TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.006,
                          color: PdfColors.grey800)),
                  Sizebox_2,
                  pw.Text('$value',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.006,
                          color: PdfColors.grey800)),
                ],
              ),
            )
          ],
        ),
      );
    }

    pw.Widget _Text(value) {
      return pw.Text('$value',
          style: pw.TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.015));
    }

    pdf.addPage(pw.MultiPage(
        //pageTheme: pageTheme,
        pageTheme: pw.PageTheme(
          //clip: 5,
          pageFormat: PdfPageFormat.a4.landscape,
        ),
        build: (context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  //color: PdfColors.blue100,
                  height: 50,
                  // margin: pw.EdgeInsets.only(bottom: 5),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(
                        width: 70,
                        height: 40,
                        child: pw.Image(
                            pw.MemoryImage(
                              byteList_image,
                              // get_bytes!,
                            ),
                            fit: pw.BoxFit.fill),
                      ),
                      pw.Text("Last Date: $formatted",
                          style: pw.TextStyle(fontSize: 12)),
                      // pw.SizedBox(
                      //   width: 100
                      // ),
                      pw.Text("Print Date: $formatted",
                          style: pw.TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                pw.Divider(height: 0.6),
                Sizebox_10,
                pw.Text('${items['type']} ${items['urgent']}',
                    style: styp_text),
                pw.Text('address : ${items['address']}', style: styp_address),
                pw.Row(
                    // mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                width: 360,
                                height: 190,
                                child: pw.Image(
                                    pw.MemoryImage(
                                      //  image_i,
                                      get_bytes!,
                                    ),
                                    fit: pw.BoxFit.cover),
                              ),

                              Sizebox_5,
                              // pw.Row(
                              //     mainAxisAlignment: pw.MainAxisAlignment.start,
                              //     children: [
                              //       (widget.list[index]['url_1'] != null)
                              //           ? pw.Container(
                              //               width: 80,
                              //               height: 80,
                              //               child: pw.Image(
                              //                   pw.MemoryImage(
                              //                     //  image_i,
                              //                     get_bytes3!,
                              //                   ),
                              //                   fit: pw.BoxFit.cover),
                              //             )
                              //           : pw.SizedBox(),
                              //       Sizebox_10w,
                              //       (widget.list[index]['url_2'] != null)
                              //           ? pw.Container(
                              //               width: 80,
                              //               height: 80,
                              //               child: pw.Image(
                              //                   pw.MemoryImage(
                              //                     //  image_i,
                              //                     get_bytes2!,
                              //                   ),
                              //                   fit: pw.BoxFit.cover),
                              //             )
                              //           : pw.SizedBox(),
                              //     ]),
                              Sizebox_5,
                              pw.Text(
                                'CONTACT AGENT',
                                style: color_text,
                                textAlign: pw.TextAlign.right,
                              ),
                              pw.SizedBox(
                                height: 3,
                              ),
                              pw.Text(
                                  'Verbal Check Replied By: ${items['id_ptys']}',
                                  style: styp_text_,
                                  textAlign: pw.TextAlign.right),
                              Sizebox_5,
                              pw.Text('KHMER FOUNDATION APPRAISALS Co.,Ltd',
                                  style: pw.TextStyle(
                                      color: PdfColors.blueAccent100,
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 10)),
                              Sizebox_5,

                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('Hotline: 077 997 888',
                                      style: styp_text_),
                                  Sizebox_2,
                                  pw.Text(
                                      'H/P : (+855) 23 988 855 / (+855)23 999 761',
                                      style: styp_text_),
                                  Sizebox_2,
                                  pw.Text('Email : info@kfa.com.kh',
                                      style: styp_text_),
                                  Sizebox_2,
                                  pw.Text('Website: www.kfa.com.kh',
                                      style: styp_text_),
                                ],
                              ),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                      'Villa #36A, Street No4, (Borey Peng Hout The Star',
                                      style: styp_text_),
                                  Sizebox_2,
                                  pw.Text(
                                      'Natural 371) Sangkat Chak Angrae Leu,',
                                      style: styp_text_),
                                  Sizebox_2,
                                  pw.Text(
                                      'Khan Mean Chey, Phnom Penh City, Cambodia,',
                                      style: styp_text_),
                                ],
                              ),
                            ]),
                      ),
                      pw.Divider(
                        height: 5,
                      ),
                      ////////value left
                      pw.Expanded(
                        flex: 3,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            Sizebox_2,
                            pw.Padding(
                              padding: pw.EdgeInsets.only(left: 10),
                              child: pw.Text("FACE AND FEATURES",
                                  textAlign: pw.TextAlign.center,
                                  style: styp_text),
                            ),
                            Sizebox_10,
                            pw.Divider(
                              height: 0.009,
                            ),
                            Sizebox_5,
                            pw.Container(
                                height: 350,
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.07, color: PdfColors.grey100),
                                  color: PdfColors.grey50,
                                ),
                                child: pw.Padding(
                                  padding: pw.EdgeInsets.only(left: 10),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceEvenly,
                                          children: [
                                            icon_text(house_type, 'Type',
                                                '${items['hometype'] ?? ""}'),
                                            icon_text(bed, 'Bed',
                                                '${items['bed'] ?? ""}'),
                                            icon_text(bath, 'bath',
                                                '${items['bath'] ?? ""}'),
                                            icon_text(lot, 'Lot(sqm)',
                                                '${items['land'] ?? ""}'),
                                            icon_text(lot, 'Size(sqm)',
                                                '${items['size_house'] ?? ""}'),
                                            icon_text(
                                                area,
                                                'Private_Area(${' m' + '\u00B2'})',
                                                '${items['Private_Area'] ?? ""}'),
                                          ]),
                                      Sizebox_5,
                                      pw.Divider(
                                          height: 0.7,
                                          color: PdfColors.grey200),
                                      Sizebox_5,
                                      pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceEvenly,
                                          children: [
                                            icon_text(parking, 'Parking',
                                                '${items['Parking'] ?? ""}'),
                                            icon_text(floor, 'Floor',
                                                '${items['floor'] ?? ""}'),
                                            icon_text(livingroom, 'Livingroom',
                                                '${items['Livingroom'] ?? ""}'),
                                            icon_text(price_sqm, 'price(sqm)',
                                                '${items['price_sqm'] ?? ""}'),
                                            icon_text(aircon_type, 'Aircon',
                                                '${items['aircon'] ?? ""}'),
                                            icon_text(
                                                total_area,
                                                'TotalArea(${' m' + '\u00B2'})',
                                                '${items['total_area'] ?? ""}'),
                                          ]),
                                      pw.Divider(
                                          height: 1, color: PdfColors.grey400),
                                      Sizebox_10,
                                      pw.Row(children: [
                                        pw.Text('${items['type'] ?? "N/A"} > ',
                                            style: pw.TextStyle(
                                              color: PdfColors.blue300,
                                              fontSize: 12,
                                            )),
                                        pw.Text('\$${items['price'] ?? "0"}',
                                            style: pw.TextStyle(
                                              color: PdfColors.red800,
                                              fontSize: 12,
                                            )),
                                      ]),
                                      Sizebox_10,
                                      _type(items),
                                      Sizebox_10,
                                      pw.Padding(
                                          padding: pw.EdgeInsets.only(left: 10),
                                          child: pw.Column(children: [
                                            pw.Row(children: [
                                              _text_dc('PROPERTY DESCRIPTION'),
                                              Sizebox_10,
                                            ]),
                                            icon_ds(arrow,
                                                ' Price : \$${items['price'] ?? ""} (Negotiate)'),
                                            Sizebox_2w,
                                            icon_ds(arrow,
                                                ' Bed : ${items['bed'] ?? ""}'),
                                            Sizebox_2w,
                                            icon_ds(arrow,
                                                ' Bath : ${items['bath'] ?? ""}'),
                                            Sizebox_5,
                                            icon_ds(
                                              arrow,
                                              'Size House : ${items['Size_l'] ?? ""} x ${items['size_w'] ?? ""} = ${items['size_house'] ?? ""}' +
                                                  ' m' +
                                                  '\u00B2',
                                            ),
                                            Sizebox_5,
                                            icon_ds(
                                              arrow,
                                              'Size Land : ${items['land_l'] ?? ""} x ${items['land_w'] ?? ""} = ${items['land'] ?? ""}' +
                                                  ' m' +
                                                  '\u00B2',
                                            ),
                                            Sizebox_5,
                                            icon_ds(
                                              arrow,
                                              'Issuance of transfer service (hard copy)',
                                            ),
                                            Sizebox_5,
                                            pw.Row(children: [
                                              icon_ds(
                                                phone,
                                                '(CellCard) : 077 216 168',
                                              ),
                                              pw.SizedBox(width: 5),
                                              icon_ds(
                                                phone,
                                                '(Officer) : 023 999 855 | 023 988 911',
                                              ),
                                            ]),
                                            Sizebox_5,
                                            pw.Row(children: [
                                              icon_ds(
                                                web,
                                                'https://kfa.com.kh/contacts',
                                              ),
                                              Sizebox_2w,
                                              icon_ds(
                                                gmail,
                                                'info@kfa.com.kh',
                                              ),
                                            ]),
                                            Sizebox_5,
                                            pw.Text(
                                                "Text * Note: It is only first price which you took from this verbal check data. The accurate value of property when we have the actual site property inspection.We are not responsible for this case when you provided the wrong land and building size or any fraud.Note: It is only first price which you took from this verbal check data. The accurate value of property when we have the actual site property inspection.We are not responsible for this case when you provided the wrong land and building size or any fraud.",
                                                style: styp_text_,
                                                maxLines: 5),
                                          ])),
                                      Sizebox_10,
                                      pw.Padding(
                                          padding: pw.EdgeInsets.only(left: 10),
                                          child: pw.Column(children: [
                                            pw.Row(children: [
                                              _text_dc('PROPERTY DESCRIPTION'),
                                              Sizebox_10,
                                            ]),
                                            icon_ds(arrow,
                                                ' Price : \$${items['price'] ?? ""} (Negotiate)'),
                                            Sizebox_2w,
                                            icon_ds(arrow,
                                                ' Bed : ${items['bed'] ?? ""}'),
                                            Sizebox_2w,
                                            icon_ds(arrow,
                                                ' Bath : ${items['bath'] ?? ""}'),
                                            Sizebox_5,
                                            icon_ds(
                                              arrow,
                                              'Size House : ${items['Size_l'] ?? ""} x ${items['size_w'] ?? ""} = ${items['size_house'] ?? ""}' +
                                                  ' m' +
                                                  '\u00B2',
                                            ),
                                            Sizebox_5,
                                            icon_ds(
                                              arrow,
                                              'Size Land : ${items['land_l'] ?? ""} x ${items['land_w'] ?? ""} = ${items['land'] ?? ""}' +
                                                  ' m' +
                                                  '\u00B2',
                                            ),
                                            Sizebox_5,
                                            icon_ds(
                                              arrow,
                                              'Issuance of transfer service (hard copy)',
                                            ),
                                            Sizebox_5,
                                            pw.Row(children: [
                                              icon_ds(
                                                phone,
                                                '(CellCard) : 077 216 168',
                                              ),
                                              pw.SizedBox(width: 5),
                                              icon_ds(
                                                phone,
                                                '(Officer) : 023 999 855 | 023 988 911',
                                              ),
                                            ]),
                                            Sizebox_5,
                                            pw.Row(children: [
                                              icon_ds(
                                                web,
                                                'https://kfa.com.kh/contacts',
                                              ),
                                              Sizebox_2w,
                                              icon_ds(
                                                gmail,
                                                'info@kfa.com.kh',
                                              ),
                                            ]),
                                            Sizebox_5,
                                            pw.Text(
                                                "Text * Note: It is only first price which you took from this verbal check data. The accurate value of property when we have the actual site property inspection.We are not responsible for this case when you provided the wrong land and building size or any fraud.Note: It is only first price which you took from this verbal check data. The accurate value of property when we have the actual site property inspection.We are not responsible for this case when you provided the wrong land and building size or any fraud.",
                                                style: styp_text_,
                                                maxLines: 5),
                                          ])),
                                      //Discription
                                      Reach_US(),
                                      // pw.Container(
                                      //     height: 100,
                                      //     width: 340,
                                      //     child: pw.Column(
                                      //         crossAxisAlignment:
                                      //             pw.CrossAxisAlignment.start,
                                      //         children: [
                                      //           // pw.Text(
                                      //           //     "${widget.list[index]['description'] ?? ""}",
                                      //           //     style: font_ds,
                                      //           //     maxLines: 30),
                                      //           pw.Text(
                                      //               "Text*Note: It is only first price which you took from this verbal check data. The accurate value of property when we have the actual site property inspection.We are not responsible for this case when you provided the wrong land and building size or any fraud.Note: It is only first price which you took from this verbal check data. The accurate value of property when we have the actual site property inspection.We are not responsible for this case when you provided the wrong land and building size or any fraud.",
                                      //               style: font_ds,
                                      //               maxLines: 30)
                                      //         ])),
                                      pw.SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      )
                    ]),
              ],
            ),
          ];
        }));
    return pdf.save();
  }

  pw.Widget _type(items) {
    return pw.Container(
        height: 20,
        width: double.infinity,
        decoration: pw.BoxDecoration(
            color: PdfColors.grey100,
            border: pw.Border.all(
              width: 0.03,
              color: PdfColors.grey400,
            )),
        child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.SizedBox(width: 1),
          pw.Container(height: 15, color: PdfColors.blue300, width: 4),
          pw.SizedBox(width: 3),
          pw.Text('${items['type'] ?? ""} > ',
              style: pw.TextStyle(color: PdfColors.blue, fontSize: 8)),
          pw.Text('\$${items['price'] ?? ""}',
              style: pw.TextStyle(color: PdfColors.red, fontSize: 8)),
        ]));
  }

  pw.Widget _text_dc(text) {
    return pw.Text(
      text,
      style: pw.TextStyle(
          fontSize: 9,
          color: PdfColors.grey700,
          fontWeight: pw.FontWeight.bold),
    );
  }

  pw.Widget Reach_US() {
    return pw.Padding(
        padding: pw.EdgeInsets.only(left: 10),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              '(Reach Us) : #36A, St.04 Borey Peng Hourt The Star Natural. Sangkat Chakangre Leu, Khan Meanchey, Phnom Penh.',
              style: pw.TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.012),
              maxLines: 4,
            ),
          ],
        ));
  }
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
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
