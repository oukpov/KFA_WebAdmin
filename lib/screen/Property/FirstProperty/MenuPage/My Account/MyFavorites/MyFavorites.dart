// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ChatUsers/UsersChat/chat_screen.dart';
import '../../../component/Colors/appbar.dart';
import '../../../component/Colors/colors.dart';
import '../../../component/Header.dart';
import '../../../component/Model/FavoriteModel.dart';
import '../../../component/fonttext/fontText.dart';
import '../../DetailScreen/DetailAll.dart';

class MyFavories extends StatefulWidget {
  MyFavories(
      {super.key,
      required this.idUsercontroller,
      required this.email,
      required this.myIdController});
  String idUsercontroller;
  String email;
  final String myIdController;
  @override
  State<MyFavories> createState() => _MyFavoriesState();
}

class _MyFavoriesState extends State<MyFavories> {
  @override
  void initState() {
    double totalContainers = lengthOfList / 24;
    if (totalContainers.runtimeType == double) {
      totalPage = totalContainers.toInt() + 1;
    } else {
      totalPage = int.parse(totalContainers.toString());
    }
    getUserFavorite();

    super.initState();
  }

  int like = 0;
  List listFavoriteModel = [];
  List<FavoriteModel> lb = [FavoriteModel('', '', 0)];

  void removeFavoriteIndex(index) {
    setState(() {
      listFavoriteModel.removeAt(index);
    });
  }

  String title = '';
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

