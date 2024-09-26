// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../Profile/components/FieldBox.dart';
import '../../Profile/components/TwinBox.dart';
import '../../Profile/components/singleBox.dart';
import '../../components/colors.dart';
import '../../components/colors/colors.dart';
import '../../screen/Property/FirstProperty/ResponseDevice/responsive_layout.dart';
import '../navigate_home/Approvel/classSubmit.dart';
import '../navigate_home/Approvel/submit.dart';
import '../navigate_home/Approvel/submit_list.dart';
import '../navigate_home/Auto_verbal/Add/googlemap_verbal.dart';
import '../navigate_home/AutoVerbal/AutoVerbal.dart';
import '../navigate_home/Comparable/comparable_new/add_comparable_new_page.dart';
import '../navigate_home/Comparable/newComparable/responsivenewcomparableadd.dart';
import '../navigate_home/Customer/List/customer_list.dart';
import '../navigate_home/Customer/component/Web/editText/dropdowntxt.dart';
import '../navigate_home/Customer/map_in_list_search _autoverbal.dart';
import '../navigate_home/Customer/responsiveDevice.dart/addnew.dart';
import '../navigate_home/Report/Total_amount.dart';
import '../navigate_home/Report/Transetoin/history.dart';
import '../navigate_home/Report/customer/menu.dart';
import '../navigate_home/Report/page/comparable_case_bar_chart.dart';
import '../navigate_home/Report/page/comparable_case_page.dart';
import '../navigate_home/Report/responsvie/responsivereportyear.dart';
import '../navigate_home/User/control_user.dart';
import '../navigate_home/User/list_notivigation.dart';
import '../navigate_home/User/use_vpoint.dart';
import '../navigate_home/Valuation/class/Executive_approvel.dart';
import '../navigate_home/Valuation/class/New_Executive.dart';
import '../navigate_home/Valuation/class/list_Executive.dart';
import '../navigate_setting/Accompany_by/Acompany_List.dart';
import '../navigate_setting/Accompany_by/Acompany_new.dart';
import '../navigate_setting/Appraiser/Appraiser_list.dart';
import '../navigate_setting/Appraiser/Appraiser_new.dart';
import '../navigate_setting/Approved/Approved_list.dart';
import '../navigate_setting/Inspector/Inspector_List.dart';
import '../navigate_setting/Inspector/Inspector_new.dart';
import '../navigate_setting/Register/Register_List.dart';
import '../navigate_setting/Register/Register_new.dart';
import '../navigate_setting/agency/Agency_list.dart';
import '../navigate_setting/agency/Agency_new.dart';
import '../navigate_setting/assign/Assign_new.dart';
import '../navigate_setting/auto/auto_list.dart';
import '../navigate_setting/auto/check_District.dart';
import '../navigate_setting/auto/new_auto.dart';
import '../navigate_setting/bank/bank/bank_list.dart';
import '../navigate_setting/bank/bank/new_bank.dart';
import '../navigate_setting/bank/brand/brand_list.dart';
import '../navigate_setting/bank/brand/new_brand.dart';
import '../navigate_home/Comparable/comparable3/search_screen.dart/comparable_search.dart';
import '../navigate_home/Comparable/comparable4/list_comparable_filter.dart';
import '../../Widgets/drawerMenu.dart';
import '../../Widgets/drawer.dart';
import '../../Widgets/widgets.dart';
import 'component/list.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import 'newUsers/notifications.dart';

class homescreen extends StatefulWidget {
  const homescreen(
      {super.key,
      required this.device,
      required this.id,
      required this.url,
      required this.listUser});
  final String id;
  final String device;
  final String url;
  final List listUser;
  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  double fontsizes = 11;
  bool drawer = false;
  double w = 0;
  int selectindex = -1;
  int selectindexs = -1;
  bool isObscure = true;
  var url = "https://img.icons8.com/fluency/100/user-male-circle.png";

