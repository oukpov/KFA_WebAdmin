import 'package:flutter/material.dart';

import '../../../../../../../Profile/contants.dart';
import '../../../../component/Colors/appbar.dart';
import '../../../../component/Colors/colors.dart';

typedef OnChangeCallback = void Function(dynamic value);

class PriceOption extends StatefulWidget {
  const PriceOption({super.key, required this.min, required this.max});
  final OnChangeCallback min;
  final OnChangeCallback max;
  @override
  State<PriceOption> createState() => _PriceOptionState();
}

class _PriceOptionState extends State<PriceOption> {
  double w = 0;
  double rl = 0;
  String min = '';
  String max = '';
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    if (w <= 500) {
      rl = 20;
    } else if (w <= 1199) {
      rl = 100;
    } else {
      rl = 400;
    }
    return Padding(
      padding: EdgeInsets.only(
        right: rl,
        left: rl,
      ),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Colors.transparent,
        child: Container(
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: whiteColor,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Price Range',
                          style: TextStyle(
                              color: blackColor,
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) * 17,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: appback,
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        textDouble('Min*', 1),
                        const SizedBox(width: 10),
                        textDouble('Max*', 2),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: 40,
                width: double.infinity,
                color: appback,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(whiteColor)),
                          onPressed: () {
                            setState(() {
                              widget.min(min);
                              widget.max(max);
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            'Done',
                            style: TextStyle(color: blackColor),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textDouble(text, i) {
    return Expanded(
      child: SizedBox(
        height: 45,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextFormField(
            style: TextStyle(
              fontSize: MediaQuery.textScaleFactorOf(context) * 14,
              fontWeight: FontWeight.bold,
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                if (i == 1) {
                  min = value;
                } else {
                  max = value;
                }
              });
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              hintText: '$text',
              fillColor: kwhite,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.grey,
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