  int startpage = 0;
  int lengthOfList = 11;
  int deTailPage = 0;
  int deTailPage4 = 0;
  int currentPage = 0;
  bool button = false;
  int totalPage = 0;
  double w = 0;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: backgroundScreen,
          appBar: (constraints.maxWidth < 770)
              ? appbarMobile(context, widget.email, widget.idUsercontroller,
                  widget.myIdController)
              : (constraints.maxWidth < 1199)
                  ? appbarTablet(context, widget.email, widget.idUsercontroller,
                      widget.myIdController)
                  : appbarDekTop(
                      context,
                      'dektop',
                      widget.email,
                      widget.idUsercontroller,
                      widget.myIdController,
                      widget.myIdController),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (constraints.maxWidth < 550) mobile() else tableDekTop(),
                if (list.isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 20),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 0.2, color: greyColor)),
                        height: 40,
                        width: 450,
                        child: NumberPaginator(
                          numberPages: totalPage,
                          onPageChange: (int index) {
                            setState(() {
                              button = true;
                              currentPage = index + 1;
                              deTailPage = (currentPage * 20);
                              startpage = (deTailPage -
                                  (currentPage - (currentPage - 1)) * 20);
                              if (lengthOfList > 24) {
                                deTailPage4 = (currentPage * 20) + 4;
                              } else {
                                deTailPage4 = lengthOfList;
                              }
                              if (deTailPage4 > 24) {
                                startpage = (deTailPage -
                                        (currentPage - (currentPage - 1)) *
                                            20) +
                                    4;
                                deTailPage4 = (currentPage * 20) + 8;
                              }
                              if (deTailPage4 > lengthOfList) {
                                startpage = ((currentPage - 1) * 20) + 8;
                                deTailPage4 = lengthOfList;
                              }
                            });
                          },
                          initialPage: 0,
                          config: NumberPaginatorUIConfig(
                            buttonShape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(1),
                            ),

                            //noclick
                            buttonUnselectedForegroundColor: blackColor,
                            buttonUnselectedBackgroundColor: whiteNotFullColor,
                            //click
                            buttonSelectedForegroundColor: whiteColor,
                            buttonSelectedBackgroundColor: appback,
                          ),
                        )),
                  )
                else
                  const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget mobile() {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        children: [
          for (int i = 0; i < list.length; i++)
            imageUrl(i, 250, 0.9, 0, list, false)
        ],
      ),
    );
  }

  Widget tableDekTop() {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        children: [
          for (int i = 0; i < list.length; i++)
            imageUrl(i, 320, 300, 0, list, true),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     height: 380,
          //     width: 280,
          //     color: Colors.red,
          //     child: Text(i.toString()),
          //   ),
          // )
        ],
      ),
    );
  }

  bool favorite = false;
  List list = [];
  Future<void> getUserFavorite() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/getall/SaleRent?search=${widget.idUsercontroller}&like=1',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        list = jsonDecode(json.encode(response.data));
        if (list.isNotEmpty) {
          lengthOfList = list.length;
          listFavoriteModel = list;
          print(listFavoriteModel.toString());
        }
      });
    } else {
      print(response.statusMessage);
    }
  }

  int _currentNumber = 0;

  void incrementNumberAutomatically() {
    const duration =
        Duration(milliseconds: 20); // Adjust the duration as needed
    Timer.periodic(duration, (Timer timer) {
      if (_currentNumber < 100) {
        setState(() {
          _currentNumber++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  int selectedIdx = -1;
  Widget imageUrl(
      int index, double hPic, wPic, r, List list, bool mobileDekTop) {
    var fontValue = TextStyle(
        fontSize: MediaQuery.textScaleFactorOf(context) * 13,
        color: const Color.fromARGB(255, 64, 65, 64));
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return DetailScreen(
              myIdcontroller: widget.myIdController,
              index: index.toString(),
              list: list,
              verbalID: list[index]['id_ptys'].toString(),
            );
          },
        );
      },
      child: Card(
        elevation: (selectedIdx == index) ? 20 : 0,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.2, color: blueColor),
            borderRadius: BorderRadius.circular(5),
          ),
          width: (mobileDekTop == false)
              ? MediaQuery.of(context).size.width * wPic
              : wPic,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
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
                            width: (mobileDekTop == false)
                                ? MediaQuery.of(context).size.width * wPic
                                : wPic,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )),
                    ),
                    // Positioned(
                    //   top: MediaQuery.of(context).size.height * 0.01,
                    //   child: type('type', 12, index, list),
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          fontSizes('', 'urgent', 12, index, list, context),
                          textS(context),
                          fontSizes(
                              '', 'Name_cummune', 12, index, list, context),
                        ],
                      ),
                      size7,
                      Row(
                        children: [
                          fontSizes('Land', 'land', 12, index, list, context),
                          textS(context),
                          fontSizes('Bath', 'bath', 12, index, list, context),
                          textS(context),
                          fontSizes('Bed', 'bed', 12, index, list, context),
                        ],
                      ),
                      size7,
                      Text(
                        '${(list[index]['address'].toString() == "null") ? "" : list[index]['address']}, ${(list[index]['Name_cummune'].toString() == "null") ? "" : list[index]['Name_cummune']} ,Cambodia',
                        style: fontValue,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 8),
                      fontSizesblue('Price', 'price', 16, index, list, context,
                          list[index]['type'].toString()),
                      const SizedBox(height: 8),
                      Divider(height: 1, color: whiteNotFullColor),
                      const SizedBox(height: 8),
                      Row(
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
                                color: blueColor,
                                size: 30,
                              )),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (listFavoriteModel[index]['id_ptys'] ==
                                    list[index]['id_ptys']) {
                                  if (listFavoriteModel[index]['like']
                                          .toString() ==
                                      '1') {
                                    upDateUserFavorites(list, index, 0);
                                    deleteFavorite(
                                        listFavoriteModel[index]['id_ptys']);
                                  } else {
                                    postUserFavorites(list, index, 1);
                                    upDateUserFavorites(list, index, 1);

                                    print('Two');
                                  }
                                }
                              });
                            },
                            onHover: (value) {
                              setState(() {
                                selectedIdx =
                                    (selectedIdx == index) ? -1 : index;
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
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Chat_Message(
                                          uid: widget.myIdController,
                                          userId:
                                              list[index]['userID'].toString()),
                                    ));
                              },
                              icon: Icon(
                                Icons.chat_outlined,
                                color: greyColorNolot,
                                size: 30,
                              )),
                          const SizedBox(width: 20),
                          SizedBox(
                            child: Row(
                              children: [
                                Text(
                                  'Code : ',
                                  style: TextStyle(
                                      color: greyColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('${list[index]['id_ptys']}')
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteFavorite(idptys) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/delete/Favorites/$idptys/${widget.myIdController}',
      options: Options(
        method: 'DELETE',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
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
        updateLike(list[index]['UserID'].toString(),
            list[index]['id_ptys'].toString(), like);
        print(json.encode(response.data));
      });
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> postUserFavorites(List list, index, like) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "UserID": widget.myIdController,
      "id_ptys": list[index]['id_ptys'].toString(),
      "like": like,
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/AddUser/Favorites',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }
}
