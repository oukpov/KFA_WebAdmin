// ignore_for_file: unnecessary_import, implementation_imports, unused_import, prefer_adjacent_string_concatenation, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

import '../../../controller/road_and_commune_controller.dart';
import '../../../models/raod_and_commune_model.dart';

class AutoList extends StatefulWidget {
  const AutoList({super.key});

  @override
  State<AutoList> createState() => _AutoListState();
}

class _AutoListState extends State<AutoList>
    with SingleTickerProviderStateMixin {
  late List M_v;
  late List N_v;

  static TabController? controller;
  static int index = 0;
  RoadAndCommnuneController roadAndCommnuneController =
      Get.put(RoadAndCommnuneController());
  late List<RoadAndCommnuneModel> list;
  @override
  void initState() {
    View_Data(
      srt: index,
    );
    controller = TabController(
        initialIndex: _AutoListState.index, length: Title.length, vsync: this);

    super.initState();
  }

  List<String> Title = [
    "Khan Chamkar Mon",
    "Khan Daun Penh",
    "Khan 7 Makara",
    "Khan Tuol Kouk",
    "Khan Mean Chey",
    "Khan Chbar Ampov",
    "Khan Chroy Changvar",
    "Khan Sensok",
    "Khan Russey Keo",
    "Khan Dangkor",
    "Khan Pou Senchey",
    "Khan Preaek Pnov",
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Title.length,
      child: Scaffold(
        appBar: AppBar(
            title: const Text("List of Auto"),
            bottom: TabBar(
              controller: controller,
              isScrollable: true,
              onTap: (value) {
                setState(() {
                  index = value;
                });
              },
              tabs: [
                for (int i = 0; i < Title.length; i++)
                  Tab(child: Text(Title.elementAt(i))),
              ],
            )),
        // ignore: prefer_const_literals_to_create_immutables
        body: TabBarView(controller: controller, children: [
          View_Data(
            srt: 0,
          ),
          View_Data(
            srt: 1,
          ),
          View_Data(
            srt: 2,
          ),
          View_Data(
            srt: 3,
          ),
          View_Data(
            srt: 4,
          ),
          View_Data(
            srt: 5,
          ),
          View_Data(
            srt: 6,
          ),
          View_Data(
            srt: 7,
          ),
          View_Data(
            srt: 8,
          ),
          View_Data(
            srt: 9,
          ),
          View_Data(
            srt: 10,
          ),
          View_Data(
            srt: 11,
          ),
        ]),
      ),
    );
  }
}

class View_Data extends StatefulWidget {
  const View_Data({super.key, required this.srt});
  final int srt;

  @override
  State<View_Data> createState() => _View_DataState();
}

class _View_DataState extends State<View_Data> {
  late List _list;
  TextStyle title = TextStyle(
    decoration: TextDecoration.underline,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  List<String> Title = [
    "Chamkarmon",
    "Daun Penh",
    "Prampi Makara",
    "Khan Tuol Kork",
    "MeanChey",
    "Chbar Ampov",
    "Chraoy Chongvar",
    "Khan Sen Sok",
    "Russei Keo",
    "Dangkor",
    "Pur SenChey",
    "Praek Pnov",
  ];
  @override
  void initState() {
    Title;
    Load();
    _list = [];
    print(widget.srt);
    print("${Title.elementAt(widget.srt)} district");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RoadAndCommnuneController roadAndCommnuneController =
        Get.put(RoadAndCommnuneController());
    var roadAndCommnune = roadAndCommnuneController.getRoadAndCommnune;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: GFAvatar(
            size: 20,
            child: Text("${_list.length}"),
          )),
      body: ((_list.length > 0)
          ? ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, i) {
                return Card(
                  // height: 300,
                  elevation: 10,
                  color: Colors.blue[100],
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.centerRight,
                        child: GFAvatar(
                          size: 20,
                          child: Text(_list[i]['cid'].toString()),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text("Commune : ", style: title),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                _list[i]['commune_name'].toString(),
                                textAlign: TextAlign.right,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text("District : ", style: title),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                _list[i]['district'].toString(),
                                textAlign: TextAlign.right,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text("Province : ", style: title),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                _list[i]['province'].toString(),
                                textAlign: TextAlign.right,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.amber[50],
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text("Max value : ", style: title),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            double.parse(_list[i]['max_value']
                                                    .toString())
                                                .toStringAsFixed(2),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            _showEditDialog(
                                                context, _list[i], 'max_value');
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text("Min value : ", style: title),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            double.parse(_list[i]['min_value']
                                                    .toString())
                                                .toStringAsFixed(2),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            _showEditDialog(
                                                context, _list[i], 'min_value');
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text("Name's Road is : ", style: title),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                _list[i]['road_name'].toString(),
                                textAlign: TextAlign.right,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                );
              })
          : Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(50.0),
              child: Text(''),
            )),
    );
  }

  void Load() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/rc_list?district=${Title.elementAt(widget.srt)}'));
    var jsonData = jsonDecode(rs.body);
    if (rs.statusCode == 200) {
      setState(() {
        _list = jsonData;
        print("Length =  ${_list.length}");
      });
    }
  }

  Future<void> update(Map<String, dynamic> data) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/update'));
    request.body = json.encode({
      "cid": data['cid'],
      "option": data['option'],
      "road_name": data['road_name'],
      "commune_name": data['commune_name'],
      "district": data['district'],
      "province": data['province'],
      "max_value": data['max_value'],
      "min_value": data['min_value'],
      "longitude": data['longitude'],
      "latitude": data['latitude']
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Load(); // Reload the data after update
    } else {
      print(response.reasonPhrase);
    }
  }

  void _showEditDialog(
      BuildContext context, Map<String, dynamic> data, String field) {
    TextEditingController controller =
        TextEditingController(text: data[field].toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ${field == 'max_value' ? 'Max' : 'Min'} Value'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Enter new value'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () async {
                setState(() {
                  data[field] = double.parse(controller.text);
                });
                await update(data);
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Success'),
                      content: Text('Update successful'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
