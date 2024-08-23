import 'package:flutter/widgets.dart';
import 'get_new_comparable.dart';

class ResponsivenewcomparableGet extends StatefulWidget {
  ResponsivenewcomparableGet({super.key, this.name, required this.index});
  String? name;
  var index;
  @override
  State<ResponsivenewcomparableGet> createState() =>
      _ResponsivenewcomparableGetState();
}

class _ResponsivenewcomparableGetState
    extends State<ResponsivenewcomparableGet> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 770) {
          return Get_NewComarable(
            index: widget.index,
            username: widget.name.toString(),
            device: 'm',
            email: '',
            idUsercontroller: '',
            myIdcontroller: '',
          );
        } else if (constraints.maxWidth < 1199) {
          return Get_NewComarable(
            index: widget.index,
            username: widget.name.toString(),
            device: 'd',
            email: '',
            idUsercontroller: '',
            myIdcontroller: '',
          );
        } else {
          return Get_NewComarable(
            index: widget.index,
            username: widget.name.toString(),
            device: 'd',
            email: '',
            idUsercontroller: '',
            myIdcontroller: '',
          );
        }
      },
    );
  }
}
