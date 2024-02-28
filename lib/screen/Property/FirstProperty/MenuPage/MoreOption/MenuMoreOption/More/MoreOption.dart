import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../../../api/contants.dart';
import '../../../../../../../components/comment.dart';
import '../../../../../Getx_api/vetbal_controller.dart';
import '../../../../component/Colors/appbar.dart';
import '../../../../component/Colors/colors.dart';

class OptionshowModalBottomSheet extends StatefulWidget {
  const OptionshowModalBottomSheet(
      {super.key,
      required this.max,
      required this.min,
      required this.province});
  final OnChangeCallback min;
  final OnChangeCallback max;
  final OnChangeCallback province;
  @override
  State<OptionshowModalBottomSheet> createState() =>
      _OptionshowModalBottomSheetState();
}

class _OptionshowModalBottomSheetState
    extends State<OptionshowModalBottomSheet> {
  Controller_verbal controller = Controller_verbal();
  @override
  void initState() {
    province();
    super.initState();
  }

  double w = 0;
  double rl = 0;
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
          height: 400,
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
                          'Lot Size',
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
                    const SizedBox(height: 10),
                    Text('Location',
                        style: TextStyle(
                            color: blackColor,
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 17,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    dropdown('  All Province/City', listProvince,
                        'property_type_id', 'Name_cummune'),
                    dropdown('  All District/Khan', [], '', ''),
                    dropdown('  All Commune/Sangkat', [], '', ''),
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
                  widget.min(value);
                } else {
                  widget.max(value);
                }
              });
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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

  Widget dropdown(text, List list, valueDrop, nameDropdown) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 10, bottom: 10),
      child: Container(
        height: 35,
        // width: wDropDown,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.5, color: greyColor)),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            // suffixIcon: (i == 5)
            //     ? InkWell(
            //         onTap: () {
            //           setState(() {
            //             moreOPTion();
            //           });
            //         },
            //         child: Container(
            //           decoration: BoxDecoration(
            //               color: appback,
            //               borderRadius: const BorderRadius.only(
            //                   topRight: Radius.circular(5),
            //                   bottomRight: Radius.circular(5))),
            //           width: 30,
            //           child: const Icon(
            //             Icons.search,
            //             color: Colors.white,
            //           ),
            //         ),
            //       )
            //     : null,
            fillColor: kwhite,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            filled: true,
            // labelText: text,
            labelStyle: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * 14),
            hintText: text,
            hintStyle: TextStyle(color: blackColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appback, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.5,
                color: Color.fromARGB(255, 127, 127, 127),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            border: InputBorder.none,

            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: kerror,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          items: list
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value["$valueDrop"].toString(),
                  child: Center(
                    child: Text(
                      " ${value["$nameDropdown"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * 14,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              widget.province(value);
            });
          },
        ),
      ),
    );
  }

  List listProvince = [];
  Future<void> province() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Commune_25_all'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonBody = jsonDecode(response.body)['data'];

        setState(() {
          listProvince = jsonBody;
        });
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }
}
