// ignore_for_file: must_be_immutable, camel_case_types, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Await_Verbal extends StatefulWidget {
  Await_Verbal({super.key});

  @override
  State<Await_Verbal> createState() => _Await_valueState();
}

class _Await_valueState extends State<Await_Verbal> {
  @override
  Widget build(BuildContext context) {
    return _reload();
  }

  Widget _reload() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Shimmer.fromColors(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Color.fromARGB(255, 234, 232, 232),
                  border: Border.all(width: 3)),
              height: 290,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConTainer(10, 180, 10),
                    ConTainer(10, 180, 10),
                    ConTainer(10, 180, 10),
                    ConTainer(10, 180, 10),
                    ConTainer(10, 180, 10),
                    ConTainer(10, 180, 10),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        ConTainer(100, 180, 10),
                        Spacer(),
                        ConTainer(45, 100, 10),
                        SizedBox(width: 10),
                        ConTainer(45, 100, 10),
                        SizedBox(width: 60)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          baseColor: Color.fromARGB(255, 151, 150, 150),
          highlightColor: Color.fromARGB(255, 221, 221, 219),
        ),
      ),
    );
  }

  Widget ConTainer(double h, double w, double n) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 26, 25, 25),
          borderRadius: BorderRadius.circular(n),
        ),
      ),
    );
  }
}
