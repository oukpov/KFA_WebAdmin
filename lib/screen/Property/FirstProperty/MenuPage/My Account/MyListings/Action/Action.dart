import 'package:flutter/material.dart';

import '../../../../../../../components/colors.dart';

class ActionWithUser extends StatefulWidget {
  const ActionWithUser({super.key});

  @override
  State<ActionWithUser> createState() => _ActionWithUserState();
}

class _ActionWithUserState extends State<ActionWithUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              height: 180,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: whiteColor),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.remove_circle_outline))
                    ],
                  ),
                  SizedBox(
                      child: Row(children: const [
                    Icon(Icons.email_outlined),
                    Text('Email'),
                  ])),
                  const SizedBox(height: 10),
                  SizedBox(
                      child: Row(children: const [
                    Icon(Icons.print_outlined),
                    Text('Print')
                  ])),
                  const SizedBox(height: 10),
                  SizedBox(
                      child: Row(children: const [
                    Icon(Icons.download_outlined),
                    Text('Download PDF')
                  ])),
                ]),
              )),
        ],
      ),
    );
  }
}
