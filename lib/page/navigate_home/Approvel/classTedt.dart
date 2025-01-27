import 'package:flutter/material.dart';
import 'package:web_admin/components/colors.dart';

class ClassTest extends StatefulWidget {
  const ClassTest({super.key});

  @override
  State<ClassTest> createState() => _ClassTestState();
}

class _ClassTestState extends State<ClassTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: redColors,
          ),
          Expanded(
              child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: yellowColor,
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                color: blackColor,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
