import 'package:flutter/material.dart';
import 'package:web_admin/components/colors/colors.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/colors.dart';
import '../component/list.dart';
import '../responsive_layout.dart';

class DrawerOption extends StatefulWidget {
  const DrawerOption({super.key, required this.device});
  final String device;

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
          : 250,
      color: whileColors,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 120,
            width: double.infinity,
            color: greyColorNolots,
          ),
          for (int i = 0; i < drawerOption.length; i++)
            InkWell(
              onTap: () {
                if (i == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResponsiveHomePage(
                            id: '12',
                            name: 'ouk pov',
                            controllerUser: '12831923',
                            nativigation: true,
                            email: 'oukpov@gmail.com'),
                      ));
                } else if (i == 3) {}
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