  String? firstName;
  String? lastName;
  String? gender;
  String? telNum;
  String? email;
  String? password;
  String? knownFrom;
  String? username;
  String? controlleruser;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    DateTime onewday = DateTime(now.year, now.month, now.day);
    DateTime twowday = DateTime(now.year, now.month, now.day + 1);
    String formattedDatenow = DateFormat('yyyy-MM-dd').format(onewday);
    String formattedDateago = DateFormat('yyyy-MM-dd').format(twowday);
    countnotifcations(formattedDatenow, formattedDateago);
  }

  String countNotification = '';
  List listnotificationlist = [];
  void countnotifcations(formattedDatenow, formattedDateago) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_nativigatoin_2?start=$formattedDatenow&end=$formattedDateago',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        listnotificationlist = jsonDecode(json.encode(response.data));
        countNotification = listnotificationlist.length.toString();
      });
    } else {
      print(response.statusMessage);
    }
  }

  int type = 0;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundScreen,
      drawer: DrawerWidget(
          email: widget.listUser[0]['username'].toString(),
          listUser: widget.listUser,
          password: widget.listUser[0]['username'].toString()),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.device == 't' || widget.device == 'd')
              ? DrawerOption(
                  device: widget.device,
                  email: widget.listUser[0]['username'].toString(),
                  listUser: widget.listUser,
                )
              : const SizedBox(),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: (widget.device == 't')
                ? MediaQuery.of(context).size.width * 0.8
                : (widget.device == 'd')
                    ? MediaQuery.of(context).size.width * 0.65
                    : MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: (widget.device == 't' || widget.device == 'd')
                    ? const EdgeInsets.only(
                        right: 30, left: 30, top: 10, bottom: 10)
                    : const EdgeInsets.only(
                        right: 10, left: 10, top: 10, bottom: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    profile(),
                    if (widget.device == 'd')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title('Home Page'),
                          homeOptioWrap(),
                          title('Setting Admin'),
                          settingOptionWrap(),
                          const SizedBox(height: 50),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title('Home Page'),
                          homeOptioWrap(),
                          title('Setting Admin'),
                          settingOptionWrap(),
                          const SizedBox(height: 50),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          (widget.device == 'd')
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  color: whiteColor,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < 5; i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 300,
                              width: double.infinity,
                              color: greyColorNolots,
                            ),
                          )
                      ],
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget homeOptioWrap() {
    return Wrap(
      alignment:
          (widget.device == 'm') ? WrapAlignment.center : WrapAlignment.start,
      children: [
        for (int index = 0; index < listTitle.length; index++)
          PopupMenuButton(
            elevation: 15,
            itemBuilder: (context) {
              return [
                if (index == 0)
                  for (int i = 0; i < customeroption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ResponsiveCustomer(
                                      email: '',
                                      idController: widget.id,
                                      myIdController: '',
                                    );
                                  },
                                ));
                              }

                              if (i == 1) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const Customer_List();
                                  },
                                ));
                              }
                            },
                            child: textfield(
                                customeroption[i]['title'].toString())))
                else if (index == 1)
                  for (int i = 0; i < valuationoption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const New_Executive();
                                  },
                                ));
                              }
                              if (i == 1) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Executive_List();
                                  },
                                ));
                              }
                              if (i == 2) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Executive_approvals();
                                  },
                                ));
                              }
                            },
                            child: textfield(
                                valuationoption[i]['title'].toString())))
                else if (index == 2)
                  for (int i = 0; i < comparableotion.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ResponsivenewcomparableAdd(
                                      id: widget.id.toString(),
                                      name: "",
                                    );
                                  },
                                ));
                              }
                              if (i == 1) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return AddComparable(
                                      listlocalhosts: widget.listUser,
                                      addNew: (value) {},
                                      // listUser: widget.listUser,
                                      type: (value) {},
                                    );
                                  },
                                ));
                              }
                              if (i == 2) {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => ComparableList(
                                //           name: widget.listUser[0]['username']
                                //               .toString(),
                                //     builder: (context) => List_newcomparable(
                                //           name: widget.user,
                                //         )));
                              }
                              if (i == 3) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const comparable_search()));
                              }
                              if (i == 4) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const List_comparable_filter()));
                              }
                            },
                            child: textfield(
                                comparableotion[i]['title'].toString())))
                else if (index == 3)
                  PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResponsiveLayout(
                                    myIdController: '',
                                    email: '',
                                    idController: '',
                                  ),
                                ));
                          },
                          child: textfield('HomeProperty')))
                else if (index == 4)
                  for (int i = 0; i < autoOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Show_autoVerbals()));
                              }
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => VerbalAdmin(
                                          addNew: (value) {},
                                          listUser: widget.listUser,
                                          type: (value) {},
                                        )));
                              }
                            },
                            child:
                                textfield(autoOption[i]['title'].toString())))
                else if (index == 5)
                  for (int i = 0; i < verbalOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => const Add(
                                //         id_control_user: 'sdf96',
                                //         id: '12',
                                //       ),
                                //     ));
                              } else if (i == 1) {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => const ListAuto(
                                //         id_control_user: 'sasdkf',
                                //         verbal_id: '0123',
                                //       ),
                                //     ));
                              } else if (i == 2) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Map_List_search_auto_verbal(
                                        get_commune: (value) {},
                                        get_district: (value) {},
                                        get_lat: (value) {},
                                        get_log: (value) {},
                                        get_max1: (value) {},
                                        get_max2: (value) {},
                                        get_min1: (value) {},
                                        get_min2: (value) {},
                                        get_province: (value) {},
                                      ),
                                    ));
                              }
                            },
                            child:
                                textfield(verbalOption[i]['title'].toString())))
                else if (index == 6)
                  for (int i = 0; i < approvelList.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ClassSubmit(
                                        device: widget.device,
                                        listUser: widget.listUser)));

                                // setState(() {
                                //   type = 70;
                                //   print("OKOK : $type");
                                // });
                              }
                            },
                            child:
                                textfield(approvelList[i]['title'].toString())))
                else if (index == 7)
                  for (int i = 0; i < userOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 2) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const CTL_User()));
                              } else if (i == 3) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Notivigation_day(),
                                    ));
                              } else if (i == 4) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => User_Vpoint(
                                        controller_user: widget.id,
                                      ),
                                    ));
                              }
                            },
                            child:
                                textfield(userOption[i]['title'].toString())))
                else if (index == 8)
                  for (int i = 0; i < reportOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return MenuCostomerResport(id: widget.id);
                                  },
                                ));
                              }
                              if (i == 2) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      content: IntrinsicWidth(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              title: const Text(
                                                  'Comparable Year Report'),
                                              onTap: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ResponsiveReportYear(),
                                                  ),
                                                );
                                              },
                                            ),
                                            ListTile(
                                              title:
                                                  const Text('Comparable Case'),
                                              onTap: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ComparableCasePage(),
                                                  ),
                                                );
                                              },
                                            ),
                                            ListTile(
                                              title: const Text(
                                                  'Comparable Case Bar Chart'),
                                              onTap: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ComparableCaseBarChartPage(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              if (i == 5) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const Total_Amount();
                                  },
                                ));
                              }
                              if (i == 6) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const Trastoin_Payment();
                                  },
                                ));
                              }
                            },
                            child:
                                textfield(reportOption[i]['title'].toString())))
              ];
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 15,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: whiteColor),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        optionIconList[index]['icon'].toString(),
                        fit: BoxFit.cover,
                        height: 90,
                        width: (widget.device == 't' || widget.device == 'd')
                            ? 100
                            : 125,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        listTitle[index]['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontsizes,
                            color: (selectindexs == index)
                                ? blueColor
                                : greyColorNolot),
                      ),
                      const SizedBox(height: 30)
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget settingOptionWrap() {
    return Wrap(
      alignment:
          (widget.device == 'm') ? WrapAlignment.center : WrapAlignment.start,
      children: [
        for (int index = 0; index < optionIconListsetting.length; index++)
          PopupMenuButton(
            elevation: 15,
            itemBuilder: (context) {
              return [
                if (index == 1)
                  for (int i = 0; i < registerOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {},
                            child: textfield(
                                registerOption[i]['title'].toString())))
                else if (index == 2)
                  for (int i = 0; i < autoOptions.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (index == 2) {
                                for (int i = 0; i < registerOption.length; i++)
                                  if (i == 0) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NewAuto()));
                                  }
                                if (i == 1) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const AutoList()));
                                }
                                if (i == 2) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const District()));
                                }
                              }
                            },
                            child:
                                textfield(autoOptions[i]['title'].toString())))
                else if (index == 4)
                  for (int i = 0; i < bankOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const new_Bank()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Bank_list()));
                              }
                            },
                            child:
                                textfield(bankOption[i]['title'].toString())))
                else if (index == 5)
                  for (int i = 0; i < brandOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const new_Brand()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Brand_list()));
                              }
                            },
                            child:
                                textfield(brandOption[i]['title'].toString())))
                else if (index == 6)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => New_Agency()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Agency_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 9)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => New_Assign()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Assign_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 10)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const New_Inspector()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Assign_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 11)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const New_Inspector()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Assign_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 12)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const New_Register()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Register_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 13)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const New_Acompany()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Acompany_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 14)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const New_Acompany()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Approved_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
                else if (index == 15)
                  for (int i = 0; i < approvedOption.length; i++)
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              if (i == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const New_Appraiser()));
                              }
                              if (i == 1) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Appraiser_List()));
                              }
                            },
                            child: textfield(
                                approvedOption[i]['title'].toString())))
              ];
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 15,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: whiteColor),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        optionIconListsetting[index]['icon'].toString(),
                        fit: BoxFit.cover,
                        height: 80,
                        width: (widget.device == 't' || widget.device == 'd')
                            ? 100
                            : 125,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        listTitlesetting[index]['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontsizes,
                            color: (selectindexs == index)
                                ? blueColor
                                : greyColorNolot),
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  int onrow = 10;
  String dd = '';
  Uint8List? getBytes;
  Uint8List? byesData;

  String? croppedBlobUrl;
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
      getBytes = Uint8List.fromList(bytes);
      // await
      setState(() {
        croppedBlobUrl = croppedFile.path;
        saveBlobToFile(croppedBlobUrl!, croppedFile.path);
        Navigator.pop(context);
      });

      if (cropimageFile != null) {}
    }
  }

  Future<void> saveBlobToFile(String blobUrl, String filename) async {
    final response = await http.get(Uri.parse(blobUrl));
    final bytes = response.bodyBytes;

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/$filename";
  }

  List bank = [
    {'title': 'Bank'},
    {'title': 'Private'},
    {'title': 'Other'},
  ];
  List genderlist = [
    {'title': 'Male'},
    {'title': 'Female'},
    {'title': 'Other'},
  ];
  Random random = Random();

  String imageUrl = '';
  Uint8List? selectedFile;
  late File croppedFile;
  final completer = Completer<Uint8List>();
  Future<void> openImgae() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();

    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files!.elementAt(0);
      final reader = html.FileReader();
      reader.onLoadEnd.listen((event) {
        setState(() {
          byesData = const Base64Decoder()
              .convert(reader.result.toString().split(',').last);
          selectedFile = byesData;
          croppedFile = File.fromRawPath(byesData!);
          imageUrl = html.Url.createObjectUrlFromBlob(file.slice());
          // Navigator.pop(context);
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  double fontsizepf = 12;
  Widget profile() {
    return Container(
      height: 100,
      width: (widget.device == 'd' || widget.device == 't')
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 26, 50, 209),
            Color.fromARGB(255, 39, 92, 206),
            Color.fromARGB(255, 39, 92, 206),
            Color.fromARGB(255, 6, 172, 201),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.1, 0.2, 0.3, 0.5],
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      (widget.device == 'm')
                          ? IconButton(
                              onPressed: () {
                                scaffoldKey.currentState!.openDrawer();
                              },
                              icon: Icon(
                                Icons.menu,
                                color: whileColors,
                              ))
                          : const SizedBox(),
                      const SizedBox(width: 10),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Profile',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: greyColor)),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                            Icons.remove_circle_outline))
                                  ]),
                              const SizedBox(height: 10),
                              Container(
                                height: 120,
                                width: 300,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: whileColors,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {});
                                        },
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            if (byesData == null)
                                              GFAvatar(
                                                size: 40,
                                                backgroundImage: NetworkImage(
                                                    '${(widget.listUser[0]['url'] == null) ? url : widget.listUser[0]['url']}'),
                                              )
                                            else if (byesData != null &&
                                                getBytes == null)
                                              GFAvatar(
                                                size: 40,
                                                backgroundImage:
                                                    MemoryImage(byesData!),
                                              )
                                            else
                                              GFAvatar(
                                                size: 40,
                                                backgroundImage:
                                                    MemoryImage(getBytes!),
                                              ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      cropImage();
                                                    },
                                                    icon: Icon(
                                                      Icons.crop,
                                                      color: whileColors,
                                                      size: 20,
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      openImgae();
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: whileColors,
                                                      size: 20,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Name : $username',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: fontsizepf,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'ID : $controlleruser',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: fontsizepf,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  TwinBox(
                                    labelText1: 'Firstname',
                                    labelText2: 'Lastname',
                                    fname: firstName.toString(),
                                    lname: lastName.toString(),
                                    get_fname: (value) {
                                      setState(() {
                                        // requestModel!.first_name = value;
                                      });
                                    },
                                    get_lname: (value) {
                                      setState(() {
                                        // requestModel!.last_name = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      DropDowntxt(
                                        txtvalue: gender.toString(),
                                        validator: true,
                                        flex: 3,
                                        value: (value) {},
                                        list: genderlist,
                                        valuedropdown: 'title',
                                        valuetxt: 'title',
                                      ),
                                      const SizedBox(width: 5),
                                      DropDowntxt(
                                        txtvalue: knownFrom.toString(),
                                        validator: true,
                                        flex: 3,
                                        value: (value) {},
                                        list: bank,
                                        valuedropdown: 'title',
                                        valuetxt: 'title',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const SingleBox(
                                    phone: "",
                                  ),
                                  const SizedBox(height: 10),
                                  Field_box(
                                    name: 'email',
                                    email: email.toString(),
                                    get_email: (value) {
                                      setState(() {
                                        email = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          // controller: Password!,
                                          onChanged: (input) {
                                            setState(() {
                                              password = input;
                                            });
                                          },
                                          // obscureText: isObscure,
                                          decoration: InputDecoration(
                                            fillColor: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            filled: true,
                                            labelText: 'Your Password',
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                color: const Color.fromRGBO(
                                                    169, 203, 56, 1),
                                                isObscure
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isObscure = !isObscure;
                                                });
                                              },
                                            ),
                                          ),
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return 'require *';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     ElevatedButton(
                              //       child: const Text('Save Change'),
                              //       onPressed: () async {
                              //         if (byesData != null) {
                              //           updateimage();
                              //           print('uploard');
                              //         }
                              //         // updateUser();
                              //       },
                              //     ),
                              //     const SizedBox(width: 15),
                              //     ElevatedButton(
                              //       child: const Text('Log Out'),
                              //       onPressed: () {
                              //         Navigator.pop(context);
                              //         Navigator.pop(context);
                              //       },
                              //     )
                              //   ],
                              // ),
                              // const SizedBox(height: 30),
                            ],
                          ))
                        ],
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(url.toString()),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.listUser[0]['username'].toString(),
                              style: TextStyle(
                                  color: whileColors,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Text(widget.listUser[0]['username'].toString(),
                              style: TextStyle(
                                color: whileColors,
                                fontSize: 12,
                              )),
                        ],
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
                const Spacer(),
                (widget.device == 'd' || widget.device == 't')
                    ? options('Notification', '0', Icons.notification_add)
                    : Stack(children: [
                        Icon(
                          Icons.notifications,
                          size: 40,
                          color: whiteColor,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Notifications(
                                          listnotificationlist:
                                              listnotificationlist,
                                        )));
                          },
                          child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 13,
                              child: Text(countNotification,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: whiteColor))),
                        ),
                      ]),
                (widget.device == 'd' || widget.device == 't')
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notifications(
                                        listnotificationlist:
                                            listnotificationlist,
                                      )));
                        },
                        child: options('New Users', countNotification,
                            Icons.notification_add),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
