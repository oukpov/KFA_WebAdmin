import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../components/colors.dart';
import '../../../../Widgets/landEdit.dart';
import '../../../../Widgets/searchProperty.dart';
import '../../../../components/road.dart';

class EditCom extends StatefulWidget {
  EditCom({super.key, required this.item});
  var item;
  @override
  State<EditCom> createState() => _EditComState();
}

class _EditComState extends State<EditCom> {
  List totally = [
    {
      'numer_id': 1,
      'type': 'Totally',
    },
    {
      'numer_id': 2,
      'type': 'Sqm',
    }
  ];
  @override
  void initState() {
    main();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    ownerphone.dispose();
    offerredPrice.dispose();
    pricepersqm.dispose();
    askingPricett.dispose();
    totalPriceSqm.dispose();
    province.dispose();
    district.dispose();
    commune.dispose();
    remark.dispose();
    latController.dispose();
    logController.dispose();
  }

  void main() {
    setState(() {
      boreyvalue = int.parse("${widget.item['borey'] ?? "0"}");
      if (boreyvalue == 1) {
        checkboreyTP = true;
      }
      market = int.parse("${widget.item['markert'] ?? "0"}");
      if (market == 1) {
        checkMarket = true;
      }
      comparablePropertyID =
          int.parse(widget.item['comparable_property_id'].toString());
      comparableroad = int.parse(widget.item['comparable_road'].toString());
      comparablelandlength = "${widget.item['comparable_land_length'] ?? ""}";
      comparablelandwidth = "${widget.item['comparable_land_width'] ?? ""}";
      totalland.text = widget.item['comparable_land_total'] ?? "0";
      comparablesoldlength = "${widget.item['comparable_sold_length'] ?? ""}";
      comparablesoldwidth = "${widget.item['comparable_sold_width'] ?? ""}";
      totalPrice.text = widget.item['comparable_sold_total'] ?? "0";
      pricepersqm.text = "${widget.item['comparable_adding_price'] ?? ""}";
      askingPricett.text = "${widget.item['comparableAmount'] ?? ""}";
      offerredPrice.text = "${widget.item['comparableaddprice'] ?? ""}";
      totalPriceSqm.text = "${widget.item['comparable_sold_price'] ?? ""}";
      latController.text = "${widget.item['latlong_la'] ?? ""}";
      logController.text = "${widget.item['latlong_log'] ?? ""}";
      remark.text = "${widget.item['comparable_remark'] ?? ""}";
      commune.text = "${widget.item['commune'] ?? ""}";
      province.text = "${widget.item['province'] ?? ""}";
      district.text = "${widget.item['district'] ?? ""}";
      ownerphone.text = "${widget.item['comparable_phone'] ?? ""}";
      comparablefloor.text = "${widget.item['comparable_floor'] ?? ""}";
    });
  }

  bool checkcalculate = false;
  bool checkcalculateBuilding = false;
  bool checkaskingPrice = false;
  bool checkownerphone = false;
  Future<void> calculate() async {
    setState(() {
      double askingPrice = double.tryParse(askingPricett.text) ?? 0;
      double totalLand = double.tryParse(totalland.text) ?? 1.0;
      double pricepersqmN = double.tryParse(pricepersqm.text) ?? 0;
      if (!checkcalculate) {
        //Asking Price
        double pricepersqmresult = askingPrice / totalLand;
        pricepersqm.text = pricepersqmresult.toStringAsFixed(0);
      } else if (pricepersqmN != 0) {
        //Asking PriceTT
        double askingPricettresult = totalLand * pricepersqmN;
        askingPricett.text = askingPricettresult.toStringAsFixed(0);
      }
    });
  }

