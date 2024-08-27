// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../components/colors.dart';
import '../MenuPage/My Account/ChatUsers/UsersChat/chat_screen.dart';
import '../../Getx_api/controller_api.dart';
import '../MenuPage/DetailScreen/DetailAll.dart';
import '../MenuPage/Province/Propert_khae.dart';
import '../component/Colors/appbar.dart';
import '../component/Header.dart';
import '../component/OPtion/Option.dart';
import '../component/OPtion/OptionGrieview.dart';
import '../component/Abouts/abouts.dart';
import '../MenuPage/Drawer/drawer.dart';
import '../MenuPage/search/SearchProperty.dart';
import '../MenuPage/Province/viewAllProvince.dart';
import '../component/fonttext/fontText.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.device,
    required this.email,
    required this.idUsercontroller,
    required this.myIdcontroller,
  });
  final String device;
  final String email;
  final String idUsercontroller;
  final String myIdcontroller;
  @override
  State<HomeScreen> createState() => _TypeDeviceState();
}

class _TypeDeviceState extends State<HomeScreen>
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

  List listFavoriteModelSale = [];
  List listFavoriteModelRent = [];
  final controllerValue = controller_api();
  int selectedIdxSale = -1;
  String? propertyID = '1';
  bool isLoading25 = false;
  int fontSize = 0;
  Future<void> button() async {
    propertyID;
    isLoading25 = true;
    await Future.wait([
      controllerValue.value_all_list(propertyID),
      controllerValue.value_all_lists(),
    ]);
    setState(() {
      isLoading25 = false;
      listFavoriteModelSale = controllerValue.list_value_all;
      listFavoriteModelRent = controllerValue.list_value_alls;
    });
  }

  @override
  void initState() {
    if (widget.idUsercontroller != '') {
      getUser();
    } else {}
    button();
    super.initState();
  }

  bool favorite = false;
  String typeDrawer = '';
  int listLenght = 0;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    l = (w - 1199) / 4;
    if (w > 560) {
      r = (w - 560) / 1.7;
    }

    return Scaffold(
      appBar: (widget.device == 'mobile')
          ? appbarMobile(context, widget.email, widget.idUsercontroller,
              widget.myIdcontroller)
          : (widget.device == 'tablet')
              ? appbarTablet(context, widget.email, widget.idUsercontroller,
                  widget.myIdcontroller)
              : appbarDekTop(
                  context,
                  'dektop',
                  widget.email,
                  widget.idUsercontroller,
                  widget.myIdcontroller,
                  widget.myIdcontroller),
      drawer: MyDrawer(
        myIdController: widget.myIdcontroller,
        idUseContoller: widget.idUsercontroller,
        email: widget.email,
        device: widget.device,
      ),
      body: body(),
    );
  }

  int selectedIdx = -1;
  double r = 0;
  double l = 0;
  double w = 0;
  Widget body() {
    return (widget.device == 'mobile')
        ? bodyMobile()
        : (widget.device == 'tablet')
            ? bodyTablet()
            : bodyDekTop();
  }

