import 'package:flutter/cupertino.dart';
import 'package:search_map_location/utils/google_search/latlng.dart';

class MarkerData {
  final LatLng latLng;
  final String comparableId;
  final List<Widget> listWidgets;

  MarkerData({
    required this.latLng,
    required this.comparableId,
    required this.listWidgets,
  });
}
