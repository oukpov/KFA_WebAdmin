import 'package:flutter/widgets.dart';
import 'newhomepage.dart';

class ResponsiveHomePage extends StatefulWidget {
  const ResponsiveHomePage(
      {super.key,
      required this.id,
      required this.name,
      required this.controllerUser,
      required this.nativigation,
      required this.email});
  final String id;
  final String name;
  final String controllerUser;
  final bool nativigation;
  final String email;

  @override
  State<ResponsiveHomePage> createState() => _ResponsiveHomePageState();
}

class _ResponsiveHomePageState extends State<ResponsiveHomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 770) {
          return homescreen(
            device: 'm',
            controllerUser: widget.controllerUser,
            email: widget.email,
            id: widget.id,
            name: widget.name,
            nativigation: widget.nativigation,
          );
        } else if (constraints.maxWidth < 1199) {
          return homescreen(
            device: 't',
            controllerUser: widget.controllerUser,
            email: widget.email,
            id: widget.id,
            name: widget.name,
            nativigation: widget.nativigation,
          );
        } else {
          return homescreen(
            device: 'd',
            controllerUser: widget.controllerUser,
            email: widget.email,
            id: widget.id,
            name: widget.name,
            nativigation: widget.nativigation,
          );
        }
      },
    );
  }
}
