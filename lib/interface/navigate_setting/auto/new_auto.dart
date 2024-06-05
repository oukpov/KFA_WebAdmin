// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../../../../components/road.dart';
import '../../../../server/api_service.dart';
import '../../../components/GoogleMap.dart';
import '../../../models/M_commune.dart';
import '../../../models/M_roadAndcommune.dart';

class NewAuto extends StatefulWidget {
  const NewAuto({super.key});

  @override
  State<NewAuto> createState() => _NewAutoState();
}

class _NewAutoState extends State<NewAuto> {
  late List _list;
  String? district;
  String? province;
  String? commune;
  double? lat, log;
  TextStyle colorizeTextStyle = TextStyle(
    fontSize: 20.0,
    fontFamily: 'Horizon',
    fontWeight: FontWeight.bold,
  );
  late M_Commune Commune;
  List<roadAndcommune>? rac;
  String? S_M_V;
  String? S_N_V;
  String? M_1_M_V;
  String? M_1_N_V;
  String? M_2_M_V;
  String? M_2_N_V;
  var M_1_idr;
  var M_2_idr;
  @override
  void initState() {
    rac = [];
    M_1_idr;
    M_2_idr;
    Load();
    S_M_V;
    S_N_V;
    // TODO: implement initState
    Commune = M_Commune(
        communename: "Null",
        district: "Null",
        province: "Null",
        longitude: 0.0,
        latitude: 0.0,
        option: "Null");
    options;
    onClick1 = false;
    onClick2 = false;
    // rac.add(roadAndcommune(rid: 0, cid: 0, maxvalue: 0, minvalue: 0));
    // rac.add(roadAndcommune(rid: 0, cid: 0, maxvalue: 0, minvalue: 0));
    super.initState();
  }

