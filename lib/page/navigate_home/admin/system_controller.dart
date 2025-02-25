import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/components/colors/colors.dart';
import 'package:web_admin/components/waiting.dart';
import 'package:web_admin/getx/checkUpdate/updateCheck.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';

class SysytemController extends StatefulWidget {
  const SysytemController({super.key});

  @override
  State<SysytemController> createState() => _SysytemControllerState();
}

class _SysytemControllerState extends State<SysytemController> {
  bool isSwitched = false;
  List listSystem1 = [
    {'title': 'Update System Client'},
    {'title': 'Update System Admin'},
  ];
  List listSystem2 = [
    {'title': 'Client System!'},
    {'title': 'Admin System!'},

    // {'title': 'Off Client System!'},
    // {'title': 'Open Client System!'},
    // {'title': 'Off Admin System!'},
    // {'title': 'Open Admin System!'},
  ];
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ControllerUpdate());
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () {
          if (controller.isSystem.value) {
            return const WaitingFunction();
          } else if (controller.listSystem.isEmpty) {
            return const SizedBox(
              child: Text('No Data'),
            );
          } else {
            return Wrap(
              children: [
                for (int i = 0; i < listSystem1.length; i++)
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        backgroundColor: Colors.blue,
                        textStyle: TextStyle(fontSize: 18, color: whileColors),
                      ),
                      onPressed: () {},
                      child: Text(
                        listSystem1[i]['title'].toString(),
                        style: TextStyle(
                          color: whileColors,
                          fontSize: 14,
                        ),
                      )),
                const SizedBox(width: 20),
                for (int i = 0; i < controller.listSystem.length; i++)
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: greyColorNolots),
                    child: Row(
                      children: [
                        Switch(
                          value: (int.tryParse(controller.listSystem[i]['check']
                                          ?.toString() ??
                                      '0') ==
                                  1)
                              ? true
                              : false,
                          onChanged: (value) async {
                            setState(() {
                              if (controller.listSystem[i]['check'] == '0') {
                                controller.listSystem[i]['check'] = '1';
                              } else {
                                controller.listSystem[i]['check'] = '0';
                              }
                            });
                            if (controller.listSystem[i]['id'] == '1') {
                              // await controller.checkOFFSystemAll(2, 2, context);
                            } else {
                              // await controller.checkOFFSystemAll(2, 0, context);
                            }
                          },
                          activeColor: whileColors,
                          inactiveThumbColor: whileColors,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          controller.listSystem[i]['title'].toString(),
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: whileColors,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
