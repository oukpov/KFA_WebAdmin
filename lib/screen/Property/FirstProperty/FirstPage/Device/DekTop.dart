import 'package:flutter/material.dart';

class DekTop extends StatefulWidget {
  const DekTop({super.key});

  @override
  State<DekTop> createState() => _DekTopState();
}

class _DekTopState extends State<DekTop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DekTop')),
    );
  }
}