//Body
  Widget bodyMobile() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            headerOptionMobile(),
            const SizedBox(height: 10),
            ViewAllProvince(
                myIdController: widget.myIdcontroller,
                email: widget.email,
                idUserController: widget.idUsercontroller),
            optionProvine('80', '0.25'),
            const SizedBox(height: 10),
            if (controllerValue.list_value_all.length != 0)
              optionProperty(
                  context,
                  controllerValue.list_value_all,
                  'Properties For Sale',
                  'No',
                  'Sale',
                  widget.device,
                  widget.email,
                  widget.idUsercontroller,
                  widget.myIdcontroller),
            const SizedBox(height: 20),
            optionPropertyMobile(controllerValue.list_value_all),

            if (controllerValue.list_value_alls != 0)
              optionProperty(
                  context,
                  controllerValue.list_value_alls,
                  'Properties For Rent',
                  'No',
                  'Rent',
                  widget.device,
                  widget.email,
                  widget.idUsercontroller,
                  widget.myIdcontroller),

            optionPropertyMobile(controllerValue.list_value_alls),
            // news(context),
            const SizedBox(height: 10),
            AboutUS(
              myIdcontroller: widget.myIdcontroller,
              email: widget.email,
              idUserController: widget.idUsercontroller,
            )
          ],
        ),
      ),
    );
  }

  Widget bodyTablet() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(w.toString()),

            headerOptionTablet(),
            const SizedBox(height: 10),
            ViewAllProvince(
                myIdController: widget.myIdcontroller,
                email: widget.email,
                idUserController: widget.idUsercontroller),
            optionProvine('80', '0.13'),
            const SizedBox(height: 10),
            if (controllerValue.list_value_all.length != 0)
              optionProperty(
                  context,
                  controllerValue.list_value_all,
                  'Properties For Sales',
                  'No',
                  'Sale',
                  widget.device,
                  widget.email,
                  widget.idUsercontroller,
                  widget.myIdcontroller),
            const SizedBox(height: 10),
            optionPropertyTablet(
              controllerValue.list_value_all,
            ),

            if (controllerValue.list_value_alls.length != 0)
              optionProperty(
                  context,
                  controllerValue.list_value_alls,
                  'Properties For Rent',
                  'No',
                  'Rent',
                  widget.device,
                  widget.email,
                  widget.idUsercontroller,
                  widget.myIdcontroller),
            optionPropertyMobile(controllerValue.list_value_alls),
            // news(context),
            const SizedBox(height: 10),
            AboutUS(
              myIdcontroller: widget.myIdcontroller,
              email: widget.email,
              idUserController: widget.idUsercontroller,
            )
          ],
        ),
      ),
    );
  }

  Widget bodyDekTop() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // headerOptionDekTop(),
            const SizedBox(height: 10),
            ViewAllProvince(
                myIdController: widget.myIdcontroller,
                email: widget.email,
                idUserController: widget.idUsercontroller),
            optionProvine('80', '0.08'),
            const SizedBox(height: 10),
            if (controllerValue.list_value_all.length != 0)
              optionProperty(
                  context,
                  controllerValue.list_value_all,
                  'Properties For Sale',
                  'No',
                  'Sale',
                  widget.device,
                  widget.email,
                  widget.idUsercontroller,
                  widget.myIdcontroller),
            const SizedBox(height: 10),
            optionPropertyDekTop(controllerValue.list_value_all),

            if (controllerValue.list_value_alls.length != 0)
              optionProperty(
                  context,
                  controllerValue.list_value_alls,
                  'Properties For Rent',
                  'No',
                  'Rent',
                  widget.device,
                  widget.email,
                  widget.idUsercontroller,
                  widget.myIdcontroller),

            // news(context),
            const SizedBox(height: 10),
            AboutUS(
              myIdcontroller: widget.myIdcontroller,
              email: widget.email,
              idUserController: widget.idUsercontroller,
            )
          ],
        ),
      ),
    );
  }

  String value = '1';
  Widget headerOptionMobile() {
    return SearchProperty(
      myIdController: widget.myIdcontroller,
      idUserPersonal: idUserperson,
      email: widget.email,
      idUserControllerl: widget.idUsercontroller,
      member: addProperty,
      fontsize: 20,
      hPic: 0.35,
      w: 0.6,
      wOption: 0.2,
      listPrice: listPrice,
      hResponsive: 1,
      raDius: 50,
    );
  }

  Widget headerOptionTablet() {
    return SearchProperty(
      myIdController: widget.myIdcontroller,
      idUserPersonal: idUserperson,
      email: widget.email,
      idUserControllerl: widget.idUsercontroller,
      member: addProperty,
      fontsize: 20,
      hPic: 0.36,
      w: 0.6,
      wOption: 0.2,
      listPrice: listPrice,
      hResponsive: 1,
      raDius: 50,
    );
  }

  Widget headerOptionDekTop() {
    return SearchProperty(
      myIdController: widget.myIdcontroller,
      idUserPersonal: idUserperson,
      email: widget.email,
      idUserControllerl: widget.idUsercontroller,
      member: addProperty,
      fontsize: 20,
      hPic: 0.4,
      w: 0.4,
      wOption: 0.2,
      listPrice: listPrice,
      hResponsive: 1,
      raDius: 50,
    );
  }

  Widget optionProvine(heightImage, viewportFraction) {
    return SizedBox(
      width: double.infinity,
      child: Property25(
        myIdController: widget.myIdcontroller,
        email: widget.email,
        idUsercontroller: widget.idUsercontroller,
        heightImage: heightImage,
        viewportFraction: viewportFraction,
        getIndexProvince: (value) {
          setState(() {
            controllerValue.province;
            propertyID = value.toString();

            button();
          });
        },
      ),
    );
  }

  Widget optionPropertyMobile(List list) {
    // if (list.length > 8) {
    //   listLenght = 8;
    // } else {
    //   listLenght = list.length;
    // }
    listLenght = list.length;
    return Wrap(
      direction: Axis.horizontal,
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        for (int i = 0; i < listLenght; i++)
          if (w < 500)
            imageUrl(list, i, 200, 700, 0)
          else
            imageUrl(list, i, 250, 600, r)
      ],
    );
  }

  Widget optionPropertyTablet(List list) {
    if (list.length > 8) {
      listLenght = 8;
    } else {
      listLenght = list.length;
    }
    return Wrap(
      direction: Axis.horizontal,
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        for (int i = 0; i < listLenght; i++)
          if (w >= 770 && w < 991)
            imageUrl(list, i, 200, 350, 0)
          else
            imageUrl(list, i, 200, 300, 0)
      ],
    );
  }

  Widget optionPropertyDekTop(List list) {
    if (list.length > 8) {
      listLenght = 8;
    } else {
      listLenght = list.length;
    }
    return Padding(
      padding: EdgeInsets.only(right: l, left: l),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 12.0,
        runSpacing: 12.0,
        children: <Widget>[
          for (int i = 0; i < listLenght; i++)
            if (w > 1199) imageUrl(list, i, 180, 280, 0)
        ],
      ),
    );
  }

