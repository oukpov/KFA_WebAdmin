import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../components/colors/colors.dart';

class GoogleMapApprovel extends StatefulWidget {
  const GoogleMapApprovel({super.key, required this.lat, required this.log});
  final double lat;
  final double log;

  @override
  State<GoogleMapApprovel> createState() => _GoogleMapApprovelState();
}

class _GoogleMapApprovelState extends State<GoogleMapApprovel> {
  final Set<Marker> listMarkerIds = {};
  CameraPosition? cameraPosition;
  GoogleMapController? mapController;
  Set<Polygon> polygons = {};

  Future<void> findLocation() async {
    setState(() {
      Marker marker = Marker(
        draggable: true,
        markerId: MarkerId(LatLng(widget.lat, widget.log).toString()),
        position: LatLng(widget.lat, widget.log),
      );
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(widget.lat, widget.log), zoom: 17)));
      setState(() {
        listMarkerIds.add(marker);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    findLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whileColors,
        title: TextButton(
            onPressed: () {},
            child: const Text(
              'Check on Google Map',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          markers: listMarkerIds.map((e) => e).toSet(),
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.lat, widget.log),
            zoom: 24.0,
          ),
          polygons: Set<Polygon>.of(polygons),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.hybrid,
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
          onCameraMove: (CameraPosition cameraPosition) {
            this.cameraPosition = cameraPosition;
          },
        ),
      ),
    );
  }
}
