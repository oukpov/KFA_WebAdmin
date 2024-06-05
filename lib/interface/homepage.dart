// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, prefer_interpolation_to_compose_strings, avoid_print, unnecessary_const, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, deprecated_member_use, unused_import, unnecessary_import, unused_local_variable, unused_element, sort_child_properties_last
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/badge/gf_button_badge.dart';
import 'package:getwidget/components/badge/gf_icon_badge.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../Customs/responsive.dart';
import 'navigate_home/User/list_notivigation.dart';
import 'navigate_setting/memu_propety.dart';
import 'navigate_home/on_home_page.dart';

class HomePage extends StatefulWidget {
  final String user;
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final String from;
  final String tel;
  final String password;
  final String id;
  final String? controller_user;
  final String? set_email;
  final String? set_password;
  // final String? control_user;

  HomePage({
    Key? key,
    required this.controller_user,
    required this.user,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.gender,
    required this.from,
    required this.tel,
    required this.id,
    required this.password,
    this.set_email,
    this.set_password,
    // this.control_user,
  }) : super(key: key);
  String getUserInfo() {
    return this.user;
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _advancedDrawerController = AdvancedDrawerController();
  static int pageIndex = 0;
  List pages = [];
  TextStyle colorizeTextStyle = TextStyle(
    fontSize: 30,
    fontFamily: 'Horizon',
    fontWeight: FontWeight.bold,
  );
  String? date_0;
  String? date_1;
  bool? nativigation;
  // var controller = controller_count();
  @override
  void initState() {
    DateTime now = DateTime.now();
    DateTime onewday = DateTime(now.year, now.month, now.day);
    DateTime twowday = DateTime(now.year, now.month, now.day + 1);
    String formattedDate_now = DateFormat('yyyy-MM-dd').format(onewday);
    String formattedDate_ago = DateFormat('yyyy-MM-dd').format(twowday);
    count_verbal(formattedDate_now, formattedDate_ago);
    pages = [
      NoBodyHome(
        email: widget.email,
        controller_user: widget.controller_user!,
        name: widget.user,
        nativigation: nativigation,
        id: widget.id,
      ),
      On_property(
        username: widget.user,
        email: widget.email,
        first_name: widget.first_name,
        last_name: widget.last_name,
        gender: widget.gender,
        from: widget.from,
        tel: widget.tel,
        id: widget.id,
      ),
    ];

    print("widget id => " + widget.controller_user!);
    super.initState();
  }

  String? count_string;

  void count_verbal(formattedDate_now, formattedDate_ago) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_nativigatoin?start=${formattedDate_now}&end=${formattedDate_ago}'));
      if (response.statusCode == 200) {
        int count_body = jsonDecode(response.body);
        int count = int.parse(count_body.toString());
        // print('Count = ${count.toString()}');
        count_string = count.toString();
        setState(() {
          count_string;
          // print(formattedDate_now.toString());
          // print(formattedDate_ago.toString());
        });
        // print('Count_String = ${count_string}');
      } else {
        print('Error value_all_list');
      }
    } catch (e) {
      print('Error value_all_list $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Color.fromARGB(255, 124, 148, 65),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const GFAvatar(
                  size: 140,
                  backgroundImage: AssetImage("assets/images/r.jpg"),
                ),
                Container(
                  height: 100.0,
                  // use name's widget.user
                  child: Text('User Name',
                      style: TextStyle(
                        //color: Color.fromRGBO(169, 203, 56, 1),
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).textScaleFactor * 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: const Text('info@kfa.com.kh | (855) 23 999 855'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 239, 238, 237),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[900],
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/k.png',
                fit: BoxFit.fitWidth,
                height: 70,
                width: 55,
              ),
              Text(
                '  ONE CLICK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' 1',
                style: TextStyle(
                    color: Colors.limeAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: const [
                      Shadow(blurRadius: 2, color: Colors.white)
                    ]),
              ),
              DefaultTextStyle(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22.0,
                  shadows: [Shadow(blurRadius: 2, color: Colors.limeAccent)],
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('\$',
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255))),
                  ],
                  pause: const Duration(milliseconds: 100),
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  onTap: () {},
                ),
              ),
            ],
          ),
          actions: [
            GFIconBadge(
              position: GFBadgePosition.topEnd(top: 15),
              child: GFIconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Notivigation_day(),
                      ));
                },
                icon: Icon(Icons.notifications_active_outlined),
              ),
              counterChild: GFBadge(
                child: Text("${count_string}"),
                shape: GFBadgeShape.circle,
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Responsive(
            mobile: pages[pageIndex],
            tablet: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 500,
                        child: pages[pageIndex],
                      ),
                    ],
                  ),
                )
              ],
            ),
            desktop: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 120, right: 120),
                  child: pages[pageIndex],
                )
              ],
            ),
            phone: pages[pageIndex],
          ),
        ),
        bottomNavigationBar: buildMyNavBar(context),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.deepPurple[800],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 40,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.widgets_rounded,
                    color: Colors.white,
                    size: 40,
                  )
                : const Icon(
                    Icons.widgets_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 30,
                  ),
          ),
        ],
      ),
    );
  }

  Widget appbar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        AppBar(
          backgroundColor: Colors.deepPurple[900],
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('KFA\' ONE CLICK  1\$'),
                  ],
                  pause: const Duration(milliseconds: 300),
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  onTap: () {},
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.auto_graph_outlined,
                size: 40,
              ),
              onPressed: () {},
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ],
    );
  }
}
