import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../component/Colors/colors.dart';
import '../../component/Header.dart';
import '../DetailScreen/DetailAll.dart';
import '../MoreOption/MenuMoreOption/searchOption/MoreOption.dart';
import '../../component/OPtion/Option.dart';

class SearchProperty extends StatefulWidget {
  SearchProperty(
      {super.key,
      required this.listPrice,
      required this.hPic,
      required this.fontsize,
      required this.w,
      required this.wOption,
      required this.hResponsive,
      required this.raDius,
      required this.member,
      required this.email,
      required this.idUserControllerl,
      required this.idUserPersonal,
      required this.myIdController});

  List listPrice = [];
  List listBedrooms = [];
  double hResponsive;
  double w = 0;
  double hPic = 0;
  double fontsize = 0;
  double wOption = 0;
  double raDius = 0;
  bool member;
  final String email;
  final String idUserControllerl;
  final String myIdController;
  final String idUserPersonal;
  @override
  State<SearchProperty> createState() => _HometestState();
}

class _HometestState extends State<SearchProperty> {
  double h = 0;
  double hI = 0;
  List searchList = [];
  int lenght = 0;
  Future<void> proertySearch(query) async {
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/link_all_search_down?search=$query'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      setState(() {
        searchList = jsonData;
        lenght = searchList.length;
        if (lenght > 0) {
          for (int i = 1; i <= searchList.length; i++) {
            hI = 30;
            h = hI * i;
          }
        }
      });
    }
  }

  String query = '';
  int verbalID = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * widget.hPic,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/salo.jpg'), fit: BoxFit.cover)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        // color: Colors.red,
        height: MediaQuery.of(context).size.height * widget.hPic,
        child: mobile(),
      ),
    );
  }

  Widget mobile() {
    return Stack(
      children: [
        Positioned(
          top: 50,
          right: 10,
          left: 10,
          child: SizedBox(
            child: Column(
              children: [
                //DekTop
                if (widget.w == 0.4)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      searchOptionMobile(
                          context,
                          listBathrooms,
                          listPrice,
                          listBedrooms,
                          widget.myIdController,
                          MediaQuery.of(context).size.width * 0.08,
                          45,
                          0,
                          5,
                          0,
                          5,
                          widget.hResponsive,
                          widget.raDius,
                          widget.email,
                          widget.idUserControllerl),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5),
                              topRight: Radius.circular(5)),
                        ),
                        height: 45,
                        width: MediaQuery.of(context).size.width * widget.w,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              query = value;
                              proertySearch(value);
                              if (value == '') {
                                h = 0;
                              }
                            });
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 12,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(9),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    proertySearch(query);
                                  });
                                },
                                icon: const Icon(Icons.search)),
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  h = 0;
                                });
                              },
                              icon: Icon(
                                Icons.cancel_outlined,
                                color: blackColor,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: '  Search listing here...',
                          ),
                        ),
                      ),
                    ],
                  ),
                //Mobile
                if (widget.w == 0.6)
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                    ),
                    height: 45,
                    width: MediaQuery.of(context).size.width * widget.w,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          query = value;
                          proertySearch(value);
                          if (value == '') {
                            h = 0;
                          }
                        });
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.textScaleFactorOf(context) * 12,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(9),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                proertySearch(query);
                              });
                            },
                            icon: const Icon(Icons.search)),
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              h = 0;
                            });
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: blackColor,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: '  Search listing here...',
                      ),
                    ),
                  ),
                //Error
                Positioned(
                  top: 0,
                  child: Container(
                    color: Colors.white,
                    height: h,
                    width: MediaQuery.of(context).size.width * widget.w,
                    child: ListView.builder(
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return DetailScreen(
                                    myIdcontroller: widget.myIdController,
                                    index: index.toString(),
                                    list: searchList,
                                    verbalID:
                                        searchList[index]['id_ptys'].toString(),
                                  );
                                },
                              );
                            });
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                '${(searchList[index]['hometype'] == null) ? "" : " ${searchList[index]['hometype']}"}${(searchList[index]['address'] == null) ? "" : " ${searchList[index]['address']}"}${(searchList[index]['urgent'] == null) ? "" : " ${searchList[index]['urgent']}"}${(searchList[index]['type'] == null) ? "" : " ${searchList[index]['type']}"}',
                              )),
                        );
                      },
                    ),
                  ),
                ),
                // if (widget.w == 0.6)
                //   searchOptionMobile(
                //       context,
                //       listBathrooms,
                //       listPrice,
                //       listBedrooms,
                //       widget.myIdController,
                //       MediaQuery.of(context).size.width * widget.w,
                //       45,
                //       0,
                //       0,
                //       5,
                //       5,
                //       widget.hResponsive,
                //       widget.raDius,
                //       widget.email,
                //       widget.idUserControllerl),
                // const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     optionHeader(
                //         'Rent',
                //         1,
                //         80,
                //         context,
                //         widget.email,
                //         widget.idUserControllerl,
                //         false,
                //         widget.idUserPersonal,
                //         widget.myIdController),
                //     const SizedBox(width: 10),
                //     optionHeader(
                //         'Sale',
                //         2,
                //         80,
                //         context,
                //         widget.email,
                //         widget.idUserControllerl,
                //         false,
                //         widget.idUserPersonal,
                //         widget.myIdController),
                //     const SizedBox(width: 10),
                //     optionHeader(
                //         'Sell',
                //         3,
                //         80,
                //         context,
                //         widget.email,
                //         widget.idUserControllerl,
                //         widget.member,
                //         widget.idUserPersonal,
                //         widget.myIdController),
                //   ],
                // ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Positioned(
          top: 10,
          right: 10,
          left: 10,
          child: SizedBox(
              width: MediaQuery.of(context).size.width * widget.w,
              child: headerTitleOption(context, widget.fontsize)),
        )
      ],
    );
  }
}
