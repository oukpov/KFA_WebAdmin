import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:web_admin/Widgets/widgets.dart';
import 'package:web_admin/components/waiting.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/fonttext/fontText.dart';
import '../../../components/colors.dart';
import '../../../getx/Auth/setAdmin.dart';
import '../../../screen/Property/FirstProperty/component/Colors/appbar.dart';
import '../Customer/component/Web/simple/inputfiled.dart';

class SetAdminClass extends StatefulWidget {
  const SetAdminClass({super.key});

  @override
  State<SetAdminClass> createState() => _SetAdminClassState();
}

class _SetAdminClassState extends State<SetAdminClass> {
  late NumberPaginatorController _inputController;
  String? id;
  @override
  void initState() {
    _inputController = NumberPaginatorController();
    super.initState();
  }

  int page = 1;
  int perPage = 10;
  int lastpage = 1;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SetAdmin());
    return
        // Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //       onPressed: () {
        //         Get.back();
        //       },
        //       icon: const Icon(Icons.arrow_back)),
        //   title: const Text('Set Admin'),
        //   actions: [
        //     InkWell(
        //       onTap: () {
        //         AwesomeDialog(
        //                 width: 500,
        //                 context: context,
        //                 animType: AnimType.leftSlide,
        //                 headerAnimationLoop: false,
        //                 dialogType: DialogType.question,
        //                 showCloseIcon: false,
        //                 title: 'Do you want to Client to Admin?',
        //                 btnOkOnPress: () {
        //                   controller.setAdmin(id!);
        //                 },
        //                 btnCancelOnPress: () {},
        //                 // autoHide: const Duration(seconds: 2),
        //                 onDismissCallback: (type) {})
        //             .show();
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.all(5),
        //         child: Container(
        //           width: 80,
        //           decoration: BoxDecoration(
        //               border: Border.all(width: 1, color: greyColor),
        //               borderRadius: BorderRadius.circular(5),
        //               color: whiteColor),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Text('Submit',
        //                   style: TextStyle(
        //                       color: greyColor, fontWeight: FontWeight.bold)),
        //               Icon(Icons.download_done_outlined, color: greyColor)
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //     const SizedBox(width: 30)
        //   ],
        // ),
        // body:
        SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              child: Row(
                children: [
                  Inputfied(
                    filedName: "ID Client",
                    readOnly: false,
                    validator: false,
                    flex: 2,
                    value: (value) {
                      setState(() {
                        id = value;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      AwesomeDialog(
                              width: 500,
                              context: context,
                              animType: AnimType.leftSlide,
                              headerAnimationLoop: false,
                              dialogType: DialogType.question,
                              showCloseIcon: false,
                              title: 'Do you want to Client to Admin?',
                              btnOkOnPress: () {
                                controller.setAdmin(id!);
                              },
                              btnCancelOnPress: () {},
                              // autoHide: const Duration(seconds: 2),
                              onDismissCallback: (type) {})
                          .show();
                    },
                    child: Container(
                      height: 35,
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: greyColor),
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Submit',
                              style: TextStyle(
                                  color: greyColor,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.download_done_outlined, color: greyColor)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      child: Obx(
                        () {
                          if (controller.isSet.value) {
                            return const WaitingFunction();
                          } else if (controller.listAdmin.isEmpty) {
                            return const SizedBox();
                          } else {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                lastpage = controller.lastPage.value;
                              });
                            });
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: ListView.builder(
                                itemCount: controller.listAdmin.length,
                                itemBuilder: (context, index) => Container(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: greyColorNolots),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    children: [
                                      textfield("No.${index + 1}"),
                                      const SizedBox(width: 10),
                                      textfield(controller.listAdmin[index]
                                              ['control_user']
                                          .toString()),
                                      const Spacer(),
                                      textfield(
                                          "Name : ${controller.listAdmin[index]['username'] ?? ""}"),
                                      const SizedBox(width: 10),
                                      textfield(
                                          "Phone Number : ${controller.listAdmin[index]['tel_num'] ?? ""}"),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: NumberPaginator(
                        controller: _inputController,
                        numberPages: lastpage,
                        onPageChange: (int index) async {
                          if (index > 0) {
                            setState(() {
                              page = index + 1;
                            });

                            controller.fetchListAdmin(perPage, page);
                          }
                        },
                        initialPage: 0,
                        config: NumberPaginatorUIConfig(
                          buttonShape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                          ),
                          buttonUnselectedForegroundColor: blackColor,
                          buttonUnselectedBackgroundColor: whiteNotFullColor,
                          buttonSelectedForegroundColor: whiteColor,
                          buttonSelectedBackgroundColor: appback,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
        // ),
      ),
    );
  }
}
