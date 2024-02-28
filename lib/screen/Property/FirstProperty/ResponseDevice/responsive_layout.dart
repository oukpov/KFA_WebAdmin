import 'package:flutter/widgets.dart';

import '../FirstPage/HomeScreen.dart';

class ResponsiveLayout extends StatefulWidget {
  ResponsiveLayout(
      {super.key,
      required this.email,
      required this.idController,
      required this.myIdController});
  String email = '';
  String idController = '';
  String myIdController = '';

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 770) {
          return HomeScreen(
            myIdcontroller: widget.myIdController,
            device: 'mobile',
            email: widget.email,
            idUsercontroller: widget.idController,
          );
        } else if (constraints.maxWidth < 1199) {
          return HomeScreen(
            myIdcontroller: widget.myIdController,
            device: 'tablet',
            email: widget.email,
            idUsercontroller: widget.idController,
          );
        } else {
          return HomeScreen(
            myIdcontroller: widget.myIdController,
            device: 'dektop',
            email: widget.email,
            idUsercontroller: widget.idController,
          );
        }
      },
    );
  }
}
