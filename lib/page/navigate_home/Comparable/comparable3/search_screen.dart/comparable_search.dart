// ignore_for_file: unused_local_variable, unused_field

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:web_admin/components/road.dart';
import 'package:web_admin/page/navigate_home/Comparable/comparable3/search_screen.dart/search_map_com.dart';
import 'package:web_admin/screen/Property/Map/ToFromDate_ForSale.dart';
import '../../../../../../components/L_w_total.dart';
import '../../../../../../components/property_type.dart';
import '../../../../../../components/province.dart';
import '../../../../../../components/total_dropdown.dart';
import '../../../../../components/colors.dart';
import '../../../../../screen/Profile/components/Drop.dart';

class comparable_search extends StatefulWidget {
  const comparable_search({super.key});

  @override
  State<comparable_search> createState() => _comparable_searchState();
}

class _comparable_searchState extends State<comparable_search> {
  List option = const [
    "Bank Officer",
    "bank Contact",
  ];
  List<Icon> optionIconList = const [
    Icon(
      Icons.branding_watermark_outlined,
      color: kImageColor,
    ),
    Icon(
      Icons.account_balance_outlined,
      color: kImageColor,
    ),
  ];
  String? bankname = '';
  String? bank_brand = '';
  String? bank_officer = '';
  String? bank_contact = '';
  String? property_type = '';
  String? id_road = '';
  String? l = '';
  String? w = '';
  String? total = '';
  String? askingprice = '';
  String? sqm_total = '';
  String? Amount = '';
  String? songkat = '';
  String? provice_map = '';
  String? khan = '';
  String? log = '';
  String? lat = '';
  TextEditingController? _log;
  TextEditingController? _lat;
  String? provnce_id = '';
  String? district_id = '';
  String? cummune_id = '';
  String? lb = '';
  String? wb = '';
  String? total_b = '';
  String? officer_price = '';
  String? officer_price_total = '';
  String? sold_price = '';
  String? total_price = '';
  String? condition = '';
  String? year = '';
  String? remak = '';
  String? con_user = '';
  String? start = '';
  String? end = '';

