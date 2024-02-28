import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;
  final Set<Marker> markers = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Markers Example'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // San Francisco, CA
          zoom: 12.0,
        ),
        markers: markers,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    // Add markers to the map
    _addMarker(LatLng(37.7749, -122.4194), 'Marker 1', 'San Francisco, CA');
    _addMarker(LatLng(37.7833, -122.4167), 'Marker 2', 'Another Location');
    _addMarker(LatLng(37.7749, -122.4294), 'Marker 3', 'Yet Another Location');
  }

  void _addMarker(LatLng position, String markerId, String markerTitle) {
    final Marker marker = Marker(
      markerId: MarkerId(markerId),
      position: position,
      infoWindow: InfoWindow(
        title: markerTitle,
      ),
    );

    setState(() {
      markers.add(marker);
    });
  }
}
