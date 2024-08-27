import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/components/colors/colors.dart';
import '../../../components/colors.dart';
import '../../navigate_home/Report/Transetoin/history.dart';
import '../../navigate_home/User/list_notivigation.dart';
import '../component/list.dart';
import '../responsive_layout.dart';

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
                } else {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const Notivigation_day();
                    },
                  ));
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
}
