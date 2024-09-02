import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Profile/components/Drop_down.dart';
import '../components/colors.dart';

class FormTwinNController extends StatefulWidget {
  final String label1;
  final String label2;

  final Widget icon1;
  final Widget icon2;
  final OnChangeCallback controller1Back;
  final OnChangeCallback controller2Back;
  final String controller1;
  final String controller2;
  const FormTwinNController({
    Key? key,
    required this.label1,
    required this.label2,
    required this.icon1,
    required this.icon2,
    required this.controller1Back,
    required this.controller2Back,
    required this.controller1,
    required this.controller2,
  }) : super(key: key);

  @override
  State<FormTwinNController> createState() => _FormTwinNControllerState();
}

class _FormTwinNControllerState extends State<FormTwinNController> {
  // final TextEditingController _controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller1.text = widget.controller1;
    controller2.text = widget.controller2;
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 58,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: TextFormField(
                controller: controller1,
                onChanged: (value) {
                  setState(() {
                    widget.controller1Back(value);
                  });
                },
                decoration: InputDecoration(
                  fillColor: kwhite,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  labelText: widget.label1,
                  prefixIcon: widget.icon1,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: SizedBox(
            height: 55,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
              child: TextFormField(
                onChanged: (value) {
                  widget.controller2Back(value);
                },
                controller: controller2,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  fillColor: kwhite,
                  filled: true,
                  labelText: widget.label2,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  prefixIcon: widget.icon2,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: kPrimaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
