// ignore_for_file: unnecessary_import, implementation_imports, unused_import, prefer_adjacent_string_concatenation, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import '../../../controller/commercialandresidencial_controller.dart';
import '../../../models/commercialandresidencial_model.dart';

class AutoList extends StatelessWidget {
  final CommercialAndResidentialController controller =
      Get.put(CommercialAndResidentialController());
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
      length: 12,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("List of Auto"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              for (int i = 0; i < Title.length; i++) Tab(child: Text(Title[i])),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for (int i = 0; i < Title.length; i++) ViewData(khanIndex: i),
          ],
        ),
      ),
    );
  }
}

class ViewData extends StatelessWidget {
  final int khanIndex;
  final CommercialAndResidentialController controller = Get.find();

  ViewData({required this.khanIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          var filteredList = controller.commercialAndResidentialList
              .where((item) => item.khanID == khanIndex + 1)
              .toList();
          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              var item = filteredList[index];
              return Card(
                elevation: 10,
                color: Colors.blue[100],
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.all(5),
                    //   alignment: Alignment.centerRight,
                    //   child: Text("${item.khanID}"),
                    // ),
                    buildInfoRow("Khan", item.khanName ?? ''),
                    buildInfoRow("Province", item.province ?? ''),
                    buildInfoRow("Sangkat", item.sangkatName ?? ''),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          buildEditableRow("Residential Min",
                              item.residentialMinValue ?? ''),
                          buildEditableRow("Residential Max",
                              item.residentialMaxValue ?? ''),
                          buildEditableRow(
                              "Commercial Min", item.commercialMinValue ?? ''),
                          buildEditableRow(
                              "Commercial Max", item.commercialMaxValue ?? ''),
                          ElevatedButton(
                            child: Text('Update'),
                            onPressed: () => _showUpdateAllDialog(item),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              );
            },
          );
        }
      }),
      // floatingActionButton: Obx(() => FloatingActionButton(
      //       onPressed: () {},
      //       child: GFAvatar(
      //         size: 20,
      //         child: Text("${controller.commercialAndResidentialList.length}"),
      //       ),
      //     )),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text("$label : ",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }

  Widget buildEditableRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text("$label : ",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }

  void _showUpdateAllDialog(ComercialAndResidencialModel item) {
    TextEditingController residentialMinController =
        TextEditingController(text: item.residentialMinValue);
    TextEditingController residentialMaxController =
        TextEditingController(text: item.residentialMaxValue);
    TextEditingController commercialMinController =
        TextEditingController(text: item.commercialMinValue);
    TextEditingController commercialMaxController =
        TextEditingController(text: item.commercialMaxValue);

    Get.dialog(
      AlertDialog(
        title: Text('Update All Values'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: residentialMinController,
              decoration: InputDecoration(labelText: 'Residential Min'),
            ),
            TextField(
              controller: residentialMaxController,
              decoration: InputDecoration(labelText: 'Residential Max'),
            ),
            TextField(
              controller: commercialMinController,
              decoration: InputDecoration(labelText: 'Commercial Min'),
            ),
            TextField(
              controller: commercialMaxController,
              decoration: InputDecoration(labelText: 'Commercial Max'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Update'),
            onPressed: () {
              controller
                  .updateCommercialAndResidentialData(
                khanID: item.khanID!,
                sangkatID: item.sangkatID!,
                residentialMinValue: residentialMinController.text,
                residentialMaxValue: residentialMaxController.text,
                commercialMinValue: commercialMinController.text,
                commercialMaxValue: commercialMaxController.text,
              )
                  .then((_) {
                Get.back();
                Get.snackbar('Success', 'Update successful');
                controller
                    .fetchCommercialAndResidentialData(); // Refresh the data
              }).catchError((error) {
                Get.back();
                Get.snackbar('Error', 'Update failed: $error');
              });
            },
          ),
        ],
      ),
    );
  }
}
