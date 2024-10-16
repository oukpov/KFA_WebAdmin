import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart'
    as street_view;
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';

class StreetViewWidget extends StatefulWidget {
  @override
  _StreetViewWidgetState createState() => _StreetViewWidgetState();
}

class _StreetViewWidgetState extends State<StreetViewWidget> {
  street_view.StreetViewController? streetViewController;
  LatLng selectedPolygonPosition =
      LatLng(11.5564, 104.9282); // Default position

  void _onMapTapped(LatLng position) {
    setState(() {
      selectedPolygonPosition = position;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenStreetView(
          initialPosition: selectedPolygonPosition,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Street View')),
      body: GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: CameraPosition(
          target: selectedPolygonPosition,
          zoom: 14.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('selectedPosition'),
            position: selectedPolygonPosition,
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          // You can do something with the controller if needed
        },
        onTap: _onMapTapped, // Add tap functionality to select polygon
      ),
    );
  }
}

class FullScreenStreetView extends StatelessWidget {
  final LatLng initialPosition;

  FullScreenStreetView({required this.initialPosition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appback,
        title: const Text('Street View'),
        // leading: IconButton(
        //   icon: Icon(Icons.save),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: street_view.FlutterGoogleStreetView(
        initPos: street_view.LatLng(
          initialPosition.latitude,
          initialPosition.longitude,
        ),
        initBearing: 30.0,
        initTilt: 30.0,
        initZoom: 1.0,
        onStreetViewCreated: (street_view.StreetViewController controller) {
          // You can do something with the controller if needed
        },
      ),
    );
  }
}
