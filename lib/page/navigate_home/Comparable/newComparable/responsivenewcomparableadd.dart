import 'package:flutter/widgets.dart';
import 'package:web_admin/page/navigate_home/Comparable/newComparable/add_new_comparable.dart';

class ResponsivenewcomparableAdd extends StatefulWidget {
  ResponsivenewcomparableAdd({super.key, this.name, this.id});
  String? name;
  String? id;
  @override
  State<ResponsivenewcomparableAdd> createState() =>
      _ResponsivenewcomparableAddState();
}

class _ResponsivenewcomparableAddState
    extends State<ResponsivenewcomparableAdd> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 770) {
          return AddNewComarable(
            username: widget.name.toString(),
            device: 'm',
            email: '',
            idUsercontroller: widget.id.toString(),
            myIdcontroller: '',
          );
        } else if (constraints.maxWidth < 1199) {
          return AddNewComarable(
            username: widget.name.toString(),
            device: 'd',
            email: widget.name.toString(),
            idUsercontroller: widget.id.toString(),
            myIdcontroller: '',
          );
        } else {
          return AddNewComarable(
            username: widget.name.toString(),
            device: 'd',
            email: widget.name.toString(),
            idUsercontroller: widget.id.toString(),
            myIdcontroller: '',
          );
        }
      },
    );
  }
}
