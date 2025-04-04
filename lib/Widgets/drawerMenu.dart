import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/Auth/login.dart';
import '../components/colors.dart';
import '../page/navigate_home/Report/Transetoin/history.dart';
import '../page/navigate_home/User/list_notivigation.dart';
import '../page/homescreen/component/list.dart';
import '../page/homescreen/responsive_layout.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget(
      {super.key,
      required this.listUser,
      required this.email,
      required this.password});
  final List listUser;
  final String email;
  final String password;
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int selectindex = -1;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 26, 50, 209),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/k.png',
                    fit: BoxFit.fitWidth,
                    height: 70,
                    width: 100,
                  ),
                  DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      shadows: [
                        Shadow(
                            blurRadius: 2,
                            color: Color.fromARGB(255, 65, 119, 255))
                      ],
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText(' Admin',
                            textAlign: TextAlign.center,
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 227, 234, 7))),
                      ],
                      pause: const Duration(milliseconds: 100),
                      isRepeatingAnimation: true,
                      repeatForever: true,
                      onTap: () {},
                    ),
                  ),
                  const Text(
                    '  APP',
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
                onTap: () {},
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
                    style: TextStyle(
                      fontSize: 15,
                      color: (selectindex == i)
                          ? blueColor
                          : Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  onTap: () {
                    if (i == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResponsiveHomePage(
                              listUser: widget.listUser,
                              url: widget.listUser[0]['url'].toString(),
                              id: widget.listUser[0]['id'].toString(),
                            ),
                          ));
                    } else if (i == 1) {
                    } else if (i == 2) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const Trastoin_Payment();
                        },
                      ));
                    } else if (i == 3) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const Login();
                        },
                      ));
                    } else {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const Notivigation_day();
                        },
                      ));
                    }
                  },
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
