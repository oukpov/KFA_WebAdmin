// ignore_for_file: unused_field, override_on_non_overriding_member, unnecessary_null_comparison, unused_local_variable, unused_element

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';

import 'edit_brand.dart';

class Brand_list extends StatefulWidget {
  const Brand_list({super.key});

  @override
  State<Brand_list> createState() => _Bank_listState();
}

class _Bank_listState extends State<Brand_list> {
  bool _wait = false;
  Future<void> _bank_list() async {
    _wait = true;
    await Future.wait([bank_list()]);
    setState(() {
      _wait = false;
    });
  }

  bool _wait_search = false;
  Future<void> _bank_search() async {
    _wait_search = true;
    await Future.wait([
      brand_searchp(),
    ]);
    setState(() {
      _wait_search = false;
    });
  }

  @override
  void initState() {
    // setState(() {
    //   bank_list_get!.clear();
    //   bank_list_get;
    // });
    brand_search = [];
    _bank_list();
    super.initState();
  }

  @override
  int on_row = 20;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 22, 13, 160),
          title: Text('Brand List'),
          actions: [
            IconButton(
                onPressed: () async {
                  await Printing.layoutPdf(
                      onLayout: (format) =>
                          _generatePdf(format, bank_list_get!));
                },
                icon: Icon(
                  Icons.print_outlined,
                  size: MediaQuery.of(context).size.height * 0.045,
                )),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: _wait
            ? Center(
                child: CircularProgressIndicator(),
              )
            :
            // ? Text('1')
            // : Text('2')
            SingleChildScrollView(
                child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                value;
                                search = value;
                                _bank_search();
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                              hintText: 'Search listing here...',
                            )),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    padding: EdgeInsets.all(5),
                    child: PaginatedDataTable(
                      horizontalMargin: 5.0,
                      arrowHeadColor: Colors.blueAccent[300],
                      columns: [
                        DataColumn(
                            label: Text(
                          'No',
                          style: TextStyle(color: Colors.green),
                        )),
                        DataColumn(
                            label: Text(
                          'Bank Brand Name',
                          style: TextStyle(color: Colors.green),
                        )),
                        DataColumn(
                            label: Text(
                          'Brand Officer',
                          style: TextStyle(color: Colors.green),
                        )),
                        DataColumn(
                            label: Text(
                          'Brand Contact',
                          style: TextStyle(color: Colors.green),
                        )),
                        DataColumn(
                            label: Text(
                          'address',
                          style: TextStyle(color: Colors.green),
                        )),
                        DataColumn(
                            label: Text(
                          'Create Date',
                          style: TextStyle(color: Colors.green),
                        )),
                      ],
                      dataRowHeight: 50,
                      rowsPerPage: on_row,
                      onRowsPerPageChanged: (value) {
                        setState(() {
                          on_row = value!;
                        });
                      },
                      source: new _DataSource(
                          bank_list_get!, bank_list_get!.length, context),
                    ),
                  ),
                ],
              )));
  }

  List? bank_list_get;
  Future<void> bank_list() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bradlist'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        bank_list_get = jsonBody;
        setState(() {
          bank_list_get;
        });
      } else {
        print('Error bank');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  String? search;
  double h = 0;
  String? dropdown_search;
  List? brand_search;
  Future<void> brand_searchp() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/brand_search?search=$search'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body);
        bank_list_get = jsonBody;
        setState(() {
          bank_list_get;
        });
      } else {
        print('Error bank');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, List items) async {
    // Create a new PDF document
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final ByteData bytes =
        await rootBundle.load('assets/images/New_KFA_Logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(pw.MultiPage(
      orientation: pw.PageOrientation.landscape,
      build: (context) {
        return [
          pw.Padding(
            padding: pw.EdgeInsets.only(top: 0, bottom: 10),
            child: pw.Column(
              children: [
                pw.Container(
                  height: 70,
                  margin: pw.EdgeInsets.only(bottom: 5),
                  child: pw.Row(
                    children: [
                      pw.Container(
                        width: 80,
                        height: 50,
                        // child: pw.Image(
                        //     pw.MemoryImage(
                        //       byteList,
                        //       // bytes1,
                        //     ),
                        //     fit: pw.BoxFit.fill),
                      ),
                      pw.SizedBox(width: 100),
                      pw.Text("Khmer Aooraisal Fuundation",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.SizedBox(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child:
                              // name rest with api
                              pw.Text("No",
                                  style: const pw.TextStyle(fontSize: 10)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          // name rest with api
                          child: pw.Text('Brand Name',
                              style: const pw.TextStyle(fontSize: 10)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          // name rest with api
                          child: pw.Text('Brand Officer',
                              style: const pw.TextStyle(fontSize: 10)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          // name rest with api
                          child: pw.Text('Bank Contact',
                              style: const pw.TextStyle(fontSize: 10)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          // name rest with api
                          child: pw.Text('Address',
                              style: const pw.TextStyle(fontSize: 10)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                for (int i = 0; i < items.length; i++)
                  pw.SizedBox(
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.center,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child:
                                // name rest with api
                                pw.Text("$i",
                                    style: const pw.TextStyle(fontSize: 10)),
                            height: 25,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.center,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child:
                                // name rest with api
                                pw.Text(
                                    "${items[i]['bank_branch_name'] ?? "_"}",
                                    style: const pw.TextStyle(fontSize: 10)),
                            height: 25,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.center,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            // name rest with api
                            child: pw.Text(
                                '${items[i]['bank_brand_officer'] ?? "_"}',
                                style: const pw.TextStyle(fontSize: 10)),
                            height: 25,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.center,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            // name rest with api
                            child: pw.Text(
                                '${items[i]['bank_brand_contact'] ?? "_"}',
                                style: const pw.TextStyle(fontSize: 10)),
                            height: 25,
                            //color: Colors.blue,
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(2),
                            alignment: pw.Alignment.center,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            // name rest with api
                            child: pw.Text(
                                '${items[i]['commune_name'] ?? "_"} , ${items[i]['district_name'] ?? "_"} , ${items[i]['provinces_name'] ?? "_"}',
                                style: const pw.TextStyle(fontSize: 8)),
                            height: 25,
                            //color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          )
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

  Color kImageColor = Color.fromRGBO(169, 203, 56, 1);
}

String? back_value;
List? Refresh_Edit_Page;

class _DataSource extends DataTableSource {
  final List data;

  final int count_row;
  final BuildContext context;
  _DataSource(this.data, this.count_row, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];
    return DataRow(
        selected: true,
        color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return index % 2 == 0
                  ? Color.fromARGB(168, 73, 83, 224)
                  : Colors.white;
            }
            return index % 2 == 0
                ? Color.fromARGB(255, 255, 162, 162)
                : Colors.white;
          },
        ),
        cells: [
          DataCell(
            placeholder: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  index.toString(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {},
          ),
          DataCell(
            Text(
              item['bank_branch_name'].toString(),
              style: TextStyle(fontSize: 10),
            ),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return Edit_brand(
                    Refresh_Edit_one: (value) {
                      back_value = value;
                    },
                    Refresh_Edit: (value) {
                      Refresh_Edit_Page = value;
                    },
                    index_E: index.toString(),
                    list: data,
                  );
                },
              ));
            },
          ),
          DataCell(
            Text(
              item['bank_brand_officer'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return Edit_brand(
                    Refresh_Edit_one: (value) {
                      back_value = value;
                    },
                    Refresh_Edit: (value) {
                      Refresh_Edit_Page = value;
                    },
                    index_E: index.toString(),
                    list: data,
                  );
                },
              ));
            },
          ),
          DataCell(
            Text(
              item['bank_brand_contact'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return Edit_brand(
                    Refresh_Edit_one: (value) {
                      back_value = value;
                    },
                    Refresh_Edit: (value) {
                      Refresh_Edit_Page = value;
                    },
                    index_E: index.toString(),
                    list: data,
                  );
                },
              ));
            },
          ),
          DataCell(
            Text(
              item['bank_branch_village'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return Edit_brand(
                    Refresh_Edit_one: (value) {
                      back_value = value;
                    },
                    Refresh_Edit: (value) {
                      Refresh_Edit_Page = value;
                    },
                    index_E: index.toString(),
                    list: data,
                  );
                },
              ));
            },
          ),
          DataCell(
            Text(
              item['created_at'].toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return Edit_brand(
                    Refresh_Edit_one: (value) {
                      back_value = value;
                    },
                    Refresh_Edit: (value) {
                      Refresh_Edit_Page = value;
                    },
                    index_E: index.toString(),
                    list: data,
                  );
                },
              ));
            },
          ),
        ]);
  }

  @override
  int get rowCount => count_row;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
