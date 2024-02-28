import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../Profile/components/TwinBox.dart';
import '../../component/Province/image&name.dart';
import '../ListProperty/ListProPerty.dart';

class Property25 extends StatefulWidget {
  Property25(
      {super.key,
      required this.getIndexProvince,
      required this.viewportFraction,
      required this.heightImage,
      required this.email,
      required this.idUsercontroller,
      required this.myIdController});
  final String email;
  final String idUsercontroller;
  String? heightImage;
  String? viewportFraction;
  final OnChangeCallback getIndexProvince;
  String myIdController;
  @override
  State<Property25> createState() => _Screen_sliderState();
}

class _Screen_sliderState extends State<Property25> {
  int a = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 140,
        width: double.infinity,
        child: Column(
          children: [
            CarouselSlider.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index, realIndex) {
                  final imageList1 = imageList[index];
                  return buildImage(imageList1, index, widget.viewportFraction,
                      widget.heightImage);
                },
                options: CarouselOptions(
                  height: 130,
                  autoPlay: true,
                  viewportFraction:
                      double.parse(widget.viewportFraction.toString()),
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      a = index;
                    });
                  },
                )),
          ],
        ));
  }

  Widget buildImage(
          String imageList1, int index, viewportFraction, heightImage) =>
      PartnersCard2(
        myIdController: widget.myIdController!,
        email: widget.email,
        idUseContoller: widget.idUsercontroller,
        heightImage: heightImage,
        index: index,
        viewportFraction: viewportFraction,
        indexOntap: index.toString(),
        img: imageList1,
      );
}

class PartnersCard2 extends StatefulWidget {
  final String indexOntap;
  final String img;
  final String myIdController;
  final String viewportFraction;
  final String heightImage;
  final index;
  final String email;
  final String idUseContoller;
  PartnersCard2(
      {Key? key,
      required this.indexOntap,
      required this.img,
      required this.viewportFraction,
      required this.index,
      required this.heightImage,
      required this.email,
      required this.idUseContoller,
      required this.myIdController})
      : super(key: key);

  @override
  State<PartnersCard2> createState() => _PartnersCard2State();
}

class _PartnersCard2State extends State<PartnersCard2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(212, 248, 243, 243),
                blurRadius: 1,
                offset: Offset(0, 5))
          ],
          border: Border.all(
            color: const Color.fromARGB(255, 138, 137, 137),
            width: 1,
          ),
        ),
        child: InkWell(
            onTap: () {
              provinceByID(widget.index);

              Property25(
                myIdController: widget.myIdController,
                email: widget.email,
                idUsercontroller: widget.idUseContoller,
                heightImage: widget.heightImage,
                viewportFraction: widget.viewportFraction,
                getIndexProvince: (value) {},
              );
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    widget.img,
                    fit: BoxFit.cover,
                    width: 100,
                    height: double.parse(widget.heightImage.toString()),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fruitlist[widget.index],
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            )),
      ),
    );
  }

  List list = [];
  Future provinceByID(i) async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/get_all_Sale_b/$i',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        list = jsonDecode(json.encode(response.data));

        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ListProperty(
              myIdController: widget.myIdController,
              email: widget.email,
              idUsercontroller: widget.idUseContoller,
              optionDropdown: true,
              drawerType: fruitlist[i].toString(),
              device: 'mobile',
              list: list,
            );
          },
        ));
      });
    } else {
      print(response.statusMessage);
    }
  }
}
