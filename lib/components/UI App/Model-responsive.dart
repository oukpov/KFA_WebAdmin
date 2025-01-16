import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../colors/colors.dart';

class SCard extends StatelessWidget {
  final String title;
  final List item;
  final int num;
  final press;
  final String backgroup;
  const SCard({
    Key? key,
    required this.title,
    required this.press,
    required this.item,
    required this.num,
    required this.backgroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
            boxShadow: [kDefaultShadow],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 90,
              width: 92,
              decoration: BoxDecoration(
                boxShadow: const [kDefaultShadow],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(backgroup),
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  // onTap: press,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 47,
                        width: 47,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.network(
                            item[num]['url'].toString(),
                            color: (item[0]['check'].toString() == "1")
                                ? whileColors
                                : kImageColor,
                          ),
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 12,
                          color: (item[0]['check'].toString() == "1")
                              ? whileColors
                              : blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
