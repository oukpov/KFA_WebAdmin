// ignore_for_file: unused_field, unused_element, unused_local_variable, equal_keys_in_map

import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../components/property_type.dart';
import '../../../../../components/province.dart';
import '../../../../components/L_w_total.dart';
import '../../../../components/bank.dart';
<<<<<<< HEAD:lib/interface/navigate_home/Comparable/comparable_1/New_Comparable.dart
import '../../../../components/colors.dart';
=======
import '../../../../components/road.dart';
>>>>>>> 4df899fe5c5b7786128f08f07b8f4c937ba094bc:lib/page/navigate_home/Comparable/comparable_1/New_Comparable.dart
import '../../../../components/total_dropdown.dart';
import '../../../../screen/Property/Map/map_in_add_verbal.dart';

class New_Comparable extends StatefulWidget {
  const New_Comparable({super.key});

  @override
  State<New_Comparable> createState() => _New_ComparableState();
}

class _New_ComparableState extends State<New_Comparable> {
  @override
  void initState() {
    super.initState();
    _textController.text;
  }

  List option = const [
    "Bank Officer",
    "bank Contact",
  ];
  List option_ps = const [
    "sdfsdf",
    "sdfs",
  ];
  List option_p = const [
    "Price Per SQM",
    "Offered Price",
    "Offered Price",
    "Sold Out Price",
  ];
  List land = [
    "L",
    "W",
    "Total",
  ];
  String? provnce_id;
  String? songkat;
  String? provice_map;
  String? khan;
  String? log;
  String? lat;
  String? value_d;
  TextEditingController? _log;
  TextEditingController? _lat;
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
  String? province_id;
  String? district_id;
  String? cummune_id;
  String? l;
  String? w;
  String? total;
  String? lb;
  String? wb;
  String? total_b;
  String? bankname;
  String? bank_brand;
  String? bank_officer = '';
  String? bank_contact;
  String? property_type;
  String? id_road;
  String? year;
  TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double textstye = MediaQuery.of(context).size.height * 0.07;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[900],
        title: Text('New Commparable'),
        actions: [
          InkWell(
            onTap: () {
              if (property_type != null &&
                  bankname != null &&
                  lat != null &&
                  log != null &&
                  cummune_id != null &&
                  provnce_id != null &&
                  district_id != null &&
                  total != null) {
                AwesomeDialog(
                    context: context,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dialogType: DialogType.success,
                    showCloseIcon: false,
                    title: 'Save Successfully',
                    autoHide: Duration(seconds: 3),
                    onDismissCallback: (type) {
                      setState(() {
                        Comparable_new();
                      });
                      Navigator.pop(context);
                    }).show();
              } else {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  headerAnimationLoop: false,
                  title: 'Error',
                  desc: "Please check ",
                  btnOkOnPress: () {},
                  btnOkIcon: Icons.cancel,
                  btnOkColor: Colors.red,
                ).show();
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 32, 167, 8)),
              child: Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            BankDropdown(
              bank: (value) {
                setState(() {
                  bankname = value;
                  bankname;
                });
              },
              bankbranch: (value) {
                setState(() {
                  bank_brand = value;
                  bank_brand;
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
                          bank_officer = value;
                        } else if (i == 1) {
                          bank_contact = value;
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
              // flex: 3,
              hometype: (value) {
                setState(() {
                  property_type = value;
                });
              },
              hometype_lable: property_type,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: RoadDropdown(
                id_road: (value) {
                  id_road = value;
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
                  l = value;
                  l;
                });
              },
              total: (value) {
                setState(() {
                  total = value;
                });
              },
              w: (value) {
                setState(() {
                  w = value;
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
                  askingprice = value;
                });
              },
              total_type: (value) {
                setState(() {
                  sqm_total = value;
                });
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 30, bottom: 10, top: 10),
            //   child: Text(
            //     'Offered Price',
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: MediaQuery.of(context).size.height * 0.022),
            //   ),
            // ),
            // Total_dropdown(
            //   input: (value) {

            //   },
            //   total_type: (value) {},
            // ),
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
                      Amount = value;
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
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Map_verbal_address_Sale(
                        get_province: (value) {
                          setState(() {
                            songkat = value.toString();
                            print(songkat);
                          });
                        },
                        get_district: (value) {
                          setState(() {
                            provice_map = value.toString();
                          });
                        },
                        get_commune: (value) {
                          setState(() {
                            khan = value.toString();
                          });
                        },
                        get_log: (value) {
                          setState(() {
                            log = value.toString();
                            _log = TextEditingController(text: '${log}');
                            log = _log!.text;
                          });
                        },
                        get_lat: (value) {
                          setState(() {
                            lat = value.toString();
                            _lat = TextEditingController(text: '${lat}');
                            lat = _lat!.text;
                          });
                        },
                      );
                    },
                  ));
                },
                child: (khan != null || songkat != null)
                    ? Container(
                        height: textstye,
                        margin:
                            EdgeInsets.only(right: 30, left: 30, bottom: 10),
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_city_outlined,
                              size: 30,
                              color: kImageColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${khan}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '/ ${provice_map}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: textstye,
                        margin: EdgeInsets.only(right: 30, left: 30),
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_city_outlined,
                              size: 30,
                              color: kImageColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'address',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                      )),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: _log,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        setState(() {
                          // bankcontact = value;
                          log = _log!.text;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.numbers_outlined,
                          color: kImageColor,
                        ),
                        hintText: "log",
                        contentPadding: EdgeInsets.symmetric(vertical: 8),

                        fillColor: kwhite,
                        // hintText: (bankcontact == null || bankcontact == '')
                        //     ? '${widget.list![index_edit]['bankcontact'].toString()}'
                        //     : bankcontact,
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: _lat,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        setState(() {
                          // bankcontact = value;
                          lat = _lat!.text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "lat",
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        prefixIcon: Icon(
                          Icons.numbers_outlined,
                          color: kImageColor,
                        ),
                        fillColor: kwhite,
                        // hintText: (bankcontact == null || bankcontact == '')
                        //     ? '${widget.list![index_edit]['bankcontact'].toString()}'
                        //     : bankcontact,
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
            SizedBox(
              height: 10,
            ),
            Province_dropdown(
              cummone_id0: null,
              district_id0: null,
              province_id0: null,
              provicne_id: (value) {
                setState(() {
                  provnce_id = value;
                });
              },
              cummone_id: (value) {
                setState(() {
                  cummune_id = value.toString();
                });
              },
              district_id: (value) {
                setState(() {
                  district_id = value.toString();
                  district_id;
                });
              },
            ),

            SizedBox(
              height: 10,
            ),
            // district_dropdown

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
                  lb = value;
                  lb;
                });
              },
              total: (value) {
                setState(() {
                  total_b = value;
                });
              },
              w: (value) {
                setState(() {
                  wb = value;
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
                  officer_price = value;
                });
              },
              total_type: (value) {
                setState(() {
                  officer_price_total = value;
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
                  sold_price = value;
                });
              },
              total_type: (value) {
                setState(() {
                  total_price = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 30, left: 25),
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
                          print(newValue.toString());
                          condition = newValue;
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
                  Container(
                    width: MediaQuery.of(context).size.height * 0.2,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        setState(() {
                          year = value;
                          year;
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
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold),
                  onChanged: (value) {
                    setState(() {
                      remak = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    prefixIcon: Icon(
                      Icons.label,
                      color: kImageColor,
                    ),
                    hintText: 'Remak',
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
                      con_user = value;
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

  String? officer_price_total;
  String? sold_price;
  String? total_price;
  String? askingprice;
  String? con_user;
  String? remak;
  String? officer_price;
  String? sqm_total;
  String? Amount;
  String? condtion;
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
  String? condition;
  List bank_name_list = [];
  Future<void> bank_name() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bank_dropdown'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['banks'];
        bank_name_list = jsonBody;
        setState(() {
          bank_name_list;
        });
      } else {
        print('Error bank');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  List brand_name_list = [];
  Future<void> brand_name() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/bankbranch_dropdown?bank_branch_details_id=$bank_brand'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody =
            jsonDecode(response.body)['bank_branches'];
        brand_name_list = jsonBody;

        setState(() {
          brand_name_list;
        });
      } else {
        print('Error bank');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  void Comparable_new() async {
    String? address;
    setState(() {
      address = '$khan / $songkat';
    });
    try {
      Map<String, dynamic> payload = {
        'comparable_property_id': int.parse(property_type.toString()),
        'comparable_land_length': l.toString(),
        'comparable_land_width': w.toString(),
        'comparable_land_total': total.toString(),
        'comparable_sold_length': (lb == null) ? 'null' : lb.toString(),
        'comparable_sold_width': w.toString(),
        'comparable_sold_total': total_b.toString(),
        'comparable_adding_price':
            (askingprice == null) ? 'null' : askingprice.toString(),
        'comparable_adding_total':
            (sqm_total == null) ? 'null' : sqm_total.toString(),
        'comparable_sold_price':
            (officer_price == null) ? 'null' : officer_price.toString(),
        'comparable_sold_total_price': (officer_price_total == null)
            ? 'null'
            : officer_price_total.toString(),
        'comparable_condition_id':
            (condition == null) ? 'null' : condition.toString(),
        'comparable_year': (year == null) ? 'null' : year.toString(),
        'comparable_address': address.toString(),
        'comparable_province_id': provnce_id.toString(),
        'comparable_district_id': district_id.toString(),
        'comparable_commune_id': cummune_id.toString(),
        'comparable_remark': (remak == null) ? 'null' : remak.toString(),
        'comparable_con': 0,
        'comparable_distance': 0,
        'comparable_status_id': 0,
        'comparableaddprice':
            (sold_price == null) ? 'null' : sold_price.toString(),
        'comparableaddpricetotal':
            (total_price == null) ? 'null' : total_price.toString(),
        'comparableboughtprice': '0',
        'comparableAmount': (Amount == null) ? 'null' : Amount.toString(),
        'latlong_log': double.parse(log.toString()),
        'latlong_la': double.parse(lat.toString()),
        'comparabl_user': 0,
        // 'comparable_phone':
        //     (con_user == null) ? null : int.parse(con_user.toString()),
        'comparable_phone': (con_user == null) ? null : con_user.toString(),
        'comparableboughtpricetotal': '0',
        'compare_bank_id': int.parse(bankname.toString()),
        'compare_bank_branch_id':
            (bank_brand == null) ? null : int.parse(bank_brand.toString()),
        'com_bankofficer':
            (bank_officer == null) ? 'null' : bank_officer.toString(),
        'com_bankofficer_contact':
            (bank_contact == null) ? 'null' : bank_contact.toString(),
        'comparable_road':
            (id_road == null) ? null : int.parse(id_road.toString()),
      };

      final url = Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/new_comparable');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        print('Success Comparable');
      } else {
        print('Error 1: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
