import 'package:flutter/widgets.dart';

import 'get_new_comparable.dart';
import 'new_comparable.dart';

class Responsivenewcomparable extends StatefulWidget {
  Responsivenewcomparable({super.key, this.name});
  String? name;
  @override
  State<Responsivenewcomparable> createState() =>
      _ResponsivenewcomparableState();
}

class _ResponsivenewcomparableState extends State<Responsivenewcomparable> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 770) {
          return NewComarable(
            username: widget.name.toString(),
            device: 'm',
            email: '',
            idUsercontroller: '',
            myIdcontroller: '',
          );
        } else if (constraints.maxWidth < 1199) {
          return NewComarable(
            username: widget.name.toString(),
            device: 'd',
            email: widget.name.toString(),
            idUsercontroller: '',
            myIdcontroller: '',
          );
        } else {
          return NewComarable(
            username: widget.name.toString(),
            device: 'd',
            email: widget.name.toString(),
            idUsercontroller: '',
            myIdcontroller: '',
          );
        }
      },
    );
  }
}
