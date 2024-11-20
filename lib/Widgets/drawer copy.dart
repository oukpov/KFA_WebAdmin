import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_admin/Auth/login.dart';
import 'package:web_admin/components/colors/colors.dart';
import '../components/colors.dart';
import '../page/navigate_home/Report/Transetoin/history.dart';
import '../page/homescreen/component/list.dart';
import '../page/homescreen/responsive_layout.dart';

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
  int selectindex = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: (widget.device == 't')
          ? MediaQuery.of(context).size.width * 0.2
          : MediaQuery.of(context).size.width * 0.15,
      color: whileColors,
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
                Image.asset(
                  'assets/k.png',
                  fit: BoxFit.fitWidth,
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                // DefaultTextStyle(
                //   textAlign: TextAlign.center,
                //   style: const TextStyle(
                //     fontSize: 16.0,
                //     shadows: [
                //       Shadow(
                //           blurRadius: 2,
                //           color: Color.fromARGB(255, 65, 119, 255))
                //     ],
                //     fontWeight: FontWeight.bold,
                //   ),
                //   child: AnimatedTextKit(
                //     animatedTexts: [
                //       WavyAnimatedText(' Admin',
                //           textAlign: TextAlign.center,
                //           textStyle: const TextStyle(
                //               color: Color.fromARGB(255, 227, 234, 7))),
                //     ],
                //     pause: const Duration(milliseconds: 100),
                //     isRepeatingAnimation: true,
                //     repeatForever: true,
                //     onTap: () {},
                //   ),
                // ),
                const Text(
                  '  Admin Web',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < drawerOption.length; i++)
            InkWell(
              onTap: () {
                if (i == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResponsiveHomePage(
                          id: widget.listUser[0]['agency'].toString(),
                          listUser: widget.listUser,
                          url: widget.listUser[0]['url'].toString(),
                        ),
                      ));
                } else if (i == 1) {
                } else if (i == 2) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const Trastoin_Payment();
                    },
                  ));
                } else if (i == 4) {
                  logOut();
                }
              },
              onHover: (value) {
                setState(() {
                  selectindex = (selectindex == i) ? -1 : i;
                });
              },
              child: ListTile(
                leading: Icon(
                  drawerIconOption[i],
                  color: (selectindex == i) ? blueColor : greyColor,
                ),
                title: Text(
                  drawerOption[i]['title'].toString(),
                  style: (selectindex == i)
                      ? TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: (selectindex == i) ? blueColor : greenColors)
                      : TextStyle(
                          color: greyColorNolot,
                          fontSize: 13,
                        ),
                ),
              ),
            )
        ],
      ),
    );
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
