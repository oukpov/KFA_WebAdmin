import 'package:flutter/material.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/colors.dart';
import '../../components/colors/colors.dart';
import '../../screen/Property/FirstProperty/ResponseDevice/responsive_layout.dart';
import '../navigate_home/Add/Add.dart';
import '../navigate_home/Add/listPropertyCheck.dart';
import '../navigate_home/AutoVerbal/AutoVerbal.dart';
import '../navigate_home/Customer/List/customer_list.dart';
import '../navigate_home/Customer/map_in_list_search _autoverbal.dart';
import '../navigate_home/Customer/responsiveDevice.dart/addnew.dart';
import '../navigate_home/Report/Total_amount.dart';
import '../navigate_home/Report/Transetoin/history.dart';
import '../navigate_home/Report/customer/menu.dart';
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
import '../navigate_home/Comparable/comparable_1/New_Comparable.dart';
import '../navigate_home/Comparable/comparable_2/Comparable_list_view.dart';
import 'Widgets/drawerMenu.dart';
import 'Widgets/drawer.dart';
import 'Widgets/widgets.dart';
import 'component/list.dart';

class homescreen extends StatefulWidget {
  const homescreen(
      {super.key,
      required this.device,
      required this.id,
      required this.name,
      required this.controllerUser,
      required this.nativigation,
      required this.email});
  final String id;
  final String name;
  final String controllerUser;
  final bool nativigation;
  final String email;
  final String device;
  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  double fontsizes = 11;
  bool drawer = false;
  double w = 0;
  int selectindex = -1;
  int selectindexs = -1;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundScreen,
      drawer: const DrawerWidget(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.device == 't' || widget.device == 'd')
              ? DrawerOption(device: widget.device)
              : const SizedBox(),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: (widget.device == 't' || widget.device == 'd')
                ? MediaQuery.of(context).size.width * 0.77
                : MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 30, left: 30, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(w.toString()),
                    profile(),
                    title('Home Page'),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: (widget.device == 'm')
                            ? WrapAlignment.center
                            : WrapAlignment.start,
                        children: [
                          for (int index = 0; index < listTitle.length; index++)
                            PopupMenuButton(
                              elevation: 15,
                              itemBuilder: (context) {
                                return [
                                  if (index == 0)
                                    for (int i = 0;
                                        i < customeroption.length;
                                        i++)
                                      PopupMenuItem(
                                          child: InkWell(
                                              onTap: () {
                                                if (i == 0) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return ResponsiveCustomer(
                                                        email: '',
                                                        idController: '96',
                                                        myIdController: '',
                                                      );
                                                    },
                                                  ));
                                                }

                                                if (i == 1) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return const Customer_List();
                                                    },
                                                  ));
                                                }
                                              },
                                              child: textfield(customeroption[i]
                                                      ['title']
                                                  .toString())))
                                  else if (index == 1)
                                    for (int i = 0;
                                        i < valuationoption.length;
                                        i++)
                                      PopupMenuItem(
                                          child: InkWell(
                                              onTap: () {
                                                if (i == 0) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return const New_Executive();
                                                    },
                                                  ));
                                                }
                                                if (i == 1) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return Executive_List();
                                                    },
                                                  ));
                                                }
                                                if (i == 2) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return Executive_approvals();
                                                    },
                                                  ));
                                                }
                                              },
                                              child: textfield(
                                                  valuationoption[i]['title']
                                                      .toString())))
                                  else if (index == 2)
                                    for (int i = 0;
                                        i < comparableotion.length;
                                        i++)
                                      PopupMenuItem(
                                          child: InkWell(
                                              onTap: () {
                                                if (i == 0) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return const New_Comparable();
                                                    },
                                                  ));
                                                }
                                                if (i == 1) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ComparableList(
                                                                name:
                                                                    widget.name,
                                                              )));
                                                }
                                                if (i == 2) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const comparable_search()));
                                                }
                                                if (i == 3) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const List_comparable_filter()));
                                                }
                                              },
                                              child: textfield(
                                                  comparableotion[i]['title']
                                                      .toString())))
                                  else if (index == 3)
                                    PopupMenuItem(
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResponsiveLayout(
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
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Show_autoVerbals()));
                                                }
                                                if (i == 0) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Add(
                                                                id_control_user:
                                                                    '97',
                                                                id: widget.id,
                                                              )));
                                                }
                                              },
                                              child: textfield(autoOption[i]
                                                      ['title']
                                                  .toString())))
                                  else if (index == 5)
                                    for (int i = 0;
                                        i < verbalOption.length;
                                        i++)
                                      PopupMenuItem(
                                          child: InkWell(
                                              onTap: () {
                                                if (i == 0) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Add(
                                                          id_control_user:
                                                              'sdf96',
                                                          id: '12',
                                                        ),
                                                      ));
                                                } else if (i == 1) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const List_Auto(
                                                          id_control_user:
                                                              'sasdkf',
                                                          verbal_id: '0123',
                                                        ),
                                                      ));
                                                } else if (i == 2) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Map_List_search_auto_verbal(
                                                          get_commune:
                                                              (value) {},
                                                          get_district:
                                                              (value) {},
                                                          get_lat: (value) {},
                                                          get_log: (value) {},
                                                          get_max1: (value) {},
                                                          get_max2: (value) {},
                                                          get_min1: (value) {},
                                                          get_min2: (value) {},
                                                          get_province:
                                                              (value) {},
                                                        ),
                                                      ));
                                                }
                                              },
                                              child: textfield(verbalOption[i]
                                                      ['title']
                                                  .toString())))
                                  else if (index == 6)
                                    for (int i = 0; i < userOption.length; i++)
                                      PopupMenuItem(
                                          child: InkWell(
                                              onTap: () {
                                                if (i == 2) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const CTL_User()));
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
                                                        builder: (context) =>
                                                            User_Vpoint(
                                                          controller_user: '94',
                                                        ),
                                                      ));
                                                }
                                              },
                                              child: textfield(userOption[i]
                                                      ['title']
                                                  .toString())))
                                  else if (index == 7)
                                    for (int i = 0;
                                        i < reportOption.length;
                                        i++)
                                      PopupMenuItem(
                                          child: InkWell(
                                              onTap: () {
                                                if (i == 0) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return MenuCostomerResport(
                                                          id: widget.id);
                                                    },
                                                  ));
                                                }
                                                if (i == 5) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return const Total_Amount();
                                                    },
                                                  ));
                                                }
                                                if (i == 6) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return const Trastoin_Payment();
                                                    },
                                                  ));
                                                }
                                              },
                                              child: textfield(reportOption[i]
                                                      ['title']
                                                  .toString())))
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
                                          optionIconList[index]['icon']
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: 90,
                                          width: (widget.device == 't' ||
                                                  widget.device == 'd')
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
                      ),
                    ),
                    title('Setting Admin'),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: (widget.device == 'm')
                            ? WrapAlignment.center
                            : WrapAlignment.start,
                        children: [
                          for (int index = 0;
                              index < optionIconListsetting.length;
                              index++)
                            PopupMenuButton(
                              elevation: 15,
                              itemBuilder: (context) {
                                return [
                                  if (index == 1)
                                    for (int i = 0;
                                        i < registerOption.length;
                                        i++)
                                      PopupMenuItem(
                                          child: InkWell(
                                              onTap: () {},
                                              child: textfield(registerOption[i]
                                                      ['title']
                                                  .toString())))
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
                                                                const AutoList()));
                                                  }
                                                  if (i == 2) {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const District()));
                                                  }
                                                }
                                              },
                                              child: textfield(autoOptions[i]
                                                      ['title']
                                                  .toString())))
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
                                              child: textfield(bankOption[i]
                                                      ['title']
                                                  .toString())))
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
                                              child: textfield(brandOption[i]
                                                      ['title']
                                                  .toString())))
                                  else if (index == 6)
                                    for (int i = 0;
                                        i < approvedOption.length;
                                        i++)
                                      PopupMenuItem(
                                          child: InkWell(
                                              onTap: () {
                                                if (i == 0) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              New_Agency()));
                                                }
                                                if (i == 1) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Agency_List()));
                                                }
                                              },
                                              child: textfield(approvedOption[i]
                                                      ['title']
                                                  .toString())))
                                  else if (index == 9)
                                    for (int i = 0;
                                        i < approvedOption.length;
                                        i++)
                                      PopupMenuItem(
                                          child: InkWell(
                                              onTap: () {
                                                if (i == 0) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              New_Assign()));
                                                }
                                                if (i == 1) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Assign_List()));
                                                }
                                              },
                                              child: textfield(approvedOption[i]
                                                      ['title']
                                                  .toString())))
                                  else if (index == 10)
                                    for (int i = 0;
                                        i < approvedOption.length;
                                        i++)
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
                                              child: textfield(approvedOption[i]
                                                      ['title']
                                                  .toString())))
                                  else if (index == 11)
                                    for (int i = 0;
                                        i < approvedOption.length;
                                        i++)
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
                                              child: textfield(approvedOption[i]
                                                      ['title']
                                                  .toString())))
                                  else if (index == 12)
                                    for (int i = 0;
                                        i < approvedOption.length;
                                        i++)
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
                                              child: textfield(approvedOption[i]
                                                      ['title']
                                                  .toString())))
                                  else if (index == 13)
                                    for (int i = 0;
                                        i < approvedOption.length;
                                        i++)
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
                                              child: textfield(approvedOption[i]
                                                      ['title']
                                                  .toString())))
                                  else if (index == 14)
                                    for (int i = 0;
                                        i < approvedOption.length;
                                        i++)
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
                                              child: textfield(approvedOption[i]
                                                      ['title']
                                                  .toString())))
                                  else if (index == 15)
                                    for (int i = 0;
                                        i < approvedOption.length;
                                        i++)
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
                                              child: textfield(approvedOption[i]
                                                      ['title']
                                                  .toString())))
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
                                          optionIconListsetting[index]['icon']
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: 80,
                                          width: (widget.device == 't' ||
                                                  widget.device == 'd')
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
                      ),
                    ),
                    const SizedBox(height: 80)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

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
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.red,
            ),
            const SizedBox(width: 10),
            Container(
              height: 100,
              color: Colors.red,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style: TextStyle(
                          color: whileColors,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(widget.email,
                      style: TextStyle(
                        color: whileColors,
                        fontSize: 12,
                      ))
                ],
              ),
            ),
            const Spacer(),
            (widget.device == 'd' || widget.device == 't')
                ? options('Notification', '100', Icons.notification_add)
                : const SizedBox(),
            (widget.device == 'd' || widget.device == 't')
                ? options('New Users', '100', Icons.notification_add)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
