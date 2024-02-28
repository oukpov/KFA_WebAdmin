import 'package:flutter/material.dart';

import '../../component/Colors/appbar.dart';
import '../../component/Colors/colors.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: appback,
        title: Row(
          children: const [
            Icon(Icons.phone, color: Colors.white),
            Text(' (855) 99 283 388'),
            SizedBox(width: 20),
            Icon(Icons.email_outlined, color: Colors.white),
            Text(' info@kfa.com.kh'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/KFA_CRM.png',
                    width: 150,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu, color: greyColor))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
