// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../Auth/login.dart';
import '../../../../../Auth/register.dart';
import '../../ResponseDevice/responsive_layout.dart';
import '../Header.dart';
import '../../MenuPage/ListProperty/ListProPerty.dart';
import '../../MenuPage/My Account/MyAccount.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
var appback = const Color.fromARGB(255, 23, 6, 78);
PreferredSizeWidget appbarMobile(
    context, email, idUsercontroller, myIdController) {
  return AppBar(
    elevation: 0,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        );
      },
    ),
    backgroundColor: Colors.white,
    title: imageBackGround,
    actions: [
      if (email == '')
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ));
            },
            child: buttonDrawer(Icons.person, 'Login', context))
      else
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ));
            },
            child: buttonDrawer(Icons.notification_add_sharp, '', context)),
      const SizedBox(width: 20),
      if (email == '')
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ));
            },
            child: buttonDrawer(Icons.person_add_alt, 'Register', context))
      else
        InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                // isScrollControlled: true,
                builder: (BuildContext context) {
                  return MyAccountProperty(
                    myIdController: myIdController,
                    email: email,
                    idUsercontroller: idUsercontroller,
                  );
                },
              );
            },
            child: buttonDrawer(Icons.person_pin, 'My Account', context)),
      const SizedBox(width: 10),
    ],
  );
}

PreferredSizeWidget appbarTablet(
    context, email, idUsercontroller, myIdController) {
  return AppBar(
    elevation: 0,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        );
      },
    ),
    backgroundColor: Colors.white,
    title: Row(
      children: [
        imageBackGround,
        const SizedBox(width: 10),
        headerTitle(context)
      ],
    ),
    actions: [
      if (email == '')
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ));
            },
            child: buttonDrawer(Icons.person, 'Login', context))
      else
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ));
            },
            child: buttonDrawer(Icons.notification_add_sharp, '', context)),
      const SizedBox(width: 20),
      if (email == '')
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ));
            },
            child: buttonDrawer(Icons.person_add_alt, 'Register', context))
      else
        InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                // isScrollControlled: true,
                builder: (BuildContext context) {
                  return MyAccountProperty(
                    myIdController: myIdController,
                    email: email,
                    idUsercontroller: idUsercontroller,
                  );
                },
              );
            },
            child: buttonDrawer(Icons.person_pin, 'My Account', context)),
      const SizedBox(width: 10),
    ],
  );
}

PreferredSizeWidget appbarDekTop(
    context, device, email, idUserController, myIdcontroller, myIdController) {
  return AppBar(
    elevation: 0,
    leading: (device == 'dektop')
        ? const SizedBox()
        : Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              );
            },
          ),
    backgroundColor: Colors.white,
    title: Row(
      children: [
        imageBackGround,
        const SizedBox(width: 10),
        headerTitle(context)
      ],
    ),
    actions: [
      InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResponsiveLayout(
                      myIdController: myIdcontroller,
                      email: email,
                      idController: idUserController),
                ));
          },
          child: buttonDrawer(Icons.home, 'Home', context)),
      const SizedBox(width: 20),
      InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListProperty(
                          myIdController: myIdcontroller,
                          email: email,
                          idUsercontroller: idUserController,
                          optionDropdown: false,
                          device: 'Mobile',
                          drawerType: 'For Sale',
                          list: const [],
                        )));
          },
          child: buttonDrawer(Icons.house_outlined, 'For Sale', context)),
      const SizedBox(width: 20),
      InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListProperty(
                          myIdController: myIdcontroller,
                          email: email,
                          idUsercontroller: idUserController,
                          optionDropdown: false,
                          device: 'Mobile',
                          drawerType: 'For Rent',
                          list: const [],
                        )));
          },
          child: buttonDrawer(Icons.home_work_outlined, 'For Rent', context)),
      const SizedBox(width: 20),
      InkWell(
          onTap: () {
            launch(
              'https://kfa.com.kh/archives/category/news',
              forceSafariVC: false,
              forceWebView: false,
            );
          },
          child: buttonDrawer(Icons.newspaper, 'News', context)),
      const SizedBox(width: 20),
      InkWell(
          onTap: () {
            launch(
              'https://kfa.com.kh/about-us',
              forceSafariVC: false,
              forceWebView: false,
            );
          },
          child: buttonDrawer(Icons.person_3, 'About Us', context)),
      const SizedBox(width: 20),
      InkWell(
          onTap: () {
            launch(
              'https://kfa.com.kh/contacts',
              forceSafariVC: false,
              forceWebView: false,
            );
          },
          child: buttonDrawer(Icons.phone, 'Contact Us', context)),
      const SizedBox(width: 20),
      if (email == '')
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ));
            },
            child: buttonDrawer(Icons.person, 'Login', context))
      else
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ));
            },
            child: buttonDrawer(Icons.notification_add_sharp, '', context)),
      const SizedBox(width: 20),
      if (email == '')
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ));
            },
            child: buttonDrawer(Icons.person_add_alt, 'Register', context))
      else
        InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                // isScrollControlled: true,
                builder: (BuildContext context) {
                  return MyAccountProperty(
                    myIdController: myIdController,
                    email: email,
                    idUsercontroller: idUserController,
                  );
                },
              );
            },
            child: buttonDrawer(Icons.person_pin, 'My Account', context)),
      const SizedBox(width: 20),
    ],
  );
}
