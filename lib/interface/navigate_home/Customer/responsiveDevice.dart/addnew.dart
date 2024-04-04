import 'package:flutter/widgets.dart';

import '../AddNew/new_customer.dart';

class ResponsiveCustomer extends StatefulWidget {
  ResponsiveCustomer(
      {super.key,
      required this.email,
      required this.idController,
      required this.myIdController});
  String email = '';
  String idController = '';
  String myIdController = '';

  @override
  State<ResponsiveCustomer> createState() => _ResponsiveCustomerState();
}

class _ResponsiveCustomerState extends State<ResponsiveCustomer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 770) {
          return new_customer(
              device: 'm',
              email: widget.email,
              idUsercontroller: widget.idController,
              myIdcontroller: widget.myIdController);
        } else if (constraints.maxWidth < 1199) {
          return new_customer(
              device: 'd',
              email: widget.email,
              idUsercontroller: widget.idController,
              myIdcontroller: widget.myIdController);
        } else {
          return new_customer(
              device: 'd',
              email: widget.email,
              idUsercontroller: widget.idController,
              myIdcontroller: widget.myIdController);
        }
      },
    );
  }
}
