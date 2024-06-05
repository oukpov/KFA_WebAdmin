import 'package:flutter/widgets.dart';
import 'newhomepage.dart';

class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage(
      {super.key,
      required this.id,
      required this.controllerUser,
      required this.email,
      required this.password,
      required this.setEmail,
      required this.user,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.from,
      required this.tel,
      required this.setPassword,
      required this.url,
      required this.listUser});
  final String id;
  final String controllerUser;
  final String email;
  final String password;
  final String setEmail;
  final String user;
  final String firstName;
  final String lastName;
  final String gender;
  final String from;
  final String tel;
  final String setPassword;
  final String url;
  final List listUser;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 770) {
          return homescreen(
              listUser: listUser,
              url: url,
              device: 'm',
              id: id,
              controllerUser: controllerUser,
              email: email,
              password: password,
              setEmail: setEmail,
              user: user,
              firstName: firstName,
              lastName: lastName,
              gender: gender,
              from: from,
              tel: tel,
              setPassword: setPassword);
        } else if (constraints.maxWidth < 1199) {
          return homescreen(
              listUser: listUser,
              url: url,
              device: 't',
              id: id,
              controllerUser: controllerUser,
              email: email,
              password: password,
              setEmail: setEmail,
              user: user,
              firstName: firstName,
              lastName: lastName,
              gender: gender,
              from: from,
              tel: tel,
              setPassword: setPassword);
        } else {
          return homescreen(
              listUser: listUser,
              url: url,
              device: 'd',
              id: id,
              controllerUser: controllerUser,
              email: email,
              password: password,
              setEmail: setEmail,
              user: user,
              firstName: firstName,
              lastName: lastName,
              gender: gender,
              from: from,
              tel: tel,
              setPassword: setPassword);
        }
      },
    );
  }
}
