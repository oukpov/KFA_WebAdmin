import 'package:flutter/widgets.dart';
import '../Edit/edit_customer.dart';

class ResponsiveEditCustomer extends StatefulWidget {
  ResponsiveEditCustomer(
      {super.key,
      required this.email,
      required this.idController,
      required this.myIdController,
      required this.index,
      required this.list});
  List list;
  String index = '';
  String email = '';
  String idController = '';
  String myIdController = '';

  @override
  State<ResponsiveEditCustomer> createState() => _ResponsiveEditCustomerState();
}

class _ResponsiveEditCustomerState extends State<ResponsiveEditCustomer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 770) {
          return editCustomer(
              list: widget.list,
              index: widget.index,
              device: 'm',
              email: widget.email,
              idUsercontroller: widget.idController,
              myIdcontroller: widget.myIdController);
        } else if (constraints.maxWidth < 1199) {
          return editCustomer(
              list: widget.list,
              index: widget.index,
              device: 'd',
              email: widget.email,
              idUsercontroller: widget.idController,
              myIdcontroller: widget.myIdController);
        } else {
          return editCustomer(
              list: widget.list,
              index: widget.index,
              device: 'd',
              email: widget.email,
              idUsercontroller: widget.idController,
              myIdcontroller: widget.myIdController);
        }
      },
    );
  }
}
