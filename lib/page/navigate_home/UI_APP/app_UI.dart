import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/components/colors/colors.dart';
import '../../../components/Title_promo.dart';
import '../../../components/UI App/Model-responsive.dart';
import '../../../components/waiting.dart';
import '../../../getx/ui_app/backgroup_Icons.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;

class UIAPP extends StatefulWidget {
  const UIAPP({super.key, required this.device});
  final String device;
  @override
  State<UIAPP> createState() => _UIAPPState();
}

class _UIAPPState extends State<UIAPP> {
  String textLock = "************";
  List<IconData> listIcons = [
    Icons.home,
    Icons.question_answer,
    Icons.contact_phone,
    Icons.people,
    Icons.feedback,
  ];
  List listTitle = [
    {"title": "Home"},
    {"title": "FAQ"},
    {"title": "Contact"},
    {"title": "About"},
    {"title": "Feedback"},
  ];
  String imageURL =
      "https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/icons_application/downloadImage.png";
  // List<Unit8List> listImage = [];
  @override
  Widget build(BuildContext context) {
    // final downloadImage = Get.put(DownloadImage());
    final iconsOption = Get.put(BackgroupIcons());
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: 400,
                color: greenColors,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width * 0.7,
                  child: Container(
                    // margin: const EdgeInsets.only(right: 30),
                    decoration: BoxDecoration(
                        // image: DecorationImage(
                        //     image: NetworkImage(list[0]['url'].toString()),
                        //     fit: BoxFit.cover),
                        border: Border.all(width: 1, color: blackColor)),
                    width: 400,
                    height: 700,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: SingleChildScrollView(
                        child: Stack(children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 70,
                                ),
                                margin: const EdgeInsets.only(top: 160),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 40,
                                        width: double.infinity,
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 15,
                                        ),
                                        decoration: BoxDecoration(
                                          // color: (list[0]['check'].toString() ==
                                          //         "0")
                                          //     ? kwhite_new
                                          //     : null,
                                          // image: (list[0]['check'].toString() ==
                                          //         "1")
                                          //     ? DecorationImage(
                                          //         image: NetworkImage(
                                          //           list[9]['url'].toString(),
                                          //         ),
                                          //         fit: BoxFit.fitWidth,
                                          //       )
                                          //     : null,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 2,
                                              color: Colors.grey,
                                              offset: Offset(-1, 1),
                                            )
                                          ],
                                          border: Border.all(
                                            // color:
                                            //     (list[0]['check'].toString() ==
                                            //             "1")
                                            //         ? whileColors
                                            //         : kImageColor,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  "Waiting approver",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Text(
                                              "New  ",
                                              style: TextStyle(
                                                color: whileColors,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                255,
                                                217,
                                                47,
                                                35,
                                              ),
                                              radius: 15,
                                            ),
                                            const Icon(
                                              Icons
                                                  .keyboard_arrow_right_outlined,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Wrap(
                                        spacing: 15.0,
                                        runSpacing: 15.0,
                                        children: <Widget>[
                                          // if (list[0]['check'].toString() ==
                                          //     "0")
                                          //   Column(
                                          //     mainAxisSize: MainAxisSize.min,
                                          //     children: [
                                          //       Stack(
                                          //         children: [
                                          //           Container(
                                          //             height: 90,
                                          //             width: 92,
                                          //             decoration: BoxDecoration(
                                          //               color: Colors.white,
                                          //               borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(
                                          //                 15,
                                          //               ),
                                          //               boxShadow: const [
                                          //                 kDefaultShadow
                                          //               ],
                                          //             ),
                                          //             child: Material(
                                          //               color:
                                          //                   Colors.transparent,
                                          //               child: InkWell(
                                          //                 borderRadius:
                                          //                     BorderRadius
                                          //                         .circular(
                                          //                   15,
                                          //                 ),
                                          //                 onTap: () {},
                                          //                 child: Column(
                                          //                   mainAxisAlignment:
                                          //                       MainAxisAlignment
                                          //                           .center,
                                          //                   children: [
                                          //                     SizedBox(
                                          //                       height: 47,
                                          //                       width: 47,
                                          //                       child: Padding(
                                          //                         padding:
                                          //                             const EdgeInsets
                                          //                                     .all(
                                          //                                 5.0),
                                          //                         child: Image
                                          //                             .network(
                                          //                           list[1]['url']
                                          //                               .toString(),
                                          //                           // color: kImageColor,
                                          //                         ),
                                          //                       ),
                                          //                     ),
                                          //                     const Text(
                                          //                       "Top Up",
                                          //                       style:
                                          //                           TextStyle(
                                          //                         fontSize: 12,
                                          //                       ),
                                          //                     ),
                                          //                   ],
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //           Positioned(
                                          //             top: 5,
                                          //             left: 62,
                                          //             child: CircleAvatar(
                                          //               backgroundColor:
                                          //                   whileColors,
                                          //               radius: 15,
                                          //               // backgroundImage:
                                          //               //     NetworkImage(
                                          //               //   downloadImage
                                          //               //       .urlImage(
                                          //               //     downloadImage
                                          //               //         .listImage4,
                                          //               //     "51",
                                          //               //   ),
                                          //               // ),
                                          //               child: Padding(
                                          //                 padding:
                                          //                     const EdgeInsets
                                          //                         .only(
                                          //                   bottom: 6,
                                          //                 ),
                                          //                 child: Row(
                                          //                   mainAxisAlignment:
                                          //                       MainAxisAlignment
                                          //                           .center,
                                          //                   children: [
                                          //                     Text(
                                          //                       " -30%",
                                          //                       style:
                                          //                           TextStyle(
                                          //                         color:
                                          //                             whileColors,
                                          //                         fontSize: 9,
                                          //                       ),
                                          //                     ),
                                          //                   ],
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       )
                                          //     ],
                                          //   )
                                          // else
                                          // const SizedBox()
                                          //   SCard(
                                          //     backgroup:
                                          //         list[7]['url'].toString(),
                                          //     item: list,
                                          //     num: 1,
                                          //     title: 'Top Up',
                                          //     press: () {},
                                          //   ),
                                          // SCard(
                                          //   backgroup:
                                          //       list[7]['url'].toString(),
                                          //   item: list,
                                          //   num: 2,
                                          //   title: 'Wallet',
                                          //   press: () {},
                                          // ),
                                          // SCard(
                                          //   backgroup:
                                          //       list[7]['url'].toString(),
                                          //   item: list,
                                          //   num: 3,
                                          //   title: 'Cross Check',
                                          //   press: () {},
                                          // ),
                                          // SCard(
                                          //   backgroup:
                                          //       list[7]['url'].toString(),
                                          //   item: list,
                                          //   num: 4,
                                          //   title: 'Verbal List',
                                          //   press: () {},
                                          // ),
                                          // SCard(
                                          //   backgroup:
                                          //       list[7]['url'].toString(),
                                          //   item: list,
                                          //   num: 5,
                                          //   title: 'Property',
                                          //   press: () {},
                                          // ),
                                          // SCard(
                                          //   backgroup:
                                          //       list[7]['url'].toString(),
                                          //   item: list,
                                          //   num: 6,
                                          //   title: 'News',
                                          //   press: () async {},
                                          // ),
                                          // SCard(
                                          //   backgroup:
                                          //       list[7]['url'].toString(),
                                          //   item: list,
                                          //   num: 10,
                                          //   title: 'Groups',
                                          //   press: () async {},
                                          // ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // TitlePromotion(
                                    //   check: list[0]['check'].toString(),
                                    //   titlePromo: 'Our Partners',
                                    //   titlePromo1: 'Show All',
                                    // ),
                                    Container(
                                      height: 50,
                                      width: 370,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          for (int i = 0; i < 5; i++)
                                            Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  decoration: BoxDecoration(
                                                    // color: (list[0]['check']
                                                    //             .toString() ==
                                                    //         "0")
                                                    //     ? blackColor
                                                    //     : whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ))
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.blueAccent,
                                      thickness: 0.5,
                                    ),
                                    const SizedBox(height: 10),
                                    // TitlePromotion(
                                    //   check: list[0]['check'].toString(),
                                    //   titlePromo: 'Our Membership',
                                    //   titlePromo1: 'Show All',
                                    // ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 50,
                                      width: 370,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          for (int i = 0; i < 5; i++)
                                            Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  decoration: BoxDecoration(
                                                    // color: (list[0]['check']
                                                    //             .toString() ==
                                                    //         "0")
                                                    //     ? blackColor
                                                    //     : whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      height: 60,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        // color:
                                        //     (list[0]['check'].toString() == "0")
                                        //         ? whiteColor
                                        //         : null,
                                        // image:
                                        //     (list[0]['check'].toString() == "0")
                                        //         ? null
                                        //         : DecorationImage(
                                        //             image: NetworkImage(
                                        //               list[9]['url'].toString(),
                                        //             ),
                                        //             fit: BoxFit.cover,
                                        //           ),
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: kImageColor,
                                            blurStyle: BlurStyle.solid,
                                            spreadRadius: 0.0,
                                            offset: Offset(0.2, 0.1),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          for (int i = 0;
                                              i < listIcons.length;
                                              i++)
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                margin: const EdgeInsets.only(
                                                    left: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      listIcons[i],
                                                      // color: (list[0]['check']
                                                      //             .toString() ==
                                                      //         "0")
                                                      //     ? blackColor
                                                      //     : whiteColor,
                                                      size: 20,
                                                    ),
                                                    Text(
                                                      listTitle[i]['title']
                                                          .toString(),
                                                      style: TextStyle(
                                                        // color: (list[0]['check']
                                                        //             .toString() ==
                                                        //         "0")
                                                        //     ? blackColor
                                                        //     : whiteColor,
                                                        fontSize: 12,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    if (_byesData != null)
                                      Column(
                                        children: [
                                          if (_byesData != null &&
                                              cropORopen == false)
                                            SizedBox(
                                              height: 150,
                                              child: Image.memory(
                                                _byesData!,
                                              ),
                                            )
                                          else if (getbytes != null &&
                                              cropORopen == true)
                                            SizedBox(
                                                height: 150,
                                                child: Image.memory(getbytes!)),
                                          IconButton(
                                              onPressed: () {
                                                cropImage();
                                              },
                                              icon: const Icon(
                                                Icons.crop,
                                                size: 35,
                                                color: Colors.grey,
                                              )),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 90.0,
                            child: InkWell(
                              onTap: () {
                                openImgae();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 15, left: 15),
                                child: Container(
                                  height: 120,
                                  width: 340,
                                  decoration: BoxDecoration(
                                    color: whileColors,
                                    image: (_byesData != null &&
                                            cropORopen == false)
                                        ? DecorationImage(
                                            image: MemoryImage(
                                              _byesData!,
                                            ),
                                            fit: BoxFit.cover)
                                        : (getbytes != null &&
                                                cropORopen == true)
                                            ? DecorationImage(
                                                image: MemoryImage(
                                                  getbytes!,
                                                ),
                                                fit: BoxFit.cover)
                                            : DecorationImage(
                                                image: NetworkImage(
                                                  imageURL,
                                                ),
                                                fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5,
                                        color: kImageColor,
                                        blurStyle: BlurStyle.solid,
                                        spreadRadius: 0.0,
                                        offset: Offset(0.2, 0.1),
                                      )
                                    ],
                                  ),
                                  child: Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Main Balance : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      textLock,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red,
                                                        fontSize: MediaQuery.of(
                                                              context,
                                                            ).textScaleFactor *
                                                            12,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "  VPoint",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    // SizedBox(
                                                    //   height:
                                                    //       20,
                                                    //   width: 20,
                                                    //   child:
                                                    //       CatchNetworkObx(
                                                    //     noImage:
                                                    //         "19",
                                                    //     item: downloadImage
                                                    //         .listImage4,
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            color: Colors.white,
                                            endIndent: 15,
                                            indent: 15,
                                            height: 1,
                                            thickness: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Created Verbal : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      textLock,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red,
                                                        fontSize: MediaQuery.of(
                                                              context,
                                                            ).textScaleFactor *
                                                            12,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "  VPoint",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    // SizedBox(
                                                    //   height:
                                                    //       15,
                                                    //   width: 15,
                                                    //   child:
                                                    //       CatchNetworkObx(
                                                    //     noImage:
                                                    //         "19",
                                                    //     item: downloadImage
                                                    //         .listImage4,
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            color: Colors.white,
                                            endIndent: 15,
                                            indent: 15,
                                            height: 1,
                                            thickness: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "My Plans : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(
                                                          context,
                                                        ).textScaleFactor *
                                                        10,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  textLock,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            color: Colors.white,
                                            endIndent: 15,
                                            indent: 15,
                                            height: 1,
                                            thickness: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Valid Until : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  textLock,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ),
                            //     }
                            //   },
                            // ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width * 0.7,
                  child: Obx(
                    () {
                      if (iconsOption.isIcons.value) {
                        return const WaitingFunction();
                      } else if (iconsOption.listLenght.value == 0) {
                        return const SizedBox();
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: iconsOption.listLenght.value,
                            itemBuilder: (context, index) {
                              List list = iconsOption.listOption[iconsOption
                                  .listOption["option"][index]['title']
                                  .toString()];
                              return Container(
                                margin: const EdgeInsets.only(right: 30),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            list[0]['url'].toString()),
                                        fit: BoxFit.cover),
                                    border: Border.all(
                                        width: 1, color: blackColor)),
                                width: 400,
                                height: 700,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15, left: 15),
                                  child: SingleChildScrollView(
                                    child: Stack(children: [
                                      Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 70,
                                            ),
                                            margin:
                                                const EdgeInsets.only(top: 160),
                                            decoration: BoxDecoration(
                                              color: (list[0]['check']
                                                          .toString() ==
                                                      "1")
                                                  ? null
                                                  : whileColors,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 40,
                                                    width: double.infinity,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 10,
                                                      left: 10,
                                                    ),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 15,
                                                      vertical: 15,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: (list[0]['check']
                                                                  .toString() ==
                                                              "0")
                                                          ? kwhite_new
                                                          : null,
                                                      image: (list[0]['check']
                                                                  .toString() ==
                                                              "1")
                                                          ? DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                list[9]['url']
                                                                    .toString(),
                                                              ),
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            )
                                                          : null,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          blurRadius: 2,
                                                          color: Colors.grey,
                                                          offset: Offset(-1, 1),
                                                        )
                                                      ],
                                                      border: Border.all(
                                                        color: (list[0]['check']
                                                                    .toString() ==
                                                                "1")
                                                            ? whileColors
                                                            : kImageColor,
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Text(
                                                              "Waiting approver",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          "New  ",
                                                          style: TextStyle(
                                                            color: whileColors,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        const CircleAvatar(
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                            255,
                                                            217,
                                                            47,
                                                            35,
                                                          ),
                                                          radius: 15,
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .keyboard_arrow_right_outlined,
                                                          color: Colors.white,
                                                          size: 25,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Wrap(
                                                    spacing: 15.0,
                                                    runSpacing: 15.0,
                                                    children: <Widget>[
                                                      if (list[0]['check']
                                                              .toString() ==
                                                          "0")
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Stack(
                                                              children: [
                                                                Container(
                                                                  height: 90,
                                                                  width: 92,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      15,
                                                                    ),
                                                                    boxShadow: const [
                                                                      kDefaultShadow
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    child:
                                                                        InkWell(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        15,
                                                                      ),
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                47,
                                                                            width:
                                                                                47,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Image.network(
                                                                                list[1]['url'].toString(),
                                                                                // color: kImageColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Text(
                                                                            "Top Up",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  top: 5,
                                                                  left: 62,
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        whileColors,
                                                                    radius: 15,
                                                                    // backgroundImage:
                                                                    //     NetworkImage(
                                                                    //   downloadImage
                                                                    //       .urlImage(
                                                                    //     downloadImage
                                                                    //         .listImage4,
                                                                    //     "51",
                                                                    //   ),
                                                                    // ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        bottom:
                                                                            6,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            " -30%",
                                                                            style:
                                                                                TextStyle(
                                                                              color: whileColors,
                                                                              fontSize: 9,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      else
                                                        // const SizedBox()
                                                        SCard(
                                                          backgroup: list[7]
                                                                  ['url']
                                                              .toString(),
                                                          item: list,
                                                          num: 1,
                                                          title: 'Top Up',
                                                          press: () {},
                                                        ),
                                                      SCard(
                                                        backgroup: list[7]
                                                                ['url']
                                                            .toString(),
                                                        item: list,
                                                        num: 2,
                                                        title: 'Wallet',
                                                        press: () {},
                                                      ),
                                                      SCard(
                                                        backgroup: list[7]
                                                                ['url']
                                                            .toString(),
                                                        item: list,
                                                        num: 3,
                                                        title: 'Cross Check',
                                                        press: () {},
                                                      ),
                                                      SCard(
                                                        backgroup: list[7]
                                                                ['url']
                                                            .toString(),
                                                        item: list,
                                                        num: 4,
                                                        title: 'Verbal List',
                                                        press: () {},
                                                      ),
                                                      SCard(
                                                        backgroup: list[7]
                                                                ['url']
                                                            .toString(),
                                                        item: list,
                                                        num: 5,
                                                        title: 'Property',
                                                        press: () {},
                                                      ),
                                                      SCard(
                                                        backgroup: list[7]
                                                                ['url']
                                                            .toString(),
                                                        item: list,
                                                        num: 6,
                                                        title: 'News',
                                                        press: () async {},
                                                      ),
                                                      SCard(
                                                        backgroup: list[7]
                                                                ['url']
                                                            .toString(),
                                                        item: list,
                                                        num: 10,
                                                        title: 'Groups',
                                                        press: () async {},
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                TitlePromotion(
                                                  check: list[0]['check']
                                                      .toString(),
                                                  titlePromo: 'Our Partners',
                                                  titlePromo1: 'Show All',
                                                ),
                                                Container(
                                                  height: 50,
                                                  width: 370,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      for (int i = 0;
                                                          i < 5;
                                                          i++)
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              height: 50,
                                                              width: 50,
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: (list[0]['check']
                                                                            .toString() ==
                                                                        "0")
                                                                    ? blackColor
                                                                    : whiteColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                            ))
                                                    ],
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.blueAccent,
                                                  thickness: 0.5,
                                                ),
                                                const SizedBox(height: 10),
                                                TitlePromotion(
                                                  check: list[0]['check']
                                                      .toString(),
                                                  titlePromo: 'Our Membership',
                                                  titlePromo1: 'Show All',
                                                ),
                                                const SizedBox(height: 10),
                                                Container(
                                                  height: 50,
                                                  width: 370,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      for (int i = 0;
                                                          i < 5;
                                                          i++)
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              height: 50,
                                                              width: 50,
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: (list[0]['check']
                                                                            .toString() ==
                                                                        "0")
                                                                    ? blackColor
                                                                    : whiteColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                            ))
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Container(
                                                  height: 60,
                                                  width: 400,
                                                  decoration: BoxDecoration(
                                                    color: (list[0]['check']
                                                                .toString() ==
                                                            "0")
                                                        ? whiteColor
                                                        : null,
                                                    image: (list[0]['check']
                                                                .toString() ==
                                                            "0")
                                                        ? null
                                                        : DecorationImage(
                                                            image: NetworkImage(
                                                              list[9]['url']
                                                                  .toString(),
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        blurRadius: 5,
                                                        color: kImageColor,
                                                        blurStyle:
                                                            BlurStyle.solid,
                                                        spreadRadius: 0.0,
                                                        offset:
                                                            Offset(0.2, 0.1),
                                                      )
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      for (int i = 0;
                                                          i < listIcons.length;
                                                          i++)
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            height: 50,
                                                            width: 50,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  listIcons[i],
                                                                  color: (list[0]['check']
                                                                              .toString() ==
                                                                          "0")
                                                                      ? blackColor
                                                                      : whiteColor,
                                                                  size: 20,
                                                                ),
                                                                Text(
                                                                  listTitle[i][
                                                                          'title']
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: (list[0]['check'].toString() ==
                                                                            "0")
                                                                        ? blackColor
                                                                        : whiteColor,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 90.0,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, left: 15),
                                          child: Container(
                                            height: 120,
                                            width: 340,
                                            decoration: BoxDecoration(
                                              // color: kImageColor,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  list[8]['url'].toString(),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  color: kImageColor,
                                                  blurStyle: BlurStyle.solid,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(0.2, 0.1),
                                                )
                                              ],
                                            ),
                                            child: Container(
                                                margin: const EdgeInsets.all(5),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    5,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "Main Balance : ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                textLock,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor *
                                                                      12,
                                                                ),
                                                              ),
                                                              const Text(
                                                                "  VPoint",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 11,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              // SizedBox(
                                                              //   height:
                                                              //       20,
                                                              //   width: 20,
                                                              //   child:
                                                              //       CatchNetworkObx(
                                                              //     noImage:
                                                              //         "19",
                                                              //     item: downloadImage
                                                              //         .listImage4,
                                                              //   ),
                                                              // )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color: Colors.white,
                                                      endIndent: 15,
                                                      indent: 15,
                                                      height: 1,
                                                      thickness: 1,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "Created Verbal : ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                textLock,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor *
                                                                      12,
                                                                ),
                                                              ),
                                                              const Text(
                                                                "  VPoint",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 11,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              // SizedBox(
                                                              //   height:
                                                              //       15,
                                                              //   width: 15,
                                                              //   child:
                                                              //       CatchNetworkObx(
                                                              //     noImage:
                                                              //         "19",
                                                              //     item: downloadImage
                                                              //         .listImage4,
                                                              //   ),
                                                              // )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color: Colors.white,
                                                      endIndent: 15,
                                                      indent: 15,
                                                      height: 1,
                                                      thickness: 1,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "My Plans : ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: MediaQuery
                                                                      .of(
                                                                    context,
                                                                  ).textScaleFactor *
                                                                  10,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            textLock,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color: Colors.white,
                                                      endIndent: 15,
                                                      indent: 15,
                                                      height: 1,
                                                      thickness: 1,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "Valid Until : ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            textLock,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ),
                                        //     }
                                        //   },
                                        // ),
                                      ),
                                    ]),
                                  ),
                                ),
                              );
                            });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  String base64string = 'No';
  bool cropORopen = false;
  String imageUrl = '';
  Uint8List? _byesData;
  Uint8List? selectedFile;
  void openImgae() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files!.elementAt(0);
      final reader = html.FileReader();
      // Check size of the file
      // int fileSizeInBytes = file.size;
      // print('File size: $fileSizeInBytes bytes');
      reader.onLoadEnd.listen((event) {
        setState(() {
          _byesData = const Base64Decoder()
              .convert(reader.result.toString().split(',').last);
          selectedFile = _byesData;
          imageUrl = html.Url.createObjectUrlFromBlob(file.slice());
          comporessList(_byesData!);
          cropORopen = false;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  String? _croppedBlobUrl;
  Uint8List? getbytes;
  html.File? cropimageFile;
  Future<void> cropImage() async {
    WebUiSettings settings;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    settings = WebUiSettings(
      context: context,
      presentStyle: CropperPresentStyle.dialog,
      boundary: CroppieBoundary(
        width: (screenWidth * 0.4).round(),
        height: (screenHeight * 0.4).round(),
      ),
      viewPort: const CroppieViewPort(
        width: 300,
        height: 300,
      ),
      enableExif: true,
      enableZoom: true,
      showZoomer: true,
    );

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageUrl,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [settings],
    );

    if (croppedFile != null) {
      final bytes = await croppedFile.readAsBytes();
      final blob = html.Blob([bytes]);
      cropimageFile = html.File([blob], 'cropped-image.png');
      getbytes = Uint8List.fromList(bytes);
      setState(() {
        cropORopen = true;
        comporessList(getbytes!);
        _croppedBlobUrl = croppedFile.path;
        if (!kIsWeb) {
          saveBlobToFile(_croppedBlobUrl!, croppedFile.path);
        }
      });
    }
  }

  Future<void> saveBlobToFile(String blobUrl, String filename) async {
    final response = await http.get(Uri.parse(blobUrl));
    final bytes = response.bodyBytes;

    if (!kIsWeb) {
      final directory = await getApplicationDocumentsDirectory();
      final path = "${directory.path}/$filename";
      final file = io.File(path);
      await file.writeAsBytes(bytes);
    }
  }

  Future<Uint8List> comporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );
    setState(() {
      base64string = base64.encode(result);
    });

    return result;
  }
}
