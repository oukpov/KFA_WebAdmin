// ignore_for_file: prefer_const_constructors
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:get/get.dart';
import '../../../../components/colors.dart';
import '../../../../controller/about_us_controller.dart';
import '../../../../controller/about_us_image_controller.dart';
import '../../../../controller/about_us_slide_controller.dart';
import 'about_us_image_page.dart';
import 'about_us_image_slide_edit_page.dart';
import 'about_us_text_update_page.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final AboutUsController aboutUsController = Get.put(AboutUsController());
  final AboutUsSlideController aboutUsSlideController =
      Get.put(AboutUsSlideController());
  final AboutUsImageController aboutUsImageController =
      Get.put(AboutUsImageController());

  @override
  void initState() {
    super.initState();
    aboutUsController.fetchAboutUsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                ),
                padding: EdgeInsets.only(right: 15, left: 15, bottom: 15),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(),
                ),
                child: Obx(() {
                  if (aboutUsController.isLoading.value ||
                      aboutUsSlideController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: greyColor)),
                        height: 50,
                        width: double.infinity,
                        child: ListTile(
                            title: Center(
                              child: Text(
                                'About Us',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: greyColor,
                                    fontSize: 20),
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.remove_circle_outline,
                                    color: greyColor))),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: 120,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                  ),
                                  items: aboutUsSlideController.aboutUsSlideList
                                      .map((item) {
                                    return Builder(
                                        builder: (BuildContext context) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                        child: Image.network(
                                          item.url ?? "",
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/message-banner3.jpg',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      );
                                    });
                                  }).toList(),
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AboutUsImageSlideEditPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Welcome to Khmer Foundation Appraisals Co., Ltd.",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "About Us",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              child: ReadMore(
                                text: aboutUsController
                                        .aboutUsData.value.aboutCaption ??
                                    "",
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () async {
                                await Get.to(() => AboutUsTextUpdatePage());
                                // Refresh data after returning from edit page
                                aboutUsController.fetchAboutUsData();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.blueAccent,
                        thickness: 0.5,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Founder & Chairman/CEO's Message",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => aboutUsImageController.isLoading.value
                                ? CircularProgressIndicator()
                                : Image.network(
                                    aboutUsImageController
                                            .aboutUsImageList[2].url ??
                                        '',
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/message-banner3.jpg');
                                    },
                                  )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Dear Value Customer",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              child: ReadMore(
                                text: aboutUsController
                                        .aboutUsData.value.dearValueCustomer ??
                                    "",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.blueAccent,
                        thickness: 0.5,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Company Overview",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              child: ReadMore(
                                text: aboutUsController
                                        .aboutUsData.value.companyOverview ??
                                    "",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.blueAccent,
                        thickness: 0.5,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Vision and Mission",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              child: ReadMore(
                                text: aboutUsController
                                        .aboutUsData.value.visionMission ??
                                    "",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.blueAccent,
                        thickness: 0.5,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Our People",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              child: ReadMore(
                                text: aboutUsController
                                        .aboutUsData.value.ourPeople ??
                                    "",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.blueAccent,
                        thickness: 0.5,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Company Profile",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              child: ReadMore(
                                text: aboutUsController
                                        .aboutUsData.value.companyProfile ??
                                    "",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (int i = 0; i <= 1; i++)
                                  Obx(() =>
                                      aboutUsImageController.isLoading.value
                                          ? CircularProgressIndicator()
                                          : Image.network(
                                              aboutUsImageController
                                                      .aboutUsImageList[i]
                                                      .url ??
                                                  '',
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    'assets/images/message-banner3.jpg');
                                              },
                                            )),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AboutUsImagePage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReadMore extends StatelessWidget {
  const ReadMore({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: 6,
      textAlign: TextAlign.justify,
      trimMode: TrimMode.Line,
      trimCollapsedText: " read more ",
      trimExpandedText: " Show Less ",
      style: TextStyle(
        fontSize: 15,
        height: 1,
      ),
    );
  }
}
