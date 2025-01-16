import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_admin/Auth/login.dart';
import 'package:web_admin/components/colors/colors.dart';
import 'package:web_admin/page/navigate_home/UI_APP/app_UI.dart';

import '../components/colors.dart';
import '../getx/Auth/Auth_agent.dart';
import '../getx/checkUpdate/updateCheck.dart';
import '../page/navigate_home/Approvel/classSubmit.dart';
import '../page/navigate_home/AutoVerbal/AutoVerbal.dart';
import '../page/navigate_home/AutoVerbal/Zone/add_zone.dart';
import '../page/navigate_home/AutoVerbal/input_road/InputRoad.dart';
import '../page/navigate_home/Auto_verbal/Add/googlemap_verbal.dart';
import '../page/navigate_home/Comparable/add_comparable_new_page.dart';
import '../page/navigate_home/Customer/List/customer_list.dart';
import '../page/navigate_home/Customer/responsiveDevice.dart/addnew.dart';
import '../page/navigate_home/Report/Total_amount.dart';
import '../page/navigate_home/Report/Transetoin/history.dart';
import '../page/homescreen/component/list.dart';
import '../page/navigate_home/Report/customer/menu.dart';
import '../page/navigate_home/Report/page/about_us_page.dart';
import '../page/navigate_home/Report/page/comparable_case_bar_chart.dart';
import '../page/navigate_home/Report/page/comparable_case_page.dart';
import '../page/navigate_home/Report/page/contact_us_page.dart';
import '../page/navigate_home/Report/page/faq_page.dart';
import '../page/navigate_home/Report/page/history_v_point_page.dart';
import '../page/navigate_home/Report/page/slider_page.dart';
import '../page/navigate_home/Report/page/sponsor_list_page.dart';
import '../page/navigate_home/Report/page/userlist_for_adminpage.dart';
import '../page/navigate_home/Report/page/userlist_page.dart';
import '../page/navigate_home/Report/page/v_point_page.dart';
import '../page/navigate_home/Report/responsvie/responsivereportyear.dart';
import '../page/navigate_home/User/control_user.dart';
import '../page/navigate_home/User/list_notivigation.dart';
import '../page/navigate_home/User/use_vpoint.dart';
import '../page/navigate_home/verbal/Add_VerbalAgent.dart';
import '../page/navigate_setting/Accompany_by/Acompany_List.dart';
import '../page/navigate_setting/Accompany_by/Acompany_new.dart';
import '../page/navigate_setting/Appraiser/Appraiser_list.dart';
import '../page/navigate_setting/Appraiser/Appraiser_new.dart';
import '../page/navigate_setting/Approved/Approved_list.dart';
import '../page/navigate_setting/Inspector/Inspector_List.dart';
import '../page/navigate_setting/Inspector/Inspector_new.dart';
import '../page/navigate_setting/Register/Register_List.dart';
import '../page/navigate_setting/Register/Register_new.dart';
import '../page/navigate_setting/agency/Agency_list.dart';
import '../page/navigate_setting/agency/Agency_new.dart';
import '../page/navigate_setting/assign/Assign_new.dart';
import '../page/navigate_setting/auto/auto_list.dart';
import '../page/navigate_setting/auto/check_District.dart';
import '../page/navigate_setting/auto/new_auto.dart';
import '../page/navigate_setting/bank/bank/bank_list.dart';
import '../page/navigate_setting/bank/bank/new_bank.dart';
import '../page/navigate_setting/bank/brand/brand_list.dart';
import '../page/navigate_setting/bank/brand/new_brand.dart';
import '../page/navigate_setting/online/add_agent.dart';
import '../page/navigate_setting/online/isonline.dart';
import '../screen/Property/FirstProperty/ResponseDevice/responsive_layout.dart';

class DrawerOption extends StatefulWidget {
  const DrawerOption({
    super.key,
    required this.device,
    required this.listUser,
    required this.email,
  });
  final String device;
  final List listUser;
  final String email;

  @override
  State<DrawerOption> createState() => _DrawerOptionState();
}

class _DrawerOptionState extends State<DrawerOption> {
  List listControllerTitle = [];
  List listControllerIcons = [];
  @override
  void initState() {
    main();
    super.initState();
  }

