// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  GoogleMapScreen({super.key, required this.id});
  String? id;
  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  void initState() {
    latlog_await();
    super.initState();
  }

  double lat = 0;
  double log = 0;
  bool latlog = false;
  Future<void> latlog_await() async {
    latlog = true;
    await Future.wait([lat_log()]);
    setState(() {
      latlog = false;
    });
  }

  List list_latlog = [];
  Future<void> lat_log() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/loglat_property_update/${widget.id}'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body)['data'];
      list_latlog = jsonData;
      setState(() {
        list_latlog;
        lat = double.parse(list_latlog[0]['lat'].toString());
        log = double.parse(list_latlog[0]['log'].toString());
      });
    }
  }

  // final LatLng targetLocation = LatLng(lat, 104.920688);
  // San Francisco, CA
  @override
  Widget build(BuildContext context) {
    // return Text('lat = ${widget.id} list = ${lat}');
    // return Container(
    //               height: MediaQuery.of(context).size.height * 0.6,
    //         width: double.infinity,
    //         child:ClipRRect(
    //               borderRadius: BorderRadius.circular(10),
    //               child: FadeInImage.assetNetwork(
    //                 placeholder: 'assets/earth.gif',
    //                 image: ,
    //                 fit: BoxFit.cover,
    //                 width: double.infinity,
    //               ),
    //             ) ,
    // );
    return (lat == 0)
        ? SizedBox()
        : Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2, color: Color.fromARGB(255, 122, 122, 122))),
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, log),
                zoom: 16.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('My location'),
                  position: LatLng(lat, log),
                ),
              },
            ),
          );
  }
}