//Component Using
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
                            // print(
                            //     '${listFavoriteModelSale[index]['id_ptys']} && ${list[index]['id_ptys']} && ${list[index]['like']}');
                            if (listFavoriteModelSale[index]['like']
                                    .toString() ==
                                '1') {
                              // print(
                              //     '${listFavoriteModelSale[index]['like']} && ${widget.myIdcontroller}');
                              deleteFavorite(listFavoriteModelSale[index]
                                      ['id_ptys']
                                  .toString());
                              upDateUserFavorites(
                                  listFavoriteModelSale, index, 0);
                            } else {
                              postUserFavorites(list, index, 1);
                              upDateUserFavorites(
                                  listFavoriteModelSale, index, 1);
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
                      const SizedBox(height: 10),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Chat_Message(
                                      uid: widget.myIdcontroller,
                                      userId: list[index]['userID'].toString()),
                                ));
                          },
                          icon: Icon(
                            Icons.chat_outlined,
                            color: whiteColor,
                            size: 35,
                          )),
                    ],
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  List getUserFavorite = [];
  Future<void> getlikeUser() async {
    var headers = {'Content-Type': 'application/json'};
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/getUser/Favorites/${widget.myIdcontroller}',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      var jsonlist = jsonDecode(json.encode(response.data));

      setState(() {});
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> deleteFavorite(idptys) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/delete/Favorites/$idptys/${widget.myIdcontroller}',
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

  Future<void> postUserFavorites(List list, index, like) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "UserID": widget.myIdcontroller,
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

  Widget type(value, number, index, List list) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.03,
        width: MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 73, 105, 9),
            borderRadius: BorderRadius.circular(5)),
        child: Text('${list[index]['$value']}',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.textScaleFactorOf(context) * number)),
      ),
    );
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

  Future<void> upDateUserFavorites(List list, index, like) async {
    updateLike(listFavoriteModelSale[index]['UserID'].toString(),
        listFavoriteModelSale[index]['id_ptys'].toString(), like);
    // var headers = {'Content-Type': 'application/json'};
    // var data = json.encode({
    //   "like": like,
    // });
    // var dio = Dio();
    // var response = await dio.request(
    //   'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/Update/Favorites/${list[index]['id_ptys']}',
    //   options: Options(
    //     method: 'POST',
    //     headers: headers,
    //   ),
    //   data: data,
    // );

    // if (response.statusCode == 200) {
    //   setState(() {
    //     // print(like);
    //     updateLike(listFavoriteModelSale[index]['UserID'].toString(),
    //         listFavoriteModelSale[index]['id_ptys'].toString(), like);
    //     print(json.encode(response.data));
    //   });
    // } else {
    //   print(response.statusMessage);
    // }
  }

  Future<void> updateLike(userID, idPtys, like) async {
    for (int i = 0; i < listFavoriteModelSale.length; i++) {
      if (listFavoriteModelSale[i]['id_ptys'].toString() == idPtys) {
        listFavoriteModelSale[i]["UserID"] = userID;
        listFavoriteModelSale[i]["id_ptys"] = idPtys;
        listFavoriteModelSale[i]["like"] = like;
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

  String idUserperson = '';
  String emailController = '';
  bool addProperty = false;
  Future getUser() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/${widget.idUsercontroller}',
      options: Options(
        method: 'GET',
      ),
    );
    var list = jsonDecode(json.encode(response.data));
    if (response.statusCode == 200) {
      setState(() {
        emailController = list[0]['email'].toString();
        idUserperson = list[0]['control_user'].toString();
        if (emailController == widget.email.toString()) {
          addProperty = true;
        }
      });
    } else {
      print(response.statusMessage);
    }
  }
}
