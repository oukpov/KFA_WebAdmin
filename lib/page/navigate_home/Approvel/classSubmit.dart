import 'package:flutter/material.dart';
import 'package:web_admin/page/navigate_home/Approvel/submit_list.dart';

class ClassSubmit extends StatefulWidget {
  const ClassSubmit({super.key, required this.device, required this.listUser});
  final String device;
  final List listUser;
  @override
  State<ClassSubmit> createState() => _ClassSubmitState();
}

class _ClassSubmitState extends State<ClassSubmit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListSubmitAdmin(device: widget.device, listUser: widget.listUser)
          ],
        ),
      ),
    );
  }
}
