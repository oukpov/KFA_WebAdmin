import 'package:flutter/material.dart';

import '../page/navigate_home/admin/check_users.dart';
import '../page/navigate_home/admin/check_verbal.dart';

class ClassTest0 extends StatefulWidget {
  const ClassTest0({super.key});

  @override
  State<ClassTest0> createState() => _ClassTest0State();
}

class _ClassTest0State extends State<ClassTest0> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const CheckVerbals(),
    );
  }
}
