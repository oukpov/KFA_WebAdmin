import 'package:flutter/material.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/appbar.dart';
import 'package:web_admin/screen/Property/FirstProperty/component/Colors/colors.dart';
import '../../../components/LandBuilding.dart';
import '../component/list.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

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
              decoration: BoxDecoration(
                color: Theme.of(context).tabBarTheme.dividerColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
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
                  onTap: () {},
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