  List _condition = [
    {
      'id': 1,
      'Condition': 'Condition 1',
    },
    {
      'id': 2,
      'Condition': 'Condition 2',
    }
  ];
  String? search = '';
  String? hie = '0';
  String? hie1 = '30';
  @override
  Widget build(BuildContext context) {
    double textstye = MediaQuery.of(context).size.height * 0.07;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple[900],
          centerTitle: true,
          title: Text('Comparable Search'),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Map_Search_Comparable(
                      property_type: property_type,
                      Amount: Amount,
                      officer_price: officer_price,
                      officer_price_total: officer_price_total,
                      sold_price: sold_price,
                      condition: condition,
                      total_price: total_price,
                      w: w,
                      id_road: id_road,
                      bank_officer: bank_officer,
                      year: year,
                      con_user: con_user,
                      total: total,
                      l: l,
                      total_b: total_b,
                      wb: wb,
                      lb: lb,
                      cummune_id: cummune_id,
                      district_id: district_id,
                      provice_map: provnce_id,
                      bankname: bankname,
                      sqm_total: sqm_total,
                      bank_brand: bank_brand,
                      askingprice: askingprice,
                      lat: lat,
                      log: log,
                      start: start,
                      end: end,
                      hh_: '30',
                      get_commune: (value) {},
                      get_district: (value) {},
                      get_lat: (value) {
                        setState(() {
                          lat = value;
                        });
                      },
                      get_log: (value) {
                        setState(() {
                          log = value;
                        });
                      },
                      get_max1: (value) {},
                      get_max2: (value) {},
                      get_min1: (value) {},
                      get_min2: (value) {},
                      get_province: (value) {},
                    );
                  },
                ));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 12, 145, 37),
                    borderRadius: BorderRadius.circular(10)),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text(
                  'Search',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(bankname.toString()),
            SizedBox(
              height: 20,
            ),
            BankDropdown(
              bank: (value) {
                setState(() {
                  bankname = '&compare_bank_id=$value';
                });
              },
              bankbranch: (value) {
                setState(() {
                  bank_brand = '&compare_bank_branch_id=$value';
                });
              },
            ),
            for (int i = 0; i < option.length; i++)
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                child: Container(
                  child: TextFormField(
                    keyboardType: (i == 1) ? TextInputType.number : null,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      setState(() {
                        if (i == 0) {
                          (bank_officer = '&com_bankofficer=$value');
                        } else if (i == 1) {
                          (bank_contact = '&com_bankofficer_contact=$value');
                        }
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      prefixIcon: optionIconList.elementAt(i),
                      hintText: option.elementAt(i).toString(),
                      fillColor: kwhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            property_hoemtype(
              hometype: (value) {
                setState(() {
                  property_type = '&comparable_property_id=$value';
                });
              },
              hometype_lable: property_type,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: RoadDropdown(
                id_road: (value) {
                  id_road = '&comparable_road=$value';
                },
                Name_road: (value) {},
                lable: '',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 10),
              child: Text(
                'Land',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.022),
              ),
            ),
            Land_building(
              l: (value) {
                setState(() {
                  l = '&comparable_land_length=$value';
                });
              },
              total: (value) {
                setState(() {
                  total = '&comparable_land_total=$value';
                });
              },
              w: (value) {
                setState(() {
                  w = '&comparable_land_width=$value';
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 10, top: 10),
              child: Text(
                'Price Per SQM',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.022),
              ),
            ),
            Total_dropdown(
              input: (value) {
                setState(() {
                  askingprice = '&comparable_adding_price=$value';
                });
              },
              total_type: (value) {
                setState(() {
                  sqm_total = '&comparableaddpricetotal=$value';
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, bottom: 10, top: 10),
              child: Container(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold),
                  onChanged: (value) {
                    setState(() {
                      Amount = '&comparableAmount=$value';
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    prefixIcon: Icon(
                      Icons.question_answer_outlined,
                      color: kImageColor,
                    ),
                    hintText: 'Asking Price(TTAmount)',
                    fillColor: kwhite,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: Map_Search_Comparable(
                  hh_: hie,
                  get_commune: (value) {},
                  get_district: (value) {},
                  get_lat: (value) {
                    setState(() {
                      lat = value;
                    });
                  },
                  get_log: (value) {
                    setState(() {
                      log = value;
                    });
                  },
                  get_max1: (value) {},
                  get_max2: (value) {},
                  get_min1: (value) {},
                  get_min2: (value) {},
                  get_province: (value) {},
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ToFromDate_p(
              fromDate: (value) {
                setState(() {
                  start = value.toString();
                  start;
                });
              },
              toDate: (value) {
                setState(() {
                  end = value.toString();
                  end;
                });
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     top: 10,
            //     right: 30,
            //     left: 30,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         width: MediaQuery.of(context).size.width * 0.4,
            //         child: TextFormField(
            //           controller: _log,
            //           keyboardType: TextInputType.number,
            //           style: TextStyle(
            //               fontSize: MediaQuery.of(context).size.height * 0.015,
            //               fontWeight: FontWeight.bold),
            //           onChanged: (value) {
            //             setState(() {
            //               // bankcontact = value;
            //               // log = _log!.text;
            //             });
            //           },
            //           decoration: InputDecoration(
            //             prefixIcon: Icon(
            //               Icons.numbers_outlined,
            //               color: kImageColor,
            //             ),
            //             hintText: "log",
            //             contentPadding: EdgeInsets.symmetric(vertical: 8),

            //             fillColor: kwhite,
            //             // hintText: (bankcontact == null || bankcontact == '')
            //             //     ? '${widget.list![index_edit]['bankcontact'].toString()}'
            //             //     : bankcontact,
            //             filled: true,
            //             focusedBorder: OutlineInputBorder(
            //               borderSide: const BorderSide(
            //                   color: kPrimaryColor, width: 2.0),
            //               borderRadius: BorderRadius.circular(10.0),
            //             ),
            //             enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(
            //                 width: 1,
            //                 color: kPrimaryColor,
            //               ),
            //               borderRadius: BorderRadius.circular(10.0),
            //             ),
            //           ),
            //         ),
            //       ),
            //       // Container(
            //       //   width: MediaQuery.of(context).size.width * 0.4,
            //       //   child: TextFormField(
            //       //     controller: _lat,
            //       //     keyboardType: TextInputType.number,
            //       //     style: TextStyle(
            //       //         fontSize: MediaQuery.of(context).size.height * 0.015,
            //       //         fontWeight: FontWeight.bold),
            //       //     onChanged: (value) {
            //       //       setState(() {
            //       //         if (value != '') {
            //       //       log = '&comparableAmount=$value';
            //       //     } else {
            //       //       Amount = '';
            //       //     }
            //       //       });
            //       //     },
            //       //     decoration: InputDecoration(
            //       //       hintText: "lat",
            //       //       contentPadding: EdgeInsets.symmetric(vertical: 8),
            //       //       prefixIcon: Icon(
            //       //         Icons.numbers_outlined,
            //       //         color: kImageColor,
            //       //       ),
            //       //       fillColor: kwhite,
            //       //       // hintText: (bankcontact == null || bankcontact == '')
            //       //       //     ? '${widget.list![index_edit]['bankcontact'].toString()}'
            //       //       //     : bankcontact,
            //       //       filled: true,
            //       //       focusedBorder: OutlineInputBorder(
            //       //         borderSide: const BorderSide(
            //       //             color: kPrimaryColor, width: 2.0),
            //       //         borderRadius: BorderRadius.circular(10.0),
            //       //       ),
            //       //       enabledBorder: OutlineInputBorder(
            //       //         borderSide: BorderSide(
            //       //           width: 1,
            //       //           color: kPrimaryColor,
            //       //         ),
            //       //         borderRadius: BorderRadius.circular(10.0),
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Province_dropdown(
              cummone_id0: null,
              district_id0: null,
              province_id0: null,
              provicne_id: (value) {
                setState(() {
                  // provnce_id = value;
                  if (value != null) {
                    provnce_id = '&comparable_province_id=$value';
                  } else {
                    provnce_id = '';
                  }
                });
              },
              cummone_id: (value) {
                setState(() {
                  // cummune_id = value.toString();
                  if (value != null) {
                    cummune_id = '&comparable_commune_id=$value';
                  } else {
                    cummune_id = '';
                  }
                });
              },
              district_id: (value) {
                setState(() {
                  // district_id = value.toString();
                  // district_id;
                  if (value != null) {
                    district_id = '&comparable_district_id=$value';
                  } else {
                    district_id = '';
                  }
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
              child: Text(
                'Building',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.022),
              ),
            ),
            Land_building(
              l: (value) {
                setState(() {
                  lb = '&comparable_sold_length=$value';
                });
              },
              total: (value) {
                setState(() {
                  total_b = '&comparable_sold_total=$value';
                });
              },
              w: (value) {
                setState(() {
                  wb = '&comparable_sold_width=$value';
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 10, top: 10),
              child: Text(
                'Offered Price',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.022),
              ),
            ),
            Total_dropdown(
              input: (value) {
                setState(() {
                  // officer_price = value;
                  officer_price = '&comparable_sold_price=$value';
                });
              },
              total_type: (value) {
                setState(() {
                  // officer_price_total = value;

                  officer_price_total = '&comparable_sold_total_price=$value';
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 10, top: 10),
              child: Text(
                'Sold Out Price',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.022),
              ),
            ),
            Total_dropdown(
              input: (value) {
                setState(() {
                  sold_price = '&comparableaddprice=$value';

                  // sold_price = value;
                });
              },
              total_type: (value) {
                setState(() {
                  // total_price = value;
                  total_price = '&comparableaddpricetotal=$value';
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.height * 0.2,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          condition = '&comparable_condition_id=$newValue';
                        });
                      },
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please select';
                        }
                        return null;
                      },
                      items: _condition
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                              value: value['id'].toString(),
                              child: Text(
                                value['Condition'].toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.textScaleFactorOf(context) *
                                            13,
                                    height: 1),
                              ),
                            ),
                          )
                          .toList(),
                      // add extra sugar..
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: kImageColor,
                      ),

                      decoration: InputDecoration(
                        fillColor: kwhite,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        prefixIcon: Icon(
                          Icons.landscape_outlined,
                          color: kImageColor,
                        ),
                        labelText: 'Condition',
                        hintText: 'select',

                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kerror,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: kerror,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        //   decoration: InputDecoration(
                        //       labelText: 'From',
                        //       prefixIcon: Icon(Icons.business_outlined)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        setState(() {
                          year = '&comparable_year=$value';
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        prefixIcon: Icon(
                          Icons.calendar_month,
                          color: kImageColor,
                        ),
                        hintText: 'Year',
                        fillColor: kwhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 30, left: 30, top: 10, bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.height * 0.75,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold),
                  onChanged: (value) {
                    setState(() {
                      con_user = '&comparable_phone=$value';
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: kImageColor,
                    ),
                    hintText: 'Owner Phone *',
                    fillColor: kwhite,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_comparable/$lat/$log?start=${start}&end=${end}&comparable_id=287036
  List<Map<String, dynamic>> dataOfVerbal = [];
  Future<void> Get_data_Comparable() async {
    setState(() {});
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_comparable/$lat/$log?start=${start}&end=${end}'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        dataOfVerbal = List<Map<String, dynamic>>.from(jsonResponse);
        dataOfVerbal;
        print(dataOfVerbal.toString());
        print(dataOfVerbal.toString());
      });
    }
  }
}
// https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/search_comparable/12.123123/104.12312?start=2021-06-14&end=2023-06-14&num=10