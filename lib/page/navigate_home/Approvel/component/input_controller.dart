import 'package:flutter/material.dart';
import '../../../../Profile/components/Drop_down.dart';
import '../../../../components/colors.dart';

class Input_controller extends StatefulWidget {
  Input_controller(
      {super.key,
      required this.icon,
      required this.lable,
      required this.controllerback,
      required this.value,
      required this.pakage,
      required this.flex});
  final String value;
  final OnChangeCallback controllerback;
  final int flex;
  final int pakage;
  final String lable;
  var icon;
  @override
  State<Input_controller> createState() => _Input_controllerState();
}

class _Input_controllerState extends State<Input_controller> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    controller.text = widget.value;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool controllerBool = false;
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: (widget.pakage == 1)
            ? EdgeInsets.only(left: 30)
            : (widget.pakage == 2)
                ? EdgeInsets.only(right: 30)
                : EdgeInsets.only(right: 0),
        child: SizedBox(
          height: 40,
          child: TextFormField(
            controller: controller,
            onChanged: (value) {
              setState(() {
                widget.controllerback(controller.text);
              });
            },
            decoration: InputDecoration(
              prefixIcon: widget.icon,
              fillColor: kwhite,
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              labelStyle: TextStyle(color: kPrimaryColor),
              labelText: widget.lable,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
