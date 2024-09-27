import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../../components/colors.dart';

class AllowSuccessfuly extends StatefulWidget {
  const AllowSuccessfuly({super.key, required this.list, required this.i});
  final List list;
  final int i;
  @override
  State<AllowSuccessfuly> createState() => _AllowSuccessfulyState();
}

class _AllowSuccessfulyState extends State<AllowSuccessfuly> {
  double? fsvM, fsvN, fx, fn;
  double totalMIN = 0;
  double totalMAX = 0;
  double x = 0, n = 0;
  List land = [];
  Future<void> landBuilding() async {
    double x = 0, n = 0;
    var rs = await http.get(Uri.parse(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_land?verbal_landid=${(widget.list[widget.i]['type_value'] == "T") ? widget.list[widget.i]['protectID'] : widget.list[widget.i]['verbal_id']}',
    ));
    if (rs.statusCode == 200) {
      land = jsonDecode(rs.body);
      setState(() {
        land.sort((a, b) {
          if (a['verbal_land_des'] == 'LS' && b['verbal_land_des'] != 'LS') {
            return -1;
          } else if (a['verbal_land_des'] != 'LS' &&
              b['verbal_land_des'] == 'LS') {
            return 1;
          } else {
            return 0;
          }
        });
      });

      // if (land.isNotEmpty) {
      //   for (var item in land) {
      //     totalMIN = totalMIN +
      //         double.parse(item["verbal_land_minvalue"].toStringAsFixed(2));
      //     totalMAX = totalMAX +
      //         double.parse(item["verbal_land_maxvalue"].toStringAsFixed(2));
    }
    // setState(() {
    // fsvM = (totalMAX *
    //         double.parse(
    //             (widget.list[widget.i]["verbal_con"] ?? 0).toString())) /
    //     100;
    // fsvN = (totalMIN *
    //         double.parse(
    //             (widget.list[widget.i]["verbal_con"] ?? 0).toString())) /
    //     100;

    // if (land.isEmpty) {
    //   totalMIN = 0;
    //   totalMAX = 0;
    // } else {
    //   fx = x *
    //       (double.parse(
    //               (widget.list[widget.i]["verbal_con"] ?? 0).toString()) /
    //           100);
    //   fn = n *
    //       (double.parse(
    //               (widget.list[widget.i]["verbal_con"] ?? 0).toString()) /
    //           100);
    // }

    // for (int i = 0; i < land.length - 1; i++) {
    //   for (int j = i + 1; j < land.length; j++) {
    //     if (land[i]['verbal_land_type'] == 'LS') {
    //       var t = land[i];
    //       land[i] = land[j];
    //       land[j] = t;
    //     }
    //   }
    // }
    //   });
    // } else {}
    // }
  }

  @override
  void initState() {
    landBuilding();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(color: whiteNotFullColor),
            height: 250,
            width: 350,
            child: ListView.builder(
              itemCount: land.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("No.${index + 1}",
                          style: TextStyle(
                              color: greyColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      landCon("DESCRIPTION",
                          "${land[index]['verbal_land_des'] ?? "N/A"}", ""),
                      if (land[index]['verbal_land_des'] != "LS")
                        landCon("Floor",
                            "${land[index]['verbal_land_dp'] ?? ""}", ""),
                      landCon(
                          "AREA/sqm",
                          "${land[index]['verbal_land_area'] ?? ""}",
                          " m\u00B2"),
                      landCon(
                          "MIN/sqm",
                          formatNumber(double.parse(
                                  "${land[index]["verbal_land_minsqm"] ?? 0}"))
                              .toString(),
                          " USD"),
                      landCon(
                          "MAX/sqm",
                          formatNumber(double.parse(
                                  "${land[index]["verbal_land_maxsqm"] ?? 0}"))
                              .toString(),
                          " USD"),
                      landCon(
                          "MIN-VALUE",
                          formatNumber(land[index]["verbal_land_minvalue"] ?? 0)
                              .toString(),
                          " USD"),
                      landCon(
                          "MAX-VALUE",
                          formatNumber(land[index]["verbal_land_maxvalue"] ?? 0)
                              .toString(),
                          " USD"),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String formatNumber(double number) {
    final formatter = NumberFormat('##,###,###,###');
    String formattedNumber =
        formatter.format(double.parse(number.toStringAsFixed(2)));
    return formattedNumber;
  }

  Widget landCon(String title, String value, String type) {
    return SizedBox(
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              height: 30,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Text(
                title,
                style: TextStyle(
                    color: greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              height: 30,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                        color: greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    type,
                    style: TextStyle(
                        color: colorsRed,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