  bool click_r = false;
  int groupValue = 0;
  var S_name_r;
  var S_id_r;
  var M_name_r1;
  var M_name_r2;
  bool onClick = false;
  bool? onClick1;
  bool? onClick2;
  var dropdown;
  String? options;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 27, 146, 1),
        centerTitle: true,
        title: const Text(
          "New Auto",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        actions: [
          if (groupValue != 0)
            GFButton(
              onPressed: () {
                setState(() {
                  if (groupValue == 1) {
                    rac!.add(roadAndcommune(
                        rid: int.parse(
                          S_id_r,
                        ),
                        cid: int.parse(_list.elementAt(0)['cid']) + 1,
                        maxvalue: double.parse(S_M_V!),
                        minvalue: double.parse(S_N_V!)));
                    APIservice setdata = APIservice();
                    setdata.RoadAndCommune(rac!.elementAt(0));
                  } else if (groupValue == 2) {
                    APIservice setdata = APIservice();
                    rac!.add(roadAndcommune(
                        rid: int.parse(M_1_idr),
                        cid: int.parse(_list.elementAt(0)['cid']) + 1,
                        maxvalue: double.parse(M_1_M_V!),
                        minvalue: double.parse(M_1_N_V!)));
                    rac!.add(roadAndcommune(
                        rid: int.parse(M_2_idr),
                        cid: int.parse(_list.elementAt(0)['cid']) + 1,
                        maxvalue: double.parse(M_2_M_V!),
                        minvalue: double.parse(M_2_N_V!)));
                    setdata.RoadAndCommune(rac!.elementAt(0));
                    setdata.RoadAndCommune(rac!.elementAt(1));
                  }
                  Navigator.of(context).pop();
                });
              },
              icon: Icon(Icons.save_alt_outlined),
              color: Color.fromRGBO(13, 71, 161, 1),
              text: 'Submit',
            ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 6, color: Color.fromARGB(197, 63, 62, 62))
                ]),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GoogleMapS(
                          get_max1: (value) {},
                          get_max2: (value) {},
                          get_min2: (value) {},
                          get_min1: (value) {},
                          get_commune: (value) {
                            setState(() {
                              commune = value;
                              print(value.toString());
                            });
                          },
                          get_district: (value) {
                            setState(() {
                              district = value;
                              print(value.toString());
                            });
                          },
                          get_lat: (value) {
                            setState(() {
                              lat = double.parse(value.toString());
                            });
                          },
                          get_log: (value) {
                            setState(() {
                              log = double.parse(value.toString());
                            });
                          },
                          get_province: (value) {
                            setState(() {
                              province = value;
                              print(value.toString());
                            });
                          },
                        )));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 6, color: Color.fromARGB(197, 63, 62, 62))
                    ]),
                child: Column(children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'Please select on the map',
                        textStyle: colorizeTextStyle,
                        colors: [
                          Colors.purple,
                          Colors.blue,
                          Colors.yellow,
                          Colors.red,
                        ],
                        speed: const Duration(milliseconds: 70),
                      ),
                      ColorizeAnimatedText(
                        'Click Now',
                        textStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Horizon',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        colors: [
                          Colors.purple,
                          Colors.blue,
                          Colors.yellow,
                          Colors.red,
                        ],
                      ),
                    ],
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                  Image.asset('assets/images/Google_Maps_city.jpg',
                      fit: BoxFit.fill, scale: 0.5)
                ]),
              ),
            ),
          ),
          if (lat != null)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.travel_explore,
                          color: Colors.cyan[600],
                          size: 30,
                        ),
                        hintText: 'Do you want to edit commune?',
                        labelText: ((commune == null) ? 'Commune' : '$commune'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onChanged: (String? value) {
                      setState(() {
                        commune = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.travel_explore,
                        color: Colors.cyan[600],
                        size: 30,
                      ),
                      hintText: 'Do you want to edit District?',
                      labelText:
                          ((district == null) ? 'District' : '$district'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        district = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.travel_explore,
                        color: Colors.cyan[600],
                        size: 30,
                      ),
                      hintText: 'Do you want to edit province?',
                      labelText:
                          ((province == null) ? 'province' : '$province'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        province = value;
                      });
                    },
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(20),
                  child: DropdownButtonHideUnderline(
                    child: GFDropdown(
                      padding: const EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(5),
                      border: const BorderSide(color: Colors.black12, width: 1),
                      dropdownButtonColor: Colors.white,
                      value: dropdown,
                      hint: Text('Option'),
                      onChanged: (newValue) {
                        setState(() {
                          dropdown = newValue;
                          options = newValue as String;
                        });
                      },
                      items: [
                        'Residencial',
                        'Commercial',
                        'Agricultural',
                      ]
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          if (lat != null)
            TextButton(
              onPressed: () {
                setState(() {
                  click_r = true;
                  Commune = M_Commune(
                      communename: commune,
                      district: district,
                      province: province,
                      longitude: log,
                      latitude: lat,
                      option: options);
                  APIservice setData = APIservice();
                  setData.SaveCommune(Commune);
                });
              },
              child: GFListTile(
                  color: Colors.blue[400],
                  margin:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  titleText: 'Please select road',
                  icon: Icon(
                    Icons.call_split,
                    color: Colors.black,
                  )),
            ),
          SizedBox(
            height: 10,
          ),
          ((click_r == false)
              ? Text('')
              : GFCard(
                  height: 90,
                  elevation: 8,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Single road",
                        style: TextStyle(
                            color: ((groupValue == 1)
                                ? Colors.red[900]
                                : Colors.black)),
                      ),
                      GFRadio(
                        size: 20,
                        value: 1,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = int.parse(value.toString());
                          });
                        },
                        inactiveIcon: null,
                        activeBorderColor: Color.fromARGB(255, 0, 4, 255),
                        radioColor: Color.fromRGBO(183, 28, 28, 1),
                      ),
                      Text(
                        "Multi road",
                        style: TextStyle(
                            color: ((groupValue == 2)
                                ? Colors.green
                                : Colors.black)),
                      ),
                      GFRadio(
                        size: 20,
                        value: 2,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = int.parse(value.toString());
                          });
                        },
                        inactiveIcon: null,
                        activeBorderColor: Color.fromARGB(255, 0, 4, 255),
                        radioColor: Color.fromRGBO(183, 28, 28, 1),
                      )
                    ],
                  ))),
          ((groupValue == 1)
              ? Column(
                  children: [
                    RoadDropdown(
                      id_road: (value) {
                        S_id_r = value;
                        setState(() {
                          onClick = true;
                        });
                      },
                      Name_road: (value) {
                        S_name_r = value;
                      },
                    ),
                    ((onClick == true)
                        ? Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.edit_road,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    hintStyle: TextStyle(color: Colors.red),
                                    labelStyle: TextStyle(color: Colors.red),
                                    hintText: 'Please Enter Value',
                                    labelText: '${S_name_r} Max Value',
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      S_M_V = value;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.blue[50],
                                    prefixIcon: Icon(
                                      Icons.edit_road,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    hintStyle: TextStyle(color: Colors.red),
                                    labelStyle: TextStyle(color: Colors.red),
                                    hintText: 'Please Enter Value',
                                    labelText: '${S_name_r} Min Value',
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  onChanged: (value) {
                                    S_N_V = value;
                                  },
                                ),
                              )
                            ],
                          )
                        : SizedBox()),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                )
              : SizedBox()),
          if (groupValue == 2)
            Column(
              children: [
                RoadDropdown(
                  id_road: (value) {
                    M_1_idr = value;
                  },
                  Name_road: (value) {
                    M_name_r1 = value;
                    setState(() {
                      onClick1 = true;
                    });
                  },
                ),
                if (onClick1 == true)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.edit_road,
                              color: Colors.red,
                              size: 30,
                            ),
                            hintStyle: TextStyle(color: Colors.red),
                            labelStyle: TextStyle(color: Colors.red),
                            hintText: 'Please Enter Value',
                            labelText: '${M_name_r1} Max Value',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onChanged: (value) {
                            setState(() {
                              M_1_M_V = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.blue[50],
                            prefixIcon: Icon(
                              Icons.edit_road,
                              color: Colors.red,
                              size: 30,
                            ),
                            hintStyle: TextStyle(color: Colors.red),
                            labelStyle: TextStyle(color: Colors.red),
                            hintText: 'Please Enter Value',
                            labelText: '${M_name_r1} Min Value',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onChanged: (value) {
                            M_1_N_V = value;
                          },
                        ),
                      )
                    ],
                  ),
                RoadDropdown(
                  id_road: (value) {
                    M_2_idr = value;
                  },
                  Name_road: (value) {
                    M_name_r2 = value;
                    setState(() {
                      onClick2 = true;
                    });
                  },
                ),
                if (onClick2 == true)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.edit_road,
                              color: Colors.red,
                              size: 30,
                            ),
                            hintStyle: TextStyle(color: Colors.red),
                            labelStyle: TextStyle(color: Colors.red),
                            hintText: 'Please Enter Value',
                            labelText: '${M_name_r2} Max Value',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onChanged: (value) {
                            setState(() {
                              M_2_M_V = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.blue[50],
                            prefixIcon: Icon(
                              Icons.edit_road,
                              color: Colors.red,
                              size: 30,
                            ),
                            hintStyle: TextStyle(color: Colors.red),
                            labelStyle: TextStyle(color: Colors.red),
                            hintText: 'Please Enter Value',
                            labelText: '${M_name_r2} Min Value',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onChanged: (value) {
                            M_2_N_V = value;
                          },
                        ),
                      )
                    ],
                  ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
        ],
      ),
    );
  }

  void Load() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/commune_list'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        _list = jsonData;
      });
    }
  }
}
