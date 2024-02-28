// ignore_for_file: prefer_const_constructors, camel_case_types, deprecated_member_use, non_constant_identifier_names, must_be_immutable, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, unused_local_variable, unnecessary_string_interpolations, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../component/Colors/appbar.dart';
import '../Drawer/drawer.dart';
import '../ListProperty/ListProPerty.dart';

class AllProvince extends StatefulWidget {
  const AllProvince(
      {super.key,
      required this.email,
      required this.idUserController,
      required this.myIdController});
  final String email;
  final String idUserController;
  final String myIdController;
  @override
  State<AllProvince> createState() => _ALl_Khae_cambodiaState();
}

class _ALl_Khae_cambodiaState extends State<AllProvince> {
  late String property_type_id;
  double ws = 0;
  @override
  Widget build(BuildContext context) {
    ws = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 221, 220, 220), body: body());
  }

  Widget body() {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: (ws < 770)
          ? appbarMobile(context, widget.email, widget.idUserController,
              widget.myIdController)
          : (ws < 1199)
              ? appbarTablet(
                  context, widget.email, '95K267F95A', widget.myIdController)
              : appbarDekTop(
                  context,
                  'dektop',
                  widget.email,
                  widget.idUserController,
                  widget.myIdController,
                  widget.myIdController),
      drawer: MyDrawer(
          myIdController: widget.myIdController,
          device: 'mobile',
          email: widget.email,
          idUseContoller: widget.idUserController),
      body: SingleChildScrollView(
        child: girdview(),
      ),
    );
  }

  Widget add() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  final Fruitlist = [
    'Battambong',
    'Phnom Penh',
    'Bonteaymeanchey',
    'KamponChnang',
    'KampongThom',
    'Kandal',
    'kam pot',
    'Kep',
    'Kracheh',
    'Oudormeanchey',
    'Preah Vihea',
    'Prey Veng',
    'Rathanakiri',
    'Siehanuk',
    'Siem Reab',
    'Steng Treng',
    'Svang Rieng',
    'Ta kao',
    'TbongKhmom',
    'Pur sat',
    'Pai lin',
    'Mondolkiri',
    'Kohkong',
    'Kampong Cham',
    'Kampong Speu',
  ];
  final imageList = [
    'assets/images/25_commune/Battambang.jpg',
    'assets/images/25_commune/PhnomPenh.jpg',
    'assets/images/25_commune/Bonteaymeanchey.jpg',
    'assets/images/25_commune/KamponChnang.jpg',
    'assets/images/25_commune/KampongThom.jpg',
    'assets/images/25_commune/Kandal.jpg',
    'assets/images/25_commune/kampot.jpg',
    'assets/images/25_commune/Kep.jpg',
    'assets/images/25_commune/Kracheh.jpg',
    'assets/images/25_commune/Oudormeanchey.jpg',
    'assets/images/25_commune/Preah_Vihea.jpg',
    'assets/images/25_commune/PreyVeng.jpeg',
    'assets/images/25_commune/Rathanakiri.jpg',
    'assets/images/25_commune/Siehanuk.jpg',
    'assets/images/25_commune/Siemreab.jpg',
    'assets/images/25_commune/Steng_Treng.jpg',
    'assets/images/25_commune/SvangRieng.jpg',
    'assets/images/25_commune/takao.jpg',
    'assets/images/25_commune/tbongKhmom.jpeg',
    'assets/images/25_commune/Pursat.jpg',
    'assets/images/25_commune/Pailin.jpg',
    'assets/images/25_commune/munduolmiri.jpg',
    'assets/images/25_commune/Kohkong.jpg',
    'assets/images/25_commune/Kampong_Cham.jpg',
    'assets/images/25_commune/Kampong_Speu.jpg',
  ];

  Widget girdview() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              for (int i = 0; i < imageList.length; i++)
                InkWell(
                  onTap: () {
                    provinceByID(i);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          height: 180,
                          width: 230,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage('${imageList[i].toString()}')),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Color.fromARGB(96, 185, 185, 185),
                                offset: Offset(2, 4),
                                blurRadius: 10,
                                spreadRadius: 10,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(Fruitlist[i].toString())
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
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
        print(
            '=========> Province : ${list.length} && ${Fruitlist[i].toString()}');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ListProperty(
              myIdController: widget.myIdController,
              email: widget.email,
              idUsercontroller: widget.idUserController,
              optionDropdown: true,
              drawerType: Fruitlist[i].toString(),
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
