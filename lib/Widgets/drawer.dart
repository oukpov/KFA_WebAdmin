import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_admin/Auth/login.dart';
import 'package:web_admin/components/ApprovebyAndVerifyby.dart';
import 'package:web_admin/components/colors/colors.dart';
import 'package:web_admin/page/navigate_home/UI_APP/app_UI.dart';
import '../components/colors.dart';
import '../getx/Auth/Auth_agent.dart';
import '../getx/checkUpdate/updateCheck.dart';
import '../models/Auth/auth.dart';
import '../page/homescreen/component/list.dart';
import '../page/navigate_home/AutoVerbal/AutoVerbal.dart';
import '../page/navigate_home/AutoVerbal/Zone/add_zone.dart';
import '../page/navigate_home/AutoVerbal/input_road/InputRoad.dart';
import '../page/navigate_home/Auto_verbal/Add/googlemap_verbal.dart';
import '../page/navigate_home/Comparable/add_comparable_new_page.dart';
import '../page/navigate_home/Customer/List/customer_list.dart';
import '../page/navigate_home/Customer/responsiveDevice.dart/addnew.dart';
import '../page/navigate_home/Report/Total_amount.dart';
import '../page/navigate_home/Report/Transetoin/history.dart';
// import '../page/homescreen/component/list.dart';
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
import '../page/navigate_home/Report/page/v_point_list_page.dart';
import '../page/navigate_home/Report/responsvie/responsivereportyear.dart';
import '../page/navigate_home/User/control_user.dart';
import '../page/navigate_home/User/list_notivigation.dart';
import '../page/navigate_home/User/use_vpoint.dart';
import '../page/navigate_home/edit_road/add_comparable_new_page.dart';
import '../page/navigate_home/verbal/Add_VerbalAgent.dart';
import '../page/navigate_setting/Accompany_by/Acompany_List.dart';
import '../page/navigate_setting/Accompany_by/Acompany_new.dart';
import '../page/navigate_setting/Appraiser/Appraiser_list.dart';
import '../page/navigate_setting/Appraiser/Appraiser_new.dart';
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
    required this.onBack,
    // required this.listTitle,
  });
  final String device;
  final List listUser;
  // final List listTitle;
  final String email;
  final OnChangeCallback onBack;
  @override
  State<DrawerOption> createState() => _DrawerOptionState();
}

class _DrawerOptionState extends State<DrawerOption> {
  @override
  void initState() {
    main();
    super.initState();
  }

