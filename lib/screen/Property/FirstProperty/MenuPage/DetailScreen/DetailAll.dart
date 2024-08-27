// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../components/colors.dart';
import '../My Account/ChatUsers/UsersChat/chat_screen.dart';
import '../../../print/print.dart';
import '../../component/Colors/appbar.dart';
import '../../component/Detail/Detail.dart';
import '../../component/Detail/google_map_detail.dart';
import 'Widgets/widget.dart';

class DetailScreen extends StatefulWidget {
  List list;
  String index;
  String verbalID;
  String myIdcontroller;
  DetailScreen(
      {super.key,
      required this.index,
      required this.verbalID,
      required this.list,
      required this.myIdcontroller});

  @override
  State<DetailScreen> createState() => Detail_propertyState();
}

class Detail_propertyState extends State<DetailScreen> {
  int index = 0;
  int? myMatch;
  String? verbal;
  @override
  void initState() {
    super.initState();
    index = int.parse(widget.index);
    getAgent();
    latLog();
  }

  double lat = 0;
  double log = 0;
  List listLatLog = [];
  Future<void> latLog() async {
    var jsonData;
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/loglat_property/${myMatch.toString()}'));

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body)['data'];
      listLatLog = jsonData;
      setState(() {
        print(listLatLog.toString());
        // listLatLog;
        lat = double.parse(listLatLog[0]['lat'].toString());
        log = double.parse(listLatLog[0]['log'].toString());
      });
    }
  }

  String? user;
  String firstName = "";
  String lastName = "";
  String email = "";
  String gender = "";
  String from = "";
  String tel = "";
  String id = "";
  String controlUser = "";
  String imageUrl = '';
  Future getAgent() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/users/193K107F359A'));
    if (rs.statusCode == 200) {
      var jsonData;
      jsonData = jsonDecode(rs.body);
      setState(() {
        user = jsonData[0]['username'].toString();
        firstName = jsonData[0]['firstName'].toString();
        lastName = jsonData[0]['last_name'].toString();
        email = jsonData[0]['email'].toString();
        gender = jsonData[0]['gender'].toString();
        from = jsonData[0]['known_from'].toString();
        tel = jsonData[0]['tel_num'].toString();
        id = jsonData[0]['id'].toString();
        imageUrl = jsonData[0]['url'].toString();
        controlUser = jsonData[0]['control_user'].toString();
      });
    }
  }

  double w = 0;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    if (w <= 560) {
      padingRL = 0;
      hth = 0.45;
    } else if (w > 560 && w <= 960) {
      padingRL = (w - 560) / 4;

      hth = 0.55;
    } else if (w > 960 && w <= 1199) {
      padingRL = (w - 960) / 1.1;

      hth = 0.65;
    } else {
      padingRL = (w - 1199) / 1.7;

      hth = 0.7;
    }
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(right: padingRL, left: padingRL, top: 8),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: whiteColor,
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Code : ${widget.list[index]['id_ptys']}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: blackColor,
                              fontSize: 20),
                        ),
                        // const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline_sharp,
                              size: 35,
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    iMage(),
                    sizebox10,
                    Text(
                      '${(widget.list[index]['Title'].toString() == 'null') ? "" : widget.list[index]['Title']}',
                      maxLines: 3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontsize,
                          color: greyColor),
                    ),
                    sizebox10,
                    const SizedBox(height: 5),
                    textField(
                        '${(widget.list[index]['address'].toString() == 'null') ? "" : widget.list[index]['address']} / ${(widget.list[index]['Name_cummune'].toString() == 'null') ? "" : widget.list[index]['Name_cummune']} / Cambodia'),
                    sizebox5,
                    titleField('FACE AND FEATURES'),
                    sizebox10,
                    typeOPtion(),
                    sizebox10,
                    filed(),
                    sizebox5,
                    Row(
                      children: [
                        titleField('PROPERTY DESCRIPTION'),
                        const Spacer(),
                        Print_screen(
                            list: widget.list,
                            verbal_ID: widget.list[index]['id_ptys'].toString(),
                            index: index.toString()),
                        const SizedBox(width: 20),
                      ],
                    ),
                    sizebox10,
                    textDS(30, 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void makePhoneCall() async {
    String phoneNumber = '+85515681358';
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunch(telUri.toString())) {
      await launch(telUri.toString());
    } else {
      throw 'Could not launch $telUri';
    }
  }

  Widget titleField(text) {
    return Text(
      text,
      style: TextStyle(
          color: const Color.fromARGB(255, 131, 128, 128), fontSize: fontsize),
    );
  }

  Widget textblue(txt) {
    return Text(
      txt,
      style: TextStyle(
          fontSize: MediaQuery.textScaleFactorOf(context) * 17,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 46, 104, 158)),
    );
  }

  double wth = 0;
  double hth = 0;
  double padingRL = 0;
  var sizebox5 = const SizedBox(height: 5);
  var sizebox10 = const SizedBox(height: 10);
  double ws = 0, hs = 0;
  Widget dc(hIcon, wIcon) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
                child: Image.asset(
              'assets/icons/arrow_icons.png',
              height: hIcon,
              width: wIcon,
              fit: BoxFit.cover,
            )),
            const SizedBox(width: 10),
            Text(
              'Desciption ៖ ',
              // maxLines: 30,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.015),
            ),
          ],
        ),
        Text(
          'So it’s tough out there for a novelist, which is why we built this generator: to try and give you some inspiration. Any of the titles that you score through it are yours to use. We’d be even more delighted if you dropped us the success story at service@reedsy.com! If you find that you need even more of a spark beyond our generator, the Internet’s got you covered. Here are some of our other favorite generators on the web:',
          maxLines: 10,
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
        )
      ],
    );
  }

  Widget textDS(hIcon, wIcon) {
    hs = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1.2,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            iconsText(
                'assets/icons/arrow_icons.png',
                'Price',
                '\$',
                '${widget.list[index]['price'] ?? ""}',
                '(Negotiate)',
                hIcon,
                wIcon),
            dc(hIcon, wIcon),
            sizebox5,
            sizes(
                'assets/icons/arrow_icons.png',
                'Size Land',
                '${widget.list[index]['land_w'] ?? ""}',
                '៖',
                '${widget.list[index]['land_l'] ?? ""}',
                '${widget.list[index]['land'] ?? ""}',
                hIcon,
                wIcon),
            sizebox5,
            sizes(
                'assets/icons/arrow_icons.png',
                'Size House',
                '${widget.list[index]['Size_l'] ?? ""}',
                '៖',
                '${widget.list[index]['size_w'] ?? ""}',
                '${widget.list[index]['size_house'] ?? ""}',
                hIcon,
                wIcon),
            sizebox5,
            issuance(hIcon, wIcon),
            sizebox5,
            Divider(height: 2, color: appback),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 140,
                        width: 120,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      textblue(user ?? ""),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          InkWell(
                              onTap: () async {
                                launch(
                                  'https://t.me/+85515681358',
                                  forceSafariVC: false,
                                  forceWebView: false,
                                );
                              },
                              child: imageIcon(
                                  'Telegram', Icons.telegram_outlined)),
                          const SizedBox(width: 5),
                          InkWell(
                              onTap: () {
                                makePhoneCall();
                              },
                              child: imageIcon('Call', Icons.phone)),
                          const SizedBox(width: 5),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Chat_Message(
                                          uid: widget.myIdcontroller,
                                          userId: controlUser),
                                    ));
                              },
                              child:
                                  imageIcon('Chat', Icons.messenger_outline)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            textField('Plese Contact ៖'),
            sizebox5,
            phones('assets/icons/phone_icon.png', '(CellCard)', '077 216 168',
                hIcon, wIcon),
            sizebox5,
            phones('assets/icons/phone_icon.png', 'Officer',
                '023 999 855 | 023 988 911', hIcon, wIcon),
            sizebox5,
            InkWell(
              onTap: () {
                setState(() {
                  launch(
                    'https://kfa.com.kh/contacts',
                    forceSafariVC: false,
                    forceWebView: false,
                  );
                });
              },
              child: phones('assets/icons/web_icons.png', '',
                  'https://kfa.com.kh/contacts', hIcon, wIcon),
            ),
            sizebox5,
            InkWell(
              onTap: () {
                setState(() {
                  launch(
                    'https://kfa.com.kh/contacts',
                    forceSafariVC: false,
                    forceWebView: false,
                  );
                });
              },
              child: phones('assets/icons/gmail_icon.png', '(Gmail) : ',
                  'info@kfa.com.kh', hIcon, wIcon),
            ),
            sizebox10,
            InkWell(
              onTap: () {
                setState(() {
                  launch(
                    'https://www.google.com/maps/@11.5193408,104.9162703,20z?entry=ttu',
                    forceSafariVC: false,
                    forceWebView: false,
                  );
                });
              },
              child: reachUS('assets/icons/mylocation.png', hIcon, wIcon),
            ),
            sizebox10,
            InkWell(
              onTap: () {
                setState(() {
                  launch(
                    'https://www.google.com/maps/@11.5193408,104.9162703,20z?entry=ttu',
                    forceSafariVC: false,
                    forceWebView: false,
                  );
                });
              },
              child: reachUS('assets/icons/mylocation.png', hIcon, wIcon),
            ),
            sizebox10,
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  linkURL('assets/icons/facebook.png',
                      'https://www.facebook.com/kfa.com.kh/'),
                  sizedBoxW5,
                  linkURL(
                      'assets/icons/telegram.png', 'https://t.me/kfa_official'),
                  sizedBoxW5,
                  linkURL('assets/icons/twitter.jpg',
                      'https://twitter.com/i/flow/login?redirect_after_login=%2FKFA_Cambodia'),
                  sizedBoxW5,
                  linkURL('assets/icons/in.png',
                      'https://www.linkedin.com/company/khmerfoundationappraisal/'),
                  const Spacer(),
                  // price('assets/icons/print.jpg', '', widget.list[index]),
                  // Print_screen(
                  //     list: widget.list!,
                  //     verbalID: widget.verbalID,
                  //     index: widget.index.toString()),
                  // InkWell(
                  //   onTap: () async {

                  //     // setState(() {
                  //     //   print("k22222${widget.list[index]['url_1'].toString()}");
                  //     // });
                  //     // await getimage_m(widget.list[index]['url'].toString());
                  //     // await getimage_m3(widget.list[index]['url_1'].toString());
                  //     // await getimage_m2(widget.list[index]['url_2'].toString());
                  //     // await Printing.layoutPdf(
                  //     //     onLayout: (format) => _generatePdf(
                  //     //         format,
                  //     //         int.parse(widget.index.toString()),
                  //     //         widget.list!),
                  //     //     format: PdfPageFormat.a4);
                  //   },
                  //   child: CircleAvatar(
                  //     radius: MediaQuery.of(context).size.height * 0.03,
                  //     backgroundImage: NetworkImage(
                  //         'https://media.istockphoto.com/id/1150684590/vector/printer-flat-icon-with-long-shadow-top-view-vector-illustration.jpg?b=1&s=612x612&w=0&k=20&c=9ou3Bvo38syK9ZhpGd7L2iK-tVZB7xb3k2Ehhx-A8v4='),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            map(),
          ],
        ),
      ),
    );
  }

  Widget map() {
    return GoogleMapScreen(
      id: widget.list[index]['id_ptys'].toString(),
    );
  }

  Widget price(icon, url, list) {
    return InkWell(
      onTap: () async {},
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.height * 0.018,
        backgroundImage: AssetImage('$icon'),
      ),
    );
  }

  var sizedBoxW5 = const SizedBox(width: 6);
  Widget linkURL(icon, url) {
    return InkWell(
      onTap: () {
        setState(() {
          launch(
            '$url',
            forceSafariVC: false,
            forceWebView: false,
          );
        });
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.height * 0.018,
        backgroundImage: AssetImage('$icon'),
      ),
    );
  }

  Widget reachUS(icon, hIcon, wIcon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            phones('assets/icons/mylocation.png', '(Reach US) : ', '', hIcon,
                wIcon),
          ],
        ),
        sizebox5,
        Text(
          ' #36A, St.04 Borey Peng Hourt The Star Natural. Sangkat Chakangre Leu, Khan Meanchey, Phnom Penh.',
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
          maxLines: 5,
        ),
      ],
    );
  }

  Widget phones(icon, man, text, hIcon, wIcon) {
    return Row(
      children: [
        Container(
            child: Image.asset(
          '$icon',
          height: hIcon,
          width: wIcon,
          fit: BoxFit.cover,
        )),
        SizedBox(width: 8),
        Text(
          '$man  $text',
          // maxLines: 30,
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
        )
      ],
    );
  }

  Widget issuance(hIcon, wIcon) {
    return Row(
      children: [
        Container(
            child: Image.asset(
          'assets/icons/arrow_icons.png',
          height: hIcon,
          width: wIcon,
          fit: BoxFit.cover,
        )),
        SizedBox(width: 8),
        Text(
          'issuance of transfer service (hard copy)',
          // maxLines: 30,
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
        ),
      ],
    );
  }

  Widget sizes(icon, text, man, l, w, size, hIcon, wIcon) {
    return Row(
      children: [
        Container(
            child: Image.asset(
          'assets/icons/arrow_icons.png',
          height: hIcon,
          width: wIcon,
          fit: BoxFit.cover,
        )),
        SizedBox(width: 8),
        Text(
          '$text $man $l x $w = $size' + ' m' + '\u00B2',
          // maxLines: 30,
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
        )
      ],
    );
  }

  Widget iconsText(icon, text, typeOPtion, value, explan, hIcon, wIcon) {
    return Row(
      children: [
        Container(
            child: Image.asset(
          'assets/icons/arrow_icons.png',
          width: wIcon,
          height: hIcon,
          fit: BoxFit.cover,
        )),
        SizedBox(width: 8),
        Text(
          '$text ៖ $typeOPtion$value $explan',
          // maxLines: 30,
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
        ),
      ],
    );
  }

  Widget filed() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 242, 240, 240),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 0.06)),
          height: MediaQuery.of(context).size.height * 0.045,
          width: double.infinity,
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.height * 0.0044,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 13, 101, 173),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${widget.list[index]['type'] ?? ""} > ',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    color: const Color.fromARGB(255, 15, 93, 157)),
              ),
              Text(
                ' \$${widget.list[index]['price'] ?? ""}',
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 160, 29, 20)),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget iconsOPTion(text, text1, value) {
    return Padding(
        padding: const EdgeInsets.only(right: 10, top: 10),
        child: Column(
          children: [
            (value != "0")
                ? Container(
                    height: 60,
                    width: 80,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(text), fit: BoxFit.cover)))
                : const SizedBox(),
            const SizedBox(height: 5),
            (value != "0") ? textType(text1) : const SizedBox(),
            const SizedBox(height: 2),
            (value != "0") ? textType(value) : const SizedBox(),
          ],
        ));
  }

  Widget textType(text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14),
    );
  }

  Widget textField(text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontsize, fontWeight: FontWeight.bold, color: greyColor),
    );
  }

  Widget typeOPtion() {
    return Wrap(
      children: [
        for (int i = 0; i < imageIcons.length; i++)
          iconsOPTion(imageIcons[i]['icons'], titleName[i]['title'],
              widget.list[index]["${listValue[i]['value']}"].toString()),
      ],
    );
  }

  double fontsize = 22;

  Widget mutipleImage() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.22,
      left: 15,
      bottom: 10,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            child: CachedNetworkImage(
                              imageUrl: widget.list[index]['url_1'].toString(),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Color.fromARGB(255, 235, 227, 227)),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.list[index]['url_1'].toString(),
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            child: CachedNetworkImage(
                              imageUrl: widget.list[index]['url_2'].toString(),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Color.fromARGB(255, 235, 227, 227)),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.list[index]['url_2'].toString(),
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget iMage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          child: CachedNetworkImage(
                            imageUrl: widget.list[index]['url'].toString(),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                      fontSize: MediaQuery.textScaleFactorOf(
                                              context) *
                                          17),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * hth,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.list[index]['url'].toString(),
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Color kImageColor = const Color.fromRGBO(169, 203, 56, 1);
}
