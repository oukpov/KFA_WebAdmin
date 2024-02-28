import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../My Account/ChatUsers/UsersChat/chat_screen.dart';
import '../../component/Colors/appbar.dart';
import '../../component/Colors/colors.dart';
import '../../component/Header.dart';
import '../DetailScreen/DetailAll.dart';
import '../MoreOption/OptionHeaderListProperty/Option.dart';
import '../Drawer/drawer.dart';
import '../../component/fonttext/fontText.dart';

class ListProperty extends StatefulWidget {
  ListProperty(
      {super.key,
      required this.list,
      required this.device,
      required this.drawerType,
      required this.optionDropdown,
      required this.email,
      required this.idUsercontroller,
      required this.myIdController});
  List list = [];
  final String device;
  final String drawerType;
  final bool optionDropdown;
  final String email;
  final String idUsercontroller;
  final String myIdController;
  @override
  BodyViewAllState createState() => BodyViewAllState();
}

class BodyViewAllState extends State<ListProperty>
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
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List list = [];
  List lists = [];
  int lengthOfList = 11;
  int currentPage = 0;
  int deTailPage = 0;
  int deTailPage4 = 0;
  int totalPage = 0;
  double totalPages = 0;
  int startpage = 0;

  double ceilNumber = 0;

  @override
  void initState() {
    super.initState();
    main();
  }

  void main() {
    if (widget.list.length != 0) {
      list = widget.list;
      lists = widget.list;
    }
    if (widget.drawerType == 'For Sale') {
      title = 'FOR SALE';
    } else if (widget.drawerType == 'For Rent') {
      title = 'FOR RENT';
    } else if (widget.drawerType == 'Urgent') {
      title = 'URGENT';
    } else {
      title = widget.drawerType;
    }
    double totalContainers = lengthOfList / 24;
    if (totalContainers.runtimeType == double) {
      totalPage = totalContainers.toInt() + 1;
    } else {
      totalPage = int.parse(totalContainers.toString());
    }
  }

  String typeDrawer = '';
  List listFavoriteModel = [];
  double r = 0;
  double l = 0;
  double w = 0;
  bool button = false;
  String title = '';
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;

    l = (w - 1199) / 4;
    if (w > 560) {
      r = (w - 560) / 1.7;
    }
    return Scaffold(
      appBar: (w < 770)
          ? appbarMobile(context, widget.email, widget.idUsercontroller,
              widget.myIdController)
          : (w < 1199)
              ? appbarTablet(context, widget.email, widget.myIdController,
                  widget.myIdController)
              : appbarDekTop(
                  context,
                  'dektop',
                  widget.email,
                  widget.idUsercontroller,
                  widget.myIdController,
                  widget.myIdController),
      drawer: MyDrawer(
        myIdController: widget.myIdController,
        email: widget.email,
        idUseContoller: widget.idUsercontroller,
        device: widget.device,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OptionDetail(
              list: widget.list,
              opTion: widget.optionDropdown,
              typeDrawer: widget.drawerType,
              listOption: (value) {
                setState(() {
                  list = value;
                });
              },
              title: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            if (w < 770) listNumber(25, 10, 20),
            if (w >= 770 && w < 1199) listNumber(5, 5, 27),
            if (w < 770)
              optionPropertyMobile()
            else if (w < 1199)
              optionPropertyTablet()
            else
              optionPropertyDekTop(),
            if (list.length != 0)
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
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
                                    (currentPage - (currentPage - 1)) * 20) +
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
  }

  // Widget optionPropertyMobile(List list) {
  Widget optionPropertyMobile() {
    setState(() {
      if (button == false) {
        deTailPage4 = list.length;
      }
    });
    return Wrap(
      direction: Axis.horizontal,
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        for (int i = startpage; i < deTailPage4; i++)
          if (w < 500)
            imageUrl(i, 200, 700, 0, list)
          else
            imageUrl(i, 250, 600, r, list)
      ],
    );
  }

  Widget optionPropertyTablet() {
    setState(() {
      if (button == false) {
        deTailPage4 = list.length;
      }
    });
    return Wrap(
      direction: Axis.horizontal,
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        for (int i = startpage; i < deTailPage4; i++)
          if (w >= 770 && w < 991)
            imageUrl(i, 200, 350, 0, list)
          else
            imageUrl(i, 200, 300, 0, list)
      ],
    );
  }

  Widget optionPropertyDekTop() {
    setState(() {
      if (button == false) {
        deTailPage4 = list.length;
      }
    });
    return Padding(
      padding: EdgeInsets.only(right: l, left: l),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 12.0,
        runSpacing: 12.0,
        children: <Widget>[
          for (int i = startpage; i < deTailPage4; i++)
            if (w > 1199) imageUrl(i, 180, 280, 0, list)
        ],
      ),
    );
  }

  int selectedIdx = -1;
  Widget imageUrl(int index, double hPic, wPic, r, List list) {
    var fontValue = TextStyle(
        fontSize: MediaQuery.textScaleFactorOf(context) * 13,
        color: const Color.fromARGB(255, 64, 65, 64));
    return InkWell(
      onHover: (value) {
        setState(() {
          selectedIdx = (selectedIdx == index) ? -1 : index;
          (selectedIdx == index) ? controller.forward() : controller.reverse();
        });
      },
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
      child: SlideTransition(
        position:
            (selectedIdx == index) ? offsetAnimationON : offsetAnimationDOWN,
        child: Padding(
          padding: EdgeInsets.only(right: r, left: r),
          child: Form(
            child: Card(
              elevation: (selectedIdx == index) ? 20 : 0,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: wPic,
                  child: Column(
                    children: [
                      // Container(
                      //   height: hPic,
                      //   width: wPic,
                      //   color: Colors.red,
                      //   child: Text('No. $index(page:$deTailPage4)'),
                      // )

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
                                  width: wPic,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
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
                                        // print(
                                        //     '${listFavoriteModel[index]['id_ptys']} && ${list[index]['id_ptys']} && ${list[index]['like']}');
                                        // if (listFavoriteModel[index]
                                        //         ['id_ptys'] ==
                                        //     list[index]['id_ptys']) {
                                        //   if (listFavoriteModel[index]['like']
                                        //           .toString() ==
                                        //       '1') {
                                        //     // print(index.toString());
                                        //     upDateUserFavorites(
                                        //         listFavoriteModel, index, 0);
                                        //   } else {
                                        //     upDateUserFavorites(
                                        //         listFavoriteModel, index, 1);
                                        //   }
                                        // }
                                      });
                                    },
                                    onHover: (value) {
                                      setState(() {
                                        selectedIdx =
                                            (selectedIdx == index) ? -1 : index;
                                        // favorite = !favorite;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.favorite_border_outlined,
                                      // color: (!favorite)
                                      //     ? ((list[index]['like'].toString() ==
                                      //             '1')
                                      //         ? greenColors
                                      //         : greyColor)
                                      // : ((selectedIdx == index)
                                      // ? redColors
                                      // : (list[index]['like']
                                      //             .toString() ==
                                      //         '1')
                                      //     ? greenColors
                                      //     : greyColor),
                                      size: 40,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Chat_Message(
                                                      uid:
                                                          widget.myIdController,
                                                      userId: list[index]
                                                              ['userID']
                                                          .toString(),
                                                    )
                                                // userId: '191K877F994A'),
                                                ));
                                      },
                                      icon: Icon(
                                        Icons.chat_outlined,
                                        color: whiteColor,
                                        size: 35,
                                      )),
                                ],
                              ))
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                fontSizes(
                                    '', 'urgent', 12, index, list, context),
                                textS(context),
                                fontSizes('', 'Name_cummune', 12, index, list,
                                    context),
                              ],
                            ),
                            size7,
                            Row(
                              children: [
                                fontSizes(
                                    'Price', 'price', 12, index, list, context),
                                textS(context),
                                fontSizes(
                                    'Bed', 'bed', 12, index, list, context),
                              ],
                            ),
                            size7,
                            Row(
                              children: [
                                fontSizes(
                                    'Land', 'land', 12, index, list, context),
                                textS(context),
                                fontSizes(
                                    'Bath', 'bath', 12, index, list, context),
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
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget listNumber(t, b, fs) {
    return Padding(
      padding: EdgeInsets.only(top: t, bottom: b),
      child: Text('${list.length} LISTING $title',
          style: TextStyle(
              fontSize: MediaQuery.textScaleFactorOf(context) * fs,
              color: appback)),
    );
  }
}
