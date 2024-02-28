import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget linkUrl(icon, url, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        launch(
          '$url',
          forceSafariVC: false,
          forceWebView: false,
        );
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.height * 0.018,
        backgroundImage: AssetImage('$icon'),
      ),
    ),
  );
}
