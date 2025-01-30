import 'package:flutter/widgets.dart';
import 'newhomepage.dart';

class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage({
    super.key,
    required this.id,
    required this.url,
    //  required this.listUser
  });
  final String id;
  final String url;
  // final List listUser;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 770) {
          return homescreen(
            // listUser: listUser,
            url: url,
            device: 'm',
            id: id,
          );
        } else if (constraints.maxWidth < 1199) {
          return homescreen(
            // listUser: listUser,
            url: url,
            device: 't',
            id: id,
          );
        } else {
          return homescreen(
            // listUser: listUser,
            url: url,
            device: 'd',
            id: id,
          );
        }
      },
    );
  }
}