  bool checksave = false;
  int count = 0;
  late Timer _timer;
  void mainsecond(int second) async {
    count = 0;
    checksave = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      setState(() {
        if (timer.isActive) {
          count++;
        }
        if (count == second) {
          _timer.cancel();
          checksave = false;
        }
      });
    });
  }

  void calculatebuilding() {
    setState(() {
      double totolprice = double.tryParse(totalPrice.text) ?? 0.0;
      double offeredPrice = double.tryParse(offerredPrice.text) ?? 0.0;
      double totalPriceSqmN = double.tryParse(totalPriceSqm.text) ?? 1;
      //Sould Out Price
      if (!checkcalculateBuilding) {
        double result = (totolprice * offeredPrice);
        totalPriceSqm.text = result.toStringAsFixed(0);
      } else {
        //Offerred Price
        double result = (totalPriceSqmN / totolprice);
        offerredPrice.text = result.toStringAsFixed(0);
      }
    });
  }

  bool _isSwitched = false;
  int market = 0;
  bool checkMarket = false;
  bool checkboreyTP = false;
  int boreyvalue = 0;
  int comparablePropertyID = 0;
  int? comparableroad;
  String comparablelandlength = '';
  String comparablelandwidth = '';
  String comparablesoldlength = '';
  String comparablesoldwidth = '';
  final TextEditingController ownerphone = TextEditingController();
  final TextEditingController comparablefloor = TextEditingController();
  final TextEditingController totalland = TextEditingController();
  final TextEditingController totalPrice = TextEditingController();
  final TextEditingController offerredPrice = TextEditingController();
  final TextEditingController pricepersqm = TextEditingController();
  final TextEditingController askingPricett = TextEditingController();
  final TextEditingController totalPriceSqm = TextEditingController();
  final TextEditingController province = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController commune = TextEditingController();
  final TextEditingController remark = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController logController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 650,
          width: 450,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 25, 9, 129),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 2, color: whiteColor)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.highlight_remove,
                            color: whiteColor,
                            size: 30,
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Spacer(),
                      checksave
                          ? const Center(child: CircularProgressIndicator())
                          : InkWell(
                              onTap: () async {
                                mainsecond(15);
                                updateData(widget.item['comparable_id']);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: greenColors,
                                    border: Border.all(
                                        width: 2, color: whiteColor)),
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: whiteColor,
                                      fontSize: 15),
                                ),
                              ),
                            )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        !checkboreyTP ? 'No borey' : 'Borey  ',
                        style: TextStyle(color: whiteColor, fontSize: 15),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              checkboreyTP = !checkboreyTP;
                              if (!checkboreyTP) {
                                boreyvalue = 0;
                              } else {
                                boreyvalue = 1;
                              }
                            });
                          },
                          icon: Icon(
                              !checkboreyTP
                                  ? Icons.check_box_outline_blank_outlined
                                  : Icons.check_box_outlined,
                              size: 25,
                              color: whiteColor),
                          color: whiteColor),
                      Text(
                        !checkboreyTP ? 'No Market' : 'Market  ',
                        style: TextStyle(color: whiteColor, fontSize: 15),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              //////////PPPPPPPPP
                              checkMarket = !checkMarket;
                              if (!checkMarket) {
                                market = 0;
                              } else {
                                market = 1;
                              }
                            });
                          },
                          icon: Icon(
                              !checkMarket
                                  ? Icons.check_box_outline_blank_outlined
                                  : Icons.check_box_outlined,
                              size: 25,
                              color: whiteColor),
                          color: whiteColor),
                      Text(
                        _isSwitched ? 'No Auto  ' : 'Auto  ',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 47, 242, 8),
                            fontSize: 15),
                      ),
                      Switch(
                        value: _isSwitched,
                        onChanged: (value) {
                          setState(() {
                            _isSwitched = value;
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Property Type *",
                          style: TextStyle(color: whiteColor, fontSize: 14)),
                      Text("( ${widget.item['property_type_name'] ?? ""} )",
                          style: TextStyle(color: yellowColor, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  propertyType(
                    lable: '${widget.item['property_type_name'] ?? ""}',
                    value: (value) {
                      setState(() {
                        ls = int.parse(value!);
                        comparablePropertyID = int.parse(value);
                      });
                    },
                    valueName: "PropertyType *",
                    valuenameback: (value) {},
                  ),
                  const SizedBox(height: 10),
                  LandbuildingEdit(
                    lvalue: comparablelandlength.toString(),
                    wvalue: comparablelandwidth.toString(),
                    totalvalue: totalland.text.toString(),
                    checkvalidate: true,
                    title: 'Land',
                    l: (value) {
                      setState(() {
                        comparablelandlength = "${value ?? "0"}";
                      });
                    },
                    total: (value) {
                      setState(() {
                        totalland.text = value.toString();
                        if (!_isSwitched) {
                          calculate();
                        }
                      });
                    },
                    w: (value) {
                      setState(() {
                        comparablelandwidth = "${value ?? "0"}";
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Text("Asking Price",
                      style: TextStyle(color: whiteColor, fontSize: 14)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            validator: (value) {
                              // if (pricepersqm
                              //             .text ==
                              //         '' ||
                              //     pricepersqm
                              //             .text ==
                              //         '0') {
                              //   setState(() {
                              //     checkpricepersqm =
                              //         true;
                              //   });
                              // } else {
                              //   setState(() {
                              //     checkpricepersqm =
                              //         false;
                              //   });
                              // }
                            },
                            controller: pricepersqm,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            onChanged: (value) {
                              setState(() {
                                checkcalculate = true;
                                if (!_isSwitched) {
                                  calculate();
                                }
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              prefixIcon: const Icon(
                                Icons.payments,
                                color: kImageColor,
                              ),
                              // hintText: 'Price Per SQM',
                              fillColor: kwhite,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: kPrimaryColor,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 35,
                          child: DropdownButtonFormField<String>(
                            //value: genderValue,
                            isExpanded: true,

                            onChanged: (newValue) {
                              // setState(() {});
                            },
                            items: totally
                                .map<DropdownMenuItem<String>>(
                                  (value) => DropdownMenuItem<String>(
                                    value: value["numer_id"].toString(),
                                    child: Text(value["type"]),
                                    onTap: () {},
                                  ),
                                )
                                .toList(),
                            // add extra sugar..
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: kImageColor,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              fillColor: kwhite,
                              filled: true,
                              labelText: 'Select',
                              hintText: 'Select',
                              prefixIcon: const Icon(
                                Icons.discount_outlined,
                                color: kImageColor,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: kPrimaryColor,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("Asking Price(TTAmount)",
                      style: TextStyle(color: whiteColor, fontSize: 14)),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      validator: (value) {
                        setState(() {
                          if (askingPricett.text == '') {
                            checkaskingPrice = true;
                          } else {
                            checkaskingPrice = false;
                          }
                        });
                      },
                      controller: askingPricett,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        setState(() {
                          checkcalculate = false;
                          if (!_isSwitched) {
                            calculate();
                          }
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        prefixIcon: const Icon(
                          Icons.question_answer_outlined,
                          color: kImageColor,
                        ),
                        hintText: 'Asking Price(TTAmount)',
                        hintStyle: TextStyle(color: greyColorNolots),
                        fillColor: kwhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("Road *",
                      style: TextStyle(color: whiteColor, fontSize: 14)),
                  const SizedBox(height: 5),
                  RoadDropdown(
                    lable: "${widget.item['road_name'] ?? ""}",
                    id_road: (value) {
                      setState(() {
                        comparableroad = int.parse(value);
                      });
                    },
                    Name_road: (value) {
                      // setState(() {
                      //   checkraod = value;
                      // });
                    },
                  ),
                  if (comparablePropertyID != 15) const SizedBox(height: 10),
                  if (comparablePropertyID != 15)
                    LandbuildingEdit(
                      lvalue: comparablesoldlength.toString(),
                      wvalue: comparablesoldwidth.toString(),
                      totalvalue: totalPrice.text,
                      checkvalidate: false,
                      title: 'Building',
                      l: (value) {
                        setState(() {
                          comparablesoldlength = "${value ?? "0"}";
                        });
                      },
                      total: (value) {
                        setState(() {
                          totalPrice.text = value.toString();
                          if (!_isSwitched) {
                            calculatebuilding();
                          }
                        });
                      },
                      w: (value) {
                        setState(() {
                          comparablesoldwidth = "${value ?? "0"}";
                        });
                      },
                    ),
                  if (comparablePropertyID != 15)
                    if (comparablePropertyID != 15) const SizedBox(height: 10),
                  if (comparablePropertyID != 15)
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Offered Price",
                                  style: TextStyle(
                                      color: whiteColor, fontSize: 14)),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: offerredPrice,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (value) {
                                    setState(() {
                                      checkcalculateBuilding = false;
                                      if (!_isSwitched) {
                                        calculatebuilding();
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    prefixIcon: const Icon(
                                      Icons.question_answer_outlined,
                                      color: kImageColor,
                                    ),
                                    hintText: 'Offered Price',
                                    hintStyle:
                                        TextStyle(color: greyColorNolots),
                                    fillColor: kwhite,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor, width: 1.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: kPrimaryColor),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text("",
                                  style: TextStyle(
                                      color: whiteColor, fontSize: 14)),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 40,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    // setState(() {});
                                  },
                                  items: totally
                                      .map<DropdownMenuItem<String>>(
                                        (value) => DropdownMenuItem<String>(
                                          value: value["numer_id"].toString(),
                                          child: Text(value["type"]),
                                          onTap: () {
                                            // setState(() {});
                                          },
                                        ),
                                      )
                                      .toList(),
                                  // add extra sugar..
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: kImageColor,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    fillColor: kwhite,
                                    filled: true,
                                    labelText: 'Sqm',
                                    hintText: 'Sqm',
                                    prefixIcon: const Icon(
                                      Icons.discount_outlined,
                                      color: kImageColor,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: kPrimaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (comparablePropertyID != 15) const SizedBox(height: 10),
                  if (comparablePropertyID != 15)
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sold Out Price",
                                  style: TextStyle(
                                      color: whiteColor, fontSize: 14)),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: totalPriceSqm,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (value) {
                                    setState(() {
                                      checkcalculateBuilding = true;

                                      if (!_isSwitched) {
                                        calculatebuilding();
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    prefixIcon: const Icon(
                                      Icons.question_answer_outlined,
                                      color: kImageColor,
                                    ),
                                    hintText: 'Sold Out Price',
                                    hintStyle:
                                        TextStyle(color: greyColorNolots),
                                    fillColor: kwhite,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor, width: 1.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: kPrimaryColor),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text("",
                                  style: TextStyle(
                                      color: whiteColor, fontSize: 14)),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 40,
                                child: DropdownButtonFormField<String>(
                                  //value: genderValue,
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    // setState(() {});
                                  },
                                  items: totally
                                      .map<DropdownMenuItem<String>>(
                                        (value) => DropdownMenuItem<String>(
                                          value: value["numer_id"].toString(),
                                          child: Text(value["type"]),
                                          onTap: () {
                                            // setState(() {});
                                          },
                                        ),
                                      )
                                      .toList(),
                                  // add extra sugar..
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: kImageColor,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    fillColor: kwhite,
                                    filled: true,
                                    labelText: 'Sqm',
                                    hintText: 'Sqm',
                                    prefixIcon: const Icon(
                                      Icons.discount_outlined,
                                      color: kImageColor,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: kPrimaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (comparablePropertyID != 15)
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Floor",
                                  style: TextStyle(
                                      color: whiteColor, fontSize: 14)),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: comparablefloor,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    prefixIcon: const Icon(
                                      Icons.question_answer_outlined,
                                      color: kImageColor,
                                    ),
                                    hintText: 'Floor',
                                    hintStyle:
                                        TextStyle(color: greyColorNolots),
                                    fillColor: kwhite,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: kPrimaryColor),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (comparablePropertyID != 15) const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Owner Phone *",
                                style:
                                    TextStyle(color: whiteColor, fontSize: 14)),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: ownerphone,
                                validator: (value) {
                                  if (value == '') {
                                    setState(() {
                                      checkownerphone = true;
                                    });
                                  } else {
                                    setState(() {
                                      checkownerphone = false;
                                    });
                                  }
                                },
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  prefixIcon: const Icon(
                                    Icons.question_answer_outlined,
                                    color: kImageColor,
                                  ),
                                  hintText: 'Owner Phone *',
                                  hintStyle: TextStyle(color: greyColorNolots),
                                  fillColor: kwhite,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: kPrimaryColor, width: 2.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 1, color: colorsRed),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: kPrimaryColor),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: province,
                      // onChanged: (value) {
                      //   setState(() {
                      //     province.text = value;
                      //   });
                      // },
                      decoration: InputDecoration(
                        fillColor: kwhite,
                        filled: true,
                        labelText: "Province",
                        labelStyle: const TextStyle(color: kTextLightColor),
                        prefixIcon: const Icon(Icons.location_on_rounded,
                            color: kImageColor),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: district,
                      decoration: InputDecoration(
                        fillColor: kwhite,
                        filled: true,
                        labelText: "District",
                        labelStyle: const TextStyle(color: kTextLightColor),
                        prefixIcon: const Icon(Icons.location_on_rounded,
                            color: kImageColor),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: commune,
                      decoration: InputDecoration(
                        fillColor: kwhite,
                        filled: true,
                        labelText: "Commune",
                        labelStyle: const TextStyle(color: kTextLightColor),
                        prefixIcon: const Icon(Icons.location_on_rounded,
                            color: kImageColor),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: remark,
                      decoration: InputDecoration(
                        fillColor: kwhite,
                        filled: true,
                        labelText: "Remark",
                        labelStyle: const TextStyle(color: kTextLightColor),
                        prefixIcon: const Icon(Icons.read_more_sharp,
                            color: kImageColor),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            validator: (value) {
                              // if (value == '') {
                              //   setState(() {
                              //     checklat = true;
                              //   });
                              // } else {
                              //   setState(() {
                              //     checklat = false;
                              //   });
                              // }
                            },
                            controller: latController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              prefixIcon: const Icon(
                                Icons.question_answer_outlined,
                                color: kImageColor,
                              ),
                              hintText: 'Latitude *',
                              hintStyle: TextStyle(color: greyColorNolots),
                              fillColor: kwhite,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            validator: (value) {
                              // if (value == '') {
                              //   setState(() {
                              //     checklog = true;
                              //   });
                              // } else {
                              //   setState(() {
                              //     checklog = false;
                              //   });
                              // }
                            },
                            controller: logController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              prefixIcon: const Icon(
                                Icons.question_answer_outlined,
                                color: kImageColor,
                              ),
                              hintText: 'Longitude *',
                              hintStyle: TextStyle(color: greyColorNolots),
                              fillColor: kwhite,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  bool check = false;
  Future<void> updateData(int comparableID) async {
    setState(() {
      if (widget.item['type_value'] == 'VN') {
        check = true;
      } else {
        check = false;
      }
    });
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "check": check,
      "borey": boreyvalue,
      "comparable_road": comparableroad,
      "comparable_property_id": comparablePropertyID,
      "protectID": widget.item['protectID'],
      "comparable_land_length": comparablelandlength,
      "comparable_land_width": comparablelandwidth,
      "comparable_land_total": totalland.text,
      "comparable_adding_price": pricepersqm.text,
      "comparableAmount": askingPricett.text,
      "comparable_sold_length":
          (comparablePropertyID == 15) ? null : comparablesoldlength,
      "comparable_sold_width":
          (comparablePropertyID == 15) ? null : comparablesoldwidth,
      "comparable_sold_total":
          (comparablePropertyID == 15) ? null : totalPrice.text,
      "comparable_sold_price":
          (comparablePropertyID == 15) ? null : totalPriceSqm.text,
      "comparableaddprice":
          (comparablePropertyID == 15) ? null : offerredPrice.text,
      "comparable_phone": ownerphone.text,
      "latlong_la": latController.text,
      "latlong_log": logController.text,
      "comparable_remark": remark.text,
      "province": province.text,
      "district": district.text,
      "commune": commune.text,
      "comparable_floor": comparablefloor.text
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update/com/all/$comparableID',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      // print();
      Get.snackbar(
        "Done",
        json.encode(response.data),
        colorText: Colors.black,
        padding:
            const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
        borderColor: const Color.fromARGB(255, 48, 47, 47),
        borderWidth: 1.0,
        borderRadius: 5,
        backgroundColor: const Color.fromARGB(255, 235, 242, 246),
        icon: const Icon(Icons.add_alert),
      );
      Navigator.pop(context);
    } else {
      print(response.statusMessage);
    }
  }

  int ls = 0;
}

class EditDetail extends StatefulWidget {
  EditDetail({super.key, required this.item});
  var item;
  @override
  State<EditDetail> createState() => _EditDetailState();
}

class _EditDetailState extends State<EditDetail> {
  int comparablePropertyID = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          dailogScreen(widget.item);
        },
        child: Icon(Icons.edit_document, color: greenColors),
      ),
    );
  }

  Future<void> dailogScreen(data) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, top: 30),
            child: EditCom(
              item: widget.item,
            ),
          );
        });
  }
}
