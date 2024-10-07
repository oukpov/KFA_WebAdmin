import 'dart:html' as html;
import 'package:flutter/material.dart';

class HomePagesssss extends StatefulWidget {
  @override
  _HomePagesssssState createState() => _HomePagesssssState();
}

class _HomePagesssssState extends State<HomePagesssss> {
  String _visibilityStatus = "Visible";

  @override
  void initState() {
    super.initState();
    // Listen for visibility changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Web Lifecycle Demo"),
      ),
      body: Center(
        child: Text(
          'Current Status: $_visibilityStatus',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
