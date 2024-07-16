import 'package:flutter/widgets.dart';
import 'package:web_admin/interface/navigate_home/Comparable/newComparable/update_new_comparable.dart';

class ResponsiveHomePupdate extends StatefulWidget {
  ResponsiveHomePupdate({
    super.key,
    required this.list,
  });
  var list;
  @override
  State<ResponsiveHomePupdate> createState() => _ResponsiveHomePupdateState();
}

class _ResponsiveHomePupdateState extends State<ResponsiveHomePupdate> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 770) {
          return Update_NewComarable(
            list: widget.list,
            device: 'm',
            email: '',
            idUsercontroller: '',
            myIdcontroller: '',
          );
        } else if (constraints.maxWidth < 1199) {
          return Update_NewComarable(
            list: widget.list,
            device: 'd',
            email: '',
            idUsercontroller: '',
            myIdcontroller: '',
          );
        } else {
          return Update_NewComarable(
            list: widget.list,
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