  void main() {
    setState(() {
      if (widget.listUser[0]['agency'].toString() == "81") {
        listControllerTitle = listTitleAdmin;
        listControllerIcons = optionIconListAdmin;
        listReportOption = reportOptionS;
        listAdminOption = autoOptionAdmin;
      } else {
        listControllerTitle = listTitle;
        listControllerIcons = optionIconList;
        listReportOption = reportOption;
        if (widget.listUser[0]['zone_Allow'].toString() == "1") {
          listAdminOption = autoOptionAdmin;
        } else {
          listAdminOption = autoOption;
        }
      }
    });
  }

  ControllerUpdate controllerUpdate = ControllerUpdate();
  Authentication authentication = Authentication();
  List listReportOption = [];
  List listAdminOption = [];
  int selectindex = -1;
  int selectindexs = -1;
  @override
  Widget build(BuildContext context) {
    authentication = Get.put(Authentication());
    controllerUpdate = Get.put(ControllerUpdate());
    return Container(
      height: double.infinity,
      width: 280,
      color: whileColors,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 120,
              width: double.infinity,
              color: const Color.fromARGB(255, 26, 50, 209),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/KFA_CRM.png',
                      fit: BoxFit.fitWidth,
                      height: 80,
                      width: (widget.device == 't')
                          ? MediaQuery.of(context).size.width * 0.12
                          : MediaQuery.of(context).size.width * 0.08,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text("Home Page",
                style: TextStyle(
                    color: greyColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            for (int index = 0; index < listControllerTitle.length; index++)
              InkWell(
                onTap: () {},
                onHover: (value) {
                  setState(() {
                    selectindex = (selectindex == index) ? -1 : index;
                  });
                },
                child: PopupMenuButton(
                  tooltip: '',
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
                                            idController: widget.listUser[0]
                                                    ['agency']
                                                .toString(),
                                            myIdController: '',
                                          );
                                        },
                                      ));
                                    } else {
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
                                    switch (i) {
                                      case 0:
                                        // Navigator.push(context, MaterialPageRoute(
                                        //   builder: (context) {
                                        //     return const New_Executive();
                                        //   },
                                        // ));
                                        break;
                                      case 1:
                                        // Navigator.push(context, MaterialPageRoute(
                                        //   builder: (context) {
                                        //     return Executive_List();
                                        //   },
                                        // ));
                                        break;

                                      default:
                                      // Navigator.push(context, MaterialPageRoute(
                                      //   builder: (context) {
                                      //     return Executive_approvals();
                                      //   },
                                      // ));
                                    }
                                  },
                                  child: textfield(
                                      valuationoption[i]['title'].toString())))
                      else if (index == 2)
                        for (int i = 0; i < comparableotion.length; i++)
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    switch (i) {
                                      // case 0:
                                      //   Navigator.push(context, MaterialPageRoute(
                                      //     builder: (context) {
                                      //       return ResponsivenewcomparableAdd(
                                      //         id: widget.id.toString(),
                                      //         name: "",
                                      //       );
                                      //     },
                                      //   ));
                                      //   break;
                                      case 0:
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return AddComparable(
                                              listlocalhosts: widget.listUser,
                                              addNew: (value) {},
                                              // listUser: widget.listUser,
                                              type: (value) {},
                                            );
                                          },
                                        ));
                                      //   break;
                                      // case 3:
                                      //   Navigator.of(context).push(MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const comparable_search()));
                                      //   break;
                                      // case 4:
                                      //   Navigator.of(context).push(MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const List_comparable_filter()));
                                      //   break;
                                      // default:
                                      //   Navigator.push(context, MaterialPageRoute(
                                      //     builder: (context) {
                                      //       return Executive_approvals();
                                      //     },
                                      //   ));
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
                        for (int i = 0; i < listAdminOption.length; i++)
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    switch (i) {
                                      case 0:
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VerbalAdmin(
                                                      addNew: (value) {},
                                                      listUser: widget.listUser,
                                                      type: (value) {},
                                                    )));
                                        break;
                                      case 1:
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Show_autoVerbals()));
                                        break;
                                      case 2:
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => ZoneMap(
                                                      listLocalHost:
                                                          widget.listUser,
                                                    )));
                                        break;

                                      default:
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => InputRoad(
                                                      listUsers:
                                                          widget.listUser,
                                                    )));
                                        break;
                                    }
                                    // switch (i) {
                                    //   case 0:
                                    //     Navigator.of(context)
                                    //         .push(MaterialPageRoute(
                                    //             builder: (context) => VerbalAdmin(
                                    //                   addNew: (value) {},
                                    //                   listUser: widget.listUser,
                                    //                   type: (value) {},
                                    //                 )));
                                    //     break;
                                    //   case 1:
                                    //     Navigator.of(context).push(
                                    //         MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 const Show_autoVerbals()));
                                    //     break;
                                    //   default:
                                    //     Navigator.of(context)
                                    //         .push(MaterialPageRoute(
                                    //             builder: (context) => ZoneMap(
                                    //                   listLocalHost:
                                    //                       widget.listUser,
                                    //                 )));
                                    //     break;
                                    // }
                                  },
                                  child: textfield(
                                      listAdminOption[i]['title'].toString())))
                      else if (index == 5)
                        for (int i = 0; i < verbalOption.length; i++)
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VerbalAgent(
                                                  type: (value) {},
                                                  listUser: widget.listUser,
                                                  addNew: (value) {},
                                                )));
                                  },
                                  child: textfield(
                                      verbalOption[i]['title'].toString())))
                      else if (index == 6)
                        for (int i = 0; i < approvelList.length; i++)
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    if (i == 0) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => ClassSubmit(
                                                  device: widget.device,
                                                  listUser: widget.listUser)));

                                      // setState(() {
                                      //   type = 70;
                                      //   print("OKOK : $type");
                                      // });
                                    }
                                  },
                                  child: textfield(
                                      approvelList[i]['title'].toString())))
                      else if (index == 7)
                        for (int i = 0; i < userOption.length; i++)
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    switch (i) {
                                      case 0:
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserListPage(
                                                        id: widget.listUser[0]
                                                                ['id']
                                                            .toString())));
                                        break;
                                      case 1:
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserListForAdmin(
                                                        id: widget.listUser[0]
                                                                ['id']
                                                            .toString())));
                                        break;
                                      case 2:
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CTL_User()));
                                        break;
                                      case 3:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Notivigation_day(),
                                            ));
                                        break;

                                      default:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => User_Vpoint(
                                                controller_user: widget
                                                    .listUser[0]['agency']
                                                    .toString(),
                                              ),
                                            ));
                                        break;
                                    }
                                  },
                                  child: textfield(
                                      userOption[i]['title'].toString())))
                      else if (index == 8)
                        for (int i = 0; i < listReportOption.length; i++)
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    switch (i) {
                                      case 0:
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return MenuCostomerResport(
                                                id: widget.listUser[0]['agency']
                                                    .toString());
                                          },
                                        ));
                                        break;
                                      case 2:
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.zero,
                                              content: IntrinsicWidth(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                      title: const Text(
                                                          'Comparable Case'),
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
                                        break;
                                      case 5:
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return const Total_Amount();
                                          },
                                        ));
                                        break;
                                      case 6:
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return const Trastoin_Payment();
                                          },
                                        ));
                                        break;
                                      case 7:
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return AddUser();
                                          },
                                        ));
                                        break;
                                      default:
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return const IsOnline();
                                          },
                                        ));
                                    }
                                  },
                                  child: textfield(
                                      listReportOption[i]['title'].toString())))
                      else if (index == 9)
                        for (int i = 0; i < adminControllerList.length; i++)
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    switch (i) {
                                      case 0:
                                        AwesomeDialog(
                                          padding: const EdgeInsets.only(
                                              right: 30,
                                              left: 30,
                                              bottom: 10,
                                              top: 10),
                                          alignment: Alignment.center,
                                          width: 400,
                                          context: context,
                                          dialogType: DialogType.question,
                                          animType: AnimType.rightSlide,
                                          headerAnimationLoop: false,
                                          title: "Client Update!",
                                          desc:
                                              "Do you want Allow to client All for New Update?",
                                          btnOkOnPress: () async {
                                            await controllerUpdate
                                                .checkUpdateClientAll(context);
                                          },
                                          btnCancelOnPress: () {},
                                        ).show();
                                        break;
                                      case 1:
                                        AwesomeDialog(
                                          padding: const EdgeInsets.only(
                                              right: 30,
                                              left: 30,
                                              bottom: 10,
                                              top: 10),
                                          alignment: Alignment.center,
                                          width: 400,
                                          context: context,
                                          dialogType: DialogType.question,
                                          animType: AnimType.rightSlide,
                                          headerAnimationLoop: false,
                                          title: "Admin Update!",
                                          desc:
                                              "Do you want Allow to Admin All for New Update?",
                                          btnOkOnPress: () async {
                                            await controllerUpdate
                                                .checkUpdateAll(context);
                                          },
                                          btnCancelOnPress: () {},
                                        ).show();
                                        break;
                                      case 2:
                                        AwesomeDialog(
                                          padding: const EdgeInsets.only(
                                              right: 30,
                                              left: 30,
                                              bottom: 10,
                                              top: 10),
                                          alignment: Alignment.center,
                                          width: 400,
                                          context: context,
                                          dialogType: DialogType.question,
                                          animType: AnimType.rightSlide,
                                          headerAnimationLoop: false,
                                          title: "Off Client System!",
                                          desc:
                                              "Do you want Off system Client?",
                                          btnOkOnPress: () async {
                                            await controllerUpdate
                                                .checkOFFSystemAll(
                                                    1, 1, context);
                                          },
                                          btnCancelOnPress: () {},
                                        ).show();
                                        break;

                                      case 3:
                                        AwesomeDialog(
                                          padding: const EdgeInsets.only(
                                              right: 30,
                                              left: 30,
                                              bottom: 10,
                                              top: 10),
                                          alignment: Alignment.center,
                                          width: 400,
                                          context: context,
                                          dialogType: DialogType.question,
                                          animType: AnimType.rightSlide,
                                          headerAnimationLoop: false,
                                          title: "Open Client System!",
                                          desc:
                                              "Do you want Open system Client?",
                                          btnOkOnPress: () async {
                                            await controllerUpdate
                                                .checkOFFSystemAll(
                                                    1, 0, context);
                                          },
                                          btnCancelOnPress: () {},
                                        ).show();
                                        break;
                                      case 4:
                                        AwesomeDialog(
                                          padding: const EdgeInsets.only(
                                              right: 30,
                                              left: 30,
                                              bottom: 10,
                                              top: 10),
                                          alignment: Alignment.center,
                                          width: 400,
                                          context: context,
                                          dialogType: DialogType.question,
                                          animType: AnimType.rightSlide,
                                          headerAnimationLoop: false,
                                          title: "Off Admin System!",
                                          desc: "Do you want Off system Admin?",
                                          btnOkOnPress: () async {
                                            await controllerUpdate
                                                .checkOFFSystemAll(
                                                    2, 2, context);
                                          },
                                          btnCancelOnPress: () {},
                                        ).show();
                                        break;
                                      case 5:
                                        AwesomeDialog(
                                          padding: const EdgeInsets.only(
                                              right: 30,
                                              left: 30,
                                              bottom: 10,
                                              top: 10),
                                          alignment: Alignment.center,
                                          width: 400,
                                          context: context,
                                          dialogType: DialogType.question,
                                          animType: AnimType.rightSlide,
                                          headerAnimationLoop: false,
                                          title: "Open Admin System!",
                                          desc:
                                              "Do you want Open system Admin?",
                                          btnOkOnPress: () async {
                                            await controllerUpdate
                                                .checkOFFSystemAll(
                                                    2, 0, context);
                                          },
                                          btnCancelOnPress: () {},
                                        ).show();
                                        break;
                                      case 6:
                                        break;
                                      default:
                                    }
                                  },
                                  child: textfield(adminControllerList[i]
                                          ['title']
                                      .toString())))
                      else
                        PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  Get.to(UIAPP(device: widget.device));
                                },
                                child: textfield('UI App'))),
                    ];
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 1,
                            color: (selectindex == index)
                                ? greyColorNolots
                                : whileColors)),
                    child: ListTile(
                      leading: Image.asset(
                        listControllerIcons[index]['icon'].toString(),
                        fit: BoxFit.cover,
                        height: 60,
                      ),
                      title: Text(
                          listControllerTitle[index]['title'].toString(),
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: greyColorNolot)),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color.fromARGB(255, 184, 179, 179),
                height: 3,
              ),
            ),
            const SizedBox(height: 10),
            Text("Setting Admin",
                style: TextStyle(
                    color: greyColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            for (int index = 0; index < optionIconListsetting.length; index++)
              InkWell(
                onTap: () {},
                onHover: (value) {
                  setState(() {
                    selectindexs = (selectindexs == index) ? -1 : index;
                  });
                },
                child: PopupMenuButton(
                  tooltip: '',
                  elevation: 15,
                  itemBuilder: (context) => [
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
                                    for (int i = 0;
                                        i < registerOption.length;
                                        i++)
                                      if (i == 0) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const NewAuto()));
                                      }
                                    if (i == 1) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AutoList()));
                                    }
                                    if (i == 2) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const District()));
                                    }
                                  }
                                },
                                child: textfield(
                                    autoOptions[i]['title'].toString())))
                    else if (index == 4)
                      for (int i = 0; i < bankOption.length; i++)
                        PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  if (i == 0) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const new_Bank()));
                                  }
                                  if (i == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Bank_list()));
                                  }
                                },
                                child: textfield(
                                    bankOption[i]['title'].toString())))
                    else if (index == 5)
                      for (int i = 0; i < brandOption.length; i++)
                        PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  if (i == 0) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const new_Brand()));
                                  }
                                  if (i == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Brand_list()));
                                  }
                                },
                                child: textfield(
                                    brandOption[i]['title'].toString())))
                    else if (index == 6)
                      for (int i = 0; i < approvedOption.length; i++)
                        PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  if (i == 0) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const New_Agency()));
                                  }
                                  if (i == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Agency_List()));
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const New_Assign()));
                                  }
                                  if (i == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Assign_List()));
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const New_Inspector()));
                                  }
                                  if (i == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Assign_List()));
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const New_Inspector()));
                                  }
                                  if (i == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Assign_List()));
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const New_Register()));
                                  }
                                  if (i == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const New_Acompany()));
                                  }
                                  if (i == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const New_Acompany()));
                                  }
                                  if (i == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const New_Appraiser()));
                                  }
                                  if (i == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Appraiser_List()));
                                  }
                                },
                                child: textfield(
                                    approvedOption[i]['title'].toString())))
                    else if (index == 19)
                      for (int i = 0; i < vpointOption.length; i++)
                        PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  if (i == 0) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VpointListPage()));
                                  }
                                  if (i == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HistoryVPointPage()));
                                  }
                                },
                                child: textfield(
                                    vpointOption[i]['title'].toString())))
                    else if (index == 20)
                      for (int i = 0; i < sponsorOption.length; i++)
                        PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  if (i == 0) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SponsorListPage()));
                                  }
                                  if (i == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SliderPage()));
                                  }
                                },
                                child: textfield(
                                    sponsorOption[i]['title'].toString())))
                    else if (index == 21)
                      for (int i = 0; i < faqOption.length; i++)
                        PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  if (i == 0) {
                                    Get.to(() => FaqPage(),
                                        preventDuplicates: false);
                                  }
                                  if (i == 1) {
                                    Get.to(() => const ContactUsPage(),
                                        preventDuplicates: false);
                                  }
                                  if (i == 2) {
                                    Get.to(() => const AboutUsPage());
                                  }
                                },
                                child: textfield(
                                    faqOption[i]['title'].toString())))
                  ],
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 1,
                            color: (selectindexs == index)
                                ? greyColorNolots
                                : whileColors)),
                    child: ListTile(
                      leading: Image.asset(
                        optionIconListsetting[index]['icon'].toString(),
                        fit: BoxFit.cover,
                        height: 60,
                      ),
                      title: Text(listTitlesetting[index]['title'].toString(),
                          style:
                              // (selectindex == index)
                              //     ?
                              TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  // decoration: TextDecoration.underline,
                                  color: greyColorNolot)
                          // :
                          //  TextStyle(
                          //     color: greyColorNolot,
                          //     fontSize: 13,
                          //   ),
                          ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                logOut();
              },
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: Text("LogOut",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: greyColorNolot)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textfield(txt) {
    return Text(txt, style: const TextStyle(fontWeight: FontWeight.bold));
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listLocalhostData = prefs.getStringList('localhost') ?? [];
    List<Map<String, dynamic>> listlocalhost = listLocalhostData
        .map((item) => json.decode(item) as Map<String, dynamic>)
        .toList();

    // Find the index of the current user using both email and password
    int userIndex = listlocalhost.indexWhere((item) =>
        item['email'] == widget.listUser[0]['email'] &&
        item['password'] == widget.listUser[0]['password']);

    if (userIndex != -1) {
      // Remove the entire user data
      listlocalhost.removeAt(userIndex);
    }

    // Update the SharedPreferences with the modified list
    List<String> updatedList =
        listlocalhost.map((item) => json.encode(item)).toList();
    await prefs.setStringList('localhost', updatedList);

    Fluttertoast.showToast(
      msg: 'Logged Out',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      textColor: Colors.blue,
      fontSize: 20,
    );
    Get.offAll(() => const LoginPage());
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => const LoginPage()),
    //   (Route<dynamic> route) => false,
    // );
  }
}
