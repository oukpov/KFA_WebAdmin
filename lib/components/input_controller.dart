import 'package:flutter/material.dart';

import '../Profile/components/Drop_down.dart';
import 'colors.dart';

// ignore: must_be_immutable
class InputController extends StatefulWidget {
  const InputController({
    super.key,
    required this.controllerback,
    required this.value,
  });
  final String value;
  final OnChangeCallback controllerback;

  @override
  State<InputController> createState() => _InputControllerState();
}

class _InputControllerState extends State<InputController> {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SizedBox(
        height: 25,
        width: 130,
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            setState(() {
              widget.controllerback(controller.text);
            });
          },
          decoration: InputDecoration(
            fillColor: kwhite,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            labelStyle: const TextStyle(color: kPrimaryColor),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: kPrimaryColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }
}
