import 'package:flutter/material.dart';
import '../../../getx/verbal/verbal_list.dart';
import 'listPropertyCheck.dart';

class ClassTest extends StatefulWidget {
  const ClassTest({super.key});

  @override
  State<ClassTest> createState() => _ClassTestState();
}

class _ClassTestState extends State<ClassTest> {
  VerbalData verbalData = VerbalData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListAuto(
                // addNew: (value) {},
                checkcolor: true,
                device: 'm',
                id_control_user: "181",
                type: (value) {},
                listUser: const [
                  {
                    "id": 65,
                    "user_role_id": 53,
                    "agency": 83,
                    "username": "somnang.se",
                    "password": "9e6981b5813c4da23404c2a3e0f95e81",
                    "user_status": 0
                  }
                ]),
          ],
        ),
      ),
    );
  }
}