  List autoOption = [];
  List listTitle = [];
  List optionIconList = [];
  List listTitlesetting = [];
  List optionIconListsetting = [];
  void main() {
    setState(() {
      autoOption = [];
      listTitle = [];
      optionIconList = [];
      listTitlesetting = [];
      optionIconListsetting = [];
      autoOption = [
        {"title": "New Auto Verbal", "click": 1},
        {"title": "Auto Verbal List", "click": 2},
      ];
      listTitle = [
        {"title": "Customer", "click": 1},
        {"title": "Valuation", "click": 2},
        {"title": "Auto Verbal", "click": 5},
        {"title": "Verbal", "click": 6},
      ];
      optionIconList = [
        {"icon": "assets/icons/Costomer.png"},
        {"icon": "assets/icons/Valuation.png"},
        {"icon": "assets/icons/AutoVerbal.png"},
        {"icon": "assets/icons/Verbal.png"},
      ];
      listTitlesetting = [
        {"title": "Building Type", "click": 1},
        {"title": "Register", "click": 2},
        {"title": "Auto", "click": 3},
        {"title": "Road", "click": 4},
        {"title": "Bank", "click": 5},
        {"title": "Brand", "click": 6},
        {"title": "Agency", "click": 7},
        {"title": "Option", "click": 8},
        {"title": "Land", "click": 9},
        {"title": "Assign To", "click": 10},
        {"title": "Inspector Name", "click": 11},
        {"title": "Inspectors Name", "click": 12},
        {"title": "Register Name", "click": 13},
        {"title": "Accomnpany Name", "click": 14},
        {"title": "Approved Name", "click": 15},
        {"title": "Appraiser Name", "click": 16},
        {"title": "Province", "click": 17},
        {"title": "District", "click": 18},
        {"title": "Commune", "click": 19},
        // {"title": "Add Point"},
        {"title": "Banner", "click": 20},
        {"title": "Pages", "click": 21},
      ];
      optionIconListsetting = [
        {"icon": "assets/icons/apartment.png"},
        {"icon": "assets/icons/Register.png"},
        {"icon": "assets/icons/locations.png"},
        {"icon": "assets/icons/road.png"},
        {"icon": "assets/icons/bank.png"},
        {"icon": "assets/icons/bank.png"},
        {"icon": "assets/icons/agency.png"},
        {"icon": "assets/icons/option.png"},
        {"icon": "assets/icons/land.png"},
        {"icon": "assets/icons/assigned.png"},
        {"icon": "assets/icons/Inspector.png"},
        {"icon": "assets/icons/Inspector.png"},
        {"icon": "assets/icons/Register.png"},
        {"icon": "assets/icons/accompany.png"},
        {"icon": "assets/icons/Approved.png"},
        {"icon": "assets/icons/Appraiser.png"},
        {"icon": "assets/icons/locations.png"},
        {"icon": "assets/icons/locations.png"},
        {"icon": "assets/icons/locations.png"},
        // {"icon": "assets/icons/v.jpg"},
        {"icon": "assets/icons/sponsor.jpg"},
        {"icon": "assets/icons/pages.png"},
      ];
      //////
      // autoOption = autoOption;
      // listTitle = listTitle;
      // optionIconList = optionIconList;
      // listTitlesetting = listTitlesetting;
      // optionIconListsetting = optionIconListsetting;
      if (widget.listUser[0]['add_zone'].toString() == "1") {
        autoOption.add(
          {"title": "Add Zone Specail", "click": 3},
        );
      }
      if (widget.listUser[0]['comparable'].toString() == "1") {
        listTitle.add(
          {"title": "Comparable", "click": 3},
        );
        optionIconList.add(
          {"icon": "assets/icons/Comparable.png"},
        );
      }
      if (widget.listUser[0]['property'].toString() == "1") {
        listTitle.add(
          {"title": "property", "click": 4},
        );
        optionIconList.add(
          {"icon": "assets/icons/Property.png"},
        );
      }
      if (widget.listUser[0]['market_price_road'].toString() == "1") {
        autoOption.add(
          {"title": "Main Road & Market Price", "click": 4},
        );
      }
      // print("autoOption : $autoOption");
      if (widget.listUser[0]['approver'].toString() == "1") {
        listTitle.add(
          {"title": "Approval AutoVerbal", "click": 7},
        );
        optionIconList.add(
          {"icon": "assets/icons/Inspector.png"},
        );
      }
      if (widget.listUser[0]['agency'].toString() == "28") {
        listTitle.add(
          {"title": "Users", "click": 8},
        );
        optionIconList.add(
          {"icon": "assets/icons/User.png"},
        );
      }
      if (widget.listUser[0]['agency'].toString() == "28") {
        listTitle.add(
          {"title": "Report"},
        );
        optionIconList.add(
          {"icon": "assets/icons/Report.png", "click": 9},
        );
      }
      if (widget.listUser[0]['agency'].toString() == "28") {
        listTitle.add(
          {"title": "Admin", "click": 10},
        );
        optionIconList.add(
          {"icon": "assets/icons/Admin.png"},
        );
      }
      if (widget.listUser[0]['agency'].toString() == "28") {
        listTitle.add(
          {"title": "UI App"},
        );
        optionIconList.add(
          {"icon": "assets/icons/ui_app.png", "click": 11},
        );
      }
      if (widget.listUser[0]['add_vpoint'].toString() == '1') {
        listTitlesetting.add({"title": "Add Point", "click": 22});
        optionIconListsetting.add({"icon": "assets/icons/v.jpg"});
      }
      // print("===> Done! [$autoOption]");
      // }
    });
  }

