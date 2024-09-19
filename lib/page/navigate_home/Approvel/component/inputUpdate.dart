import 'package:flutter/material.dart';
import '../../../../Profile/components/Drop_down.dart';
import '../../../../components/colors.dart';

class TextInputUpdate extends StatefulWidget {
  const TextInputUpdate(
      {Key? key,
      required this.backvalue,
      required this.value,
      required this.readonly,
      required this.type})
      : super(key: key);

  final OnChangeCallback backvalue;
  final String value;
  final bool readonly;
  final String type;
  @override
  State<TextInputUpdate> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputUpdate> {
  TextEditingController controller = TextEditingController();
  int proID = 0;
  String proName = "";
  @override
  void initState() {
    super.initState();
    controller.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          width: 100,
          child: TextFormField(
            readOnly: widget.readonly,
            onChanged: (value) {
              setState(() {
                widget.backvalue(controller.text);
              });
            },
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: (widget.readonly == true) ? Colors.red : greyColor),
            controller: controller,
            decoration: InputDecoration(
              fillColor: whiteColor,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: greyColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: (widget.readonly == true)
                  ? InputBorder.none
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                        color: greyColor,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        Text(
          widget.type,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: greenColors, fontSize: 11),
        )
      ],
    );
  }
}
