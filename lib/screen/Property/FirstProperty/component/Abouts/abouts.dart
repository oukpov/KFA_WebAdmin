// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../Auth/login.dart';
import '../../../../../Auth/register.dart';
import '../../../../../components/colors.dart';
import '../../MenuPage/ListProperty/ListProPerty.dart';
import '../Colors/appbar.dart';

import '../LinkURL/AboutUS/aboutus.dart';
import '../OPtion/Option.dart';
import '../urlLink.dart';

class AboutUS extends StatefulWidget {
  const AboutUS(
      {super.key,
      required this.email,
      required this.idUserController,
      required this.myIdcontroller});
  final String email;
  final String idUserController;
  final String myIdcontroller;
  @override
  State<AboutUS> createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  @override
  Widget build(BuildContext context) {
    return aboutUs(context);
  }

  String typeSale = 'For Sale';
  String typeRent = 'For Rent';
  int selectedIdxSale = -1;
  int selectedIdxRent = -1;
  int selectedIdxAboutUs = -1;
  int selectedIdxQuickLinks = -1;

  Widget aboutUs(context) {
    return Container(
      width: double.infinity,
      color: appback,
      child: Form(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/KFA_CRM.png',
                height: 115,
              ),
              Wrap(
                direction: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 170,
                      width: 400,
                      child: Wrap(
                        children: [
                          Text(
                              '#36A, St.04 Borey Peng Hourt The Star Natural. Sangkat Chakangre Leu, Khan Meanchey, Phnom Penh.',
                              maxLines: 5,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.textScaleFactorOf(context) *
                                          11)),
                          const SizedBox(height: 20),
                          headerText('(855) 77 216 168'),
                          headerText('(855) 23 999 855'),
                          headerText('(855) 23 988 91'),
                          headerText('info@kfa.com.kh'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 120,
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          texts('Navigatotions', context),
                          for (int x = 0; x < navigatotionList.length; x++)
                            InkWell(
                                onHover: (value) {
                                  setState(() {
                                    selectedIdxAboutUs =
                                        (selectedIdxAboutUs == x) ? -1 : x;
                                  });
                                },
                                onTap: () {
                                  if (x == 0) {
                                    launch(
                                      listLinkURL[0]['url'].toString(),
                                      forceSafariVC: false,
                                      forceWebView: false,
                                    );
                                  } else if (x == 1) {
                                    launch(
                                      listLinkURL[1]['url'].toString(),
                                      forceSafariVC: false,
                                      forceWebView: false,
                                    );
                                  } else if (x == 1) {
                                    launch(
                                      listLinkURL[2]['url'].toString(),
                                      forceSafariVC: false,
                                      forceWebView: false,
                                    );
                                  }
                                },
                                child: text(
                                    navigatotionList[x]['type'].toString(),
                                    false,
                                    15,
                                    true,
                                    context,
                                    x)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 430,
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          texts('FOR SALE', context),
                          for (int j = 0; j < aboutUsList.length; j++)
                            InkWell(
                              onHover: (value) {
                                setState(() {
                                  selectedIdxSale =
                                      (selectedIdxSale == j) ? -1 : j;
                                });
                              },
                              onTap: () {
                                moreOPTion('${aboutUsList[j]['type']}', context,
                                    typeSale, true);
                              },
                              child: textIcon(
                                  '${aboutUsList[j]['type']}', context, j),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 430,
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          texts('FOR RENT', context),
                          for (int i = 0; i < aboutUsList.length; i++)
                            InkWell(
                              onHover: (value) {
                                setState(() {
                                  selectedIdxRent =
                                      (selectedIdxRent == i) ? -1 : i;
                                });
                              },
                              onTap: () {
                                moreOPTion('${aboutUsList[i]['type']}', context,
                                    typeRent, true);
                              },
                              child: textIcons(
                                  '${aboutUsList[i]['type']}', context, i),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 250,
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          texts('QUICK LINKS', context),
                          for (int i = 0; i < quickLinkList.length; i++)
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (i == 2) {
                                      launch(
                                        'https://www.oneclickonedollar.com/Privacy/kfa.html',
                                        forceSafariVC: false,
                                        forceWebView: false,
                                      );
                                    } else if (i == 4) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ListProperty(
                                                myIdController:
                                                    widget.myIdcontroller,
                                                email: widget.email,
                                                idUsercontroller:
                                                    widget.idUserController,
                                                optionDropdown: false,
                                                device: 'Mobile',
                                                drawerType: '',
                                                list: const []),
                                          ));
                                    } else if (i == 5) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPage(),
                                          ));
                                    } else if (i == 6) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Login(),
                                          ));
                                    } else {
                                      moreOPTion(
                                          quickLinkList[i]['relationship'],
                                          context,
                                          quickLinkList[i]['type'],
                                          false);
                                    }
                                  });
                                },
                                onHover: (value) {
                                  setState(() {
                                    selectedIdxQuickLinks =
                                        (selectedIdxQuickLinks == i) ? -1 : i;
                                  });
                                },
                                child: textQuitLink(
                                    quickLinkList[i]['title'].toString(),
                                    context,
                                    i)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 120,
                      width: 300,
                      child: Column(
                        children: [
                          // text('Get In Touch', true, 15, false, null, context),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              linkUrl(
                                  'assets/icons/facebook.png',
                                  'https://www.facebook.com/kfa.com.kh/',
                                  context),
                              linkUrl('assets/icons/telegram.png',
                                  'https://t.me/kfa_official', context),
                              linkUrl(
                                  'assets/icons/twitter.jpg',
                                  'https://twitter.com/i/flow/login?redirect_after_login=%2FKFA_Cambodia',
                                  context),
                              linkUrl(
                                  'assets/icons/in.png',
                                  'https://www.linkedin.com/company/khmerfoundationappraisal/',
                                  context),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerText(text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          const Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.white,
            size: 13,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
                color: whiteColor,
                fontSize: MediaQuery.textScaleFactorOf(context) * 14),
          ),
        ],
      ),
    );
  }

  String query = '';
  Future<void> moreOPTion(domain, context, type, bool b) async {
    if (b == true) {
      query = "hometype=$domain&type=$type";
    } else {
      query = "$domain";
    }
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/More_option?$query',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      List list = jsonDecode(json.encode(response.data));

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListProperty(
                myIdController: widget.myIdcontroller,
                email: widget.email,
                idUsercontroller: widget.idUserController,
                device: 'Mobile',
                drawerType: type,
                list: list,
                optionDropdown: true),
          ));
    } else {
      print(response.statusMessage);
    }
  }

  Widget texts(text, context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        text,
        style: TextStyle(
            color: const Color.fromARGB(255, 121, 215, 70),
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.textScaleFactorOf(context) * 17),
      ),
    );
  }

  Widget textIcon(text, context, i) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          const Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.white,
            size: 13,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: (selectedIdxSale == i)
                ? TextStyle(
                    color: whiteColor,
                    decoration: TextDecoration.underline,
                    decorationColor: whiteColor,
                    decorationThickness: 1.5,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 14)
                : TextStyle(
                    color: whiteColor,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 14),
          ),
        ],
      ),
    );
  }

  Widget textIcons(text, context, i) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          const Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.white,
            size: 13,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: (selectedIdxRent == i)
                ? TextStyle(
                    color: whiteColor,
                    decoration: TextDecoration.underline,
                    decorationColor: whiteColor,
                    decorationThickness: 1.5,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 14)
                : TextStyle(
                    color: whiteColor,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 14),
          ),
        ],
      ),
    );
  }

  Widget text(text, bool b, int size, bool icon, context, i) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          icon == true
              ? const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                  size: 13,
                )
              : const SizedBox(),
          const SizedBox(width: 5),
          Text(
            text,
            style: (selectedIdxAboutUs == i)
                ? TextStyle(
                    color: whiteColor,
                    decoration: TextDecoration.underline,
                    decorationColor: whiteColor,
                    decorationThickness: 1.5,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 14)
                : TextStyle(
                    color: whiteColor,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 14),
          ),
        ],
      ),
    );
  }

  Widget textQuitLink(text, context, i) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          const Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.white,
            size: 13,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: (selectedIdxQuickLinks == i)
                ? TextStyle(
                    color: whiteColor,
                    decoration: TextDecoration.underline,
                    decorationColor: whiteColor,
                    decorationThickness: 1.5,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 14)
                : TextStyle(
                    color: whiteColor,
                    fontSize: MediaQuery.textScaleFactorOf(context) * 14),
          ),
        ],
      ),
    );
  }
}
