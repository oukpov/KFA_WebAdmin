import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/colors.dart';
import '../../MenuPage/DetailScreen/DetailAll.dart';
import '../../component/Header.dart';
import '../../component/fonttext/fontText.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen(
      {super.key, required this.list, required this.myIdcontroller});
  final List list;
  final String myIdcontroller;
  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    animationBehavior: AnimationBehavior.preserve,
    vsync: this,
  );
  late final Animation<Offset> offsetAnimationON = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, -0.05),
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.linear,
  ));
  late final Animation<Offset> offsetAnimationDOWN = Tween<Offset>(
    begin: Offset.zero,
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.elasticIn,
  ));
  int selectedIdxSale = -1;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          selectedIdxSale = (selectedIdxSale == index) ? -1 : index;
          (selectedIdxSale == index)
              ? controller.forward()
              : controller.reverse();
        });
      },
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return DetailScreen(
              myIdcontroller: widget.myIdcontroller,
              index: index.toString(),
              list: widget.list,
              verbalID: widget.list[index]['id_ptys'].toString(),
            );
          },
        );
      },
      child: SlideTransition(
        position: (selectedIdxSale == index)
            ? offsetAnimationON
            : offsetAnimationDOWN,
        child: Padding(
          padding: const EdgeInsets.only(
              // right: r,
              // left: r,
              ),
          child: Card(
            elevation: (selectedIdxSale == index) ? 20 : 0,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 0.5, color: Colors.grey)),
                width: 700,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          child: CachedNetworkImage(
                            imageUrl: widget.list[index]['url'].toString(),
                            fit: BoxFit.cover,
                            height: 200,
                            width: 700,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 10, left: 20, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              fontSizes('', 'urgent', 12, index, widget.list),
                              textS(),
                              fontSizes(
                                  '', 'Name_cummune', 12, index, widget.list),
                            ],
                          ),
                          size7,
                          fontSizesblue(
                              'Price',
                              'price',
                              16,
                              index,
                              widget.list,
                              context,
                              widget.list[index]['type'].toString()),
                          size7,
                          Row(
                            children: [
                              fontSizes('Bed', 'bed', 12, index, widget.list),
                              textS(),
                              fontSizes('Land', 'land', 12, index, widget.list),
                              textS(),
                              fontSizes('Bath', 'bath', 12, index, widget.list),
                            ],
                          ),
                          size7,
                          Text(
                            '${(widget.list[index]['address'].toString() == "null") ? "" : widget.list[index]['address']}, ${(widget.list[index]['Name_cummune'].toString() == "null") ? "" : widget.list[index]['Name_cummune']} ,Cambodia',
                            // style: fontValue,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 30,
                  left: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            launch(
                              'https://oneclickonedollar.com/listing/#/code/${widget.list[index]['id_ptys']}',
                              forceSafariVC: false,
                              forceWebView: false,
                            );
                          },
                          icon: Icon(
                            Icons.share,
                            color: whiteColor,
                            size: 35,
                          )),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          setState(() {
                            print(
                                '${listFavoriteModel[index]['id_ptys']} && ${widget.list[index]['id_ptys']} && ${widget.list[index]['like']}');
                            if (listFavoriteModel[index]['id_ptys'] ==
                                widget.list[index]['id_ptys']) {
                              if (listFavoriteModel[index]['like'].toString() ==
                                  '1') {
                                // print(index.toString());
                                upDateUserFavorites(
                                    listFavoriteModel, index, 0);
                              } else {
                                upDateUserFavorites(
                                    listFavoriteModel, index, 1);
                              }
                            }
                          });
                        },
                        onHover: (value) {
                          setState(() {
                            selectedIdx = (selectedIdx == index) ? -1 : index;
                            favorite = !favorite;
                          });
                        },
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: (!favorite)
                              ? ((widget.list[index]['like'].toString() == '1')
                                  ? greenColors
                                  : greyColor)
                              : ((selectedIdx == index)
                                  ? redColors
                                  : (widget.list[index]['like'].toString() ==
                                          '1')
                                      ? greenColors
                                      : greyColor),
                          size: 40,
                        ),
                      ),
                    ],
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  List listFavoriteModel = [];
  Future<void> updateLike(userID, idPtys, like) async {
    for (int i = 0; i < listFavoriteModel.length; i++) {
      if (listFavoriteModel[i]['id_ptys'].toString() == idPtys) {
        listFavoriteModel[i]["UserID"] = userID;
        listFavoriteModel[i]["id_ptys"] = idPtys;
        listFavoriteModel[i]["like"] = like;
        if (like == 1) {
          AwesomeDialog(
                  context: context,
                  animType: AnimType.leftSlide,
                  headerAnimationLoop: false,
                  dialogType: DialogType.success,
                  showCloseIcon: false,
                  title: 'Add Your Favorite',
                  autoHide: const Duration(seconds: 3),
                  onDismissCallback: (type) {
                    // Navigator.pop(context);
                  })
              .show();
        } else {
          AwesomeDialog(
                  context: context,
                  animType: AnimType.leftSlide,
                  headerAnimationLoop: false,
                  dialogType: DialogType.success,
                  showCloseIcon: false,
                  title: 'Remove Your Favorite',
                  autoHide: const Duration(seconds: 3),
                  onDismissCallback: (type) {
                    // Navigator.pop(context);
                  })
              .show();
        }

        break;
      } else {
        print('Value not same');
      }
    }
  }

  int listLenght = 0;
  // Widget optionPropertyMobile(List list) {
  //   // if (list.length > 8) {
  //   //   listLenght = 8;
  //   // } else {
  //   //   listLenght = list.length;
  //   // }
  //   listLenght = list.length;
  //   return Wrap(
  //     direction: Axis.horizontal,
  //     spacing: 12.0,
  //     runSpacing: 12.0,
  //     children: <Widget>[
  //       for (int i = 0; i < listLenght; i++)
  //         if (w < 500)
  //           imageUrl(list, i, 200, 700, 0)
  //         else
  //           imageUrl(list, i, 250, 600, r)
  //     ],
  //   );
  // }

  bool favorite = false;
  int selectedIdx = -1;
  Widget imageUrl(List list, int index, double hPic, wPic, r) {
    var fontValue = TextStyle(
        fontSize: MediaQuery.textScaleFactorOf(context) * 13,
        color: const Color.fromARGB(255, 64, 65, 64));
    return InkWell(
      onHover: (value) {
        setState(() {
          selectedIdxSale = (selectedIdxSale == index) ? -1 : index;
          (selectedIdxSale == index)
              ? controller.forward()
              : controller.reverse();
        });
      },
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return DetailScreen(
              myIdcontroller: widget.myIdcontroller,
              index: index.toString(),
              list: list,
              verbalID: list[index]['id_ptys'].toString(),
            );
          },
        );
      },
      child: SlideTransition(
        position: (selectedIdxSale == index)
            ? offsetAnimationON
            : offsetAnimationDOWN,
        child: Padding(
          padding: EdgeInsets.only(
            right: r,
            left: r,
          ),
          child: Card(
            elevation: (selectedIdxSale == index) ? 20 : 0,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 0.5, color: Colors.grey)),
                width: wPic,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          child: CachedNetworkImage(
                            imageUrl: list[index]['url'].toString(),
                            fit: BoxFit.cover,
                            height: hPic,
                            width: wPic,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 10, left: 20, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              fontSizes('', 'urgent', 12, index, list),
                              textS(),
                              fontSizes('', 'Name_cummune', 12, index, list),
                            ],
                          ),
                          size7,
                          fontSizesblue('Price', 'price', 16, index, list,
                              context, list[index]['type'].toString()),
                          size7,
                          Row(
                            children: [
                              fontSizes('Bed', 'bed', 12, index, list),
                              textS(),
                              fontSizes('Land', 'land', 12, index, list),
                              textS(),
                              fontSizes('Bath', 'bath', 12, index, list),
                            ],
                          ),
                          size7,
                          Text(
                            '${(list[index]['address'].toString() == "null") ? "" : list[index]['address']}, ${(list[index]['Name_cummune'].toString() == "null") ? "" : list[index]['Name_cummune']} ,Cambodia',
                            style: fontValue,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 30,
                  left: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            launch(
                              'https://oneclickonedollar.com/listing/#/code/${list[index]['id_ptys']}',
                              forceSafariVC: false,
                              forceWebView: false,
                            );
                          },
                          icon: Icon(
                            Icons.share,
                            color: whiteColor,
                            size: 35,
                          )),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          setState(() {
                            print(
                                '${listFavoriteModel[index]['id_ptys']} && ${list[index]['id_ptys']} && ${list[index]['like']}');
                            if (listFavoriteModel[index]['id_ptys'] ==
                                list[index]['id_ptys']) {
                              if (listFavoriteModel[index]['like'].toString() ==
                                  '1') {
                                // print(index.toString());
                                upDateUserFavorites(
                                    listFavoriteModel, index, 0);
                              } else {
                                upDateUserFavorites(
                                    listFavoriteModel, index, 1);
                              }
                            }
                          });
                        },
                        onHover: (value) {
                          setState(() {
                            selectedIdx = (selectedIdx == index) ? -1 : index;
                            favorite = !favorite;
                          });
                        },
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: (!favorite)
                              ? ((list[index]['like'].toString() == '1')
                                  ? greenColors
                                  : greyColor)
                              : ((selectedIdx == index)
                                  ? redColors
                                  : (list[index]['like'].toString() == '1')
                                      ? greenColors
                                      : greyColor),
                          size: 40,
                        ),
                      ),
                    ],
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> upDateUserFavorites(List list, index, like) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "like": like,
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Update/Favorites/${list[index]['id_ptys']}',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      setState(() {
        // print(like);
        updateLike(listFavoriteModel[index]['UserID'].toString(),
            listFavoriteModel[index]['id_ptys'].toString(), like);
        print(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  Widget fontSizes(text, value, fontSize, index, List list) {
    return Text(
        '${(text == "") ? "" : "$text : "}${list[index]['$value'].toString()}',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.textScaleFactorOf(context) * fontSize));
  }

  Widget textS() {
    return Text(' | ',
        style: TextStyle(
            color: Colors.grey,
            fontSize: MediaQuery.textScaleFactorOf(context) * 12));
  }
}
