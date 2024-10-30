import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonMapPage extends StatefulWidget {
  @override
  _PolygonMapPageState createState() => _PolygonMapPageState();
}

class _PolygonMapPageState extends State<PolygonMapPage> {
  late GoogleMapController mapController;

  // Define markers and polygons
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};

  @override
  void initState() {
    super.initState();
    _createPolygonWithMarkers();
  }

  void _createPolygonWithMarkers() {
    List<LatLng> polygonCoords = [
      LatLng(37.7749, -122.4194), // Example coordinates
      LatLng(37.8049, -122.4294),
      LatLng(37.7949, -122.4494),
    ];

    // Add polygon
    _polygons.add(Polygon(
      polygonId: PolygonId("polygon_1"),
      points: polygonCoords,
      strokeColor: Colors.blue,
      strokeWidth: 2,
      fillColor: Colors.blue.withOpacity(0.1),
    ));

    // Add draggable markers to each vertex
    for (int i = 0; i < polygonCoords.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId('marker_$i'),
          position: polygonCoords[i],
          draggable: true,
          onDragEnd: (newPosition) {
            setState(() {
              // Update the polygon with the new marker position
              polygonCoords[i] = newPosition;
              _polygons.clear();
              _polygons.add(Polygon(
                polygonId: PolygonId("polygon_1"),
                points: polygonCoords,
                strokeColor: Colors.blue,
                strokeWidth: 2,
                fillColor: Colors.blue.withOpacity(0.1),
              ));
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polygon with Draggable Markers'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 12,
        ),
        markers: _markers,
        polygons: _polygons,
      ),
    );
  }
}
