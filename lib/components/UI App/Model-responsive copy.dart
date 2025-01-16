import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../components/waiting.dart';
import '../../getx/UI/download.dart';
import '../../getx/ui_app/backgroup_Icons.dart';
import '../colors.dart';
import '../colors/colors.dart';

class SCard extends StatelessWidget {
  final String title;
  final List item;
  final String num;
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
    final iconsOption = Get.put(BackgroupIcons());
    final downloadImage = Get.put(DownloadImage());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () {
            if (iconsOption.isIcons.value) {
              return const WaitingFunction();
            } else if (iconsOption.listOption.isEmpty) {
              return const SizedBox();
            } else {
              return Container(
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
                        onTap: press,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () {
                                if (iconsOption.listOption.isEmpty) {
                                  return SizedBox(
                                    height: 47,
                                    width: 47,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.network(
                                        "https://www.oneclickonedollar.com/laravel_kfa_2023/public/data_imgs_kfa/icons_application/downloadImage.png",
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                    height: 47,
                                    width: 47,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SvgPicture.network(
                                        downloadImage
                                            .urlImage(
                                              item,
                                              num,
                                            )
                                            .toString(),
                                        color: (iconsOption.listOption[0]
                                                        ['check']
                                                    .toString() ==
                                                "1")
                                            ? whileColors
                                            : kImageColor,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 12,
                                color: (iconsOption.listOption[0]['check']
                                            .toString() ==
                                        "1")
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
              );
            }
          },
        ),
      ],
    );
  }
}