  ControllerUpdate controllerUpdate = ControllerUpdate();
  Authentication authentication = Authentication();
  List listReportOption = [];
  // List listAdminOption = [];
  int selectindex = -1;
  int selectindexs = -1;
  int menuType5 = 0;
  AuthenModel authenModel = AuthenModel();
  @override
  Widget build(BuildContext context) {
    authentication = Get.put(Authentication());
    controllerUpdate = Get.put(ControllerUpdate());
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 280,
      color: whileColors,
      child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                widget.onBack(0);
              },
              child: Container(
                height: 40,
                width: 280,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
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
                child: Text("Home Page",
                    style: TextStyle(
                      color: whileColors,
                      fontSize: 15,
                    )),
              ),
            ),
            const SizedBox(height: 5),
            for (int index = 0; index < listTitle.length; index++)
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
                    int menuType = listTitle[index]['click'];
                    switch (menuType) {
                      case 1:
                        return [
                          for (int i = 0; i < customeroption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        Get.to(ResponsiveCustomer(
                                          email: '',
                                          idController: widget.listUser[0]
                                                  ['agency']
                                              .toString(),
                                          myIdController: '',
                                        ));
                                      } else {
                                        Get.to(const Customer_List());
                                      }
                                    },
                                    child: textfield(
                                        customeroption[i]['title'].toString())))
                        ];
                      case 2:
                        return [
                          for (int i = 0; i < valuationoption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      switch (i) {
                                        case 0:
                                          Get.to(ChangeRaod(
                                              type: (value) {},
                                              addNew: (value) {},
                                              listlocalhosts: widget.listUser));
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
                                    child: textfield(valuationoption[i]['title']
                                        .toString())))
                        ];
                      case 3:
                        return [
                          for (int i = 0; i < comparableotion.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      switch (i) {
                                        case 0:
                                          Get.to(AddComparable(
                                            listlocalhosts: widget.listUser,
                                            addNew: (value) {},
                                            // listUser: widget.listUser,
                                            type: (value) {},
                                          ));
                                      }
                                    },
                                    child: textfield(comparableotion[i]['title']
                                        .toString())))
                        ];
                      case 4:
                        return [
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    Get.to(ResponsiveLayout(
                                      myIdController: '',
                                      email: '',
                                      idController: '',
                                    ));
                                  },
                                  child: textfield('HomeProperty')))
                        ];
                      case 5:
                        return [
                          for (int i = 0; i < autoOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        menuType5 = autoOption[i]['click'];
                                        print("menuType5 : $menuType5");
                                      });
                                      switch (menuType5) {
                                        case 1:
                                          Get.to(VerbalAdmin(
                                            addNew: (value) {},
                                            listUser: widget.listUser,
                                            type: (value) {},
                                          ));
                                          break;
                                        case 2:
                                          Get.to(const Show_autoVerbals());
                                          break;
                                        case 3:
                                          Get.to(ZoneMap(
                                            listLocalHost: widget.listUser,
                                          ));
                                          break;

                                        case 4:
                                          Get.to(InputRoad(
                                            listUsers: widget.listUser,
                                          ));
                                          break;
                                        default:
                                          // Get.to(InputRoad(
                                          //   listUsers: widget.listUser,
                                          // ));
                                          break;
                                      }
                                    },
                                    child: textfield(
                                        autoOption[i]['title'].toString())))
                        ];
                      case 6:
                        return [
                          for (int i = 0; i < verbalOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      Get.to(VerbalAgent(
                                        type: (value) {},
                                        listUser: widget.listUser,
                                        addNew: (value) {},
                                      ));
                                    },
                                    child: textfield(
                                        verbalOption[i]['title'].toString())))
                        ];
                      case 7:
                        return [
                          for (int i = 0; i < approvelList.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      widget.onBack(7);
                                      // if (i == 0) {
                                      //   Get.to(ClassSubmit(
                                      //       device: widget.device,
                                      //       listUser: widget.listUser));
                                      // }
                                    },
                                    child: textfield(
                                        approvelList[i]['title'].toString())))
                        ];
                      case 8:
                        return [
                          for (int i = 0; i < userOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      switch (i) {
                                        case 0:
                                          Get.to(UserListPage(
                                              id: widget.listUser[0]['id']
                                                  .toString()));
                                          break;
                                        case 1:
                                          Get.to(UserListForAdmin(
                                              id: widget.listUser[0]['id']
                                                  .toString()));
                                          break;
                                        case 2:
                                          Get.to(const CTL_User());
                                          break;
                                        case 3:
                                          Get.to(const Notivigation_day());
                                          break;

                                        default:
                                          Get.to(
                                            User_Vpoint(
                                              controller_user: widget
                                                  .listUser[0]['agency']
                                                  .toString(),
                                            ),
                                          );
                                          break;
                                      }
                                    },
                                    child: textfield(
                                        userOption[i]['title'].toString())))
                        ];
                      case 9:
                        return [
                          for (int i = 0; i < listReportOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      switch (i) {
                                        case 0:
                                          Get.to(MenuCostomerResport(
                                              id: widget.listUser[0]['agency']
                                                  .toString()));
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
                                                          Navigator.pop(
                                                              context);
                                                          Get.to(
                                                              const ResponsiveReportYear());
                                                        },
                                                      ),
                                                      ListTile(
                                                        title: const Text(
                                                            'Comparable Case'),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          Get.to(
                                                              const ComparableCasePage());
                                                        },
                                                      ),
                                                      ListTile(
                                                        title: const Text(
                                                            'Comparable Case Bar Chart'),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);

                                                          Get.to(
                                                              const ComparableCaseBarChartPage());
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
                                          Get.to(const Total_Amount());
                                          break;
                                        case 6:
                                          Get.to(const Trastoin_Payment());
                                          break;
                                        case 7:
                                          Get.to(AddUser());
                                          break;
                                        default:
                                          Get.to(const IsOnline());
                                      }
                                    },
                                    child: textfield(listReportOption[i]
                                            ['title']
                                        .toString())))
                        ];
                      case 10:
                        return [
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
                                                  .checkUpdateClientAll(
                                                      context);
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
                                            desc:
                                                "Do you want Off system Admin?",
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
                                        case 7:
                                          // print("Admin");
                                          widget.onBack(107);
                                          Get.back();

                                          break;
                                        case 8:
                                          widget.onBack(108);
                                          Get.back();

                                          break;
                                        case 9:
                                          widget.onBack(109);
                                          Get.back();

                                          break;
                                        default:
                                      }
                                    },
                                    child: textfield(adminControllerList[i]
                                            ['title']
                                        .toString())))
                        ];
                      case 11:
                        // default:
                        return [
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    Get.to(UIAPP(device: widget.device));
                                  },
                                  child: textfield('UI App'))),
                        ];
                      default:
                        return [];
                    }
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
                        optionIconList[index]['icon'].toString(),
                        fit: BoxFit.cover,
                        height: 60,
                      ),
                      title: Text(listTitle[index]['title'].toString(),
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
            InkWell(
              onTap: () {
                widget.onBack(0);
              },
              child: Container(
                height: 40,
                width: 280,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
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
                child: Text("Setting Admin",
                    style: TextStyle(
                      color: whileColors,
                      fontSize: 15,
                    )),
              ),
            ),
            // Text("Setting Admin",
            //     style: TextStyle(
            //         color: greyColor,
            //         fontSize: 15,
            //         fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
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
                  itemBuilder: (context) {
                    int menuType = listTitlesetting[index]['click'];
                    switch (menuType) {
                      case 1:
                        return [];
                      case 2:
                        return [
                          for (int i = 0; i < registerOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {},
                                    child: textfield(
                                        registerOption[i]['title'].toString())))
                        ];
                      case 3:
                        return [
                          for (int i = 0; i < autoOptions.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      switch (i) {
                                        case 0:
                                          Get.to(const NewAuto());
                                          break;
                                        case 1:
                                          Get.to(AutoList());
                                          break;
                                        case 2:
                                          Get.to(const District());
                                          break;
                                      }
                                      // if (index == 2) {
                                      //   for (int i = 0;
                                      //       i < registerOption.length;
                                      //       i++)
                                      //     if (i == 0) {
                                      //
                                      //     }
                                      //   if (i == 1) {
                                      //
                                      //   }
                                      //   if (i == 2) {
                                      //
                                      //   }
                                      // }
                                    },
                                    child: textfield(
                                        autoOption[i]['title'].toString())))
                        ];
                      case 4:
                        return [];
                      case 5:
                        return [
                          for (int i = 0; i < bankOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        Get.to(const new_Bank());
                                      } else {
                                        Get.to(const Bank_list());
                                      }
                                    },
                                    child: textfield(
                                        bankOption[i]['title'].toString())))
                        ];
                      case 6:
                        return [
                          for (int i = 0; i < brandOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        Get.to(const new_Brand());
                                      } else {
                                        Get.to(const Brand_list());
                                      }
                                    },
                                    child: textfield(
                                        brandOption[i]['title'].toString())))
                        ];
                      case 7:
                        return [
                          for (int i = 0; i < approvedOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        Get.to(const New_Agency());
                                      } else {
                                        Get.to(const Agency_List());
                                      }
                                    },
                                    child: textfield(
                                        approvedOption[i]['title'].toString())))
                        ];
                      case 8:
                        return [];
                      case 9:
                        return [];

                      case 10:
                        return [
                          for (int i = 0; i < approvedOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        Get.to(const New_Assign());
                                      } else {
                                        Get.to(const Assign_List());
                                      }
                                    },
                                    child: textfield(
                                        approvedOption[i]['title'].toString())))
                        ];
                      case 11:
                        return [
                          for (int i = 0; i < approvedOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        Get.to(const New_Inspector());
                                      } else {
                                        Get.to(const Assign_List());
                                      }
                                    },
                                    child: textfield(
                                        approvedOption[i]['title'].toString())))
                        ];
                      case 12:
                        return [
                          for (int i = 0; i < approvedOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        Get.to(const New_Inspector());
                                      } else {
                                        Get.to(const Assign_List());
                                      }
                                    },
                                    child: textfield(
                                        approvedOption[i]['title'].toString())))
                        ];
                      case 13:
                        return [
                          for (int i = 0; i < approvedOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        Get.to(const New_Register());
                                      } else {
                                        Get.to(const Register_List());
                                      }
                                    },
                                    child: textfield(
                                        approvedOption[i]['title'].toString())))
                        ];
                      case 14:
                        return [
                          for (int i = 0; i < approvedOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        Get.to(const New_Acompany());
                                      } else {
                                        Get.to(const Acompany_List());
                                      }
                                    },
                                    child: textfield(
                                        approvedOption[i]['title'].toString())))
                        ];
                      case 15:
                        return [];
                      case 16:
                        return [
                          for (int i = 0; i < approvedOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        Get.to(const New_Appraiser());
                                      } else {
                                        Get.to(const Appraiser_List());
                                      }
                                    },
                                    child: textfield(
                                        approvedOption[i]['title'].toString())))
                        ];

                      case 20:
                        return [
                          for (int i = 0; i < sponsorOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        Get.to(const SponsorListPage());
                                      } else {
                                        Get.to(const SliderPage());
                                      }
                                    },
                                    child: textfield(
                                        sponsorOption[i]['title'].toString())))
                        ];
                      case 21:
                        return [
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
                        ];
                      case 22:
                        return [
                          for (int i = 0; i < vpointOption.length; i++)
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        Get.to(VpointListPage());
                                      } else {
                                        Get.to(const HistoryVPointPage());
                                      }
                                    },
                                    child: textfield(
                                        vpointOption[i]['title'].toString())))
                        ];
                      default:
                        return [];
                    }
                  },
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
  }
}
